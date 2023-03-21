#!/bin/bash

function showJQabsenseErrorMessage {
    echo -e "\nShell script requires 'jq'. Please install the utility depending of your system:"
    echo -e "\nMacOS"
    echo -e "Install 'jq' via Homebrew: brew install jq"
    echo -e "\nWindows"
    echo -e "Use Chocolatey NuGet: chocolatey install jq"
    echo -e "\nLinux"
    echo -e "On Ubuntu or Debian use sudo-apt: sudo apt-get install jq\n"
}

function help {
  echo -e "\nupdate-pipeline-definition - modify a JSON pipeline file with the JQ lib and create a new one (e.g. pipeline-{date-of-creation}.json)"

  echo -e "\nUsage:"
  echo -e "$ update-pipeline-definition.sh <json-file-name.json> [options]"

  echo -e "\nExample:"
  echo -e "$ update-pipeline-definition.sh ./pipeline.json --configuration production --owner boale --branch feat/cicd-lab --poll-for-source-changes true"

  echo -e "\nPipeline config options:"
  echo -e "-c | --configuration\tChoose environment configuration (production / dev)\n"
  echo -e "-o | --owner\t\tSet owner of the source code\n"
  echo -e "-b | --branch\t\tChoose target branch\n"
  echo -e "-p | --poll-for-source-changes\n\t\t\tTo poll new changes\n"
  echo -e "-r | --repo\t\tSet repository link\n"
}

function handleJQAbsense {
  if [[ ! $(command -v jq) ]]; then
    showJQabsenseErrorMessage
    exit 1
  fi
}

function updatePipelineDefinition {
    newFileName="pipeline-$(date +"%d-%m-%YT%T").json"
    fileName="$1"
    configuration="$2"
    branch="$3"
    pollChanges="$4"
    repository="$5"
    owner="$6"

    tmp=$(mktemp)

    jq \
        --arg branch "$branch" \
        --arg owner "$owner" \
        --arg repository "$repository" \
        --arg pollChanges "$pollChanges" \
        --arg configuration "$configuration" \
        '
            del(.metadata)
            | .pipeline.version = .pipeline.version + 1
            | .pipeline.stages[0].actions[0].configuration |=
                ((if $owner != "" then .Owner = $owner else . end) |
                (if $branch != "" then .Branch = $branch else . end) |
                (if $repository != "" then .Repo = $repository else . end) |
                (if $pollChanges != "" then .PollForSourceChanges = $pollChanges else . end) |
                (if $configuration != "" then .EnvironmentVariables = { BUILD_CONFIGURATION: $configuration } else . end))
        ' $fileName > $tmp
  
    mv "$tmp" $newFileName
}

fileName="$1"
if [[ $fileName == '--help' || $fileName == '-h' || $fileName == '' ]]; then
  help
  exit 1
fi

if [[ $fileName == -* ]]; then
  echo "Please input file name"
  exit 1
fi

while [[ $# -gt 1 ]]; do
  option="$2"

  case $option in
    -c|--configuration)
      configuration="$3"
      shift
      shift
    ;;
    -o|--owner)
      owner="$3"
      shift
      shift
    ;;
    -b|--branch)
      branch="$3"
      shift
      shift
    ;;
    -p|--poll-for-source-changes)
      poll="$3"
      shift
      shift
    ;;
    -r|--repo)
      repo="$3"
      shift
      shift
    ;;
    *)
      echo "This option '$option' is not supported"
      exit 1
    ;;
  esac
done

handleJQAbsense
updatePipelineDefinition $fileName $configuration $branch $poll $repo $owner
