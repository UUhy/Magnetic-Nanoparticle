%MNPLibrary Class
%
%This class is a library of all the magnetic nanoparticles we have.
%
%The functions of this class are:
%   nameList            A list of all particles in the library
%   compareLoop         Plots all hysteresis loops
%   compareLoopShape    Plots all hysteresis loops (normalized)
%Long Chang, UH, Februrary 2016

classdef MNPLibrary
    
    properties(GetAccess=public, SetAccess=protected, Hidden=false)
        %The get and set privileges are as shown above.
        
        %Magnetic particle data
        MNP;
        
        %Vendor list
        vendorList;
        
        %Particle name list
        nameList;
        
        %color scheme
        c;
    end
    
    properties(GetAccess=public, SetAccess=protected, Hidden=true)
        %No Private Variables
    end
    
    properties(GetAccess=private, Constant=true, Hidden=true)
        %No Constants
    end
    
    methods (Access=public, Sealed=true)
        
        function obj = MNPLibrary()
        %obj = MNPLibrary()
        %
        %   Output:
        %       obj     	:   class instance
        %
        %   Description:
        %   Constructor for the class.
     
            obj.MNP = {};
            obj.vendorList = {};
            obj.nameList = {};
            obj.c = {'b' 'g' 'r' 'm' 'c' 'k' 'b--' 'g--' 'r--' 'm--' 'c--' 'k--'};
            obj = obj.loadLibrary();
        end
        
        function obj = loadLibrary(obj)
        %obj = loadLibrary(obj)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Loads all magnetic nanoparticle data into the library
            
            obj = obj.loadAdemtech();
            obj = obj.loadYiting();
            
        end
        
        function obj = compareLoop(obj)
        %obj = compareLoop(obj)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Plots the hysteresis loops of all particles in the library.
            
            hold on
            for i = 1:length(obj.MNP)
                plot(obj.MNP{i}.f,obj.MNP{i}.M,obj.c{i});
            end
            hold off
        end
        
        function obj = compareLoopShape(obj)
        %obj = compareLoopShape(obj)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Plots the hysteresis loops of all particles in the library.
        %   The loops are normalized to facilitate comparisons of the loop
        %   shape.
            
            hold on
            for i = 1:length(obj.MNP)
                plot(obj.MNP{i}.f,obj.MNP{i}.M/range(obj.MNP{i}.M),obj.c{i});
            end
            hold off
        end
        
    end
    
    methods (Access=protected, Sealed=true)
        
        function obj = loadAdemtech(obj)
        %obj = loadAdemtech(obj, radius)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Loads Ademtech particles into the library
            
            mnp = MagneticNanoparticle();
            tmp = load('Adembeads_0321.mat');
            mnp = mnp.setField(tmp.f);
            mnp = mnp.setM(tmp.M);
            mnp = mnp.setMraw(tmp.Mraw);
            mnp = mnp.setName('Bio-Adembeads Streptavidin plus 0321');
            mnp = mnp.setManufacturer('ademtech');
            mnp = mnp.setRadius(120);
            mnp = mnp.setMs(40);
            mnp = mnp.setDensity(2);
            
            obj.MNP{end+1} = mnp;
            obj.vendorList{end+1} = mnp.manufacturer;
            obj.nameList{end+1} = mnp.name;
            
        end
        
        function obj = loadYiting(obj)
        %obj = loadYiting(obj, radius)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Loads Yi-Ting particles into the library.  Yi-Ting is a
        %   graduate student from Dr. T.R. Lee's group.  She specializes in
        %   Fe3O4 nanoparticles and can make them in various sizes ranging
        %   from 50 nm to 500 nm.
            
            mnp = MagneticNanoparticle();
            tmp = load('Yiting_300.mat');
            mnp = mnp.setField(tmp.f);
            mnp = mnp.setM(tmp.M);
            mnp = mnp.setMraw(tmp.Mraw);
            mnp = mnp.setName('Yiting 300nm Fe3O4');
            mnp = mnp.setManufacturer('Yiting');
            mnp = mnp.setRadius(150);
            mnp = mnp.setMs(80);
            mnp = mnp.setDensity(5.24);
            
            obj.MNP{end+1} = mnp;
            obj.vendorList{end+1} = mnp.manufacturer;
            obj.nameList{end+1} = mnp.name;
            
        end
        
        function obj = loadBulk(obj)
        %obj = loadYiting(obj, radius)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Loads magnetic properties of bulk material.  These materials
        %   may or may not exist in particle form for biosensing
        %   applications.  Nonetheless, it provides a reference for someone
        %   who's looking for "better" magnetic particles.
            
            mnp = class();

            %Cobalt
            mnp = mnp.setName('Co - Bulk');
            mnp = mnp.setManufacturer('None');
            mnp = mnp.setRadius(100);
            mnp = mnp.setMs(161);
            mnp = mnp.setDensity(8.9);
            
            obj.MNP{end+1} = mnp;
            obj.vendorList{end+1} = mnp.manufacturer;
            obj.nameList{end+1} = mnp.name;

        end
        
    end
    
end