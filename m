Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215126;
	b=r7UB7NWcmUD/4wYgZvFOMXG2iIxJTH9ADxEgRJFjB/FM+EYo2zYD4Evfu8f3CAyP6KzS
	 pTxK83LfS/2r1RGQg3liDP6gH5mBmx5vunDi7cKga79JcwM3Ri+PqB9hDJgKjwR+jh0ni
	 4w8MiccBLkdJLrRRhn/nwJat5y3DaIPpi8tCjimoYswdAIVNlQPlPEegdvaU48uK9A+Jo
	 /fUYE+FM0OYku6wcT5MbQ7dgtCitVImOK9erU3t6K1G8ww0rVZ3pfSINptMd98iYY0tDk
	 gSODgFSJFHkVGoNPRb8SPGk3UZA7qzTeqIdOmTzUBUCcuGvHaGeHUBDbC784irKVkQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ddwtRStrJOI7ltMx3bJ8U+RW9zhPc6/v8M8LvxaWFCY=;
	b=uWWVVfC9HjY/foKHv8n0mTtV6j+tPEfncmHN0m85yItlnEptutE1ahbo1rtjm9hNgLcj
	 7kd2jj4z1p7zMiYETQepfGGeii72byspeRHn68rFc81gupq/V9cU01H3eU66FEHeIb9Eb
	 hrEO09CzVmqeK2v/hEEIs+wrHpSmnpKONAu/S5L5y6fP1AYddgO7aJ4WfPvIfCT15jsU7
	 jBuBHt6/kM+gizoRX8uKOBOQeGi32L3vG4XOvGoxvcComou15oqv5iS3+0j8sCTTspNuK
	 1DA1yZUHFtIorgBP0R7jsFavdG0sU8o0PuMTr3R02H9uTzks8j/app+6enC1odsaCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjTab6cu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6B606A339
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjTab6cu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35A31F008A6;
	Mon,  9 Nov 2026 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215126;
	bh=ddwtRStrJOI7ltMx3bJ8U+RW9zhPc6/v8M8LvxaWFCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjTab6cu9O371OdjhvlODWLKQ9JBhDEenwq3Ewjuc7UJ9Owcb0lTB/FFCzuWDB1I4
	 etuOym7wETkK8Dc5wbhoDHQFIisbdje7LrDwsuZuA9ou8SpTBzXGSYNI/Ne31vZiwx
	 WZInLsnAU9H6iSEoohQPBDBQ5iSel1mrxaL3kn0o6kktG56EOVO3ku0BTFSQhOTzvT
	 lhfDul1k60t0a0rhWlY1EdFPS/mKWgcTuxC+tJux7NgSAp0WzOPDcAbnYqJn603qj9
	 ke2eaD7LB8AhpRHa6lznKDvHxuoEReJ8C1jCfD1g8GTSZP2H2KYb4JAY4zswOqnVQv
	 EBa4tqRbYYLaA==
Message-ID: <sashiko-outbox-204662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> _sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
> allocate the SCCBs used to read the CPU information, to configure a
> channel path and to read the channel path information.
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
> While on it, allocate only the amount of memory the SCCB actually
> requires in _sclp_get_core_info() rather than rounding it up to the next
> power of two. An SCCB must be page aligned and kmalloc() guarantees that
> the alignment of an allocation is at least its largest power of two
> divisor, so the extended SCCB is still page aligned.
>=20
> Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
> and free_page[s]() with kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D10

