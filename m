Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164851;
	b=rnrStnWZKQj+FjGLFJngZU8KAlYFUVZURMtAbNEQGaRacOoxsVg7LSX0SvcjSxc4dZeX
	 4bCNxthbrYVXyZan/70S0CUuZ1K82hr6vZgdViBj1L5acOzE0SC1UZ6tw5413UTSV6nXS
	 Vh16bYIe/cmXr9TDuoIg3Qkik+STVMzwF2dlFILdUnd5//x0SatqAqXrs0GvLoXMasCL3
	 oHQrUH8O/Zj4Y329hvFXe0bDD205jn7SbmUtZ9hFplMsD50eRYPIj5Ai+sxB7xwho9E1n
	 vNuyhqHCVIGwmSY0h9gO3JjukIttgCoQDUtNK8EJzG0U+yakam/C3fMHHMSatZjZivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JtsLuGgf6eTFWYpxvy+ZM9x2q8Py3kuPT57GAkvEliQ=;
	b=sCKoqQcLiUlwrCJ+jf/JXTsKliZHytmT1X6qIExG3sfYageYu+B1oTcCHWW3zXOyvnP9
	 4SjUBygnebKT6DxR0eobOXBr5Kv/JsbimZITTGfVF4KvCg8piB4DDC6ntbdBAuJ2wQSwD
	 cJ1FcIN3uXWdgvslbhS6vYR6Av6tJV9+7iU2GMMuh7RfhIFtExEt86z9JvnBymb1cI4dE
	 PDkYrhrWl9cVyvBiV6Cf0bCG1FoX/aWMzF2fdW8babJ7ghnrWtP1rjF8KoZCuOkooq8KF
	 T3warqSMKHBNKHRyVDv1xl1jxY3cmQ5eMBj8MDVF8l00kAzDg5zlDsCeyeWuYpXyh0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmkqyAsM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838A606A31D
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmkqyAsM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DCE1F01825;
	Wed, 28 Oct 2026 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164850;
	bh=JtsLuGgf6eTFWYpxvy+ZM9x2q8Py3kuPT57GAkvEliQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmkqyAsMA+D/5aRWdEZnVazDkgbQABa+TwcaGw+QlaKP9e8njdONnh6RwGbpV0nso
	 K3KPvQtct//MWGQTAjIxTSqgYDdll3lf+Uemtxtml3uVVmFrGv+8fX8w16g1QsD2ZT
	 I6ot0a79IReZ4Fmp1/SCCN+ThXeTdKD6dhGIJR42vVvjjBjz+qeNyhypPyLMGaUmxK
	 Tsn0Uv/mUM5F95hvfadFf0hlpRAMS2kTCYDtPLxLlapTBDYyvZ5IrqP+5SLRUSnRdk
	 rf5rtc8fN3Y0VVpCOdk5GVDmkwPSVcpW29ESB0Mta7ouugUKuu/K2X6xI3UmrI9wlg
	 hEOI7H+htiJag==
Message-ID: <sashiko-outbox-187527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028051446.3163392-2-nikh1092@linux.ibm.com>
References: <20261028051446.3163392-1-nikh1092@linux.ibm.com>
 <20261028051446.3163392-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 05:20:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
> sg_resp members, which are of type struct scatterlist, with request and
> response sg_table instances.
>=20
> These sg_table structure reference the corresponding scatterlists
> (sg_req and sg_resp) maintained in struct zfcp_fc_req.
>=20
> These changes allows to track the original and mapped scatterlist nents
> once zfcp is converted to use DMA-API for mapping the sg lists.
>=20
> Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028051446.3163=
392-1-nikh1092@linux.ibm.com?part=3D1

