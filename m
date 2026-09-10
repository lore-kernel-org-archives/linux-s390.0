Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28646C835
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038697; cv=none; b=XR39W240qjfF8mqIbawGt8UAHtjxlMPtWM00GdoWoIZemYbwWHcD6dAw3Dc2Wgr2AV4jF6Lb+S8USqt0QuoA7heX0yowv98d8WIbBAx5cSGrxJfuH1Lc6YWtHJ/DFn/CIMbfAXOrxd9x1mPgez/aWL0BZPjj0BR1C2RU7oGxuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038697; c=relaxed/simple;
	bh=dCRMFGyfE/+w0RTmb45r5iExb/Xb7lxw3+xS7hiPfmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYRNkDiRPpwVhx855oMas2Q+ngmEUPDJHh7WmRSWERqKAZiIx2ANaQLo+G74NOcqnkBN/hadpGroWf5u7zVEoPEvgV9ETvkaHCiguvXjwpru6yBVjEXceXH/ooRCWjRCkl1qVxEjqkiUZKOpFmMZ4RIxdCrSQeCJPjB2FhLd8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIR3VQs9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIR3VQs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38951F000FF;
	Thu, 10 Sep 2026 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038696;
	bh=dCRMFGyfE/+w0RTmb45r5iExb/Xb7lxw3+xS7hiPfmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIR3VQs9u4JTElI5vi9yR9uzIImJdIX+LByCx9DbDg9sKKG0Rm/68zthPfUEE3BK+
	 OdLPBQa1RS5tCeTbm6GINMgz47rugnMYs4v2C5l3hRWDauDAWMF3KppuZbOGxR2Dw6
	 LM8uLC3/s0S6zqegoMHeceZiUMrySak04CnTep3iYQrvp4FGtnWe4eRmGWHpSJ0FWC
	 OiGcL8D03EEiJhZMcnQe/vsP4v8T2CKZL+ivJi/204k9CLiRtnbLpFTu8CSArLMiSh
	 ddnfLkMdvTzHpOpdchyPr+CRLfXtYj4VLMiANhsXx1O4MqeqNHTJiukiV1YQPzwWwT
	 t5KFe5Piza/3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] s390/qdio_main: Use kzalloc() for the QDR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-9-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-9-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:11:35 +0000
Message-Id: <20260910111135.F38951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> qdio_allocate() allocates the queue description record (QDR).
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
eady-v2-0-e931086fdde1@kernel.org?part=3D9

