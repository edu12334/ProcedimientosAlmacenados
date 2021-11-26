-- Procedimientos Almacenados
-- Nicolas Velasco 
-- 23/11/2021 
------------------------------------------------------------------------------------------------------------
-- CREACION DE PROCEDIMIENTOS ALMACENADOS 
------------------------------------------------------------------------------------------------------------
-- CRUB TClienteNaturaL

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTCNatural') is not null
	drop proc spListarTCNatural
go
create proc spListarTCNatural
as
begin 
	select * from TClienteNatural
end 
go

--ejecutar el procedimiento listar****  
exec spListarTCNatural
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTCNatural') is not null
	drop proc spAgregarTCNatural
go
create proc spAgregarTCNatural
 @DNI_CN varchar (8), @Nombres varchar(50), @Apellidos varchar(50), @Telefono varchar(9), @Direccion varchar(50), @E_mail varchar(50) 
as
begin 
	--- validar que el DNI_Cliente Natural que no se duplique 
	if not exists (select DNI_CN from TClienteNatural  where DNI_CN = @DNI_CN)
		begin 
			-- insertar servicio 
			insert into TClienteNatural values (@DNI_CN, @Nombres, @Apellidos, @Telefono, @Direccion,@E_mail)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente Cliente Natural'
		end
	else select CodError = 1, Mensaje = 'Error: Cliente Existente' 

end 
go

exec spAgregarTCNatural '77787878','JUAN','MAMANI QUISPE','957077555','AV. EL SOL 444','juanmamani@gmail.com'
go
select * from TClienteNatural

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTCNatural') is not null
	drop proc spEliminarTCNatural
go
create proc spEliminarTCNatural
@DNI_CN varchar(8)
as
begin
	--  Validar que el Id exista
	if exists(select DNI_CN from TClienteNatural where DNI_CN = @DNI_CN)
		-- Validar que no exista la referencia foranea en la tabla Territorio
		if not exists(select DNI_CN from TBoleta where DNI_CN=@DNI_CN)
			begin
				delete from TClienteNatural where DNI_CN = @DNI_CN
				select CodError=0, Mensaje = 'Se ha eliminado correctamente al cliente'
			end
		else select CodError=1, Mensaje = 'Error: DNI existe en la tabla Clientes'
	else select CodError = 1, Mensaje = 'Error: DNI no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTCNatural 77787878
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTCNatural') is not null 
	drop proc spActualizarTCNatural 
go
create proc spActualizarTCNatural 
@DNI_CN varchar (8), @Nombres varchar(50), @Apellidos varchar(50), @Telefono varchar(9), @Direccion varchar(50), @E_mail varchar(50) 
as 
begin 
	---Validar que el ID de region exista 
	if exists (select DNI_CN from TClienteNatural where DNI_CN = @DNI_CN)
			begin
				update TClienteNatural set Nombres=@Nombres, Apellidos=@Apellidos, Telefono=@Telefono, Direccion=@Direccion, E_mail=@E_mail where DNI_CN=@DNI_CN
				select CodError = 0, Mensaje = 'Cliente actualizada Correctamente'
			end
	else select CodError = 1, 'Error: Codigo de Cliente no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTCNatural '77787878','JUAN MARCELO','MAMANI QUISPE','957077555','AV. EL SOL 444','juanmamani@gmail.com'
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTCNatural') is not null 
	drop proc spBuscarTCNatural 
go
create proc spBuscarTCNatural 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select DNI_CN, Nombres, Apellidos, Telefono, Direccion, E_mail from TClienteNatural where DNI_CN = @Texto  
	else if (@Criterio = 'Description') -- Busqueda sencitiva
		select DNI_CN, Nombres, Apellidos, Telefono, Direccion, E_mail from TClienteNatural where Apellidos like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTCNatural 'Mam','Description'
go

-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TClienteJuridico 

------------------------------------------------------------------------------------------------------------
-- TClienteJuridico Listar  
------------------------------------------------------------------------------------------------------------
if OBJECT_DEFINITION ('spListarTCJuridico') is not null
	drop proc spListarTCJuridico
go
create proc spListarTCJuridicos
as
begin 
	select * from TClienteJuridicos
end 
go

--ejecutar el procedimiento listar****  
exec spListarTCJuridicos
go

------------------------------------------------------------------------------------------------------------
-- TClienteJurudico Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTCJuridicos') is not null
	drop proc spAgregarTCJuridicos
go
create proc spAgregarTCJuridicos
@RUC_CJ varchar (11), @Razon_Social varchar(50), @Telefono varchar(9), @Direccion varchar(50), @E_mail varchar(50) 
as
begin 
	--- validar que el DNI_Cliente Juridico que no se duplique 
	if not exists (select RUC_CJ from TClienteJuridicos  where RUC_CJ = @RUC_CJ)
		begin 
			-- insertar Cliente  
			insert into TClienteJuridicos values (@RUC_CJ, @Razon_Social, @Telefono, @Direccion,@E_mail)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente Cliente Juridico'
		end
	else select CodError = 1, Mensaje = 'Error: Cliente Existente' 

end 
go

exec spAgregarTCJuridicos'22445577889','MAMANIS QUISPE','957077555','AV. EL SOL 444','juanmamani@gmail.com'
go
select * from TClienteJuridicos

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTCJuridicos') is not null
	drop proc spEliminarTCJuridicos
go
create proc spEliminarTCJuridicos
@RUC_CJ varchar(11)
as
begin
	--  Validar que el Id exista
	if exists(select RUC_CJ from TClienteJuridicos where RUC_CJ = @RUC_CJ)
		-- Validar que no exista la referencia foranea en la tabla Territorio
		if not exists(select RUC_CJ from TFactura where RUC_CJ=@RUC_CJ)
			begin
				delete from TClienteJuridicos where RUC_CJ = @RUC_CJ
				select CodError=0, Mensaje = 'Se ha eliminado correctamente al cliente'
			end
		else select CodError=1, Mensaje = 'Error: DNI existe en la tabla Clientes'
	else select CodError = 1, Mensaje = 'Error: DNI no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTCJuridicos 22445577889
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTCJuridicos') is not null 
	drop proc spActualizarTCJuridicos 
