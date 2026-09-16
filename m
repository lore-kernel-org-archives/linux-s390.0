Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3B43F08F
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561317; cv=none; b=OuyEO3yjCohg5OoTqBhoL6wLFIqYxYvDrNYebWrhIDuZYCxFwJ0CMGwF8s5QWkSMLS+Tn/9Sa8yZLmn+kk0RfsW+fvRMxrQxujX/Hxhws4tla0hzZzJxJWrxQA8vr5OtI+d3qQqsKF+cOITrzpIk8KbI6s8xSsgoSdEOkPHgp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561317; c=relaxed/simple;
	bh=taIeKgg40lmuiretMb8Hn2mLbFsqEKQJK01MBmCQ/mM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TPOkwhohiPTeqjhJtcPt1Kr4aRCenAcOxkplR9RSydhqrtbM/2yO0JIE0Cb1+6vLY621s+FB+WhpN0kcfKWSP3W3kGMIkL6zpd6sUf9RLkK1yBrfXvcOh/tqCTZZllluwBHSTXzrS4Cc8E3aJwErOVM3bfPbWdHZRmwVohcPurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYuyNOV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYuyNOV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89AA1F000FF;
	Wed, 16 Sep 2026 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561316;
	bh=taIeKgg40lmuiretMb8Hn2mLbFsqEKQJK01MBmCQ/mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jYuyNOV1FtzMsyc7A6QG7Yvui/T6ZOX4rdB3V4N/34jigauluza2sgvExYsmqqlDY
	 R4JaSc0ual/P0O2faSgBfCsK4AfMP5ErD8+fgNMZlwGeb87523DdG6ysYePV/BWs1I
	 dmISde7Tb2/I82+mrsp5tsU03uJJiBDKNPY6+x8PPGGk7CxWh6hiNPQ1KnCcON+NRP
	 Ct3AdHeO2TkSSTYiIGvJae9374vWIXG44MbaDmeCJ+bVZrS6HXTQCxtfKdpEssWidG
	 2YzRD6X5soSR75BVMEmRzFIHEvhAN6G3W/tCCwKJp6+RyYTS/1QHaK1JM4oOnKvs71
	 1jKBybhqTIvMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] s390/qdio_setup: Use kzalloc() for QDIO
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-10-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-10-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:21:55 +0000
Message-Id: <20260916122155.D89AA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> qdio_alloc_buffers() allocates the QDIO buffers.
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
eady-v3-0-39e4894637d6@kernel.org?part=3D10

