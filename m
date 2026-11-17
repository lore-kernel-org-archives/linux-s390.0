Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924780;
	b=npKgg/ufHRP4NwPfLOdVjJ2NES0WQLXEGdDBMSMjkxt3gPBEFqqcwdnWRo6ys59VAYgE
	 tTscKkm9S+X6XiEcsNWJjhYUBEHl0/Aw3s1bOCbkjQC3vtxKVYlMhuemNpzQrdojkGck/
	 AQPPULDDu3jMmUWY/gMvRreNqUScXFv4b4El2yClnIBAMvf7/wEvtT0Km4Ql9Pf0Repn1
	 fnIiay6fbEi14AvxbeGpXVQOBuH1q+dAR7w8+ojOVtNr1xHTA9wL9B2Swg8hHRw6tqfWw
	 MEQmudkw0FLdSx9jzcZdJuQDi3Y9UTuuGQpNLUKjvWkh2Hv9M0W8+pYXPiWZY1ym9wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5pIm4eqYYTo8hdeb7YOyqi0i24XzG6Vi9HrxcpYQ5ik=;
	b=zlYQCYhcqwTtPZa5SxKXrZ4qTChfSwo9UX/e0y79ze6nL62inpv85OryFvE/+sENWwJG
	 SoB2txkagUCfR9WUow2GFv5cbkN48YaNCCeBwsIo5xDxMKsH93vUv8sQQJqmRzL8jjszq
	 /9birHJbnIWLB2YLecjiNq2V66Q2+/Rx2hE3399xe/kJaqTPtPWmzBRX+RMm9HTZpw0MD
	 JlS3VS9AfWFntkm4R0gbGzsO8YGKHHQsoyVcO242VjzQGOrXEu41WR8LXkKGnA2HGCQiP
	 tnfYQnsP3rs2tryX12hYEFRX9weHzj4ZexMftOtCXeTgNOI6XsAS5Tq0WhRWk1X3MlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMbVbzcj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879B606B0B7
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMbVbzcj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4801F000C5;
	Tue, 17 Nov 2026 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924779;
	bh=5pIm4eqYYTo8hdeb7YOyqi0i24XzG6Vi9HrxcpYQ5ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMbVbzcj0m9MDeP+kfo46TkrG/bacAs7yFSOREGuMRN9JXMPTzICnca02IgrN3Iz5
	 WQOyUcqvjtHtMALKzDHEtgEvnIIXq0nGGXdXgi8U1LsDRV2jGYjKiJXjCDTN59qZR4
	 Hg4ge5G8BRoMRJdl6O8upTKLGEKjCwomW+EwmIBrguJAU1XBBuZM3PbyfpGKmlpN4Y
	 bU6rMzPK9SDRtcUXClnVY5Rx0KVoOiW+mATveh5jEnqnWLaHb8n8yU4C++rmQNamzJ
	 y8pGUQG0J1U1XCJicaOacJJKEJ9xKvKlUfdjrNn9MGzR0MFagAxnL7HsJPVSCMK+Yj
	 NEeTbOSlC8XOg==
Message-ID: <sashiko-outbox-218941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/14] s390/sclp: Replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-7-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-7-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_init() allocates the SCCBs used for reading SCLP events and for
> the SCLP init mask request.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
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
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D7

