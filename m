Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304994;
	b=JAcN/LVkm30CxXW7IU1FT2e+a6Iz/cLavFogRFctbLnrkdKdhwFku/uj2giQIRZC25bd
	 F4uaHVCI5tsU0uJF+ULLUp2M7L7/j8OuRRU/iFUOsNiaR+yowrKUWzKh0DmQfdna0Jbc7
	 eKRWmBfx6TAVNXrk/LZU8Zq6EXuqwdXeRfJ5+keMUQaIpUwX9WyZIhPuoPUh+EYRQ5Klg
	 TsaF+l4lSFTVR4hz6BtMEbBrE3gMgttZHef5zkN8KTERI5OG4wVgwqZcMj3J0iqx4zNzn
	 BlotntvSctf7QJxncGNhO7c1jLHSKwrzbc8O68saMBkAX2dasxVYan1/lr6myPIoNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jeWgFB2hpsmzqaBIH2X5H0Bk18fQP+2a940vzTwThCc=;
	b=12NPo4f/ftnBlTZrnXEJRxzqr8cu7UhOkN8+oOSE3poE0UrcqMJ9VqvN+JyreiK5ZZg3
	 T92b/YCdTTXUr3saIAnjmKqGO0MG9RUFO1zJOQV9NMyd5XGTN5tDMp/RUox+hBL1H0DTd
	 BcHghb7z9MiU7MEWdDL0TrY/KSNHEMQiaWycYcjQYDc+xWPxGro0Qdnkx7B00/Hdth4Ax
	 ZbFnoiMf+VFMOE0lknV8LwCjHfvuFjEftm2TLWmcM/QxMdGDiR1cDqm/gKHdO4XWcs5QU
	 Qi7Q05+SMIVMdBRBE/dtV2Q6gzHXVN0V/SMdrRYDGMWCfFx9Yz6Mta+aafbr28/4Adw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEMMu+Er;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DE606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEMMu+Er
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1A01F01816;
	Thu, 29 Oct 2026 20:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304993;
	bh=jeWgFB2hpsmzqaBIH2X5H0Bk18fQP+2a940vzTwThCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEMMu+Er4sRhwbIVflNxSI7GgMQjLDzWACEaTn2wAWJGVdLTllk4cG8WF1Pg4VzaK
	 gwy10+iJz5PeXGX4daS1VzaUc3JaC0ftA5HqDCQNba9AQDH6LJbg/gmZ/m5dRS5+dU
	 icS35/xHjX+e0A+88dsPVxSxTwEi8EuJN7+7vLb17YE6jzsx8aEGNyIMHlZBIB9ZCJ
	 mZpMzpzjmELgWE4d9JT9QF69+Z/IRJaCxfi7Khixxewy1XYNPv+66hLNtsUKQdnIEN
	 TGQSuHCU7AeCifrAsQ0Gez6btw4bfkQQFbHB0NreV7w2QydonRkfFeb/f9Ou5yaKsa
	 GN7ngtv4I2hQg==
Message-ID: <sashiko-outbox-189909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] mm/memfd: recheck the page cache before
 allocating a hugetlb folio
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-9-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-9-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> A concurrent fault or PIN request can populate the page cache
> after memfd_pin_folios() misses it in the page cache but before
> memfd_alloc_folio() takes the fault mutex. The latter still tries to
> allocate another folio and can return -ENOMEM even though the requested
> folio is already cached.
>=20
> In particular, hugetlb_reserve_pages() finds the existing reservation-map
> entry and reserves nothing. If no global reservations remain,
> alloc_hugetlb_folio_reserve() fails even when the pool has free pages,
> effectively failing memfd_pin_folios().
>=20
> Recheck the page cache before reserving or allocating. If the folio is
> present, drop the lookup reference and return -EEXIST so
> memfd_pin_folios() retries its lookup.
>=20
> This is probably not worth backporting to stable.
>=20
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning me=
mfd folios")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D9