go
create proc spActualizarTCJuridicos 
@RUC_CJ varchar (11), @Razon_Social varchar(50), @Telefono varchar(9), @Direccion varchar(50), @E_mail varchar(50) 
as 
begin 
	---Validar que el ID de region exista 
	if exists (select RUC_CJ from TClienteJuridicos where RUC_CJ = @RUC_CJ)
			begin
				update TClienteJuridicos set Razon_Social=@Razon_Social, Telefono=@Telefono, Direccion=@Direccion, E_mail=@E_mail where RUC_CJ=@RUC_CJ
				select CodError = 0, Mensaje = 'Cliente actualizada Correctamente'
			end
	else select CodError = 1, 'Error: Codigo de Cliente no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTCJuridicos '22445577889','MAMANIS MAMANIS','957077555','AV. EL SOL 444','juanmamani@gmail.com'
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTCJuridicos') is not null 
	drop proc spBuscarTCJuridicos 
go
create proc spBuscarTCJuridicos 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select RUC_CJ, Razon_Social, Telefono, Direccion, E_mail from TClienteJuridicos where RUC_CJ = @Texto  
	else if (@Criterio = 'Description') -- Busqueda sencitiva
		select RUC_CJ, Razon_Social, Telefono, Direccion, E_mail from TClienteJuridicos where Razon_Social like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTCJuridicos 'Mam','Description'
go

-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TUsuario  

------------------------------------------------------------------------------------------------------------
-- TUsuario Listar  
------------------------------------------------------------------------------------------------------------
if OBJECT_DEFINITION ('spListarTUsuario') is not null
	drop proc spListarTUsuario
go
create proc spListarTUsuario
as
begin 
	select * from TUsuario
end 
go

--ejecutar el procedimiento listar****  
exec spListarTUsuario
go

-- TUsuario Listar  
------------------------------------------------------------------------------------------------------------
if OBJECT_DEFINITION ('spListarIdUsuario') is not null
	drop proc spListarIdUsuario
go
create proc spListarIdUsuario
as
begin 
	select ID_U, IdUsuario from TUsuario order by IdUsuario asc
end 
go

--ejecutar el procedimiento listar****  
exec spListarIdUsuario
go

------------------------------------------------------------------------------------------------------------
-- TUsuario Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarUsuario') is not null
	drop proc spAgregarUsuario
go
--procedimiento Agregar 
create proc spAgregarUsuario
@Usuario nvarchar(12), @Contrasena nvarchar(60)
as
begin 
	--- validar que el ID de región no se duplique 
	if not exists (select * from TUsuario where IdUsuario = @Usuario)
		begin 
			-- insertar servicio 
			insert into TUsuario values (@Usuario, ENCRYPTBYPASSPHRASE ('pass', @Contrasena))
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente El Usuario'
		end
	else select CodError = 1, Mensaje = 'Error: Este nombre de Usuario esta duplicado' 

end 
go

exec spAgregarUsuario 'Myimmi','45678'
go
select * from TUsuario

------------------------------------------------------------------------------------------------------------
-- TUsuario Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTUsuario') is not null
	drop proc spEliminarTUsuario
go
create proc spEliminarTUsuario
@ID_U int
as
begin
	--  Validar que el Id exista
	if exists(select ID_U from TUsuario where ID_U = @ID_U)
		-- Validar que no exista la referencia foranea en la tabla Territorio
		if not exists(select ID_U from TTrabajador where ID_U=@ID_U)
			begin
				delete from TUsuario where ID_U = @ID_U
				select CodError=0, Mensaje = 'Se ha eliminado correctamente al Usuario'
			end
		else select CodError=1, Mensaje = 'Error: Usuario existente en la tabla Trabajador'
	else select CodError = 1, Mensaje = 'Error: Usuario no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTUsuario 4
go
select * from TUsuario

------------------------------------------------------------------------------------------------------------
-- TUsuario Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTUsuario') is not null 
	drop proc spActualizarTUsuario
go
create proc spActualizarTUsuario 
@Id_U int, @Usuario varchar(15), @Contrasena nvarchar(60)
as 
begin 
	---Validar que el ID de usuario exista 
	if exists (select ID_U from TUsuario where ID_U = @Id_U)
			begin
				update TUsuario set IdUsuario = @Usuario, Contrasena=(ENCRYPTBYPASSPHRASE('pass',@Contrasena)) where ID_U=@Id_U
				select CodError = 0, Mensaje = 'Usuario actualizada Correctamente'
			end
	else select CodError = 1, 'Error: IdUsuario de Usuario no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTUsuario 1,'VNicolas','43182444'
go

------------------------------------------------------------------------------------------------------------
-- TUsuario Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTUsuario') is not null 
	drop proc spBuscarTUsuario
go
create proc spBuscarTUsuario 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select ID_U, Id_Usuario, IdUsuario, Contrasena from TUsuario where Id_Usuario like '%' + @Texto + '%' 
	else if (@Criterio = 'Id_USuario') -- Busqueda sencitiva
		select ID_U, Id_Usuario, IdUsuario, Contrasena from TUsuario where IdUsuario like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTusuario 'U00','Id'
go

----Proc Login Usuario --------------------------------------------------------------------------------------------
if OBJECT_ID('spLoginUsuario') is not null 
	drop proc spLoginUsuario 
go
create proc spLoginUsuario 
@Usuario nvarchar(12), @Contrasena nvarchar(60)
as 
begin
	if exists (select IdUsuario from TUsuario where IdUsuario = @Usuario and CONVERT(nvarchar(max),DECRYPTBYPASSPHRASE('pass',Contrasena)) = @Contrasena)
	select CodError=0, Mensaje = 'OK, Bienvenido'
	else select CodError=1, Mensaje = 'Error, Usuario /o contraseña incorrecta'
