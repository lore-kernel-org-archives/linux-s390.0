Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483198;
	b=eeOtO4xhjeOuhB/2dXu8oXA0H+qz7hGgb532QLhJOcB0sQqDOmDNomj9eCp6hCPiAyT+
	 8x2GMBXhoJ08ZCfLMAItUSwebCMNvq4MhqzSBhOU8p2UVuTVhybyq7IpH6Pvpl/9iP4dQ
	 s608gHJvJUw4WuT2QMIR/nV0nkZEHVM/9KE51hdi7imL0cBjbqoULUi3AFBGxKeOKY2r8
	 n8R0BiJd7On86iI3WRqTvBHf2LYwVHG0R9w2QlsFFHuGxRI6/h2PHZ6bcdnGkREtwPyQO
	 afmR4kDQ9CL8+x5jJJ0MZmBcBK05VMyr0kCF/KH6SH/2vw/CtL9t+6n7vPtjrsB8LmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fkFNkK9waQrr04LqwebhOzpt6VfUKvnie5m0HgQWrUo=;
	b=L7BLIEDWirbQrMHDbKooMX00K/e3Ljbjm1MWsw//pKQZRcHS5OAHM/Pk17FpWryyyXiz
	 yt7h9fMugW8XTCTnuk35ilS070LC9ebnKO5bct25CyKWJzLq+euogL+fgXkMYvPftGEBB
	 ydWxa27bQurgGumLeseyaY932ulAOKcM3mwxbr0W7hnYl9rEtI7sqqqJ+UKI0za9+3o5z
	 QbFYudSjLP9kUlc3gD5aQ0i8hH0BNDU5Yhpk+9PcyzvrfGewOY8znTAFP2zoQL4YndseC
	 wl/kUwViTNkZf3FcFq1/QW3r1OgZcVB8W/eE0EGvTViEhjvYta7KPmFmdiPS05OgGFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onDgyYuJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00719606A323
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onDgyYuJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8511F00A05;
	Thu, 12 Nov 2026 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483197;
	bh=fkFNkK9waQrr04LqwebhOzpt6VfUKvnie5m0HgQWrUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onDgyYuJKgV44zugwU9gGwPzSAFyEAxTs/scsFiB0tU8kRJbXb2A3jG8IdykKNp2a
	 6zPxM0dPoTwCGGvxOZ6L/z3kL0BzkcEyREoh7k3n+otLvhLnxWcy6EDRvxrYzKOnei
	 pbfH2+bz6mqvNyuTwv+igEJfT1jrvHfD5cyQWfg/qIhCrgVTz11baOAxOQ/ZCsKFlI
	 v2CQGk+TuMgbV7PIVpo402NA6MWbw1y3+vG3NorVAg/o7Jz34JKpBJLofuMbBxMhbS
	 0jT1Es9hS8e2HE1WKQM/cfcJBAJtXrHgc4bBX0hlzElDzSAEuV3P1UHNzc+r7BUIlu
	 W5xAOXdZJoAJw==
Message-ID: <sashiko-outbox-211025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] s390/boot: Allow additional usable memory ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-5-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-5-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:33:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> All online memory above the usable limit is left unused. A kdump kernel
> will need a few ranges above that limit for the crashkernel CMA memory
> of the crashed kernel.
>=20
> Add physmem_add_usable_range() to register usable memory ranges. Clip
> them to ident_map_size and merge overlapping or adjacent ranges.
> for_each_physmem_usable_range() walks their intersection with the
> online memory ranges.
>=20
> Use the same ranges for boot allocations, identity mappings, KASAN
> shadow and memblock. Keep the allocation position separate from the
> usable ranges.
>=20
> When no extra ranges are added, nothing changes.
>=20
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D4

