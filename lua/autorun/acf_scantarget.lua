if SERVER then
	hook.Add("PostGamemodeLoaded", "ReplaceACFScanHook", function()
		if not ACF then
			return
		end

		ACF.Scanning.OldBeginScanning = ACF.Scanning.OldBeginScanning or ACF.Scanning.BeginScanning

		function ACF.Scanning.BeginScanning(playerScanning, targetPlayer)
			if not IsValid(playerScanning) then
				return
			end
			if not IsValid(targetPlayer) then ACF.Scanning.EndScanning()
				return
			end
			if hook.Run("ACF_PreBeginScanning1", playerScanning, targetPlayer) == false then
				return
			end

			ACF.Scanning.OldBeginScanning(playerScanning, targetPlayer)
		end
	end)

	return
end

hook.Add("InitPostEntity", "ReplaceACFScanHook", function()
	if not ACF then
		return
	end

	ACF.Scanning.OldBeginScanning = ACF.Scanning.OldBeginScanning or ACF.Scanning.BeginScanning

	function ACF.Scanning.BeginScanning(target)
		local canScan, whyNot = hook.Run("ACF_PreBeginScanning1", LocalPlayer(), target)
		if not canScan then
			Derma_Message("Scanning has been blocked by the server: " .. (whyNot or "<no reason provided>"), "Scanning Blocked", "OK")
			return
		end

		ACF.Scanning.OldBeginScanning(target)
	end
end)