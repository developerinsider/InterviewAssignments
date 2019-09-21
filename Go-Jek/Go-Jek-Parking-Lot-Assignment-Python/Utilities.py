class Car:
    """
    Car class
    """

    def __init__(self, registrationNumber, colour):
        """
        Constructor for Car object

        ARGS:
            registrationNumber(str) - given registration number of the car
            colour(str) - given colour of the car
        """
        self.carRegistrationNumber = registrationNumber
        self.carColour = colour
        self.carSlot = None

    def set_slot(self, slot):
        """
        Setter for slot

        ARGS:
            slot(int) - the allocated slot for the car
        """
        self.carSlot = slot

    def get_slot(self):
        """
        Getter for slot
        """
        return self.carSlot

    def get_colour(self):
        """
        Getter for colour
        """
        return self.carColour

    def get_registration_number(self):
        """
        Getter for Registration Number
        """
        return self.carRegistrationNumber


class ParkingLot:
    """
    Parking Lot Class
    """

    def __init__(self, size):
        """
        Constructor for Parking Lot

        ARGS:
            size(int) - size of the parking lot
        """
        self.parkedCars = 0
        self.slots = dict.fromkeys([i for i in range(1, int(size)+1)])

    def increment_parked_cars(self):
        """
        will increment the number of parked cars
        """
        self.parkedCars += 1

    def decrement_parked_cars(self):
        """
        will decrement the number of parked cars
        """
        self.parkedCars -= 1

    def get_parked_cars(self):
        """
        getter for the number of parked cars
        """
        return self.parkedCars

    def get_slots(self):
        """
        getter for the parking slots
        """
        return self.slots

    def set_slots(self, slot, value):
        """
        setter for parking slots

        ARGS:
            slot(int) - where to place the incoming value
            value(Nonetype or Car object) - for setting the value on the given slot
        """
        self.slots[slot] = value


def create_parking_lot(size):
    """
    creates a parking lot

    ARGS:
        size(str) - size of the parking lot
    """
    parkingLot = ParkingLot(int(size))
    print('Created a parking slot with ' + size + ' slots')
    return parkingLot


def parking_lot_is_full(parkingLot):
    """
    checks whether parking lot is full or not

    ARGS:
        parkingLot(ParkingLot Object)
    """
    return len(parkingLot.get_slots()) <= parkingLot.get_parked_cars()


def park_car(parkingLot, registrationNumber, colour):
    """
    will park the car in the parking lot and prints the allocated slot in the parking lot

    ARGS:
        parkingLot(ParkingLot Object)
        registrationNumber(str) - given registration number for the car
        colour(str) - given colour for the car
    """
    returnString = ''
    if parkingLot:
        if not parking_lot_is_full(parkingLot):
            parkingSlot = parkingLot.get_slots()
            for slot in parkingSlot.keys():
                if parkingSlot[slot] is None:
                    car = Car(registrationNumber, colour)
                    parkingLot.set_slots(slot, car)
                    car.set_slot(slot)
                    parkingLot.increment_parked_cars()
                    returnString = 'Allocated slot number: ' + str(slot)
                    break
        else:
            returnString = 'Sorry, parking lot is full'
    else:
        returnString = 'Parking lot is not defined'
    return returnString


def car_departure(parkingLot, inputSlot):
    """
    will leave the parking lot from desired slot and prints the leaving slot

    ARGS:
        parkingLot(ParkingLot Object)
        inputSlot(str) - given slot number
    """
    returnString = ''
    if parkingLot:
        if not parkingLot.get_parked_cars():
            returnString = 'Sorry, parking lot is empty'
        elif int(inputSlot) >= 1 and int(inputSlot) <= len(parkingLot.get_slots()):
            parkingSlot = parkingLot.get_slots()
            value = parkingSlot.get(int(inputSlot), None)
            if value is not None:
                parkingLot.set_slots(int(inputSlot), None)
                parkingLot.decrement_parked_cars()
                returnString = 'Slot number ' + inputSlot + ' is free'
            else:
                returnString = 'No car at Slot number ' + inputSlot
        else:
            returnString = 'Cannot exit slot: ' + inputSlot + ' as no such exist!'
    else:
        returnString = 'Parking lot is not defined'
    return returnString


def lot_status(parkingLot):
    """
    return the status of Parking Lot

    ARGS:
        parkingLot(ParkingLot Object)
    """
    returnString = ''
    if parkingLot:
        print('Slot No.\tRegistration No\tColour')
        parkingSlot = parkingLot.get_slots()
        for parkedCar in parkingSlot.values():
            if parkedCar is not None:
                returnString += str(parkedCar.get_slot()) + '\t' + \
                    parkedCar.get_registration_number() + '\t' + \
                    parkedCar.get_colour() + '\n'
    else:
        returnString = 'Parking lot is not defined'
    return returnString


def car_by_colour(parkingLot, inputColour):
    """
    prints the registration number of the cars for the given colour

    ARGS:
        parkingLot(ParkingLot Object)
        inputColour(str) - given Colour
    """
    returnString = ''
    if parkingLot:
        if not parkingLot.get_parked_cars():
            returnString = 'Sorry, parking lot is empty'
        else:
            flag = False
            parkingSlot = parkingLot.get_slots()
            for parkedCar in parkingSlot.values():
                if parkedCar is not None:
                    if parkedCar.get_colour() == inputColour:
                        flag = True
                        returnString += parkedCar.get_registration_number() + ', '
            if not flag:
                returnString = 'Not found'
    else:
        returnString = 'Parking lot is not defined'
    return returnString


def slot_by_colour(parkingLot, inputColour):
    """
    prints the slot number of the cars for the given colour

    ARGS:
        parkingLot(ParkingLot Object)
        inputColour(str) - given colour
    """
    returnString = ''
    if parkingLot:
        if not parkingLot.get_parked_cars():
            returnString = 'Sorry, parking lot is empty'
        else:
            flag = False
            parkingSlot = parkingLot.get_slots()
            for parkedCar in parkingSlot.values():
                if parkedCar is not None:
                    if parkedCar.get_colour() == inputColour:
                        flag = True
                        returnString += str(parkedCar.get_slot()) + ', '
            if not flag:
                returnString = 'Not found'
    else:
        returnString = 'Parking Lot is not defined'
    return returnString


def slot_by_car_number(parkingLot, number):
    """
    prints the slot number of the cars for the given number

    ARGS:
        parkingLot(ParkingLot Object)
        number(str) - given registration number
    """
    returnString = ''
    if parkingLot:
        if not parkingLot.get_parked_cars():
            returnString = 'Sorry, parking lot is empty'
        else:
            flag = False
            parkingSlot = parkingLot.get_slots()
            for parkedCar in parkingSlot.values():
                if parkedCar is not None:
                    if parkedCar.get_registration_number() == number:
                        flag = True
                        returnString += str(parkedCar.get_slot()) + ', '
                        # assuming that for the cars, there is one and only one registration number exits
                        break
            if not flag:
                returnString = 'Not found'
    else:
        returnString = 'Parking lot is not defined'
    return returnString
