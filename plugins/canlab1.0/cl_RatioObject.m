classdef cl_RatioObject
    properties
        SubjectID
        IAF
        TF
        ratio_Alpha32
        ratio_AlphaTheta
        ratio_Alpha32Fixed
        ratio_AlphaThetaFixed
        IAFs
        TFs
        avgSignal
        avgPSD
        Freqs
        rejectedIAFs
        rejectedTFs
        inspectedIAFs
        inspectedTFs
        deltaFloor
        deltaCeiling
        thetaFloor
        thetaCeiling
        alphaFloor
        alpha1Floor
        alpha1Ceiling
        alpha2Floor
        alpha2Ceiling
        alpha3Floor
        alpha3Ceiling
        betaFloor
        betaCeiling
        gammaFloor
        gammaCeiling
        deltaFloor_fixed
        deltaCeiling_fixed
        thetaFloor_fixed
        thetaCeiling_fixed
        alphaFloor_fixed
        alpha1Floor_fixed
        alpha1Ceiling_fixed
        alpha2Floor_fixed
        alpha2Ceiling_fixed
        alpha3Floor_fixed
        alpha3Ceiling_fixed
        alphaCeiling_fixed
        betaFloor_fixed
        betaCeiling_fixed
        gammaFloor_fixed
        gammaCeiling_fixed
        deltaPower
        thetaPower
        alphaPower
        alpha1Power
        alpha2Power
        alpha3Power
        betaPower
        gammaPower
        deltaPower_fixed
        thetaPower_fixed
        alphaPower_fixed
        alpha1Power_fixed
        alpha2Power_fixed
        alpha3Power_fixed
        betaPower_fixed
        gammaPower_fixed
    end

    methods
        function subjectArray = cl_RatioObject()
            
            