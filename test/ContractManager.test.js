/* global describe it beforeEach artifacts */

import { expect } from 'chai'

const ContractManager = artifacts.require('ContractManager')
const PersistentStorageDelegate = artifacts.require('PersistentStorageDelegate')
const PersistentStorage = artifacts.require('PersistentStorage')
const NumTracker = artifacts.require('NumTracker')
const NumTrackerDelegate1 = artifacts.require('NumTrackerDelegate1')
const NumTrackerDelegate2 = artifacts.require('NumTrackerDelegate2')
const NumStorage = artifacts.require('NumStorage')

const NUM = 123456789

describe.only('Upgrade', () => {
  it('should allow for upgrades', async () => {
    let num
    const storageDelegate = await PersistentStorageDelegate.new()
    const contractManager = await ContractManager.new(storageDelegate.address)
    const storage = await PersistentStorage.at(await contractManager._storage())
    const numTrackerDelegate1 = await NumTrackerDelegate1.new()
    const numStorage = await NumStorage.new()
    const numTrackerProxy = await NumTracker.new(storage.address)
    let numTracker = await NumTrackerDelegate1.at(numTrackerProxy.address);

    await contractManager.setContract('NumTracker', numTracker.address)
    await contractManager.setStorageDelegate('NumTracker', numStorage.address)
    await contractManager.setDelegate('NumTracker', numTrackerDelegate1.address)

    // Set num to NUM
    await numTracker.setNum(NUM)
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // upgrade NumTracker to NumTracker2
    const numTrackerDelegate2 = await NumTrackerDelegate2.new()
    await contractManager.setDelegate('NumTracker', numTrackerDelegate2.address)
    numTracker = await NumTrackerDelegate2.at(numTrackerProxy.address);

    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // Use NumTracker2 new functionality to add one
    await numTracker.addOne()
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM + 1)
  })
})