end
go

---Ejecutamos procedimiento
Exec spLoginUsuario 'VNicolas','43182444' 
select * from TUsuario
-- Desencriptar la tabla  
select IdUsuario as [IdIsuario], CONVERT(nvarchar(MAX), DECRYPTBYPASSPHRASE('pass', Contrasena)) as password from TUsuario
------------------------------------------------------------------------------------------------------------
-- CRUB TTrabajador

------------------------------------------------------------------------------------------------------------
-- TTrabajador Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTTrabajador') is not null
	drop proc spListarTTrabajador
go
create proc spListarTTrabajador
as
begin 
	select * from TTrabajador
end 
go

--ejecutar el procedimiento listar****  
exec spListarTTrabajador
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTTrabajador') is not null
	drop proc spAgregarTTrabajador
go
create proc spAgregarTTrabajador
@DNI_T varchar (8), @Apellidos varchar(30), @Nombres varchar(30), @Rol_T varchar(50), @Telefono varchar(9), @Direccion varchar(50), @Genero char(1), @ID_U int 
as
begin 
	--- validar que el DNI_Cliente Natural que no se duplique 
	if not exists (select DNI_T from TTrabajador  where DNI_T = @DNI_T)
		begin 
			-- insertar servicio 
			insert into TTrabajador values (@DNI_T, @Apellidos, @Nombres, @Rol_T, @Telefono, @Direccion,@Genero, @ID_U)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente al Trabajador'
		end
	else select CodError = 1, Mensaje = 'Error: Trabajador Existente' 

end 
go

exec spAgregarTTrabajador '00000001','Deeee', 'deee','Administrativa','123456789','san jeronimo K-45','F',5
go
select * from TTrabajador
------------------------------------------------------------------------------------------------------------
-- TTrabajador Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTTrabajador') is not null
	drop proc spEliminarTTrabajador
go
create proc spEliminarTTrabajador
@ID_T int
as
begin
	--  Validar que el Id exista
	if exists(select ID_T from TTrabajador where ID_T = @ID_T)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select ID_T from TFactura where ID_T=@ID_T)
			-- Validar que no exista la referencia foranea en la tabla Boleta
			if not exists(select ID_T from TBoleta where ID_T=@ID_T)
			begin
				delete from TTrabajador where ID_T = @ID_T
				select CodError=0, Mensaje = 'Se ha eliminado correctamente al Trabajador'
			end
			else select CodError=1, Mensaje = 'Error: DNI existe en la tabla Factura'
		else select CodError=1, Mensaje = 'Error: DNI existe en la tabla Boleta'
	else select CodError = 1, Mensaje = 'Error: DNI no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTTrabajador 4
go
------------------------------------------------------------------------------------------------------------
-- TTrabajador Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTTrabajador') is not null 
	drop proc spActualizarTTrabajador 
go
create proc spActualizarTTrabajador 
@DNI_T varchar (8), @Apellidos varchar(30), @Nombres varchar(30), @Rol_T varchar(50), @Telefono varchar(9), @Direccion varchar(50), @Genero char(1), @ID_U int 
as 
begin 
	---Validar que el ID de region exista 
	if exists (select DNI_T from TTrabajador where DNI_T = @DNI_T)
			begin
				update TTrabajador set DNI_T=@DNI_T, Apellidos=@Apellidos, Nombres=@Nombres, Rol_T=@Rol_T, Telefono=@Telefono, Direccion=@Direccion, Genero=@Genero, ID_U=@ID_U where DNI_T=@DNI_T
				select CodError = 0, Mensaje = 'Trabajador actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Codigo de Trabajador no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTTrabajador'00000001','DDeje', 'deee','Administrativa','123456789','san jeronimo K-45','F',5
go
------------------------------------------------------------------------------------------------------------
-- TTrabajador Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTTrabajador') is not null 
	drop proc spBuscarTTrabajador 
go
create proc spBuscarTTrabajador 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'DNI') ---busqueda exacta
		select * from TTrabajador where DNI_T like '%' + @Texto + '%'  
	else if (@Criterio = 'Apellido') -- Busqueda sencitiva
		select * from TTrabajador where Apellidos like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTTrabajador'Ve','Apellido'
go
------------------------------------------------------------------------------------------------------------
-- TTrabajador Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTTTU') is not null
	drop proc spListaTTTU
go
create proc spListarTTTU
as
begin 
	SELECT ID_U, IdUsuario
	FROM TUsuario ORDER BY IdUsuario ASC
end 
go

--ejecutar el procedimiento listar****  
exec spListarTTTU
go










-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TEmpresa

------------------------------------------------------------------------------------------------------------
-- TEmpresa Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTEmpresa') is not null
	drop proc spListarTEmpresa
go
create proc spListarTEmpresa
as
begin 
	select * from TEmpresa
end 
go

--ejecutar el procedimiento listar****  
exec spListarTEmpresa
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTEmpresar') is not null
	drop proc spAgregarTEmpresa
go
create proc spAgregarTEmpresa
@RucEmpresa nvarchar (11), @RazonSocial nvarchar(200), @Direccion nvarchar(200), @Telefono nvarchar(15), @Celular nvarchar(9), @E_mail nvarchar(200), @Propietario nvarchar(200) 
as
begin 
	--- validar que el DNI_Cliente Natural que no se duplique 
	if not exists (select @RucEmpresa from TEmpresa  where RucEmpresa = @RucEmpresa)
		begin 
			-- insertar servicio 
			insert into TEmpresa values (@RucEmpresa, @RazonSocial, @Direccion, @Telefono, @Celular, @E_mail, @Propietario)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente al Trabajador'
		end
	else select CodError = 1, Mensaje = 'Error: Trabajador Existente' 

end 
go

