Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC533E0234;
	Tue, 30 Jun 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840210; cv=none; b=LBnmjj+2g5MaNMs76+fpi+4SqUJPg15MvtSfdMK64JMWhrSSO7fJVANOmHVJg9z1iNJ4QSftNPK9yJhc6k7hbn3ZtQqbrIhIiWKQV5pyEiqFRJs9uE0hN+fvOr4Bjo0zxOniFMKtX9+vlsFV/JkNvx76YwLP5i4Ub/ydAREZ/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840210; c=relaxed/simple;
	bh=2/PLOMBW0BkEjg72GdqLIJB72ETbgMgHbDTZU0aPQoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=paKAGhncBsd9/s2itupMD2CRn/KOqN0Hx+MOL6I7AB7dXvS7mviD7zCWnbdT0SUpw/m0w2GC1O2zBBNx/ndHm1Owgl+4uP8m1h5fYAfYlIUdKCymEN3ye9ANpodOmKyK62Asqej2B4a8OIhlqsi8kxKUXWx5Mlz2Exke98mIrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECQAGwOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECQAGwOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565E71F000E9;
	Tue, 30 Jun 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782840206;
	bh=2/PLOMBW0BkEjg72GdqLIJB72ETbgMgHbDTZU0aPQoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECQAGwOJoXCCuBrl7wvcjdp/wN7d7FRkxmc17LXc7ByQ0dRKAbZtHwThP8H1UEnoJ
	 NUfsPV6gwpTOC27avqUEVHZOzgWtyOg4QNn5KQl3rO3qZUiMTgv/yCYtSj6Bg6tgtl
	 KyL/Lu1nawbEMofZwfWjyiXkLMZKslS3W6vhrs6OwjLe+GoMKRTCaiQXcbc5qjPlHQ
	 1TIayRb4vSD5ckCYrXhIKTfepirlSzuYv4S1gy2FHDwdTOU+YgS+X0wx3d5bF52Fkn
	 KiKpy2C5HRydWIaeH5JNztym2efjwxVRdo0pfar/BWeAjlA9U4mc54VMjvJt+1Q1Ns
	 8fRAIcubizIzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/3] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260630165553.725-3-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:23:24 +0000
Message-Id: <20260630172325.565E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> For zPCI devices, we have platform specific error information. The platfo=
rm
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add=
 a
> new device feature to expose this information.
>=20
> Userspace needs to be provide a buffer of fixed size. This size is provid=
ed
> to userspace via the VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630165553.725-=
1-alifm@linux.ibm.com?part=3D2

