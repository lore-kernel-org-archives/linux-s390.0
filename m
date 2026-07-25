Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59B31E840;
	Sat, 25 Jul 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993633; cv=none; b=nnGWU3uHeGcNhrkTg6eJU7zk4B2+a5TADpVVMvCTHI2JwAfsrXkfs7i2mbWT6aQk04AlMBGOAsjgiE6hsjB83IvJVLlvpugIucZp5TO9ldUHUbT92wC869OJD5wQti6je1QiPncST+4WEypvg+Id3xOruDKpGdV8DtSf+jcUtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993633; c=relaxed/simple;
	bh=QJIRG+pUYhsTCluHe/msR7UcHfkp5/pvhwUPGP8DuyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hnb9ZVnqoCD/6hZupnUQSUNI35OqD4qI2SjrANanGhLguh0FCvUXDY0Bo0T5JvbIHb01ktULeZ4M1woPWYvqi8JeFegkx5Cqs7OoGt0HSvZUDAN8pY3JznPyN8rf1BNlORpOKiltWLu4PZesRciijjilPDCnps8KdO/k0prOY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK+CGdw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK+CGdw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DB11F000E9;
	Sat, 25 Jul 2026 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784993632;
	bh=QJIRG+pUYhsTCluHe/msR7UcHfkp5/pvhwUPGP8DuyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hK+CGdw1jXMUXme3ww2zNu3SZYxNuvCO0JW55KyoIAlEM8PIjvYqJGf4aXzzpIxus
	 0pLOF5GDN/Qf4oF1grgnJ5ufqM/RyKA70r7N/vz2kjfri+C2uIrfGdvrt3mR66lBDi
	 qI+IgHwUDChwCuZrEvi+yBfbUpqC5UixVPRn0NvZhfuh+IjOA4NNKIL1aDzn4TIk2S
	 vBNSugu2qXSfAV9sa3L3B81ek+LUDEQGcpfR8yvAPcq3MGYPMZINAZPgvxoNsIZPRv
	 U++jEyfbVTOm12qgzveW5EoMJLWP1dxfTp0cZV4WAYkMeoojodUhtjU+Dxv5x+Nm7A
	 bVzEqPoaRIy9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-4-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:33:51 +0000
Message-Id: <20260725153351.B7DB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The routine ccwchain_calc_length() counts the number of channel
> command words (CCWs) that are chained together in a single channel
> program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
>=20
> The loop itself is "do..while (count < 257)", and while the logic in
> is_cpa_within_range() correctly adjusts between the 0-index array of
> CCWs and the count of CCWs starting at 1, this means it would look
> at a possible 257th CCW before ending the loop and (correctly)
> returning an error.
>=20
> Fix this by restructuring the loop to break as soon as 256 CCWs
> (thus indexes 0-255) are examined, without looking at memory
> outside the range.
>=20
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D3

