const int potPin = 27;
#define BUTTON_PIN 2
#define LED_PIN 15
int xyzPins[] = {39, 32, 33}; // x, y, joystick switch
void setup() {
  Serial.begin(9600);
  pinMode(xyzPins[2], INPUT_PULLUP);
  pinMode(potPin, INPUT);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(LED_PIN, OUTPUT);
}
void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  int potVal = analogRead(potPin);
  int buttonState = digitalRead(BUTTON_PIN);
  digitalWrite(LED_PIN, buttonState == LOW ? HIGH : LOW);
  Serial.printf("%d,%d,%d,%d,%d\n", xVal, yVal, zVal, potVal, buttonState);
  delay(100);
}
