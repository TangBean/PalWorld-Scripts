#!/bin/bash

sh ./auto_executor.sh --script_name=restart --period="* * * * *"
sh ./auto_executor.sh --script_name=update --period="0 4 * * *"
sh ./auto_executor.sh --script_name=backup --period="0 3 * * *"
