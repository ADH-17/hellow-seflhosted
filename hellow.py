import time

def print_hello_world(times=1, delay=5):
    for _ in range(times):
        print("HelloWorld")
        time.sleep(delay)

def get_integers():
    x = 5
    y = 6
    z = 2
    w = 3
    return x, y, z, w

if __name__ == "__main__":
    print_hello_world()
    get_integers()
