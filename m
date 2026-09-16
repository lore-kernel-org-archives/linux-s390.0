Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E264A843C
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560945; cv=none; b=TjM/rPfeNuE9eEZx1ARl4QlXBa6vD2Ugo7VniEHOERdKP9ICeiYy/yQDj0b7Yrem1fAeSJcSfe4c3Iwbghhi6f8sUKVAz85Kpms7+hb5Q6qe0pzDikGzgbnywLRNXukNmchvd0gE3trKKONBmoD4acJ1xfm7oW3mhW8gbGPuLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560945; c=relaxed/simple;
	bh=q6cCPtLJLuGcH+UwrECL0SeXw/RiaL2QNXO32YYRBA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZEp/OUxxgULwbcDyJ1jPuEIISUPfh1rOV+iA1D64jPlZbccAq+5AKYK1ImTyZsyXnrvwWlPzWGGyIKPSoeBZ0vMxQSuYI/cP0M7E30ODXRKQkNna0/4PIbuGJscTcrodq6BZi3NrRLpLLGj3FCtQWMMJ0sVPmklN1MlJhCMBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMcRAa4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMcRAa4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1DB1F00898;
	Wed, 16 Sep 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560943;
	bh=q6cCPtLJLuGcH+UwrECL0SeXw/RiaL2QNXO32YYRBA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QMcRAa4XMYgmsE982fWoIdHqp41VJFWhGEIYKy+Vcjf8TRCnEnuoXZzI8FxRweAep
	 ywBmXXVCAPt8QPjSDArS5sDRuCcgDC/Q6wOdr6TUhGWRbiY05BbFBxe5TtK2A8Gr65
	 hkvRAMTgHy986z0H5RLWhOTEgiUq/pjyTWJJxBpOAbcfE+aAkxHp6CW79vNkBw8+++
	 EVrRgXwM2eijZGoRpePpOoCwgkr3dXbj/PieNGe6DdjI3QDE87zSJPBBczL58isTBu
	 VXzoJOGUTS8gHNz6gJs7qoHLdg63aUAttxI5WKRs5ZI6293qUyn7uq6AuJhHno0l0j
	 6AKMpDLr9eQRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] s390/chsc: Use kzalloc() for the SEI work area
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-2-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-2-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:15:42 +0000
Message-Id: <20260916121543.7B1DB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> chsc_init() allocates the work area for store event information data.
>=20
> This memory can be allocated with kmalloc() as there's nothing special
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
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D2

