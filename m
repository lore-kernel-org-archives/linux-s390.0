Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924782;
	b=kL8x0whF/Zvg5fJMYD3rZ/mLh6n6sbfDTt3OQxWLTifpWzbztKnJPoZRFEUnxJQz+9ZL
	 /hvLlfaHUxuE1wQVcbtEAkG09uy6SBAzRMCLnUzc2AC5/y+UK7XWhBwRTcB0D1atI/OMs
	 3ajvw/aF5Hu57CkUAzWyk6CM6HU5riSHhK7kVophYXIVCH/YxUJrx3V+eGCWWfMZzzpmt
	 3q+BqigdGvX5w2KwIByfxyZuWIKIX91lDx/p+FhUUo26iEno7jHjUy8M1RfTk7V2ESfEw
	 +lfNNhu3rblCFu9EdNs5pJoq1mUBszsJQqfl5idSr00jAiOJ+hYL34uJLCXUUN8BN4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ITL9n6coRqzT61vcHjGkK/Xvhb1pVyzCMs3uBM1jepU=;
	b=lr85LvvtiFASx7kmmUQdGyxanalCMkJ80lmhj/4hcs+URi0vh5A/azkbfmJVTfcb8kPF
	 xGr4cvogZ6afecFfIPUhE0cnmmva105Hv+zw8MEeFlzQs4BRBEuuQYCAC0XdcTJmoJiTt
	 C8iWPfE3vBDoSn7aQpp8JezUsEqC3qyZ6TrqeOl7S1c3GUIKOy9WzURhQR+/WWZrOFjFo
	 IayAMaQaxeYbnzTD4RVVS81E2H+bcTg7Mubx/6qy22ICDdpLmCapnvtPmdBe36htPUrQl
	 t7b79zP/bJkkd7t0Jr4tOwlGyy+FSfVKPcxQ7setZIAkG4pirZGo2Dm6TbEW8Bad/+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nl2DUFVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73F606B0BD
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nl2DUFVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4A71F000C4;
	Tue, 17 Nov 2026 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924781;
	bh=ITL9n6coRqzT61vcHjGkK/Xvhb1pVyzCMs3uBM1jepU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nl2DUFVOJd/PhQP4FGkpGDQCpZ5yhRLNk6/4fMzgxlQGFABUGZqeNq89nYDFPcT7E
	 zJKtrz6/FC8dTLjN8UfAcZHjdZcuZHiUBiRta+9Fi79DGUMBVUX5RqTkhrOQdeg1e0
	 OB7T0n1Z68vLVM5a/oecg+9h57nEJoYl7jnVdHL1z8L8pQJrJAsTxddhZw8RRLDDsJ
	 vv/2yQk2q5CTYNJDqGAfom2u1qbN9BFwvX6twT8ClMStBTlkPmg48iBXylPkNA920D
	 Jjq3VKFbgQLzNKDo+C/1IiMO8jQzFffYQ+8ppqqOGpObYtp0BJ16Md2r5yUCq+/QvC
	 lujJ3MKEMB7MQ==
Message-ID: <sashiko-outbox-218943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] s390/sclp_sd: Replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-9-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-9-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:13:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_sd_store_data() allocates the SCCB used for the SCLP store data
> requests.
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
> While on it, pass the SCCB to sclp_sd_sync() as a typed pointer instead
> of an unsigned long.
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
ready-v2-0-e518c99622c6@kernel.org?part=3D9

