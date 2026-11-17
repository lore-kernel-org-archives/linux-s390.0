Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924771;
	b=BoN4NeL3IHGE61IMzwyFJUEK0IYEoCXxUei9qu/b1kFljfAhqMbiKVyO5M2CJh7xSwmX
	 Mmn71amlcLBv+MNXgxaJsdhUQnpMTHu8Ay2ubcCZ3rfmgL1jGkdAcNlV444LwtGMi7ZP5
	 NUNdeU/X/3pKywBlsMznfkvuB0e/e2FKMslj3P+qs0Pqad7AQsFTldG1T5p2TvEmZ9IW8
	 0H99R7LJCtfdlZbSnO9tntKZ5l+9GJh1W6RbGCXVOy8xKry7wM7VwU1qnNn0c04unuLzc
	 AoEsPKKQDaSychEUfrya/H3RSsmSRiX8yF14wFjosrimQmnSEQWUiX818n1jELgoiEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Jx7RV7wC5qowynCmp1l2fkHe9PhmrZ2YRVn42J+opbM=;
	b=kAgGK/je5NHHcBuwRiL+wrte5xDFQfRlBAt5nWrYXthl2pxCrSsd2XATAnFy3l1pNM9A
	 gpEiIvtESrWiHKl4tY3t9WKGHdvAOfdXXIsMpbqmbCy0kOpacKRWNFFqvBZHxTmwWewhl
	 n/yrEZC1RevF09oaOqamnOmJKH2lxsPQfqa5FNnUatPs0a3yN+ebtQp0BENsqLgKW6U8k
	 BV8mpZ8DMjF+mbopUVSiqFVauC0Tlfszb9wsy/5ZqP8t0PBmqURH8p6eN4pwLSlUKwfnI
	 27OqIfMAyMs8zhsBKdVi0mkQg+sTjWKqgpWfK/cGmjdNGYBdvoiObSb2vDawxfJXjVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ai92cY8C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E14606A88F
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ai92cY8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316AB1F000C4;
	Tue, 17 Nov 2026 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924771;
	bh=Jx7RV7wC5qowynCmp1l2fkHe9PhmrZ2YRVn42J+opbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ai92cY8CNhwzw/dTbCgxEDSf/35F3Zo16EIdLULm8a86CqoqB9+//YZI2VGjuK2H9
	 rvLTb9phWy/ikpNzd+xcBXaiGcaivFtvvU+mnZzKWq9Yhf+fUm800r7Smtl4lliJGx
	 YFqTpsJojFttKXv5AccYwHJLiVGiSICm15UI4O2qWRHPH7VwSY1hjP52RnJVKaF8JM
	 9ELtcedy2xuctde5Ptr79F2I0+REMwFa0VH46xKPF2PHpXituIYB5OScmK+3WIGPR8
	 gYcZksQm7pO7Q3W1dfPulqzQb+PFcjedig93Lwr8OItjnvAqJ/qeYplK1lfHrO2or9
	 fbnM6SvJdGJ7g==
Message-ID: <sashiko-outbox-218936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] s390/sclp_config: Replace get_zeroed_page()
 with kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-2-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-2-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_ofb_send_req() allocates the SCCB used to send an
> "Open For Business" event notification to the SCLP.
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
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D2

