Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718539;
	b=QDafCHEXtcDlUKLytUA77UHwvXmUU16prfT5Bqf+jnBco7V39b0j8ANns3bgjlMjo0Mp
	 W4IHbdZbagwFLT1gGf2HoMOvSnok5/yMZjqz92DIjw2bjnz2xV5c/r7f5jkEMYhtLPwUL
	 7Q0gYmHR/UcEN2t/6auo/q8EqvWEeoFWxCbWGxk2mwMOEdxwRdVGD1mxmsC3eNpN/xuxu
	 B3IudQEO+XBxcxN9GdQBqxg4cbPclM6x+knyjyxS/GdtU7r6z2qxSkYgm+dN6Sqm9n09V
	 NPsqetzbrszDXxN3MXQwlROdWuu4SKaSGe1PNpDEoxpU2mWPN7Nukg5HayNVvRsRaIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UFyQiRu5rR8tJy5dJ48Bc4cGsmZQ2PI2r+zBGHHvXtg=;
	b=zliuS+7K4Y4LbG9FFbMxus0dGNp4Ei2Fp2dWqZ8QJetKOWIAFnGwvy2QxHTPq7fKl32i
	 lnDI7+H9UwcTblEWOq5JBLYDrq5f5bmAVhCT2eihJKSM9+oAMMvzFn6MvhJE6PRlJYyU4
	 0Zdz0Xbkmj/wcyx+GT7ywf63n1GkYXieC54ILXVAO/JbbPGs7T5DwQT68YRuLtqFgFhqL
	 GH57eK9KRJ7Aua97N/f7gmsLB3EUf5okZhlas6P/AmPFnY+xnwhVx8SitG2V8IKxGbYAp
	 wFhizLexxM5FFf1xoKuEnglOJdzXWux5fz6hqbUQ6/zLRXyEljoWd/9l+pY+QZJ22Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdPUfd5A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB64606B261
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdPUfd5A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2DC1F00919;
	Tue,  3 Nov 2026 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718538;
	bh=UFyQiRu5rR8tJy5dJ48Bc4cGsmZQ2PI2r+zBGHHvXtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdPUfd5Aw+PVgXpvItJhXsRx3xRE+rdHyGpzWZ0UYzKPgO1WcnIhmT0v4TRq5fQ23
	 Nrl5H5KU8+1bcaC1o7zcXSpG7I2sHUx8sULoB/uOSYXSN3UmvPcFQ5GZdtWIUTbdLQ
	 hXWdX+iZXOfjooHDCdwVxtbSnGOmsb8a93K4U+gvf6jz4+T1pfll/qqtlVG+M6+7ey
	 xHTJ7ImvVYoINmA20pAkuZk6VJyre5evGRJyvs3q6Mx4rmfzhrHBgvx2n6J+jv+sPc
	 NU0YCIhcaSEWzkQYHRE3oj+ECsrel3AFgMnvGtMl8dPhUH3KYLv3ElbZsxP8OwyjlT
	 tgSqSwMU7tm9g==
Message-ID: <sashiko-outbox-195558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/5] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103150114.68873-6-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
 <20261103150114.68873-6-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:08:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
> userspace.
>=20
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103150114.6887=
3-1-oelghoul@linux.ibm.com?part=3D5

