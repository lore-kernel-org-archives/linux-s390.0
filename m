Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924772;
	b=o4pskJd/LZ9l1vjco+CQNhpKItj/5KogH6EmdWUrtm8LkkutBb7DjJNLoDTrV1NoKOd8
	 2T1G1mQh5r6xHIyMAqYn9pMG20qyswOyNIXoIU44ytWfWUyNSPCUUYQX2C/BX/T7Cg7zd
	 uzlb1bakXp8IVxXRQ/M/4C4JY22EqWRqJFo5dMTXrTdYD2mKZBswlGC3ttSnJ1UsVLu+D
	 gQ3/SUDw0jYYPCu/KHEcxxkGWDDCS9GKUhxS5mbmlhXXtXi6IgpZJ0IUfvp1Dw1jFlhiR
	 9a4fGjOBJqD6Iw+QxCp2ajhPUOHH9sUtcPx0RcQxpfyoOaw13M0A2zYBcDV7ZtIibGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924772;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BrTEGxbb+hdyjpC4+ja95j3M2sAVyDzWOZ5D1nNxTNo=;
	b=YuuAjH0mMruhkNDNyRtNUV4cd6iqiwF8Pa+oxN1M372YRagu/YIO8q0bI5D89RHwk6ER
	 6G5tYl4I9+DWG8uHPjUqdRyZm01sZitKTRBogInZsL/RM9EUha2QHPLcuoYFO0VHXSKqk
	 A4+imCvla5vTbJmL3j6dHLpZHWOrEnWL0Rq9NgDIMvLvb4SwWgwtmOeXW2L0Iy2D4m4pR
	 nsG3ef08vOZsF2CBW4daL7aR+NHgj6lBRPcUNauixHO00QcJBrIjFhA21KFIKBm0N1/HE
	 N2QKkxx1RfnxFUr5SjveA3EtFwiIsj+u9pmjGohH81dVg8z+fN3iJa1YWpSa1ZQqN+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYMxopZs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78550606A88F
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYMxopZs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C1B1F000C4;
	Tue, 17 Nov 2026 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924772;
	bh=BrTEGxbb+hdyjpC4+ja95j3M2sAVyDzWOZ5D1nNxTNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYMxopZsQHMgkyDimIwmBXnXLPIIdzSiEOCnc4rravXYnCVFy7tU7TfWRpD1a0mnu
	 YCj+q0O7wPh3StiW9lsyotxYayMHobN8fM9riJkON9rFMtd737T+7KPwig+CWH/Gky
	 6cD9qrLeEbh8aok/L6TMgXzuK0zRPt4MD2as3tjOJy+Fp+1/5HNcWB7RM0G9aD+Rse
	 Oi44AtA0yj4NNhNOX8N6qzQbszBVvLer/6gpoOW/9nnfIV68k9ZkE+mzQHgI+QCqvz
	 O4OoCW3IgGoEl+ul7RWfhO0XGuDyGPfd3Rt37a3fXOWRbzQBQ6MLVSjt1twKPRXUJa
	 3+M0tG0Oia3Xw==
Message-ID: <sashiko-outbox-218937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] s390/sclp_pci: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-3-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-3-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> do_pci_configure() and sclp_pci_report() allocate the SCCBs used to
> (de)configure a PCI function and to report PCI errors to the SCLP.
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
ready-v2-0-e518c99622c6@kernel.org?part=3D3

