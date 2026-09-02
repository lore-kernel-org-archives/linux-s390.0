Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65E314D34;
	Wed,  2 Sep 2026 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329942; cv=none; b=rZlFnLN7J2ojw/doyTQLhuzFJel/z4SYEa4At7uISc5ERePjqg7me1VnTqLzBcVNCMvTVzJuPPgfJH3LQAPI0ZNjnBsLc4Dfha7rEYwTUCiz/tbBAIKX9P1cqFjHRtuSb8ivoWk7Qcm7/d3xrJKJkrQDWQaGCreDUg16z++wvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329942; c=relaxed/simple;
	bh=yZImgHLijKu4eoQlRqK4VD2xnoglVSyksl3dOF62968=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XyfpiOyFgFoUcfTmI8JkoBJIOLM0kuQWKNdfAPRxTThDLCJ8nlSZXsNfB1jV79Pe5z815pZq6auiaNUpunnelddZw9LPxHkBMdifkNn3vPLhXJ3nFEuEhOzFUmN6IRlTvOIOFYpYfLG3sU6HhASfep0qjrtogE5jL4VXvhgJhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI8MmDZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI8MmDZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E41F000E9;
	Wed,  2 Sep 2026 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329941;
	bh=yZImgHLijKu4eoQlRqK4VD2xnoglVSyksl3dOF62968=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oI8MmDZ9ZW1i1Vbm8Felty6TiPirAmrOMXvBSmUwzvh1yj3zg/EE4Lqy0BF4l8NDv
	 LExf4pHl3hTqGl3G0C7giSPxVB5CQoVqhtvALE6E0wCWp0l0qh8DPvXfjG4zmaXcEu
	 POWJ0IyzWR7B/LHpdcUm7ynu3InDp+hsovYfY/rzW0+cnpBtN5iBdffS2E6e1Amd2z
	 q+/l/xk6QELqRwPo4L0q63rDjqdmEqP3SgCRboJecDEA7TpMXDFuDfHiq3d3jjS+kq
	 dkX/rOMV4hoFpRn1sn6nLyaMd0mUT2xa77Q7VAoCJ1POBoFqCAVvTc3s0KD0em/Zai
	 J6TufK8BHIV7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for the STHYI buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260902-s390-kvm-v1-1-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
 <20260902-s390-kvm-v1-1-3bc0986550b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:19:00 +0000
Message-Id: <20260902061901.0E6E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> handle_sthyi() allocates the buffer that receives the STHYI response
> block before it is copied to the guest.
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
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-s390-kvm-v=
1-0-3bc0986550b1@kernel.org?part=3D1

