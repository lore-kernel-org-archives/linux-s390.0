Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83C4D7968;
	Fri,  9 Oct 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547031; cv=none; b=W6h6d7HazCy5bnXoIBsep6cwhmfTUPQKDwoQZaJOb+lLNLpAqeS8pizKugZMbSvRpn5sj+qO5AqrrOgY79CsRxZLpbfmt+qC7hvLMkA10+kRJ/rbBAK7MYHshSGbXiNiOlBbQYLcKlAZlEFVFvyIgcf92vKWqUTZ1Zpk5jH+zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547031; c=relaxed/simple;
	bh=2YG6XmStZVGSnr6G+gp+hZUVxiT3wwb4dgwUPCEMMXk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=g06V5Dd4E2+W/F6+ZlNFxcf4sQtMD/GxdhZODSCfavKkI6W8QGBRUUrWbm1A8D7STPbZMO5ePfiLHrtbbBBpClOksILCfrdMfVxhHmjKKuhhmiE14b2Zx6GGEwoKqtoCk+xmRSeJ/foGPEMTidoN7Tow4hloAJcTNyNPKCHrxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj+j+Cej; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj+j+Cej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7BB1F00893;
	Fri,  9 Oct 2026 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547023;
	bh=2YG6XmStZVGSnr6G+gp+hZUVxiT3wwb4dgwUPCEMMXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wj+j+CejTG2H0+D8DIzLmXJeOAVNHRGXC1gf7rDzSkKMRvIydboxzhF958XKO/NPf
	 t8V6Z/vu+8PKyUGbVaQqoSkxYoa/kjtrLPr5M226Ckrlhi8B1C6QxaZfwPjzd7J/T1
	 Jyo/ZEMke738b6fno+UhwhGGByj954jcH1cbNt1UhPKwHEV5WclpLHKqFswCtQDp98
	 iOIwr+Oj72attQ+TSb9DV1XVuAnCrb6l+Fzi5Jyk5aqzC8yUBQZDl+xxAM9523CUWF
	 ef5I8lA1AFtMAyRkPCTQzf+xpVD6jGS7cKSdMlTPddt/FGRJj8+/s+axzqVThCvTar
	 2e0FNvWeopWMw==
Message-ID: <sashiko-outbox-165455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-7-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:57:02 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
> vfio device state. The vfio device state is comprised of the guest's
> AP configuration which specifies the adapters, domains and control
> domains to which the guest will be given access.
>=20
> To begin the process of saving the vfio device state, the VFIO AP device
> driver opens a file stream that will be used to read the source guest's
> AP configuration.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the read operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D6

