using SharpDX.DirectInput;
using SharpDX.XInput;
using System.Collections.Generic;

namespace JWNameSpace
{
    public partial class JoystickWrapper
    {
        // Maps SharpDX "Offsets" (Input Identifiers) to both iinput type and input index (eg x axis to axis 1)
        private static Dictionary<InputType, List<JoystickOffset>> inputMappings = new Dictionary<InputType, List<JoystickOffset>>(){
            {
                InputType.AXIS, new List<JoystickOffset>()
                {
                    JoystickOffset.X,
                    JoystickOffset.Y,
                    JoystickOffset.Z,
                    JoystickOffset.RotationX,
                    JoystickOffset.RotationY,
                    JoystickOffset.RotationZ,
                    JoystickOffset.Sliders0,
                    JoystickOffset.Sliders1
                }
            },
            {
                InputType.BUTTON, new List<JoystickOffset>()
                {
                    JoystickOffset.Buttons0, JoystickOffset.Buttons1, JoystickOffset.Buttons2, JoystickOffset.Buttons3, JoystickOffset.Buttons4,
                    JoystickOffset.Buttons5, JoystickOffset.Buttons6, JoystickOffset.Buttons7, JoystickOffset.Buttons8, JoystickOffset.Buttons9, JoystickOffset.Buttons10,
                    JoystickOffset.Buttons11, JoystickOffset.Buttons12, JoystickOffset.Buttons13, JoystickOffset.Buttons14, JoystickOffset.Buttons15, JoystickOffset.Buttons16,
                    JoystickOffset.Buttons17, JoystickOffset.Buttons18, JoystickOffset.Buttons19, JoystickOffset.Buttons20, JoystickOffset.Buttons21, JoystickOffset.Buttons22,
                    JoystickOffset.Buttons23, JoystickOffset.Buttons24, JoystickOffset.Buttons25, JoystickOffset.Buttons26, JoystickOffset.Buttons27, JoystickOffset.Buttons28,
                    JoystickOffset.Buttons29, JoystickOffset.Buttons30, JoystickOffset.Buttons31, JoystickOffset.Buttons32, JoystickOffset.Buttons33, JoystickOffset.Buttons34,
                    JoystickOffset.Buttons35, JoystickOffset.Buttons36, JoystickOffset.Buttons37, JoystickOffset.Buttons38, JoystickOffset.Buttons39, JoystickOffset.Buttons40,
                    JoystickOffset.Buttons41, JoystickOffset.Buttons42, JoystickOffset.Buttons43, JoystickOffset.Buttons44, JoystickOffset.Buttons45, JoystickOffset.Buttons46,
                    JoystickOffset.Buttons47, JoystickOffset.Buttons48, JoystickOffset.Buttons49, JoystickOffset.Buttons50, JoystickOffset.Buttons51, JoystickOffset.Buttons52,
                    JoystickOffset.Buttons53, JoystickOffset.Buttons54, JoystickOffset.Buttons55, JoystickOffset.Buttons56, JoystickOffset.Buttons57, JoystickOffset.Buttons58,
                    JoystickOffset.Buttons59, JoystickOffset.Buttons60, JoystickOffset.Buttons61, JoystickOffset.Buttons62, JoystickOffset.Buttons63, JoystickOffset.Buttons64,
                    JoystickOffset.Buttons65, JoystickOffset.Buttons66, JoystickOffset.Buttons67, JoystickOffset.Buttons68, JoystickOffset.Buttons69, JoystickOffset.Buttons70,
                    JoystickOffset.Buttons71, JoystickOffset.Buttons72, JoystickOffset.Buttons73, JoystickOffset.Buttons74, JoystickOffset.Buttons75, JoystickOffset.Buttons76,
                    JoystickOffset.Buttons77, JoystickOffset.Buttons78, JoystickOffset.Buttons79, JoystickOffset.Buttons80, JoystickOffset.Buttons81, JoystickOffset.Buttons82,
                    JoystickOffset.Buttons83, JoystickOffset.Buttons84, JoystickOffset.Buttons85, JoystickOffset.Buttons86, JoystickOffset.Buttons87, JoystickOffset.Buttons88,
                    JoystickOffset.Buttons89, JoystickOffset.Buttons90, JoystickOffset.Buttons91, JoystickOffset.Buttons92, JoystickOffset.Buttons93, JoystickOffset.Buttons94,
                    JoystickOffset.Buttons95, JoystickOffset.Buttons96, JoystickOffset.Buttons97, JoystickOffset.Buttons98, JoystickOffset.Buttons99, JoystickOffset.Buttons100,
                    JoystickOffset.Buttons101, JoystickOffset.Buttons102, JoystickOffset.Buttons103, JoystickOffset.Buttons104, JoystickOffset.Buttons105, JoystickOffset.Buttons106,
                    JoystickOffset.Buttons107, JoystickOffset.Buttons108, JoystickOffset.Buttons109, JoystickOffset.Buttons110, JoystickOffset.Buttons111, JoystickOffset.Buttons112,
                    JoystickOffset.Buttons113, JoystickOffset.Buttons114, JoystickOffset.Buttons115, JoystickOffset.Buttons116, JoystickOffset.Buttons117, JoystickOffset.Buttons118,
                    JoystickOffset.Buttons119, JoystickOffset.Buttons120, JoystickOffset.Buttons121, JoystickOffset.Buttons122, JoystickOffset.Buttons123, JoystickOffset.Buttons124,
                    JoystickOffset.Buttons125, JoystickOffset.Buttons126, JoystickOffset.Buttons127
                }
            },
            {
                InputType.POV, new List<JoystickOffset>()
                {
                    JoystickOffset.PointOfViewControllers0,
                    JoystickOffset.PointOfViewControllers1,
                    JoystickOffset.PointOfViewControllers2,
                    JoystickOffset.PointOfViewControllers3
                }

            }
        };

        public enum XIInputType { Axis, Button, Dpad }
        private enum xinputAxes {  LeftThumbX = 1, LeftThumbY, RightThumbX, RightThumbY, LeftTrigger, RightTrigger }
        private enum xinputButtons { A = 1, B, X, Y, L, R, Back, Start, LS, RS }

        private static List<string> xinputAxisIdentifiers = new List<string>()
        {
            "LeftThumbX", "LeftThumbY", "LeftTrigger", "RightThumbX", "RightThumbY", "RightTrigger"
        };

        private static List<GamepadButtonFlags> xinputButtonIdentifiers = new List<GamepadButtonFlags>()
        {
            GamepadButtonFlags.A, GamepadButtonFlags.B, GamepadButtonFlags.X, GamepadButtonFlags.Y
            , GamepadButtonFlags.LeftShoulder, GamepadButtonFlags.RightShoulder, GamepadButtonFlags.Back, GamepadButtonFlags.Start
            , GamepadButtonFlags.LeftThumb, GamepadButtonFlags.RightThumb
        };

        private static List<GamepadButtonFlags> xinputDpadDirectionIdentifiers = new List<GamepadButtonFlags>()
        {
            GamepadButtonFlags.DPadUp, GamepadButtonFlags.DPadRight, GamepadButtonFlags.DPadDown, GamepadButtonFlags.DPadLeft
        };
    }
}