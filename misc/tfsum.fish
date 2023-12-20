function tfsum
    if test -z $argv[1]
        echo "You should type 'tfsum terraform|terragrunt'"
    else
        echo -e "Starting tf summary..."
        # Don't print output of terraform plan
        # If you don't want full plan output: $argv[1] plan -out plan.tfplan > /dev/null
        $argv[1] plan -out plan.tfplan
        echo -e "\n"
        $argv[1] show -json plan.tfplan | tftools summarize
        # Delete plan out file to avoid git tracking (although is included in .gitignore)
        if test -f "plan.tfplan"; rm plan.tfplan; end
    end
end

