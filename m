Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD5431E70
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816713; cv=none; b=ZQkJm45MmpNaL/pCzmZE420kp0I1xn5m6ChLIFx/vuf5+Bte4YcquUGMSyW9ywIhSJlaeizOeN6ppKL1uGbDinTlQP6+434dXpPjIAi6wba+R1MKAP9VNz3eNs67cNN87KFqbrQu0SHkAsvfOdus3IdUeyvO5fH/0P1ri8OZm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816713; c=relaxed/simple;
	bh=2PV+jAj7HH7DeSapRN7zCRVb9B0mjzH4uc9/tSSkcNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z7A1QEp0LxD8KOWFQLKkxwtHv6X6tJAccuAF3MuyrIzNAonOiP429uAssN0nY+MH39hTxcgHcb499GEBKVivJ3qR+k8FO7nZs3mna/By6rsA6jBX6d8jtcda+38UPCiem3mxJRuThX0MKrpk01FiaHK41i2XFrX4aLQdgGiO/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5wxMuEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5wxMuEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE22F1F000E9;
	Thu, 23 Jul 2026 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816710;
	bh=2PV+jAj7HH7DeSapRN7zCRVb9B0mjzH4uc9/tSSkcNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H5wxMuEJGnszw2vK/BuClsbnRd186zJAGu8veMtSCqPfrcEvXMHLOZwAkHZsuc5sh
	 XGO1FwzsHTTmH12BzVaa15Zqn9OKmwlJWAZSw06VZScSo+fKg23DhFjXM50IA52kyb
	 WFkAauuS/pRP2r7OZaYWqLPXIADiRoYuTXKWduGV89N0sBE8jYgIwPxQe4P22XgFwY
	 Tf56nB1t89ToXfr1IQefYPBYUPUzHHy+CU6BleG3dkZKtB//UF4WMElY7NNfntScSl
	 0QdG083O4MeJk9YCXfTZhL17zvCOWWnje8dmfkTCy03RW9vlcAyWTIT7fY9ZUT5+cT
	 W7cxFclWwIBQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/13] s390/dasd: Extend prepare_itcw() to support
 WRITE_FULL_TRACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723134743.672413-5-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-5-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:25:07 +0000
Message-Id: <20260723142509.EE22F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> prepare_itcw() builds the FCX prefix block (PFX + LRE) for track-mode
> I/O. Extend it to handle DASD_ECKD_CCW_WRITE_FULL_TRACK.
>=20
> WRITE_FULL_TRACK needs two extra bytes appended to the LRE for that
> bitmask. The prefix block is a scratch buffer copied into the TCCB by
> itcw_add_dcw(), so keep it on the stack (sized for the two extra bytes)
> rather than allocating it: this runs in the writeback path and must not
> depend on an allocation that can fail under memory pressure.
>=20
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D4