exec spAgregarTEmpresa '22222222222','Salomone', 'tecte nro 338 ','084-787854','777777777','solomone@gmail.com','salomone Ayarsa'
go
select * from TEmpresa

------------------------------------------------------------------------------------------------------------
-- TTrabajador Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTEmpresa') is not null
	drop proc spEliminarTEmpresa
go
create proc spEliminarTEmpresa
@RucEmpresa nvarchar(11)
as
begin
	--  Validar que el Id exista
	if exists(select RucEmpresa from TEmpresa where RucEmpresa = @RucEmpresa)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select RucEmpresa from TFactura where RucEmpresa=@RucEmpresa)
			-- Validar que no exista la referencia foranea en la tabla Boleta
			if not exists(select RucEmpresa from TBoleta where RucEmpresa=@RucEmpresa)
			begin
				delete from TEmpresa where RucEmpresa = @RucEmpresa
				select CodError=0, Mensaje = 'Se ha eliminado correctamente a la Empresa'
			end
			else select CodError=1, Mensaje = 'Error: RUC existe en la tabla Factura'
		else select CodError=1, Mensaje = 'Error: RUC existe en la tabla Boleta'
	else select CodError = 1, Mensaje = 'Error: RUC no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTEmpresa '22222222222'
go
------------------------------------------------------------------------------------------------------------
-- TEmpresa Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTEmpresa') is not null 
	drop proc spActualizarTEmpresa 
go
create proc spActualizarTEmpresa 
@RucEmpresa nvarchar (11), @RazonSocial nvarchar(200), @Direccion nvarchar(200), @Telefono nvarchar(15), @Celular nvarchar(9), @E_mail nvarchar(200), @Propietario nvarchar(200) 
as 
begin 
	---Validar que el ID de Empresa exista 
	if exists (select RucEmpresa from TEmpresa where RucEmpresa = @RucEmpresa)
			begin
				update TEmpresa set RucEmpresa=@RucEmpresa, RazonSocial=@RazonSocial, Direccion=@Direccion, Telefono=@Telefono,  Celular=@Celular, E_mail=@E_mail, Propietario=@Propietario where RucEmpresa=@RucEmpresa
				select CodError = 0, Mensaje = 'Empresa actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Ruc de Empresa no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTEmpresa '22222222222','Salomoneee', 'tecte nro 338 ','084-787854','777777777','solomone@gmail.com','salomone Ayarsa'
go
------------------------------------------------------------------------------------------------------------
-- TEmpresa Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTEmpresa') is not null 
	drop proc spBuscarTEmpresa 
go
create proc spBuscarTEmpresa 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'RUC') ---busqueda exacta
		select RucEmpresa, RazonSocial, Direccion, Telefono, Celular, E_mail, Propietario from TEmpresa where RucEmpresa like '%' + @Texto + '%'  
	else if (@Criterio = 'RazonSocial') -- Busqueda sencitiva
		select RucEmpresa, RazonSocial, Direccion, Telefono, Celular, E_mail, Propietario from TEmpresa where RazonSocial like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTEmpresa'22','RUC'
go
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TLocal

------------------------------------------------------------------------------------------------------------
-- TLocal Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTLocal') is not null
	drop proc spListarTLocal
go
create proc spListarTLocal
as
begin 
	select * from TLocal
end 
go

--ejecutar el procedimiento listar****  
exec spListarTLocal
go

------------------------------------------------------------------------------------------------------------
-- TClienteNaturaL Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTLocal') is not null
	drop proc spAgregarTLocal
go
create proc spAgregarTLocal
@NombreLocal varchar (50), @Telefono varchar(9), @Direccion varchar(50)
as
begin 
	--- validar que el DNI_Cliente Natural que no se duplique 
	if not exists (select * from TLocal  where NombreLocal = @NombreLocal)
		begin 
			-- insertar servicio 
			insert into TLocal values (@NombreLocal, @Telefono, @Direccion)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente el local'
		end
	else select CodError = 1, Mensaje = 'Error: Local Existente' 

end 
go

exec spAgregarTLocal 'OFICINA LIMA','777777777','tecte nro 338 '
go
select * from TLocal

------------------------------------------------------------------------------------------------------------
-- TLocal Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTLocal') is not null
	drop proc spEliminarTLocal
go
create proc spEliminarTLocal
@ID_L int
as
begin
	--  Validar que el Id exista
	if exists(select ID_L from TLocal where ID_L = @ID_L)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select ID_L from TFactura where ID_L=@ID_L)
			-- Validar que no exista la referencia foranea en la tabla Boleta
			if not exists(select ID_L from TBoleta where ID_L=@ID_L)
			begin
				delete from TLocal where ID_L = @ID_L
				select CodError=0, Mensaje = 'Se ha eliminado correctamente local'
			end
			else select CodError=1, Mensaje = 'Error: Local existe en la tabla Factura'
		else select CodError=1, Mensaje = 'Error: Local existe en la tabla Boleta'
	else select CodError = 1, Mensaje = 'Error: Local no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTLocal 4
go
------------------------------------------------------------------------------------------------------------
-- TLocal Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTLocal') is not null 
	drop proc spActualizarTLocal 
go
create proc spActualizarTLocal 
@ID_L int, @NombreLocal varchar (50), @Telefono varchar(9), @Direccion varchar(50)
as 
begin 
	---Validar que el ID de Empresa exista 
	if exists (select NombreLocal from TLocal where ID_L = @ID_L)
			begin
				update TLocal set NombreLocal=@NombreLocal, telefono=@Telefono, direccion=@Direccion where ID_L=@ID_L
				select CodError = 0, Mensaje = 'Local actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Local de Empresa no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTLocal 5,'OFICINA AREQUIPA','777777888','tecte nro 338 '
go
select * from TLocal
------------------------------------------------------------------------------------------------------------
-- TLocal Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTLocal') is not null 
	drop proc spBuscarTLocal 
