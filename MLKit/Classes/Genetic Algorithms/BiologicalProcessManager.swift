//
//  BiologicalProcessManager.swift
//  Pods
//
//  Created by Guled  on 3/7/17.
//
//

import Foundation

/// Handles process involving crossover and mutation.
open class BiologicalProcessManager{


    /*************************************************************************
       _____
      / ___/______  ___ ___ ___ _  _____ ____
     / /__/ __/ _ \(_-<(_-</ _ \ |/ / -_) __/
     \___/_/  \___/___/___/\___/___/\__/_/

    *************************************************************************/

    /**
     The onePointCrossover method performs the "one point" crossover operation.

     - parameter crossOverRate: Your crossover rate (should be between 0 and 1).
     - parameter parentOne: Parent represented as a Genome Object.
     - parameter parentTwo: Parent represented as a Genome Object. 

     - returns: The mean of the array
     */
    open static func onePointCrossover(crossOverRate:Float, parentOne: Genome, parentTwo: Genome) -> (Genome, Genome){

        var randomProbability: Float = Float(arc4random()) / Float(UINT32_MAX)

        if randomProbability < crossOverRate {

            return (parentOne, parentTwo)

        }else{

            var pivot: Int = Int(arc4random_uniform(UInt32(parentOne.genotypeRepresentation.count)))

            var newGenotypeForChild1 = parentOne.genotypeRepresentation[0..<pivot] + parentTwo.genotypeRepresentation[pivot...parentTwo.genotypeRepresentation.count-1]

            var newGenotypeForChild2 = parentTwo.genotypeRepresentation[0..<pivot] + parentOne.genotypeRepresentation[pivot...parentTwo.genotypeRepresentation.count-1]

            
            var child1 = Genome(genotype: Array<Float>(newGenotypeForChild1))

            var child2 = Genome(genotype: Array<Float>(newGenotypeForChild2))

            return (child1, child2)
        }
    }


    /*************************************************************************
       __  ___     __       __  _
      /  |/  /_ __/ /____ _/ /_(_)__  ___
     / /|_/ / // / __/ _ `/ __/ / _ \/ _ \
    /_/  /_/\_,_/\__/\_,_/\__/_/\___/_//_/

     *************************************************************************/

    /**
     The generateRandomIndexes generates random indexes.

     - parameter genotypeCount: The `count` of the `genotypeRepresentation` of a Genome object.
     
     - returns: A tuple consisted of type Integer.

     */
    private static func generateRandomIndexes(genotypeCount: Int) -> (Int, Int) {
        var randomIndexOne = Int(arc4random_uniform(UInt32(genotypeCount)))
        var randomIndexTwo = Int(arc4random_uniform(UInt32(genotypeCount)))


        if randomIndexOne == randomIndexTwo {

            while true {

                randomIndexTwo = Int(arc4random_uniform(UInt32(genotypeCount)))

                if randomIndexTwo != randomIndexOne {
                    break
                }else{
                    continue
                }
            }
        }

        return (randomIndexOne, randomIndexTwo)
    }


    /**
     The swapMutation method swaps genes of a Genome objects `genotypeRepresentation`.

     - parameter genotype: The genotypeRepresentation array of a Genome object.

     */
    open static func swapMutation( genotype:inout [Float]) {

        var randomIdx = generateRandomIndexes(genotypeCount: genotype.count - 1)

        var temp = genotype[randomIdx.0]

        genotype[randomIdx.0] = genotype[randomIdx.1]
        genotype[randomIdx.1] = temp
    }

    /**
     The insertMutation method inserts random genes of a Genome objects `genotypeRepresentation` into random positions.

     - parameter genotype: The genotypeRepresentation array of a Genome object.

     */
    open static func insertMutation( genotype:inout [Float]) {

        var randomIdx = generateRandomIndexes(genotypeCount: genotype.count - 1)

        var temp = genotype[randomIdx.1]

        genotype.remove(at: randomIdx.1)

        genotype.insert(temp, at: randomIdx.0 + 1)
    }

    /**
     The scrambleMutation method shuffles a portion of the genes of a Genome object. 

     - parameter genotype: The genotypeRepresentation array of a Genome object.

     */
    open static func scrambleMutation( genotype:inout [Float]) {

        var randomIdx = generateRandomIndexes(genotypeCount: genotype.count - 1)


        if randomIdx.0 > randomIdx.1 {

            var subset = genotype[randomIdx.1...randomIdx.0].shuffle()
            
        }else{
            
            var subset = genotype[randomIdx.0...randomIdx.1].shuffle()
        }
    }


    /**
     The inverseMutation method shuffles a portion of the genes of a Genome object.

     - parameter genotype: The genotypeRepresentation array of a Genome object.

     */
    open static func inverseMutation(genotype:inout [Float]) {

        var randomIdx = generateRandomIndexes(genotypeCount: genotype.count - 1)

        if randomIdx.0 > randomIdx.1 {

            genotype[randomIdx.1...randomIdx.0].reverse()

        }else{
            genotype[randomIdx.0...randomIdx.1].reverse()

        }

    }


}