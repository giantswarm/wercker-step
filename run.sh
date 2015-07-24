#!/bin/sh
# get the token by calling `swarm login` with user/pass
$WERCKER_STEP_ROOT/swarm login -p $WERCKER_GIANTSWARM_PASS $WERCKER_GIANTSWARM_USER

# If we have an environment set, switch to it
if [ -n "$WERCKER_GIANTSWARM_ENV" ]; then
  echo $WERCKER_STEP_ROOT/swarm env $WERCKER_GIANTSWARM_ENV
  $WERCKER_STEP_ROOT/swarm env $WERCKER_GIANTSWARM_ENV
fi

# If we have a swarm.json then try to create and start the app
if [ -f "swarm.json" ]; then
  # check the application status
  if [ "$( swarm status swacker |grep -c -e '\sup$' )" -ne 0 ]; then
    # not running, so we swarm up
    $WERCKER_STEP_ROOT/swarm up $WERCKER_GIANTSWARM_OPTS
  else
  	# running, so we update
    $WERCKER_STEP_ROOT/swarm update $WERCKER_GIANTSWARM_UPDATE
  fi
fi
