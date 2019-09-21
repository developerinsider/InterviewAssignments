import unittest
from Utilities import create_parking_lot, park_car, parking_lot_is_full, car_departure, \
    car_by_colour, slot_by_car_number, slot_by_colour


class TestParkingLotUtilities(unittest.TestCase):
    """
    will test the endpoints
    """

    def test_create_parking_lot(self):
        testParkingLot = create_parking_lot(str(6))
        self.assertEqual(len(testParkingLot.get_slots()), 6)

    def test_parking_lot_is_full(self):
        testParkingLot = create_parking_lot(str(6))
        self.assertEqual(parking_lot_is_full(testParkingLot), False)

    def test_park_car_lot_not_defined(self):
        testString = park_car(None, 'KA-01-AA-1111', 'White')
        self.assertEqual('Parking lot is not defined', testString)

    def test_park_car_lot_allocated(self):
        testParkingLot = create_parking_lot(str(6))
        testString = park_car(testParkingLot, 'KA-01-AA-1112', 'White')
        self.assertEqual('Allocated slot number: 1', testString)

    def test_park_car_lot_full(self):
        testParkingLot = create_parking_lot(str(1))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1112', 'White')
        testString = park_car(testParkingLot, 'KA-01-AA-1113', 'White')
        self.assertEqual('Sorry, parking lot is full', testString)

    def test_car_departure_empty(self):
        testParkingLot = create_parking_lot(str(6))
        testString = car_departure(testParkingLot, '1')
        self.assertEqual('Sorry, parking lot is empty', testString)

    def test_car_departure_free(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1114', 'White')
        testString = car_departure(testParkingLot, '1')
        self.assertEqual('Slot number 1 is free', testString)

    def test_car_departure_cannot_exit(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1115', 'White')
        testString = car_departure(testParkingLot, '7')
        self.assertEqual('Cannot exit slot: 7 as no such exist!', testString)

    def test_car_departure_slot_free(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1116', 'White')
        testString = car_departure(testParkingLot, '2')
        self.assertEqual('No car at Slot number 2', testString)

    def test_car_departure_not_defined(self):
        testString = car_departure(None, '1')
        self.assertEqual('Parking lot is not defined', testString)

    def test_car_by_colour(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1117', 'White')
        testString = car_by_colour(testParkingLot, 'White')
        self.assertEqual(testString, 'KA-01-AA-1117, ')

    def test_slot_by_car_number_not_found(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1118', 'White')
        testString = slot_by_car_number(testParkingLot, 'KA-01-AA-1113')
        self.assertEqual(testString, 'Not found')

    def test_slot_by_car_number(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1103', 'White')
        testString = slot_by_car_number(testParkingLot, 'KA-01-AA-1103')
        self.assertEqual(testString, '1, ')

    def test_slot_by_colour(self):
        testParkingLot = create_parking_lot(str(6))
        testParkString = park_car(testParkingLot, 'KA-01-AA-1119', 'White')
        testString = slot_by_colour(testParkingLot, 'White')
        self.assertEqual(testString, '1, ')


if __name__ == '__main__':
    unittest.main()
