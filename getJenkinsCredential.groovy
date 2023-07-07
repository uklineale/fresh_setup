import jenkins.*
import jenkins.model.* 
import hudson.*
import hudson.model.*

// Run this script at https://{jenkins_host}/script
// Change this value to the ID of the secret you want to find
def credentialId = "jenkins-key"

def jenkinsCredentials = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
        com.cloudbees.plugins.credentials.Credentials.class,
        Jenkins.instance,
        null,
        null
);

def getSecret(creds) {
    if (creds instanceof org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl) {
        println(creds.getSecret())
    } else if (creds instanceof com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl) {
        println("Username: " + creds.getUsername())
        println("Password: " + creds.getPassword())
    } else if (creds instanceof org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl) {
        inputStream = creds.getContent()
        int data = inputStream.read()
        while(data != -1){
            char theChar = (char) data;
            print(theChar)
            data = inputStream.read()
        }
    } else if (creds instanceof com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey) {
        println("Passphrase: " + creds.getPassphrase())
        println("Private key: \n" + creds.getPrivateKey())
    }
}

for (creds in jenkinsCredentials) {
  if (creds.id == credentialId) {
    getSecret(creds)
  }
}
