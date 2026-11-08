Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178255;
	b=ZbQck3IMdMIn4TS7EL8V2saiuXcP82N7QJakOXkt5Pf1UrlEoYSI/aXIqmMvK/Z7m0GY
	 7h6M+rv0VLFaz17OuWYPKKO1I8xEvuopL0LC2Zxc+69phjT+DkwA0xwEeJxTMFGI6qOEo
	 LdEtv02U3NhU4YyUOc/YFUJa87Q5/iFdCQ7AyHirOraDkwaNJ1CTzGyCzj3sRPJ8kb7FK
	 1AmNgeLIadtg98BHPMwo4yASFP7IfzKAD4uHHkc51Al3PVXUo6ktYedWdc7KHN+K+vmFD
	 ryOpsV8ra98GXdmquY90ko3CTpiqgNxn3VKNNN2/oTogtQOeMcNgUydsD0APYrYxhLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p+b0XJh6ehm6eS2n9kcRO8iB0CPwL++ldMcqb+DQ7B4=;
	b=CJ8pPKAJhJWUo7y1if66StIjOgfkWvREHiRR3SAzBf3gZ5xsjHyfu5H7Qe72Wz+ZhVy4
	 /BH9E0/r9XvWIWKk8RTnCemMUWryr4B8LfPffTLI/+4UjUO1xcEAlDh20nsOkjh95Tb+G
	 P/9frpymEdfGG+5pQ1w3mzEIEGtjbrjC1uEKnvYk2Oz7gzAPuy6zXKe4dd+8FsOb8jgD4
	 PuusS0jI46bMsUuszMd7HFFcq++1YZEh8IVa7BkS5FIVYj0FDTSDRUaEjeGr9S9rpFuQH
	 AwWf/yQ+GZbxbvz3DBdxqe/MDbtNS0odxB5jHP18A3u+tNvcpRiyB1qLPiRsNCDxjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=noEBraQX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF2606A31C
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=noEBraQX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B2F1F0089F;
	Sun,  8 Nov 2026 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178254;
	bh=p+b0XJh6ehm6eS2n9kcRO8iB0CPwL++ldMcqb+DQ7B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noEBraQXhzNylCd/djAZmLSK+r7jL3kV2oKgU4lfeAosHlGmkigOwwAZLkDGOfKdZ
	 89cFWbo8D2gVoxr002l0jRWmbHhEVQdKx8A7++EW1qqpQJ+2PbQK+rpnaJmDjRN7Mp
	 ELYOdvSakipr5cQIqW9tTuk+zixcg0K1seaN3oebGC9YtJ1Pf5SOTghT11grDaBdqS
	 EhKSIhoqkU3mZOrprulROz5UkHsgEl3FYMhd7GdfeROYVQ/jBUpeGmXPJf3xvUtyg3
	 9cd5c2L2HxerOQR12cwRjy+MhVRzYP3EXKXZEEOc3XMCYKEy1W3GoRfZx9hjtlCqq8
	 QkJL33jvJgAKA==
Message-ID: <sashiko-outbox-204136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-3-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 22:50:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In add_var(), a struct kobject is dynamically allocated with
> kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
> sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
> However, secvar_ktype does not define a .release callback, which results
> in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).
>=20
> Provide a secvar_release() callback that calls kfree(kobj).
>=20
> Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via s=
ysfs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D2

