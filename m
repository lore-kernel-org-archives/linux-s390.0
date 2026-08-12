Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9A47F77F;
	Wed, 12 Aug 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555042; cv=none; b=SkVvnamxF9K+YBU7KHUpTWzBJZqHWc6HxI/0fcDivxjKrvwl+TDEyOOkHe9mDeAebIyVVf8XX+iLiOhnBzC2YwKpGrIfVlhVgyK6FnNU6uKAvskDrY2nfqMxch+6a5CWO3z2cLkc+/BIqlrQbGM4vKNtlOc9QqJVnyjQ+7L0xak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555042; c=relaxed/simple;
	bh=LQfRqJdgQnS2tLTGtcAOniFoPPIIeKA4DPVso+Vm9bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1NkeSM+zmA2GD4spjbWsO7mekpkKmQ07PSP6vdr9PyWDaAoopyQmP361cCIt7IZjz6WWBRdkcHHKImey+wYDLHBTEplKrTerW1AU1LHwVmSLH9QpPrjZmVYXdf6Wf6cHCLOn9JwMSUcBf3JKNfiVmSDgPRagzydLwlVxl4cqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH9zwiai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH9zwiai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714151F000E9;
	Wed, 12 Aug 2026 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555039;
	bh=LQfRqJdgQnS2tLTGtcAOniFoPPIIeKA4DPVso+Vm9bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KH9zwiaijX91adLe+V2qY28z4BWETmP6Y0D+FcFUygIh6Ky9FMM2O7V/nBHqwxSaQ
	 d2pnIIqHSPckFutjrU6WzH4pgP0tUsb1tP4nX+0o3zBK07ACt3zrDEcXPJbJCw4qyu
	 6qSE6f7P6AUNKrvdCF2w4BCy+sNY/eVT03+VmmHwgs4dT5R/mWARRuPTB49HomdrxL
	 7IHdb0eQGhzKCqUGHBorqndHEMhM9UPQsHt0FnfD4bxxsvEEktcJRKlQGOrZH1unlp
	 e7D3SeT6FoNiDYyNk6wFqLhD2GMi98XR6uDA5WT5p8+ZRExJDmohw3fUNcsNkjnYQL
	 5nK+XS4c9S9CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] s390/vfio-ap: fix potential use of uninitialized
 apm_filtered bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812170945.738351-7-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:17:18 +0000
Message-Id: <20260812171719.714151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
> on the stack without zero-initializing it.
>=20
> In vfio_ap_mdev_hot_plug_cfg(), the vfio_ap_mdev_filter_matrix() function
> is only called to initialize and populate apm_filtered if either
> filter_adapters or filter_domains is true. If the hot plug configuration
> change only adds control domains (meaning filter_cdoms is true, but
> filter_adapters and filter_domains are both false),
> vfio_ap_mdev_filter_matrix() is bypassed.
>=20
> Consequently, apm_filtered is passed to reset_queues_for_apids() with
> uninitialized stack garbage. This can cause reset_queues_for_apids() to
> interpret arbitrary stack garbage bits as valid APIDs to reset, potential=
ly
> performing unintended guest hardware queue resets.
>=20
> Fix this by zero-initializing the apm_filtered bitmap at the beginning of
> vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().
>=20
> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan compl=
ete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D6

