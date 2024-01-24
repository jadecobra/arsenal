PROJECT_NAME=$1

rm -rf $PROJECT_NAME
mkdir $PROJECT_NAME
cd $PROJECT_NAME

cat << DELIMITER > requirements.txt
sniffer
macfsevents
DELIMITER

cat << DELIMITER > scent.py
import sniffer.api
import subprocess
import os

@sniffer.api.file_validator
def rst_files(filename):
    return (filename.endswith(".cs") or filename.endswith('.py'))
    # return (filename.endswith(".cs") or filename.endswith('.py'))

@sniffer.api.runnable
def run_tests(*args):
    if subprocess.run("dotnet test", shell=True).returncode == 0:
        return True
DELIMITER

python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install --requirement requirements.txt

dotnet new xunit

rm UnitTest1.cs
cat << DELIMITER > Test$PROJECT_NAME.cs
namespace $PROJECT_NAME;

public class Test$PROJECT_NAME
{
    [Fact]
    public void TestFailure()
    {
        Assert.True(false);
    }
}

// Exceptions Encountered
// System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)
// System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)
DELIMITER

sniffer