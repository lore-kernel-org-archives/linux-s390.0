Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215125;
	b=3kCRYOgjj36Gic5T3PLkbgFJ9CUTN/wTnqnDFNLZOKE58px3lyKZ3OvRvFtYVp68RYg0
	 ru2ZY+8xFfkOGojsZlhxRk+MgE2Yrc872e55tX4PLMtUxoTWF/vGs7SRBnklXb6QN7I8e
	 OAN0Q6pP3UdkP1F2POLsg46rTTlQ+uXZPY3cwtOFVsx/tEHYRj0/4lqwE2ELDXO6ljJIW
	 BcCnIMZbb1L0joNBFD/oCmpM2jPUBilx+Mj8KcjfojOpF3gBZXjihqFZddK34eF63361g
	 he//9RH3htnwHOLy/RVzSwyBcAUlyg+Un4I9OVIIj47tTSlixKjpov4P5zewyvCZmwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6j0n3df2+z1F4vxOFUts8V3AIqPydv7xg2O2rkCo9wU=;
	b=Y2AIxJ9J5elPt9aesT5tQiCbTH/nSUOlRIr+c3EZwHKUFm8Ibb7TbovE/+gSXYQcTK63
	 XmuStvfV/nBc4zp363Ut731VUhSqiNOU39l39GaEtU7CziQ7ICZYBUqfoecTAhF4t0dJJ
	 j4695f+focOu+XYNLznlIjCENQk9r4pnyQwFCH9SqKbvsEWzUiPx4SgHCE/RxYOM2SvZE
	 ugyd2zuJb8fJNRIjeD72tYSLQP56TEhiXRKWSmj0249KHNLa8D2oVrmXnjuaN7/Z9vTw4
	 hkWk666yF/VQKmcorq6XTU7IZ8zaQXj1zNq143kVVBXv9NL5G2I0rDnxVTRXpzCLonw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOa5CkPg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E9606A334
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOa5CkPg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1FA1F0089F;
	Mon,  9 Nov 2026 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215124;
	bh=6j0n3df2+z1F4vxOFUts8V3AIqPydv7xg2O2rkCo9wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oOa5CkPgN/eHrxI1d3P0sLbYDjIZYVnHPl6LA60jyv47ZQSKW/WPKvMz6jmYJbre5
	 vmoi8qLstcX/El3gKRmVn/m5MaoCWjrUa5lUFGmBONHuitoMZzA8zm3UsNs7xkhMhv
	 GdjLiSennq/Jjpekapy0c0pDQ4OhOkO8+9bmdmf7gX2VeAHr/PvvH049pD22BBWPl0
	 eYFynPdSe1fFEenn+7hNy8ixRKqMH8RmIk08703P76GA8SRudjW6/Hf6Wz8RV5weJI
	 AiZaTgBbzkVyOPv+icxBeHrE6hKbi/3LP4VcB1oKqpsdMMn7kqyd6K03sVWlyIbIDJ
	 X8tHscFtohkxQ==
Message-ID: <sashiko-outbox-204660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/14] s390/sclp_sdias: Replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-8-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-8-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_sdias_init() allocates the SCCB used for the SCLP store dump
> information requests.
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
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D8

