# TaskLang++

DSL for task scheduling using Flex & Bison

## Setup
brew install flex bison

## DSL Example 

TASK backup
RUN "backup.sh"
EVERY DAY AT 10.00

TASK email
RUN "send_email.sh"
AFTER backup
IF SUCCESS