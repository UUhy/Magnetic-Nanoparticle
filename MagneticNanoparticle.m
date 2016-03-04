%MagneticNanoparticle Class
%
%This class is designed to store information on magnetic nanoparticles.  In
%addition, it can also calculate dipole fields.
%
%Here we provide more information on the template class.
%
%The functions of this class are:
%   getM
%   getParticleMoment
%   getDipoleField
%   plot2DDipoleField
%
%Long Chang, UH, 3/2/2016

classdef MagneticNanoparticle
    
    properties(GetAccess=public, SetAccess=protected, Hidden=false)
        %The get and set privileges are as shown above.
        
        %Name
        name;
        
        %Manufacturer
        manufacturer;
        
        %Magnetic hysteresis loop
        f;          %field
        M;          %magnetization smooth
        Mraw;       %raw magnetization
        
        %Magnetization saturation [emu/g]
        Ms;
        
        %Magnetization remnant
        Mr;
        
        %Density [g/cc]
        density;
        
        %Volume
        V;
        
        %Radius
        r;
        
        %Area
        A;
    end
    
    properties(GetAccess=public, SetAccess=protected, Hidden=true)
        %No Private Variables
    end
    
    properties(GetAccess=private, Constant=true, Hidden=true)
        %No Constants
    end
    
    methods (Access=public, Sealed=true)
        
        function obj = MagneticNanoparticle()
        %obj = MagneticNanoparticle()
        %
        %   Output:
        %       obj     	:   class instance
        %
        %   Description:
        %   Constructor for the class.
     
            obj.name = [];
            obj.manufacturer = [];
            obj.f = [];
            obj.M = [];
            obj.Mraw = [];
            obj.Ms = [];
            obj.Mr = [];
            obj.density = [];
            obj.V = [];
            obj.A = [];
            obj.r = [];
        end
        
        function obj = setRadius(obj,radius)
        %obj = setRadius(obj, radius)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       radius      :   integer     =   radius in units of [nm]
        %
        %   Description:
        %   Sets the radius for the particle and calculates its area and
        %   volume
            
            obj.r = radius*1e-9;            %[m]
            obj.A = pi*obj.r^2;             %[m2]
            obj.V = 4/3*pi*obj.r^3;         %[m3]
            
        end
        
        function obj = setField(obj, field)
        %obj = setField(obj, filename)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       field       :   double array    =   field data for the
        %                                           hysteresis loop in
        %                                           units of [Oe]
        %
        %   Description:
        %   Sets the field data for the hysteresis loop  
            
            obj.f = field;
            
        end
        
        function obj = setM(obj, M)
        %obj = setM(obj, M)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       M           :   double array    =   moment data for the
        %                                           hysteresis loop in
        %                                           units of [emu]
        %
        %   Description:
        %   Sets the moment data for the hysteresis loop
        %
        %   Example:
        %   tmp = class();
        %   data1 = tmp.loadData('GMR_S1.txt');
            
            obj.M = M;
            
        end
        
        function obj = setMraw(obj, Mraw)
        %obj = setMraw(obj, Mraw)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       Mraw        :   double array    =   raw moment data for the
        %                                           hysteresis loop in
        %                                           units of [emu]
        %
        %   Description:
        %   Sets the raw moment data for the hysteresis loop.  This data is
        %   currently not being used for anything.
            
            obj.Mraw = Mraw;
            
        end
        
        function obj = setMs(obj, Ms)
        %obj = setMs(obj, Ms)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       Ms          :   double          =   magnetization 
        %                                           saturation of the 
        %                                           material in units of 
        %                                           [emu/g]                                         
        %
        %   Description:
        %   Sets the magnetization saturation data.  If the hysteresis loop
        %   is not available, then Ms can be used for calculations.
            
            obj.Ms = Ms;
            
        end
        
        function obj = setMr(obj, Mr)
        %obj = setMr(obj, Mr)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       Mr          :   double          =   remnant magnetization
        %                                           of the material in
        %                                           units of [emu/g]
        %
        %   Description:
        %   Sets the remnant magnetization data for the hysteresis loop.  
        %   This value is currently not used for anything.  
            
            obj.Mr = Mr;
            
        end
        
        function obj = setDensity(obj, density)
        %obj = setDensity(obj, density)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       density     :   double          =   density of the material
        %                                           in units of [g/cc]
        %
        %   Description:
        %   Sets the density data for the material.  Density and volume 
        %   data is required to estimate the moment of the particle.
            
            obj.density = density;
            
        end
        
        function obj = setName(obj, name)
        %obj = setName(obj, name)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       name        :   string          =   name of the particle
        %
        %   Description:
        %   The name of the particle is used to identify it from other
        %   magnetic particles.
            
            obj.name = name;
            
        end
        
        function obj = setManufacturer(obj, name)
        %obj = setManufacturer(obj, name)
        %
        %   Output:
        %       obj         :   class instance
        %
        %   Input:
        %       obj         :   class instance
        %       name        :   string          =   name of the vendor of
        %                                           the particle
        %
        %   Description:
        %   The name of the vendor is used to categorize particles.
            
            obj.manufacturer = name;
            
        end
        
        function m = getM(obj, field)
        %m = getM(obj, M)
        %
        %   Output:
        %       m           :   double          =   magnetization [emu/g]
        %
        %   Input:
        %       obj         :   class instance
        %       field       :   double          =   field in [Oe]
        %
        %   Description:
        %   Interpolates the magnitization data to determine the
        %   magnitization at the desired field.
        
            index = 1:floor(length(obj.f)/2);
            m = interp1(obj.f(index), obj.M(index), field);
            
        end
        
        function m = getParticleMoment(obj, varargin)
        %m = getParticleMoment(obj, field*)
        %
        %   Output:
        %       m           :   double          =   magnetic moment [emu]
        %
        %   Input:
        %       obj         :   class instance
        %       field*      :   double          =   field in [Oe]
        %
        %   Description:
        %   Calculates the moment of a single particle.  If the field is
        %   not specified, the saturation magnetization will be used for
        %   the calculation.
        
            mass = obj.density*(obj.V*1e6);     %[g]

            if nargin == 2
                field = varargin{1};
                m = obj.getM(field)*mass;
            else
                m = obj.Ms*mass;
            end

        end
        
        function h = getDipoleField(obj, r, varargin)
        %h = getDipoleField(obj, r, field*)
        %
        %   Output:
        %       h           :   double      =   magnetic field [Oe]
        %
        %   Input:
        %       obj         :   class instance
        %       r           :   vector      =   [xi yj kz]
        %       field*      :   double      =   field in [Oe]
        %
        %   Description:
        %   The dipole field is calculated from the formula:
        %       H(r) =      1    [ 3(m.ur)ur  -  m   ]
        %               -------- [                   ]
        %               4*pi*r^3 [                   ]
        %
        %   The dipole moment, m = [1i 0j 0k]*m(field), is directed along
        %   the positive x axis.  The magnitude of the dipole moment is
        %   equal to the moment of the particle at the applied field.  If
        %   the field is not specified, then the moment at saturation is
        %   used.
        
            if length(r) ~= 3
                error('MagneticNanoparticle.getDipoleField:  r should be a vector with 3 elements');
            end
            
            if nargin > 2
                moment = [1 0 0]*obj.getParticleMoment(varargin{1})*1e-3;
            else
                moment = [1 0 0]*obj.getParticleMoment()*1e-3;
            end
            
            ur = r/norm(r);

            h = 1/(4*pi*norm(r)^3)*(3*dot(moment,ur)*ur - moment) * (4*pi)/(1e3);
        end
        
        function plot2DDipoleField(obj)
        %plot2DDipoleField(obj)
        %
        %   Output:
        %
        %   Input:
        %       obj         :   class instance
        %
        %   Description:
        %   Makes a quiver plot of the magnetic field around the magnetic
        %   particle.  The calculations assumes that the particle is a
        %   point source.
            
            [X, Y] = meshgrid(linspace(-3*obj.r,3*obj.r,61),linspace(-3*obj.r,3*obj.r,61));
            X = reshape(X,numel(X),1);
            Y = reshape(Y,numel(Y),1);

            U = zeros(size(X));
            V = U;
            for i = 1:length(X)
                R = obj.getDipoleField([X(i) Y(i) 0]);
                U(i) = R(1);
                V(i) = R(2);
            end

            ind = ~(sqrt(X.^2+Y.^2) <= obj.r);

            quiver(X(ind)*1e9,Y(ind)*1e9,U(ind),V(ind));
            rectangle('Position',[-obj.r*1e9, -obj.r*1e9, 2*obj.r*1e9, 2*obj.r*1e9],'Curvature',[1, 1]);
            xlabel('X [nm]','fontsize',14);
            ylabel('Y [nm]','fontsize',14);
        end
        
    end
    
end