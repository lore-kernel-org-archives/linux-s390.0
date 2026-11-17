Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924774;
	b=CNqICykUsy9f/5Uk97VDcJXH3GOTkbIao4keiSCXPi+7NkQDs4MC1bf1Rna1ANql95+n
	 eUcSEc5ra82lewNVpB0iU/Dr9sHmBdQXPzgzjOOJuc/1gfU9O8MrXDTOcP4PKm8oiEPTw
	 6lIpY/+2rOIx0J3Y5bubCMa84i3qf8M4Nnz7uQRroPOOQxeyTq7CiwbtT1/95T1j6niNC
	 HyaRuoIKiScR9AbY4TXA4MFXYRitLlUUlYkdZESaYRLp4ieol8vtPIcqGQ5Divjf9z9b9
	 /t4u5cAZFVAgRDURrO3m+z6U1h7tx6lnBJbLGD6ItF6yJkKIm3thhq70n+MaRZVSIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Mblno3zGbk+dRtrMvz9eXCZQki6K6S2AYbxwmix1n4=;
	b=4raNKaDq+MiyJ7cMKSOWMY+QbbjA0s+bTmtwBgGexm8bEMm0vlAfzOdGU+wIGKujAUSc
	 pVExgA4DSE9mRlYL0eAGP0z2yh352bB8lt/FMZWykX+f2wceD8M7F5skFbtaI7ALKOZSl
	 8Pqd/E0IJ+hauvLGreaTylTbd90vvDkO1aKugJopNXKr8JLtOCsWr+4RNVquX0kzNjdZa
	 P9DBw7uIzkqr4nOyUftfcQQ5tYfezGiGxEqs3C0+yg3jAHsIDoZWpgD3/dt0K1f67VWin
	 ySSPn4iNxppPECUutPRSgoBt3dN0BA5Zrwdz/dOHSk7Iv1F16HLlurkAvQk/3n8UW4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHiQRomR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19948606B088
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHiQRomR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCA71F000C4;
	Tue, 17 Nov 2026 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924773;
	bh=2Mblno3zGbk+dRtrMvz9eXCZQki6K6S2AYbxwmix1n4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHiQRomRieJ8yfL1prP3/ryBrvJyzuILekQmIQEM8LXBKGqA1FdgR7vWsd+9qcaqs
	 q2x4NoT0TKoO3h33LL8i92trk4b3PmidmgzsuUMKJxtNXZR2w07UmryGeguKAMzV9g
	 T7FUFueTppm7dehpwcGbOUZkoAUm85jVMCT8oqdxeVGHfxnEjwJTbZ8bUGE1sSzgFr
	 bOY+eaGasQ+VUlH9P08aKmnE2VIpbDtIavy2Z2IktMjBm+ezUiangyjT1XDv+xLP7d
	 c/EImCv+FmXflyb3AN/0Il13XDrW0jHvo70Jw26f0YrvxcUcv3BHrQTaJjj0xT0QR9
	 laWGzZhhW4kIw==
Message-ID: <sashiko-outbox-218938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] s390/sclp_ctl: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-4-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-4-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:52 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_ctl_ioctl_sccb() allocates the SCCB that carries a user supplied
> SCLP command.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D4

