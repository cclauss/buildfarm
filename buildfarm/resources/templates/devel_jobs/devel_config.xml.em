<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description>@job_name autogenerated</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <jenkins.advancedqueue.AdvancedQueueSorterJobProperty plugin="PrioritySorter@@2.6">
      <useJobPriority>false</useJobPriority>
      <priority>-1</priority>
    </jenkins.advancedqueue.AdvancedQueueSorterJobProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@@2.0.1">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>@url</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>@version</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions>
      <hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
        <relativeTargetDir>monitored_vcs</relativeTargetDir>
      </hudson.plugins.git.extensions.impl.RelativeTargetDirectory>
      <hudson.plugins.git.extensions.impl.SubmoduleOption>
        <disableSubmodules>false</disableSubmodules>
        <recursiveSubmodules>true</recursiveSubmodules>
      </hudson.plugins.git.extensions.impl.SubmoduleOption>
    </extensions>
  </scm>
  <assignedNode>docker</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@@1.8">
      <spec></spec>
    </com.cloudbees.jenkins.GitHubPushTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>#!/usr/bin/env bash

rm -rf jenkins_scripts

git clone https://github.com/tfoote/jenkins_scripts.git -b docker

sudo rm -rf $WORKSPACE/output || true

mkdir $WORKSPACE/output

export ROS_HOME=$WORKSPACE/rosdep
rosdep update

echo &apos;rosdep updated&apos;


cd jenkins_scripts
python generate_devel_job.py ubuntu precise amd64 hydro $WORKSPACE/output $WORKSPACE/monitored_vcs --rebuild
</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.junit.JUnitResultArchiver>
      <testResults>output/test_results/**/*.xml</testResults>
      <keepLongStdio>false</keepLongStdio>
      <testDataPublishers/>
    </hudson.tasks.junit.JUnitResultArchiver>
  </publishers>
  <buildWrappers>
    <com.cloudbees.jenkins.plugins.sshagent.SSHAgentBuildWrapper plugin="ssh-agent@@1.4.1">
      <user>6967d370-5376-437b-b26a-55da4c72bd84</user>
    </com.cloudbees.jenkins.plugins.sshagent.SSHAgentBuildWrapper>
  </buildWrappers>
</project>