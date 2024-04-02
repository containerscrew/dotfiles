function aws-profile
    set -gx AWS_PROFILES $(cat ~/.aws/credentials | sed -n -e 's/^\[\(.*\)\]/\1/p' | fzf)
    if test -n "$AWS_PROFILES"
        set -gx AWS_PROFILE $AWS_PROFILES
        echo "Selected profile: $AWS_PROFILES"
    else
        echo "No profile selected"
    end
end
