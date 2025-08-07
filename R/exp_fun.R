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

