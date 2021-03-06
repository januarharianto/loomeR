#' @title Constant Speed Model
#'
#' @description Given a viewing distance, this function calculates the on-screen
#'   diameters of a hypothetical object of defined size approaching at a
#'   constant speed. This allows a looming animation with precise parameters to
#'   be created.
#'
#' @details Calculates the screen diameters for a modelled object of specified
#'   size approaching at a constant speed, from a specified distance away. The
#'   output list object can be used to create a looming animation in
#'   \code{\link{looming_animation}}. An object screen diameter is calculated
#'   for each frame from the specified starting distance until the hypothetical
#'   distance between the attacker and target is zero.
#'
#'   Requires the intended frame rate at which the subsequent animation will be
#'   played, and distance from the screen at which the observing specimen will
#'   be located. These details are important in experiments where you want to
#'   precisely determine at what time, perceived distance, or perceived velocity
#'   of an attack an escape response occurs. Note: if the specimen is closer or
#'   further away than the specified screen distance, the animation will be
#'   perceived as a different distance and a different velocity.
#'
#'   If you need to create a looming animation simply to elicit a response, and
#'   are not concerned with the precise details, the function is more than
#'   capable of this. Simply enter some inputs, use
#'   \code{\link{looming_animation}} to create the animation, play it back and
#'   if it is not what you want, go back and vary the inputs until you are happy
#'   with the result. For instance, to change the starting diameter of the
#'   animation (and hence its total duration), modify the \code{start_distance}
#'   parameter until you get the starting diameter or total duration you want.
#'
#'   Inputs should be in \code{cm}, speed in \code{cm/s}, and frame rate in
#'   \code{Hz} or \code{Frames per Second}.
#'
#' @seealso \code{\link{looming_animation}},
#'   \code{\link{looming_animation_calib}},  \code{\link{variable_speed_model}}
#'
#' @param screen_distance numeric. Distance (cm) from the playback screen to
#'   your specimen.
#' @param anim_frame_rate numeric. Frames per second (Hz) you want the resulting
#'   animation to be.
#' @param speed numeric. Speed (cm/s) of the hypothetical approaching attacker.
#' @param attacker_diameter numeric. Diameter of the hypothetical approaching
#'   attacker
#' @param start_distance numeric. Starting distance of the hypothetical
#'   approaching attacker
#'
#' @return List object containing the input parameters and the resulting
#'   diameter for each frame in the animation.
#'
#' @examples
#' loom_model <- constant_speed_model(
#'                      screen_distance = 20,
#'                      anim_frame_rate = 60,
#'                      speed = 500,
#'                      attacker_diameter = 50,
#'                      start_distance = 1000)
#'
#' @author Nicholas Carey - \email{nicholascarey@gmail.com}
#'
#' @export

constant_speed_model <-
  function(
    screen_distance = 20,
    anim_frame_rate = 60,
    speed = 500,
    attacker_diameter = 50,
    start_distance = 1000){

    ## calculate total time of animation
    total_time <- start_distance/speed

    ## get number of frames
    ## ceiling to round up, otherwise results df will be a frame short if total frames ends up a decimal
    total_frames <- ceiling(total_time*anim_frame_rate)

    ## calculate distance covered each frame at this speed and frame rate
    ## rounding it because of ridiculously long results in later calcs
    distance_per_frame <- round(speed/anim_frame_rate, 3)

    ## build up data frame
    ## list of frames
    results_df <- data.frame(frame = seq(1,total_frames,1))

    ## add time
    results_df$time <- results_df$frame/anim_frame_rate

    ## add hypothetical predator distance
    results_df$distance <- start_distance-((results_df$frame) * distance_per_frame)

    ## add screen diameter of model for each frame
    results_df$diam_on_screen <- (attacker_diameter*screen_distance)/results_df$distance
    ## set last value to 1000 cm
    ## this is because rounding of distance_per_frame above can cause small negative
    ## or positive values as last entry when calculating distance. Therefore diameter
    ## becomes ridiculously large (or negative) A zero distance also cause 'inf' values
    ## when dividing above.
    results_df$diam_on_screen[length(results_df$diam_on_screen)] <- 1000


    ## assemble output list object
    output <- list(
      model = results_df,
      screen_distance = screen_distance,
      anim_frame_rate = anim_frame_rate,
      speed = speed,
      attacker_diameter = attacker_diameter,
      start_distance = start_distance
    )

    class(output) <- "constant_speed_model"

    return(output)
  }