go
create proc spBuscarTLocal 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Nombre') ---busqueda exacta
		select * from TLocal where NombreLocal like '%' + @Texto + '%'  
	else if (@Criterio = 'Direccion') -- Busqueda sencitiva
		select * from TLocal where direccion like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTLocal'ofi','Nombre'
go
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TCategoria

------------------------------------------------------------------------------------------------------------
-- TCategoria Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTCategoria') is not null
	drop proc spListarTCategoria
go
create proc spListarTCategoria
as
begin 
	select * from TCategoria
end 
go

--ejecutar el procedimiento listar****  
exec spListarTCategoria
go

------------------------------------------------------------------------------------------------------------
-- TCategoria ListarcOMBOBOX  
------------------------------------------------------------------------------------------------------------
if OBJECT_DEFINITION ('spListarCategoriaCombo') is not null
	drop proc spListaCategoriaCombo
go
create proc spListarCategoriaCombo
as
begin 
	SELECT * 
	FROM TCategoria order by Descripcion ASC
end 
go

--ejecutar el procedimiento listar****  
exec spListarListarCategoriaCombo
go
select * from TCategoria


------------------------------------------------------------------------------------------------------------
-- TCategoria Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTCategoria') is not null
drop proc spAgregarTCategoria
go
create proc spAgregarTCategoria
@Nombre_Categoria varchar (50), @Descripcion varchar(50)
as
begin 
	--- validar que el Nombre Categoria no se duplique 
	if not exists (select Nombre_Categoria from TCategoria  where Descripcion = @Descripcion)
		begin 
			-- insertar servicio 
			insert into TCategoria values (@Nombre_Categoria, @Descripcion)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente la categoria'
		end
	else select CodError = 1, Mensaje = 'Error: Categoria Existente' 

end 
go

exec spAgregarTCategoria 'Servicio','Estudio de Suelos'
go
select * from TCategoria

------------------------------------------------------------------------------------------------------------
-- TCategoria Eliminar  
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spEliminarTCategoria') is not null
	drop proc spEliminarTCategoria
go
create proc spEliminarTCategoria
@ID_C int
as
begin
	--  Validar que el Id exista
	if exists(select ID_C from TCategoria where ID_C = @ID_C)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select ID_C from TProducto where ID_C=@ID_C)
			begin
				delete from TCategoria where ID_C = @ID_C
				select CodError=0, Mensaje = 'Se ha eliminado correctamente categoria'
			end
		else select CodError=1, Mensaje = 'Error: Categoria existe en la tabla Producto'
	else select CodError = 1, Mensaje = 'Error: Categoria no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTCategoria 7
go
------------------------------------------------------------------------------------------------------------
-- TCategoria Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTCategoria') is not null 
	drop proc spActualizarTCategoria 
go
create proc spActualizarTCategoria 
@ID_C int, @Nombre_Categoria varchar (50), @Descripcion varchar(50)
as 
begin 
	---Validar que el ID de Empresa exista 
	if exists (select ID_C from TCategoria where ID_C = @ID_C)
			begin
				update TCategoria set Nombre_Categoria=@Nombre_Categoria, Descripcion=@Descripcion where ID_C=@ID_C
				select CodError = 0, Mensaje = 'TCategoria actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Categoria no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTCategoria 8,'Servicio','Analisis Financiero'
go
select * from TCategoria
------------------------------------------------------------------------------------------------------------
-- TCategoria Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTCategoria') is not null 
	drop proc spBuscarTCategoria 
go
create proc spBuscarTCategoria
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Nombre') ---busqueda exacta
		select * from TCategoria where Nombre_Categoria like '%' + @Texto + '%'  
	else if (@Criterio = 'Descrip') -- Busqueda sencitiva
		select * from TCategoria where Descripcion like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTCategoria'Est','Descrip'
go


-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TProducto

------------------------------------------------------------------------------------------------------------
-- TProducto Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTProducto') is not null
	drop proc spListarTProducto
go
create proc spListarTProducto
as
begin 
	select * from TProducto
end 
go

--ejecutar el procedimiento listar****  
exec spListarTProducto
go

------------------------------------------------------------------------------------------------------------
-- TCategoria Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTProducto') is not null
drop proc spAgregarTProducto
go
create proc spAgregarTProducto
@Nombre varchar (50), @Descripcion varchar(50), @Precio real, @ID_C int
as
begin 
	--- validar que el Nombre Categoria no se duplique 
	if not exists (select Nombre from TProducto  where Descripcion = @Descripcion)
		begin 
			-- insertar servicio 
			insert into TProducto values (@Nombre, @Descripcion, @Precio, @ID_C)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente el Producto'
		end
	else select CodError = 1, Mensaje = 'Error: Producto Existente' 
end 
go

exec spAgregarTProducto 'Consultoria','Estudio Topografico',12000.00,6
go
select * from TProducto

------------------------------------------------------------------------------------------------------------
-- TCategoria Eliminar  
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spEliminarTProducto') is not null
	drop proc spEliminarTProducto
go
create proc spEliminarTProducto
@ID_P int
as
begin
	--  Validar que el Id exista
	if exists(select ID_P from TProducto where ID_P = @ID_P)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select ID_P from TDetalleF where ID_P=@ID_P)
			-- Validar que no exista la referencia foranea en la tabla Factura
			if not exists(select ID_P from TDetalleB where ID_P=@ID_P)
			begin
				delete from TProducto where ID_P = @ID_P
				select CodError=0, Mensaje = 'Se ha eliminado correctamente producto'
			end
			else select CodError=1, Mensaje = 'Error: Producto existe en la tabla Detalle Boleta'
		else select CodError=1, Mensaje = 'Error: Producto existe en la tabla Detalle factura'
	else select CodError = 1, Mensaje = 'Error: Categoria no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTProducto 4
go
------------------------------------------------------------------------------------------------------------
-- TProducto Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTProducto') is not null 
	drop proc spActualizarTProducto 
