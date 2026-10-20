Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507112;
	b=juS6gzwAnjqHnYx/Nz2p2f/dv95Kppyei7yBqOz55UlSaF+UHE0GzObM3oNd4UKsmkeT
	 Tt4BdtXju15qenqMhgUMIueKBHL2tSGdamB/e5Mm0T2DsfyUVgaF6Or5QL/S2SCp8mInY
	 7c3qtnvT8buNnlFswvru+2gJ/Mk9MGJDNJYBOSndqhmS65ELl2eh70ClxeY+F1LoO7K9L
	 zuFFxQCA3rkuUNsoQSHpMVLK84HMYYKALfxJwtsl3/Wh+E9mwkEISd67ng+rat1um8Bal
	 Wu+JTelPPOFfa5te+YCyGqSAjTvR5gvBYTfV7SbGi12/FBhC4fPJogKaVeoo1p1oE5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GlTKTmN3XwE/TyXpGmwyoVcehfdL7YMfyPEWLc0ErtE=;
	b=NNu/qzZThIBFH8ge9hJPWS1aMiAFB2nrZoJLGeNnfeBKPcMkjh+8l5ayi0jWKqU5/bpL
	 DPWrFOQywyYjEk1hL6hA23c/vTnORKoVhgGaM++d83eVcQmTnqre37n3YoUpaEqDouH1N
	 KxgbFUDFd1gZUWlnaUJ1oOrR2n6i8SvDhhHVeU+7yPWleO+KHNAgOtcWGfYDfuSWak2iz
	 ROBiRj+M8k/u0q49DOpU5w4Jw57XD1EI7y9QF7kegbK4DtJDC5ZwkME312uYUSgUCXQ5H
	 FTiP1lE4XMtb18oNZe4TySJdvEX5qdmCxfnHO0rB9DBQ5GhWqlZe4AbCnChPLIcv0IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMpQZntx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B7606A322
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMpQZntx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8496E1F000C8;
	Tue, 20 Oct 2026 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507111;
	bh=GlTKTmN3XwE/TyXpGmwyoVcehfdL7YMfyPEWLc0ErtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TMpQZntxaEdlYoY/BgYKzmVWpwLQHN6RW2m29NQWuJKgB39Byw8WM6juHtK+oLQtL
	 CPYeNHLTTjAS154jO8yHoERWUHf1XpWybgqQjO47QvdwA4LtFdrdNIQLS5CC0pUSw9
	 qsqnfVIZ5AgxOvklDfq82PqC8pNBDlO+6CDGI5iKhZAcL1sV86Zy1sKs1vxJlVe/ne
	 LmsJ8eQnOpylt2pFtetxxz6nnjaOT7U1tw0/FvktXLZ3AeA8PbXJHf+aNMVRex5b20
	 m6KDZZcT0qNHNfj57Tuy2zcmgUtGGh3ni2qSA2OWvC/pDOgNk6USZ+J3VplHx/we/M
	 z64sBecZhkc7Q==
Message-ID: <sashiko-outbox-179167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: Set up async page faults only for faults that
 need to wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261020143308.228328-2-borntraeger@linux.ibm.com>
References: <20261020143308.228328-1-borntraeger@linux.ibm.com>
 <20261020143308.228328-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:38:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
> There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
> errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
> async_pf resulting in endless retries.
>=20
> Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
> the error otherwise.
>=20
> Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020143308.2283=
28-1-borntraeger@linux.ibm.com?part=3D1

