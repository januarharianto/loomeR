% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/diameter_model.R
\name{diameter_model}
\alias{diameter_model}
\title{Diameter Model}
\usage{
diameter_model(start_diameter = 3, end_diameter = 50, duration = 3,
  anim_frame_rate = 60, expansion = "constant_speed")
}
\arguments{
\item{start_diameter}{numeric. Diameter (cm) you want the animation to start
at.}

\item{end_diameter}{numeric. Diameter (cm) you want the animation to end at.
If you want the animation to fill the screen, this should be slightly
larger than the physical screen size.}

\item{duration}{numeric. Total duration (s) you want the animation to be.}

\item{anim_frame_rate}{numeric. Frames per second (Hz) you want the resulting
animation to be played at.}

\item{expansion}{string. \code{constant_speed} or \code{constant_diameter}.
Sets if the expansion of the simulation is modelled as a constant speed or
constant increase in diameter (see Details).}
}
\value{
List object containing the input parameters and a model with the
  resulting diameter for each frame in the animation.
}
\description{
Creates a simple model for making a looming animation by setting
  start and end screen diameters and total duration
}
\details{
Creates a simple expansion model for use in
  \code{looming_animation}, from a start and end diameter, and a total
  duration. Expansion of the simulation can be set in two ways. In the
  default, \code{constant_speed}, the function models the expansion of the
  simulated oncoming object as if it were approaching at a constant speed.
  Because of visual foreshortening, this results in a simulation that expands
  progressively more rapidly as the animation progresses. If \code{=
  constant_diameter}, the function instead imposes a constant increase in
  diameter, i.e. a simulation that expands by the same amount in diameter in
  each frame. This simulation represents an oncoming object that is starting
  off at high speed, but slowing down as it gets closer to the target.

  Inputs should be in \code{cm}, duration in seconds (s), and frame rate in
  \code{Hz} or \code{Frames per Second}.
}
\examples{
loom_model <- diameter_model(
                     start_diameter = 2,
                     end_diameter = 50,
                     duration = 3,
                     anim_frame_rate = 60,
                     expansion = "constant_speed")

}
\seealso{
\code{\link{looming_animation}},
  \code{\link{looming_animation_calib}},  \code{\link{variable_speed_model}}
  \code{\link{constant_speed_model}},
}
\author{
Nicholas Carey - \email{nicholascarey@gmail.com}
}
