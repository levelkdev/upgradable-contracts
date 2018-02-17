/* global describe it beforeEach artifacts */

import { expect } from 'chai'

const Coordinator = artifacts.require('Coordinator')
const CoordinatorStorageDelegate = artifacts.require('CoordinatorStorageDelegate')
const DelegatedStorage = artifacts.require('DelegatedStorage')


const UpgradableContract = artifacts.require('UpgradableContract')
const NumTrackerDelegate1 = artifacts.require('NumTrackerDelegate1')
const NumTrackerDelegate2 = artifacts.require('NumTrackerDelegate2')
const NumStorage = artifacts.require('NumStorage')

const NUM = 123456789

describe.only('Upgrade', () => {
  it.only('should also allow for upgrades', async () => {
    let num
    // Deploy delegates
    // If delegates have been deployed, they can be reused
    const coordinatorStorageDelegate = await CoordinatorStorageDelegate.new()
    const numTrackerDelegate1 = await NumTrackerDelegate1.new()
    const numTrackerDelegate2 = await NumTrackerDelegate2.new()

    // Set up storage and coordinator
    const coordinator = await Coordinator.new(coordinatorStorageDelegate.address)
    const storage = await DelegatedStorage.at(await coordinator._storage())

    const numStorage = await NumStorage.new()
    const upgradableContract = await UpgradableContract.new(storage.address, coordinator.address)
    let numTracker = await NumTrackerDelegate1.at(upgradableContract.address);


    await coordinator.setContract('NumTracker', numTracker.address)
    await coordinator.setStorageDelegate('NumTracker', numStorage.address)
    await coordinator.setDelegate('NumTracker', numTrackerDelegate1.address)

    // Set num to NUM
    await numTracker.setNum(NUM)
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // upgrade NumTracker to NumTracker2
    await coordinator.setDelegate('NumTracker', numTrackerDelegate2.address)
    numTracker = await NumTrackerDelegate2.at(numTracker.address);

    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // Use NumTracker2 new functionality to add one
    await numTracker.addOne()
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM + 1)
  })

  it('should allow for upgrades', async () => {
    let num
    const storageDelegate = await PersistentStorageDelegate.new()
    const coordinator = await Coordinator.new(storageDelegate.address)
    const storage = await PersistentStorage.at(await coordinator._storage())
    const numTrackerDelegate1 = await NumTrackerDelegate1.new()
    const numStorage = await NumStorage.new()
    const numTrackerProxy = await NumTracker.new(storage.address)
    let numTracker = await NumTrackerDelegate1.at(numTrackerProxy.address);

    await coordinator.setContract('NumTracker', numTracker.address)
    await coordinator.setStorageDelegate('NumTracker', numStorage.address)
    await coordinator.setDelegate('NumTracker', numTrackerDelegate1.address)

    // Set num to NUM
    await numTracker.setNum(NUM)
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // upgrade NumTracker to NumTracker2
    const numTrackerDelegate2 = await NumTrackerDelegate2.new()
    await coordinator.setDelegate('NumTracker', numTrackerDelegate2.address)
    numTracker = await NumTrackerDelegate2.at(numTrackerProxy.address);

    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // Use NumTracker2 new functionality to add one
    await numTracker.addOne()
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM + 1)
  })
})

async function logEvents(asyncFn) {
  const { logs } = await asyncFn

  console.log(``);
  console.log(`    Found ${logs.length} events`)
  logs.forEach((log) => {
    console.log(log)
  })
  console.log(``);
}
