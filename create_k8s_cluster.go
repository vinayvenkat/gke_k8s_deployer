// In the previous example we looked at
// [spawning external processes](spawning-processes). We
// do this when we need an external process accessible to
// a running Go process. Sometimes we just want to
// completely replace the current Go process with another
// (perhaps non-Go) one. To do this we'll use Go's
// implementation of the classic
// <a href="http://en.wikipedia.org/wiki/Exec_(operating_system)"><code>exec</code></a>
// function.

package main

import "syscall"
import "os"
import "os/exec"
import "flag"
import "fmt"

func main() {

	binaryPtr := flag.String("executable", "gcloud", "The executable to be run")
	clusterNamePtr := flag.String("clusterName", "vv15-", "Name of the cluster to deploy")
	clusterVersion := flag.String("clusterVersion", "1.10.5-gke.4", "Cluster Version")
	zonePtr := flag.String("zoneName", "us east 1", "The zone to deploy into")
	projectPtr := flag.String("projectId", "default-vv15", "Project ID")

	flag.Parse()

	fmt.Println("executable: ", *binaryPtr)
	fmt.Println("clusterName: ", *clusterNamePtr)
	fmt.Println("zonePtr: ", *zonePtr)
	fmt.Println("projectPtr: ", *projectPtr)
	fmt.Println("clusterVersion: ", *clusterVersion)
    // For our example we'll exec `ls`. Go requires an
    // absolute path to the binary we want to execute, so
    // we'll use `exec.LookPath` to find it (probably
    // `/bin/ls`).
    binary, lookErr := exec.LookPath(*binaryPtr)
    if lookErr != nil {
        panic(lookErr)
	}
	fmt.Println("binary: ", binary)
	
	//args := []string{"container", "clusters", "create", *clusterNamePtr, "--cluster-version=" + *clusterVersion, "--zone", *zonePtr, "--project", *projectPtr}
	//args1 := []string{"container"}
	//fmt.Println("args: ", args1)
    // `Exec` also needs a set of [environment variables](environment-variables)
    // to use. Here we just provide our current
    // environment.
    env := os.Environ()
	//os.Exit(3)
    // Here's the actual `syscall.Exec` call. If this call is
    // successful, the execution of our process will end
    // here and be replaced by the `/bin/ls -a -l -h`
    // process. If there is an error we'll get a return
    // value.
    execErr := syscall.Exec(binary, nil, env)
    if execErr != nil {
        panic(execErr)
    }
}