go
create proc spActualizarTProducto 
@ID_P int, @Nombre varchar (50), @Descripcion varchar(50), @Precio real, @ID_C int
as 
begin 
	---Validar que el ID de Empresa exista 
	if exists (select ID_P from TProducto where ID_P = @ID_P)
			begin
				update TProducto set Nombre=@Nombre, Descripcion=@Descripcion, Precio=@Precio, ID_C=@ID_C where ID_P=@ID_P
				select CodError = 0, Mensaje = 'Producto actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Producto no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTProducto 5,'Consultoria','Estudio Topografico Geofisisco',14000.00,6
go
select * from TProducto
select * from TCategoria
------------------------------------------------------------------------------------------------------------
-- TCategoria Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTProducto') is not null 
	drop proc spBuscarTProducto 
go
create proc spBuscarTProducto
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Nombre') ---busqueda exacta
		select Nombre, Descripcion, Precio, ID_C from TProducto where Nombre like '%' + @Texto + '%'  
	else if (@Criterio = 'Descrip') -- Busqueda sencitiva
		select Nombre, Descripcion, Precio, ID_C from TProducto where Descripcion like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTProducto 'E','Descrip'
go


-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TBoleta

------------------------------------------------------------------------------------------------------------
-- TBoleta Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTBoleta') is not null
	drop proc spListarTBoleta
go
create proc spListarTBoleta
as
begin 
	select * from TBoleta
end 
go

--ejecutar el procedimiento listar****  
exec spListarTBoleta
go

------------------------------------------------------------------------------------------------------------
-- TBoleta Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTBoleta') is not null
drop proc spAgregarTBoleta
go
create proc spAgregarTBoleta
@Id_Boleta varchar(6), @Id_Trabajador int, @Id_Local int, @Fecha datetime, @SubTotal decimal(6,2), 
@Total decimal(6,2), @Descuento decimal(6,2), @Porcentaje_Desc decimal(6,2), @DNI_CN varchar(8), 
@ID_T int, @ID_L int, @RucEmpresa nvarchar(11)
as
begin 
	--- validar que el Nombre Categoria no se duplique 
	if not exists (select Id_Boleta from TBoleta  where Id_Boleta = @Id_Boleta)
		begin 
			-- insertar servicio 
			insert into TBoleta values (@Id_Boleta, @Id_Trabajador, @Id_Local, @Fecha, @SubTotal, 
						@Total, @Descuento, @Porcentaje_Desc, @DNI_CN, @ID_T, @ID_L, @RucEmpresa)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente la boleta'
		end
	else select CodError = 1, Mensaje = 'Error: Boleta Existente' 
end 
go

exec spAgregarTBoleta 'BE0003',2,1,'08/11/2021',0,0,5,0.05,45454545,1,2,20606435607
go
select * from TBoleta

------------------------------------------------------------------------------------------------------------
-- TBoleta Eliminar  
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spEliminarTBoleta') is not null
	drop proc spEliminarTBoleta
go
create proc spEliminarTBoleta
@Id_Boleta varchar(6)
as
begin
	--  Validar que el Id exista
	if exists(select Id_Boleta from TBoleta where Id_Boleta = @Id_Boleta)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select Id_Boleta from TDetalleB where Id_Boleta=@Id_Boleta)
			begin
				delete from TBoleta where Id_Boleta = @Id_Boleta
				select CodError=0, Mensaje = 'Se ha eliminado correctamente la boleta'
			end
			else select CodError=1, Mensaje = 'Error: La Boleta existe en la tabla Detalle Boleta'
	else select CodError = 1, Mensaje = 'Error: Boleta no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTBoleta 'BE0003'
go
------------------------------------------------------------------------------------------------------------
-- TBoleta Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTBoleta') is not null 
	drop proc spActualizarTBoleta 
go
create proc spActualizarTBoleta 
@Id_Boleta varchar(6), @Id_Trabajador int, @Id_Local int, @Fecha datetime, @SubTotal decimal(6,2), 
@Total decimal(6,2), @Descuento decimal(6,2), @Porcentaje_Desc decimal(6,2), @DNI_CN varchar(8), 
@ID_T int, @ID_L int, @RucEmpresa nvarchar(11)
as 
begin 
	---Validar que el ID de Empresa exista 
	if exists (select Id_Boleta from TBoleta where Id_Boleta = @Id_Boleta)
			begin
				update TBoleta set Id_Boleta=@Id_Boleta, Id_Trabajador=@Id_Trabajador, Id_Local=@Id_Local,
									Fecha=@Fecha, SubTotal=@SubTotal, Total=@Total, Descuento=@Descuento,
									Porcentaje_Desc=@Porcentaje_Desc, DNI_CN=@DNI_CN, ID_T=@ID_T, ID_L=@ID_L, RucEmpresa=@RucEmpresa
								where Id_Boleta=@Id_Boleta
				select CodError = 0, Mensaje = 'Boleta actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Boleta no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTBoleta 'BE0003',2,1,'07/11/2021',0,0,5,0.05,45454545,1,2,20606435607
go
select * from TBoleta
------------------------------------------------------------------------------------------------------------
-- TBoleta Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTBoleta') is not null 
	drop proc spBuscarTBoleta 
go
create proc spBuscarTBoleta
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select * from TBoleta where Id_Boleta like '%' + @Texto + '%'  
	else if (@Criterio = 'Fecha') -- Busqueda sencitiva
		select * from TBoleta where Fecha like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTBoleta 'BE0003','Id'
go


-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TFactura

------------------------------------------------------------------------------------------------------------
-- TFactura Listar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spListarTFactura') is not null
	drop proc spListarTFactura
go
create proc spListarTFactura
as
begin 
	select * from TFactura
end 
go

--ejecutar el procedimiento listar****  
exec spListarTFactura
go

