Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888352;
	b=VnNfDD95llXhJ4cun9j13JUu0WykYULiMnWOnU46/D0r0eHjx/1wu3EQoZ4igLPnlpt5
	 whiPEoG61ry6NanX14JqDtb6aMPH26rC8C9fyeuFQ5dsaQLpuEqrgmY24Vs2nARRYfM0C
	 GMyCj385FeRwrl1wg0gJPiOHgeqCqXt2N/raIO/EFUSvTuO4Yom3OoqpeM0OL4GhF/d71
	 21nl5aBWJV5ibRFW437YyL04QdObSGwjUZZdJdFBuGDLobVgP7fdgYgRKsYFFXopbvjoH
	 I4jCxN7nBNs2wKK8N6Jx363G/e4xvDg7bKjPL/yLuWpLwbkvUjKJBL5/xJId8i1Cj+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jEViOPtCbiSdWEKkmNpKzBB5PQACzPrXcvvbx1xPg0c=;
	b=vPnB3aa9FmVCecYx/muGueaVWRIwmOlPvqkFv4i/CjmQt39EsreEAdOynurTzQPHV9Ie
	 fCypNzloZjAH7s4tsVHZMw/Y/4zWURzUtNzwtnipSRtWkZkkxK5YzCjRbfw/PpHEKyd+s
	 3mLtp++Jg1xL0DYy679bH8gH5KNpD+Agb4MJeUoXHwLF81i5cI14OqCNMip3//t/zbP0N
	 rbIUKND6VjKVRWWtdU6eVOCZxUbyQUTgMLhEQgFNJB1cBx65XJYhzw4cGsVwx525UwHx5
	 ng8W7EceVfSgx1gKPSbOSxFd6OretYl8aZmag/8AgvmyGB1gdrhvwsqd5O/MeJ5csMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVY0AYxQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED347606A332
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVY0AYxQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C25A1F00919;
	Thu,  5 Nov 2026 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888351;
	bh=jEViOPtCbiSdWEKkmNpKzBB5PQACzPrXcvvbx1xPg0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVY0AYxQwx9vQeIJ0qDHFAK96bsC6UC6xQZIpqfUIaOiOSD2DJO1+4UF7Qbb5wXgY
	 xrxSxZffAmql9BWbo4VoCp0wVW1NDEFU9p8LJnBZijfVMCeu4GLoMdHSkb7BwLfDLA
	 PQNueCVDLhgjK8SESxP8QmoK7MZ8DOblL88bnnzt1IxmZOWEVh8KHLHKBymLAkruVB
	 QK2kXIrduVa5lAbhfpMiX2JFBZPtz9n4amJqslPPhUVA8pdOQZLMUW/3KYgu10EOmH
	 ZNxsY/wJLbz3NiJ16qwWXn7L1b9XSMRIGaoT97Hs8G+ECTR8A8ihoXHYeNDlN41Ce1
	 kPJ2UcTGGMthg==
Message-ID: <sashiko-outbox-199220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: arm64: Tolerate unused functions in
 extracted source
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Grapentin" <gra@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com>
References: <20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:19:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Extracting static declared arm64 functions with no consumer on the s390
> side into the generated sources causes compiler warnings when subsuming
> the generated sources from s390. This causes spurious compiler warnings
> that make it harder to extract larger, more cohesive portions of the
> arm64 source.
>=20
> Update the extraction logic to wrap the extracted source into diagnostic
> pragmas to disable -Wunused-function for the extracted block. This
> allows us to share more freely, and also opens up more paths for future
> code sharing with a separation of extraction and definition of consumers
> in separate commits.
>=20
> Obviously no functional change intended.
>=20
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-series1-fi=
xups2-v1-1-55f59e6c4c7b@linux.ibm.com?part=3D1

