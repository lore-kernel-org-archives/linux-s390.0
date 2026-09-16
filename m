Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE624B04B1
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561383; cv=none; b=PQ7V6QwLln4MgyGq9BMvNnTxQvK/ck7A/pGumTIWON1grVye+znYhJ+xcNsu33+0pjrCJKDX1ku3FbjhZe5pSMmL6pKaNuu9+qEm8SStKtcQPfCRfOsYZr+MW7NQoN3IHSv6UbcMGWXmQ+OJ0PFhN2LgWyq5XiJ2sqekrtfm6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561383; c=relaxed/simple;
	bh=wFA3F/oocLEtTLSepPFcPAzcWrLzxaC2SOieQ9WY460=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h+rAtDjqw2URdbdS0i8sTI9pfCnaqzqAWpkM8LHSFoQir9JmUbpKVeyFP+VX1PG7VmBKGnG/+DKa6tMhYcRx56vAcCQL2nucoCfSAibTYRvBMz0+UAVzKfSdZKnm8QoOQu7csm1euFq5TGqipFA/rpS1l1P5o4Tpn4OjMH/hAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqIUFVHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqIUFVHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8051F000FF;
	Wed, 16 Sep 2026 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561382;
	bh=wFA3F/oocLEtTLSepPFcPAzcWrLzxaC2SOieQ9WY460=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JqIUFVHC1mvdEw2/FXZ4BEdHISVTRuAJP6crnwaifIfJoeXz2xPWFuL1BIe8AKa5r
	 LKj6+5B/sTOnNZA8068hj/Deus74wtYFZa9LEG4IV9ld4DX6E9RAs79euCauHEmwaC
	 +8gJm8Ag6sNYbrgWztZ2d+xxcU4Vi+Q9IzoRAnJpILzqBdzPcjtNEnScY6zq2K9UpS
	 d2BDBsFc8TBHar3nhn7vCOKToJnpgln+/QN2Z5k0j4AC2j/eJKZS+lTPCIffVLfeqn
	 ZekKzGY0SV5dRyKzJSWRedv6SnLBhzzM+mjCQzmgh25sHvXhUMeJ8DORLVHkN+reqi
	 e8BmFCTUzn3yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] s390/qdio_setup: Use kmalloc() for the storage
 list
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-11-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-11-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:23:01 +0000
Message-Id: <20260916122301.CC8051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __qdio_allocate_qs() allocates the storage list information block of a
> queue.
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
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D11

