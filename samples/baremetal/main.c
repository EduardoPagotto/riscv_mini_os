extern void put_char(char c);

void print(const char* s) {
    while (*s)
        put_char(*s++);
}

int main() {
    print("hello\n");
    return 0;
}
