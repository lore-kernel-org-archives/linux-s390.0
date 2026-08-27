Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB596484238;
	Thu, 27 Aug 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846425; cv=none; b=cyYDHMRbgamSyRQ3OwAaM3vAjHrA64VltRWp7VcmXprYeGn8wIdumjCDa1iY71uHvym0TclHG6q8VRhjuKShfgup3XE2zslXjexaCYgu8bUeZ3C8b9B3FG+v/aFokaovCdCQpx1aW1YP/i+CGX4U5wICC1k4w2SN6tZ4fkO6lD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846425; c=relaxed/simple;
	bh=1jnxbB8n5nN4n++CYEbxChncJQU/CiMS83Dow/kWSng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kO0Cp0MTqQLGhIzZXIHNEqO2SC+9oKimrAWt1MS5uG8ZCkjfneago8+1YqigAqqOKy8uXjD0FTMWbdxQ5BFJsq8EY7fxZtjREWQ5HK78sxh3lQ/Xc5z1RiwCesj+G4maZcQu+Drbg3l1TBxMVnkp75pMCWc0F6Cisjq8IAXQoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In3WwupM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In3WwupM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706BB1F000E9;
	Thu, 27 Aug 2026 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846424;
	bh=1jnxbB8n5nN4n++CYEbxChncJQU/CiMS83Dow/kWSng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=In3WwupMtlKEH2dH0qxh0XW2m/V+bXZaBCtHadqbKsLdi9nlDQ1FVkoketCvVRfhw
	 Fjr3uD5Fx2aGfLwB6dfH/N0lijCdcwXpSDKW6ZOVmM7spzyS5jlzn/NDTaF4D8hRJq
	 AnHWBqJNphK/vjZsqTa2vUSuzbLIG88kTOpyz+z066phb6fOMFhTjH7edxW0lvBgeO
	 Xz0LwyZs0xBltZzarIt/U2Ss8CDui4iIAI8NQesRccE3THecAYsMhw2T89+spspwR/
	 9GRRty3qs50017yznLGkKcdW/6RQGEPifqsvYPadxlLYXOsOYnvFnlKvUBYEm4Sfii
	 59MHtr47lj/9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/21] KVM: s390: vsie: Add SCAO read and write
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-1-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-1-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:00:24 +0000
Message-Id: <20260827160024.706BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce some small helper functions to get and set the system control
> area origin address from the SIE control block.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D1

