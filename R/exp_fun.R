# Visual Angle calculator -------------------------------------------------

# Thanks to http://stephenrho.github.io/visual-angle.html

#' get_stim_degree
#' @description calculating the visual
#' @param size stimulus size
#' @param distance distance from the screen
#' @return the angle
#' @export
#'

get_stim_degree <- function(size, distance){
  # this function calculates visual angle
  # size and distance must be in the same units
  Rad = 2*atan(size/(2*distance))
  Ang = Rad*(180/pi)
  return(Ang)
}

#' get_stim_size
#' @description calculating the visual
#' @param vis_angle stimulus size in degrees of visual angles
#' @param distance distance from the screen
#' @return the distance
#' @export
#'

get_stim_size <- function(vis_angle, distance){
  # this function gives desired size of stimulus
  # given visual angle and distance
  # size returned is in same units and distance
  Rad = vis_angle/(180/pi) # or pi*(visAngle/180)
  size = 2*distance*tan(Rad/2)
  return(size)
}

#' rad_to_deg
#' @description convert radians to degrees
#' @param rad numeric indicating the angle in radians
#'
#' @return the angle in radians
#' @export
#'
#'
rad_to_deg <- function(rad){
  rad * 180/pi
}

#' deg_to_rad
#' @description convert degrees to radians
#' @param deg numeric indicating the angle in degrees
#'
#' @return the angle in degrees
#' @export
#'
#'
deg_to_rad <- function(deg){
  deg * pi/180
}

#' frames_to_dur
#'
#' @param nframes the number of frames
#' @param refresh_rate the monitor refresh rate (e.g. 60)
#'
#' @return the duration in ms
#' @export
#'
#'
frames_to_dur <- function(nframes, refresh_rate){
  1/refresh_rate * nframes * 1000 # in ms
}

#' dur_to_frames
#' @description return the number of frames associated with a specific duration (in ms)
#' @param duration the duration in ms
#' @param refresh_rate the monitor refresh rate (e.g. 60)
#'
#' @return the number of frames
#' @export
#'
dur_to_frames <- function(duration, refresh_rate){
  duration / (1/refresh_rate * 1000)
}

#' Express a Probability Relative to Chance
#'
#' Converts a probability or accuracy value to a chance-relative scale.
#' The chance level is mapped to 0, and perfect performance is mapped to 1.
#' Values below chance become negative.
#'
#' @param p Numeric vector. Observed probability or accuracy values.
#'   Values must be between 0 and 1.
#' @param chance Numeric vector or scalar. Chance-level probability.
#'   Defaults to `1/2`. Values must be greater than or equal to 0 and
#'   strictly less than 1.
#'
#' @details
#' The transformation is:
#'
#' \deqn{
#'   \frac{p - chance}{1 - chance}
#' }
#'
#' This expresses performance as the proportion of the maximum possible
#' improvement above chance.
#'
#' For example, if `p = 0.75` and `chance = 0.5`, then the chance-relative
#' score is `0.5`, meaning that performance covers 50% of the possible
#' improvement from chance to perfect accuracy.
#'
#' @return A numeric vector of chance-relative scores. Values are 0 at chance,
#'   1 at perfect performance, and negative below chance.
#'
#' @examples
#' rel_chance(0.75, chance = 0.5)
#' rel_chance(c(0.55, 0.60, 0.70), chance = 0.5)
#'
#' @export
rel_chance <- function(p, chance = 1/2) {
  stopifnot(
    "p must be a probability (0 <= p <= 1)" = all(0 <= p & p <= 1),
    "chance must be a probability (0 <= chance < 1)" = all(0 <= chance & chance < 1)
  )

  (p - chance) / (1 - chance)
}


#' Rescale a Probability to a Different Chance Level
#'
#' Converts a probability or accuracy value from one chance-level scale to
#' another while preserving the same chance-relative performance.
#'
#' @param p Numeric vector. Observed probability or accuracy values on the
#'   original scale. Values must be between 0 and 1.
#' @param chance.old Numeric vector or scalar. Original chance-level probability.
#'   Values must be greater than or equal to 0 and strictly less than 1.
#' @param chance.new Numeric vector or scalar. New chance-level probability.
#'   Values must be between 0 and 1.
#'
#' @details
#' The transformation first computes chance-relative performance:
#'
#' \deqn{
#'   r = \frac{p - chance.old}{1 - chance.old}
#' }
#'
#' and then maps it onto the new chance-level scale:
#'
#' \deqn{
#'   p_{new} = chance.new + r(1 - chance.new)
#' }
#'
#' Equivalently:
#'
#' \deqn{
#'   p_{new} =
#'   chance.new +
#'   \frac{p - chance.old}{1 - chance.old}(1 - chance.new)
#' }
#'
#' This preserves the relative distance between chance and perfect performance.
#'
#' @return A numeric vector of probabilities rescaled to the new chance level.
#'
#' @examples
#' rescale_chance(0.60, chance.old = 0.5, chance.new = 0.2)
#'
#' p <- c(0.55, 0.60, 0.70)
#' rescale_chance(p, chance.old = 0.5, chance.new = 0.25)
#'
#' @export
rescale_chance <- function(p, chance.old, chance.new) {
  stopifnot(
    "p must be a probability (0 <= p <= 1)" = all(0 <= p & p <= 1),
    "chance.old must be a probability (0 <= chance.old < 1)" = all(0 <= chance.old & chance.old < 1),
    "chance.new must be a probability (0 <= chance.new <= 1)" = all(0 <= chance.new & chance.new <= 1)
  )

  chance.new + rel_chance(p, chance.old) * (1 - chance.new)
}
