#!/bin/bash
set -o pipefail

PassedValue=$1

cat << EOF > dynamic-static-test.yml
version: 2.1

parameters:
  run_generated_config:
    type: boolean
    default: false
jobs:
  generated_config:
    docker:
      - image: ubuntu
    steps:
      - checkout
      - run:
          name: In Generated Configs ( No echo )
          command: |
            inGeneratedConfigUsingPassedValue="$PassedValue"
            echo $inGeneratedConfigUsingPassedValue
            inGeneratedConfig='This is from the generated config'
            echo $inGeneratedConfig
workflows:
  generated_config:
    when: << pipeline.parameters.run_generated_config >>
    jobs:
      - generated_config


EOF

chmod +x dynamic-static-test.yml