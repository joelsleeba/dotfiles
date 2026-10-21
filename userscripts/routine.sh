#!/usr/bin/env bash

lunch_messages=(
  "Your stomach has opened a support ticket."
  "Go acquire nutrients. The machine can survive without you for a bit."
  "This meeting could have been a sandwich."
  "Your blood sugar would like to schedule a brief consultation."
  "Food is not an optional dependency."
  "Time to perform routine biological maintenance."
  "The kitchen side quest is now available."
  "You cannot subsist entirely on caffeine and mathematical conviction."
  "Somewhere out there, a sandwich believes in you."
  "The body demands tribute."
  "Go eat something before your brain starts running in power-saving mode."
  "A tactical deployment to the kitchen is advised."
  "Your internal processes are requesting additional resources."
  "Lunch has entered the chat."
  "You have been granted temporary leave from whatever nonsense you're doing."
  "Plot twist: the next important task is food."
  "The productivity meta currently favors eating."
  "Your stomach is beginning to unionize."
  "Please insert food into mathematician."
  "The Council has convened. The Council recommends lunch."
)

gym_messages=(
  "The weights have noticed your absence."
  "The training montage cannot begin without you."
  "Motivation is optional. Showing up isn't."
  "Go pick up heavy objects and put them back down."
  "The gains are not going to acquire themselves."
  "Your muscles have filed a missing-person report."
  "It is time for the daily confrontation with gravity."
  "The iron calls."
  "Go become marginally harder to kill."
  "Today's boss fight is your own inertia."
  "Somewhere, a dumbbell is sitting there completely unlifted."
  "Your character sheet could use some strength points."
  "The couch has had enough victories."
  "Do it for tomorrow's unreasonable confidence."
  "Time to engage in recreational suffering."
  "You don't need enthusiasm. You need shoes."
  "The temple of iron awaits its mildly reluctant pilgrim."
  "Today's episode includes physical exertion."
  "You can negotiate with yourself after you arrive."
  "Get moving. The montage music has already started."
)

sleep_messages=(
  "Shut it down. The night shift is over."
  "Tomorrow-you is going to have opinions about this."
  "This is no longer a reminder. It is an intervention."
  "You have reached the post-credits scene of the day."
  "SHUT. IT. DOWN."
  "We are well past 'one more thing.'"
  "Bed. Now. The computer has become an accomplice."
  "There are no achievements left to unlock tonight."
  "The machine wants to sleep. Take the hint."
  "Close the laptop. Return to the biological world."
  "Your circadian rhythm has filed a formal complaint."
  "Whatever you're doing will still be questionable tomorrow."
  "This session has exceeded its recommended runtime."
  "The plot requires you to go to bed now."
  "Save your work. Abandon your ambitions. Become horizontal."
  "You've had enough screen for one lifetime. Specifically, today."
  "The responsible adult in this room appears to be the notification daemon."
  "Go to sleep before tomorrow becomes today."
  "Your brain is requesting scheduled maintenance."
  "You are borrowing cognitive function from tomorrow at predatory interest rates."
  "The laptop has become an enabler."
  "No new good ideas are arriving tonight."
  "Anything brilliant you think of now can survive eight hours."
  "Step away from the keyboard."
  "Your bed has been trying to reach you regarding your extended wakefulness."
  "The day's main process should now terminate."
  "You have exceeded your daily allocation of consciousness."
  "Sleep is not technical debt. Stop deferring it."
  "Tomorrow has enough problems without sleep deprivation joining them."
  "This is the scene where the protagonist finally closes the laptop."
  "You are not Batman. Go to bed."
  "Gotham can survive until morning."
  "Even Batman presumably sleeps occasionally."
  "The Force will still be there tomorrow."
  "These are not the productivity gains you're looking for."
  "Go to bed, young Padawan."
  "Your wakefulness is becoming a disturbance in the Force."
  "The Council has denied your request for another hour."
  "The One Ring can wait until morning."
  "You shall not pass... into another hour of this nonsense."
  "One does not simply stay productive indefinitely."
  "The beacons are lit. Bed calls for aid."
  "Even Gandalf disappeared for a while. You can manage eight hours."
  "It's dangerous to go alone. Take a pillow."
  "The fellowship is disbanding for the evening."
  "Winter is coming. Get under a blanket."
  "The night is dark and full of screen light."
  "Your watch has ended."
  "Not today, sleep deprivation."
  "The Iron Throne will still be contested tomorrow."
  "The arc reactor cannot compensate for poor sleep hygiene."
  "Jarvis would have shut this operation down by now."
  "Avengers, disassemble."
  "The endgame here is unconsciousness."
  "With great power comes great responsibility. Turn the computer off."
  "Your origin story does not require chronic sleep deprivation."
  "Even superheroes need a loading screen."
  "The Matrix will still be here when you wake up."
  "Take the red pill, take the blue pill, just take something that leads to bed."
  "Wake up, Neo. Actually, terrible timing. Go to sleep."
  "There is no spoon. There is, however, a bedtime."
  "Your simulation has exceeded today's runtime allocation."
  "Houston, we have a bedtime problem."
  "Failure to sleep is not an option."
  "Ground control recommends immediate horizontal orientation."
  "The mission can resume after scheduled crew rest."
  "Your command module is requesting shutdown."
  "This is your captain speaking: go to bed."
  "Scotty cannot give your brain any more power."
  "The engines cannae take much more, Captain."
  "Set course for bed. Maximum warp."
  "Resistance is futile. Sleep."
  "Computer, end program."
  "The holodeck is closed."
  "Your biological warp core requires maintenance."
  "The spice can wait."
  "Fear is the mind-killer. So is sleeping four hours."
  "The sleeper must awaken. But preferably tomorrow morning."
  "Arrakis will still be dry tomorrow."
  "Your terrible purpose tonight is getting into bed."
  "This is not the weirding way. This is just staying up too late."
  "The first rule of bedtime is: go to bedtime."
  "You met me at a very strange time in my sleep schedule."
  "This is your life, and it's ending one unnecessary late night at a time."
  "I am Jack's complete lack of circadian discipline."
  "Choose sleep. Choose a bed. Choose waking up functional."
  "You don't talk about staying up this late."
  "The Dude would absolutely abide by going to bed."
  "That screen really ties the sleep deprivation together."
  "Yeah, well, that's just like your bedtime, man."
  "Nobody puts bedtime in a corner."
  "I'll make you an offer you can't refuse: eight hours of unconsciousness."
  "Leave the laptop. Take the pillow."
  "May your dreams be less complicated than your open tabs."
  "Here's looking at you, kid. Now close the computer."
  "Frankly, my dear, tomorrow-you will give a damn."
  "You're gonna need a bigger pillow."
  "E.T. phone bed."
  "Life finds a way. So should you, toward the bedroom."
  "Clever girl. Now shut the laptop."
  "Welcome to Jurassic Park. The exhibits are closed."
  "Hasta la vista, wakefulness."
  "Come with me if you want to sleep."
  "I'll be back. After eight hours."
)

