def call(Map scmParams) {
    env.COMMITTER = scmParams.committer
    env.BRANCH = scmParams.branch
    echo "Environment prepared: Committer=${env.COMMITTER}, Branch=${env.BRANCH}"
}