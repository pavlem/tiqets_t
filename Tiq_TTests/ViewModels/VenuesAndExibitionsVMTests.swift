//
//  VenuesAndExibitionsVMTests.swift
//  Tiq_TTests
//
//  Created by Pavle Mijatovic on 8.2.22..
//

import XCTest
@testable import Tiq_T
@testable import NetworkProvider


class VenuesAndExibitionsVMTests: XCTestCase {

    func testIsInAWishListForUUID() {
        
        // given
        let uuid1 = UUID(); let uuid2 = UUID()
        let venue1 = VenueAndExibition(id: uuid1, type: OfferingType.venue, name: "", image: "", priceCurrencyCode: "", price: "", starsRating: Double(1.0), location: "", startDate: "", endDate: "")
        let venue2 = VenueAndExibition(id: uuid2, type: OfferingType.venue, name: "", image: "", priceCurrencyCode: "", price: "", starsRating: Double(1.0), location: "", startDate: "", endDate: "")
        let venueCellVM1 = VenueAndExibitionCellVM(venueAndExibition: venue1)
        let venueCellVM2 = VenueAndExibitionCellVM(venueAndExibition: venue2)
        
        let venuesVM = VenuesAndExibitionsVM(venueAndExibitionRepo: VenueAndExibitionLocal())
        
        // when
        venuesVM.venuesAndExibitionsWishes = [venueCellVM1, venueCellVM2]

        // then
        XCTAssertTrue(venuesVM.isInAWishList(forUUID: uuid1))
        XCTAssertTrue(venuesVM.isInAWishList(forUUID: uuid2))
        XCTAssertFalse(venuesVM.isInAWishList(forUUID: UUID()))
    }
    
    func testAddOrRemoveToWishesUUID() {
        
        // given
        let uuid1 = UUID(); let uuid2 = UUID()
        let venue1 = VenueAndExibition(id: uuid1, type: OfferingType.venue, name: "", image: "", priceCurrencyCode: "", price: "", starsRating: Double(1.0), location: "", startDate: "", endDate: "")
        let venue2 = VenueAndExibition(id: uuid2, type: OfferingType.venue, name: "", image: "", priceCurrencyCode: "", price: "", starsRating: Double(1.0), location: "", startDate: "", endDate: "")
        let venueCellVM1 = VenueAndExibitionCellVM(venueAndExibition: venue1)
        let venueCellVM2 = VenueAndExibitionCellVM(venueAndExibition: venue2)
        let venuesVM = VenuesAndExibitionsVM(venueAndExibitionRepo: VenueAndExibitionLocal())

        XCTAssertTrue(venuesVM.venuesAndExibitionsWishes.count == 0)
        venuesVM.addOrRemoveToWishes(uuid: uuid1)
        XCTAssertTrue(venuesVM.venuesAndExibitionsWishes.filter { $0.id == uuid1 }.count == 0)
        
        venuesVM.venuesAndExibitions = [venueCellVM1, venueCellVM2]
        venuesVM.addOrRemoveToWishes(uuid: uuid1)
        XCTAssertTrue(venuesVM.venuesAndExibitionsWishes.filter { $0.id == uuid1 }.count == 1)

        XCTAssertTrue(venuesVM.venuesAndExibitionsWishes.filter { $0.id == uuid2 }.count == 0)
        venuesVM.addOrRemoveToWishes(uuid: uuid2)
        XCTAssertTrue(venuesVM.venuesAndExibitionsWishes.filter { $0.id == uuid2 }.count == 1)
    }
}
