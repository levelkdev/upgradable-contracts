/* global describe it beforeEach artifacts */

import { expect } from 'chai'

const ContractManager = artifacts.require('ContractManager')
const PersistentStorageDelegate = artifacts.require('PersistentStorageDelegate')
const PersistentStorage = artifacts.require('PersistentStorage')
const NumTracker = artifacts.require('NumTracker')
const NumTracker2 = artifacts.require('NumTracker2')
const NumStorage = artifacts.require('NumStorage')

const NUM = 123456789

describe.only('Upgrade', () => {
  it('should allow for upgrades', async () => {
    let num
    const storageDelegate = await PersistentStorageDelegate.new()
    const contractManager = await ContractManager.new(storageDelegate.address)
    const storage = await PersistentStorage.at(await contractManager._storage())
    const numStorage = await NumStorage.new()
    let numTracker = await NumTracker.new(storage.address)

    await contractManager.setContract('NumTracker', numTracker.address)
    await contractManager.setProxy('NumTracker', numStorage.address)

    // Set num to NUM
    await numTracker.setNum(NUM)
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // upgrade NumTracker to NumTracker2
    numTracker = await NumTracker2.new(storage.address)
    await contractManager.setContract('NumTracker', numTracker.address)

    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM)

    // Use NumTracker2 new functionality to add one
    await numTracker.addOne()
    num = await numTracker.num()
    expect(num.toNumber()).to.equal(NUM + 1)
  })
})
