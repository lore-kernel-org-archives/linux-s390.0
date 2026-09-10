Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734B46EC99
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038734; cv=none; b=vFpNEBlRLPcj724Bdxu66pX07tlIkJpsCkPlSZi5Ysf8R4cNfo/S8DNHS2U3v4iKls0XR7Uki8q+YpMulo5syp2vNd98zcx3Z3cFfvC/YrzTpgGbL2ue0rAC1tXBFQFHbO1S4Fl5bvmPUqrZYo5ZS05pD3izs6XGf/MnskVorbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038734; c=relaxed/simple;
	bh=Jd/NGAcLyQ307ICe0rqEBjIewVssUN93r0nQPvKEiQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V35R2YW95gtMze2DSel4qS5oEz/xwr18YbudZygGsIaATixKBQ4K1ttVTc17i0uLnyskr0JWCdtZBOUkfNjWSgFivJ96b5NKk0KFkppiWPGBNVZ1Kwlqm/C835XF6XULCW/Xjp0fgcGZN7yqrHkjNy1qNYbmhN9nMRMakKYQO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsPvYqjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsPvYqjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A41F000FF;
	Thu, 10 Sep 2026 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038733;
	bh=Jd/NGAcLyQ307ICe0rqEBjIewVssUN93r0nQPvKEiQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CsPvYqjnvfujJz58ag+U7r3JCV9d9QUZYsRtDMjvzd2Iv/WI4GWrf4vFMkdt+PPds
	 PahUDXJiPApA6e1t75w49B/nau43w651h1p59/XruUIpdaCKU2chL9cdlE/E+ZMLf2
	 TzfXKd7u3mb2PCGkuCGlkLxLnMSu/FYuPeC5j5Yikfd+nfAlb6LLX0JCw2vG+qwIwV
	 zqI2e3JTBC9fsszCJyfxDogdnVvjatmmR4c0MQGNmrkGtxunWuUXGYLLtLHKoEwYH/
	 0F0M1xYF+H9PMZ7yk8p0vs3qR2uLbBZbR4AzhxfXO7PVUquCkQ82gPAhlpiQHWF4MS
	 MgWiwE0BbjhMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] s390/chsc: Use kzalloc() for the SEI work area
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-2-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-2-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:12:12 +0000
Message-Id: <20260910111212.DF7A41F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D2

