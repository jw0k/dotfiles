import signal
import keyboard
import time
import os

class MyKeyEventClass1(object):
    def __init__(self):
        self.done = False
        signal.signal(signal.SIGINT, self.cleanup)
        # keyboard.hook(self.my_on_key_event)

        self.f_pressed = False
        self.d_pressed = False

        keyboard.on_press_key('f', self.f_down)
        keyboard.on_release_key('f', self.f_up)

        keyboard.on_press_key('d', self.d_down)
        keyboard.on_release_key('d', self.d_up)

        while not self.done:
            time.sleep(1)  #  Wait for Ctrl+C

    def cleanup(self, signum, frame):
        self.done = True

    # def my_on_key_event(self, e):
        # print("Got key release event: " + str(e))

    def f_down(self, e):
        if not self.f_pressed:
            os.system("xdotool mousedown 1")
        self.f_pressed = True

    def f_up(self, e):
        if self.f_pressed:
            os.system("xdotool mouseup 1")
        self.f_pressed = False

    def d_down(self, e):
        if not self.d_pressed:
            os.system("xdotool mousedown 3")
        self.d_pressed = True

    def d_up(self, e):
        if self.d_pressed:
            os.system("xdotool mouseup 3")
        self.d_pressed = False

a = MyKeyEventClass1()