random_message() {
  local array_name="$1"
  local -n messages="$array_name"

  printf '%s\n' "${messages[RANDOM % ${#messages[@]}]}"
}

mode="$1"

case "$mode" in

# ------------------------------------------------------------
# LUNCH
# ------------------------------------------------------------
lunch)
  message=$(random_message lunch_messages)

  hour=$(date +%H)
  minute=$(date +%M)

  # Only accept the three intended trigger times.
  if ((10#$hour != 12)); then
    exit 0
  fi

  case "$minute" in
  00)
    notify-send \
      -t 180000 \
      -u normal \
      -c reminder-warning \
      "Lunch" \
      "$message"
    ;;

  05)
    notify-send \
      -t 180000 \
      -u normal \
      -c reminder-warning \
      "Lunch. Seriously." \
      "$message"
    ;;

  10)
    notify-send \
      -t 180000 \
      -u critical \
      -c reminder-critical \
      "GO EAT" \
      "$message"
    ;;

  *)
    exit 0
    ;;
  esac
  ;;

# ------------------------------------------------------------
# GYM
# ------------------------------------------------------------
gym)
  message=$(random_message gym_messages)

  hour=$(date +%H)
  minute=$(date +%M)

  # Only accept the three intended trigger times.
  if ((10#$hour != 17)); then
    exit 0
  fi

  case "$minute" in
  30)
    notify-send \
      -t 180000 \
      -u normal \
      -c reminder-warning \
      "Gym time" \
      "$message"
    ;;

  35)
    notify-send \
      -t 180000 \
      -u normal \
      -c reminder-warning \
      "Gym. Shoes. Go." \
      "$message"
    ;;

  40)
    notify-send \
      -t 180000 \
      -u critical \
      -c reminder-critical \
      "GO TO THE GYM" \
      "$message"
    ;;

  *)
    exit 0
    ;;
  esac
  ;;

# ------------------------------------------------------------
# SLEEP
# ------------------------------------------------------------
sleep)
  message=$(random_message sleep_messages)

  hour=$(date +%H)
  minute=$(date +%M)

  # Convert current clock time into minutes since midnight.
  now=$((10#$hour * 60 + 10#$minute))

  # Sleep reminder window:
  #
  #   23:30 -> 23:59
  #   00:00 -> 01:30
  #
  # Because this crosses midnight, treat the two portions separately.

  late_start=$((23 * 60 + 30)) # 1410
  early_end=$((1 * 60 + 30))   # 90

  if ! ((now >= late_start || now <= early_end)); then
    exit 0
  fi

  # First reminder: 23:30
  if ((hour == 23 && minute == 30)); then

    notify-send \
      -t 180000 \
      -u normal \
      -c reminder-warning \
      "Bedtime approaches" \
      "$message"

  # Second reminder: 23:35
  elif ((hour == 23 && minute == 35)); then

    notify-send \
      -t 180000 \
      -u critical \
      -c reminder-critical \
      "Go to bed" \
      "$message"

  # Everything from 23:40 onward is critical.
  else

    notify-send \
      -t 180000 \
      -u critical \
      -c reminder-critical \
      "GO TO SLEEP" \
      "$message"

  fi
  ;;

# ------------------------------------------------------------
# INVALID MODE
# ------------------------------------------------------------
*)
  echo "Usage: $0 {lunch|gym|sleep}" >&2
  exit 1
  ;;
esac