------------------------------------------------------------------------------------------------------------
-- TBoleta Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTFactura') is not null
drop proc spAgregarTFactura
go
create proc spAgregarTFactura
@Id_Factura varchar(6), @Id_Trabajador int, @Id_Local int, @Fecha datetime, @SubTotal decimal(6,2), 
@Total decimal(6,2), @IGV decimal(6,2), @Descuento decimal(6,2), @Porcentaje_Desc decimal(6,2), 
@RUC_CJ varchar(11), @ID_T int, @ID_L int, @RucEmpresa nvarchar(11)
as
begin 
	--- validar que el Nombre Categoria no se duplique 
	if not exists (select Id_Factura from TFactura  where Id_Factura = @Id_Factura)
		begin 
			-- insertar servicio 
			insert into TFactura values (@Id_Factura, @Id_Trabajador, @Id_Local, @Fecha, @SubTotal, 
						@Total, @IGV, @Descuento, @Porcentaje_Desc, @RUC_CJ, @ID_T, @ID_L, @RucEmpresa)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente la Factura'
		end
	else select CodError = 1, Mensaje = 'Error: Factura Existente' 
end 
go

exec spAgregarTFactura 'FE0003',2,1,'07/07/2021',0,0,0.18,5,0.05,20606435609,1,2,20606435607
go
select * from TFactura

------------------------------------------------------------------------------------------------------------
-- TFactura Eliminar  
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spEliminarTFactura') is not null
	drop proc spEliminarTFactura
go
create proc spEliminarTFactura
@Id_Factura varchar(6)
as
begin
	--  Validar que el Id exista
	if exists(select Id_Factura from TFactura where Id_Factura = @Id_Factura)
		-- Validar que no exista la referencia foranea en la tabla Factura
		if not exists(select Id_Factura from TDetalleF where Id_Factura=@Id_Factura)
			begin
				delete from TFactura where Id_Factura = @Id_Factura
				select CodError=0, Mensaje = 'Se ha eliminado correctamente la factura'
			end
			else select CodError=1, Mensaje = 'Error: La factura existe en la tabla Detalle factura'
	else select CodError = 1, Mensaje = 'Error: Factura no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTFactura 'FE0003'
go
------------------------------------------------------------------------------------------------------------
-- TFactura Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTFactura') is not null 
	drop proc spActualizarTFactura 
go
create proc spActualizarTFactura 
@Id_Factura varchar(6), @Id_Trabajador int, @Id_Local int, @Fecha datetime, @SubTotal decimal(6,2), 
@Total decimal(6,2), @IGV decimal(6,2), @Descuento decimal(6,2), @Porcentaje_Desc decimal(6,2), 
@RUC_CJ varchar(11), @ID_T int, @ID_L int, @RucEmpresa nvarchar(11)
as 
begin 
	---Validar que el ID de Empresa exista 
	if exists (select Id_Factura from TFactura where Id_Factura = @Id_Factura)
			begin
				update TFactura set Id_Factura=@Id_Factura, Id_Trabajador=@Id_Trabajador, Id_Local=@Id_Local,
									Fecha=@Fecha, SubTotal=@SubTotal, Total=@Total, IGV=@IGV, Descuento=@Descuento,
									Porcentaje_Desc=@Porcentaje_Desc, RUC_CJ=@RUC_CJ, ID_T=@ID_T, ID_L=@ID_L, 
									RucEmpresa=@RucEmpresa
								where Id_Factura=@Id_Factura
				select CodError = 0, Mensaje = 'Factura actualizado Correctamente'
			end
	else select CodError = 1, 'Error: Factura no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTFactura 'FE0003',2,1,'07/17/2021',0,0,0.18,5,0.05,20606435609,1,2,20606435607
go
select * from TFactura
------------------------------------------------------------------------------------------------------------
-- TBoleta Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTFactura') is not null 
	drop proc spBuscarTFactura 
go
create proc spBuscarTFactura
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select * from TFactura where Id_Factura like '%' + @Texto + '%'  
	else if (@Criterio = 'Fecha') -- Busqueda sencitiva
		select * from TFactura where Fecha like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTFactura 'FE0003','Id'
go
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TDetalleB

------------------------------------------------------------------------------------------------------------
-- TDetalleB Listar  
------------------------------------------------------------------------------------------------------------
if OBJECT_DEFINITION ('spListarTDetalleB') is not null
	drop proc spListarTDetalleB
go
create proc spListarTDetalleB
as
begin 
	select * from TDetalleB
end 
go

--ejecutar el procedimiento listar****  
exec spListarTDetalleB
go

------------------------------------------------------------------------------------------------------------
-- TDetalleB Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTDetalleB') is not null
	drop proc spAgregarTDetalleB
go
--procedimiento Agregar 
create proc spAgregarTDetalleB
@Id_Boleta nvarchar(6), @Id_P int, @Cantidad real
as
begin 
	--- validar que el ID de región no se duplique 
	if not exists (select Id_Boleta from TDetalleB where Id_Boleta = @Id_Boleta)
		begin 
			-- insertar servicio 
			insert into TDetalleB values (@Id_Boleta, @Id_P, @Cantidad)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente El detalle boleta'
		end
	else select CodError = 1, Mensaje = 'Error: Este detalle boleta esta duplicado' 

end 
go

exec spAgregarTDetalleB 'BE0004',3,'1'
go
select * from TDetalleB
------------------------------------------------------------------------------------------------------------
-- TDetalleB Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTDetalleB') is not null
	drop proc spEliminarTDetalleB
go
create proc spEliminarTDetalleB
@Id_Boleta varchar (6)
as
begin
	--  Validar que el Id exista
	if exists(select Id_Boleta from TDetalleB where Id_Boleta = @Id_Boleta)
		-- Validar que no exista la referencia foranea en la tabla Territorio
		if not exists(select Id_Boleta from TBoleta where Id_Boleta=@Id_Boleta)
			begin
				delete from TDetalleB where Id_Boleta = @Id_Boleta
				select CodError=0, Mensaje = 'Se ha eliminado correctamente al Detalle'
			end
		else select CodError=1, Mensaje = 'Error: Detalle Boleta existente en la tabla TBoleta'
	else select CodError = 1, Mensaje = 'Error: Detalle no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTDetalleB 'BE0003'
go
select * from TDetalleB

------------------------------------------------------------------------------------------------------------
-- TDetalleB Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTDetalleB') is not null 
	drop proc spActualizarTDetalleB
go
create proc spActualizarTDetalleB 
@Id_Boleta nvarchar(6), @Id_P int, @Cantidad real
as 
begin 
	---Validar que el ID de usuario exista 
	if exists (select Id_Boleta from TDetalleB where Id_Boleta = @Id_Boleta)
			begin
				update TDetalleB set @Id_Boleta = @Id_Boleta, Id_P = @Id_P, Cantidad = @Cantidad where Id_Boleta=@Id_Boleta
				select CodError = 0, Mensaje = 'Detalle boleta actualizada Correctamente'
			end
	else select CodError = 1, 'Error: Detalle boleta no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTDetalleB 'BE0003',3,'1'
go
select * from TDetalleB
------------------------------------------------------------------------------------------------------------
-- TUsuario Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTDetalleB') is not null 
	drop proc spBuscarTDetalleB
go
create proc spBuscarTDetalleB 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select * from TDetalleB where Id_Boleta like '%' + @Texto + '%' 
	else if (@Criterio = 'Id_Trabajador') -- Busqueda sencitiva
		select * from TDetalleB where ID_P like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTDetalleB '3','Id_Trabajador'
go
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
-------------------***************-------------------------------------------
------------------------------------------------------------------------------------------------------------
-- CRUB TDetalleF

------------------------------------------------------------------------------------------------------------
-- TDetalleF Listar  
------------------------------------------------------------------------------------------------------------
if OBJECT_DEFINITION ('spListarTDetalleF') is not null
	drop proc spListarTDetalleF
go
create proc spListarTDetalleF
as
begin 
	select * from TDetalleF
end 
go

--ejecutar el procedimiento listar****  
exec spListarTDetalleF
go

------------------------------------------------------------------------------------------------------------
-- TDetalleB Agregar  
------------------------------------------------------------------------------------------------------------

if OBJECT_DEFINITION ('spAgregarTDetalleF') is not null
	drop proc spAgregarTDetalleF
go
--procedimiento Agregar 
create proc spAgregarTDetalleF
@Id_Factura nvarchar(6), @Id_P int, @Cantidad real
as
begin 
	--- validar que el ID de región no se duplique 
	if not exists (select Id_Factura from TDetalleF where Id_Factura = @Id_Factura)
		begin 
			-- insertar servicio 
			insert into TDetalleF values (@Id_Factura, @Id_P, @Cantidad)
			select CodError = 0, Mensaje = 'Se ha insertado Correctamente El detalle factura'
		end
	else select CodError = 1, Mensaje = 'Error: Este detalle factura esta duplicado' 

end 
go

exec spAgregarTDetalleF 'FE0003',3,'1'
go
select * from TDetalleB
------------------------------------------------------------------------------------------------------------
-- TDetalleB Eliminar  
------------------------------------------------------------------------------------------------------------

if OBJECT_ID('spEliminarTDetalleF') is not null
	drop proc spEliminarTDetalleF
go
create proc spEliminarTDetalleF
@Id_Factura varchar (6)
as
begin
	--  Validar que el Id exista
	if exists(select Id_Factura from TDetalleF where Id_Factura = @Id_Factura)
		-- Validar que no exista la referencia foranea en la tabla Territorio
		if not exists(select Id_Factura from TFactura where Id_Factura=@Id_Factura)
			begin
				delete from TDetalleF where Id_Factura = @Id_Factura
				select CodError=0, Mensaje = 'Se ha eliminado correctamente al Detalle'
			end
		else select CodError=1, Mensaje = 'Error: Detalle factura existente en la tabla TFactura'
	else select CodError = 1, Mensaje = 'Error: Detalle no existe'
end
go
--ejecutar el procedimiento Eliminar  
exec spEliminarTDetalleF 'FE0003'
go
select * from TDetalleB

------------------------------------------------------------------------------------------------------------
-- TDetalleB Actualizar 
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spActualizarTDetalleF') is not null 
	drop proc spActualizarTDetalleF
go
create proc spActualizarTDetalleF 
@Id_Factura nvarchar(6), @Id_P int, @Cantidad real
as 
begin 
	---Validar que el ID de usuario exista 
	if exists (select Id_Factura from TDetalleF where Id_Factura = @Id_Factura)
			begin
				update TDetalleF set Id_Factura = @Id_Factura, Id_P = @Id_P, Cantidad = @Cantidad where Id_Factura=@Id_Factura
				select CodError = 0, Mensaje = 'Detalle factura actualizada Correctamente'
			end
	else select CodError = 1, 'Error: Detalle factura no existe'
	end
go
--- Ejecutar Procedimiento Actualizar 
exec spActualizarTDetalleF 'FE0003',3,'1'
go
select * from TDetalleF
------------------------------------------------------------------------------------------------------------
-- TDetalleF Buscar
------------------------------------------------------------------------------------------------------------
if OBJECT_ID('spBuscarTDetalleF') is not null 
	drop proc spBuscarTDetalleF
go
create proc spBuscarTDetalleF 
@Texto varchar(50), @Criterio varchar(20)
as 
begin
	if (@Criterio = 'Id') ---busqueda exacta
		select * from TDetalleF where Id_Factura like '%' + @Texto + '%' 
	else if (@Criterio = 'Id_Trabajador') -- Busqueda sencitiva
		select * from TDetalleF where ID_P like '%' + @Texto + '%'  
end
go
--Ejecutar Buscar 
exec spBuscarTDetalleF '3','Id_Trabajador'
go

