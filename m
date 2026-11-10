Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302669;
	b=q2b3+P6lrjSDj1evrkj/K82RUBA1jWMX6kZQoMlZDTKofLYkFe8oCdr2btbtqICTNgtV
	 yhoGvOECuYU9fA+zVMMxP2sdcvuXMWfQfbGAoKctZcMh4fJipL6lDWDDmzv+3EJfeN0P5
	 //8niD7ofXRQS5Rm2bfm6jXamVfPL9eWicrRtl2DnRDJmxC8ZMkQIoh1ouYlA3AA7WTd1
	 wACXSDx32zSdRySqkPcv8VE/jxhSrT3h8XFDrS5UeYrZlQ0w3MfxHv0Wkt3DmGefL6+qA
	 ZWMvRVoa9Cqq2ojz+OfoTNIFX10Nzqqx7M+ak5Gge87TVGK2A7zJuhUjtwYzTbgZ1Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302669;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DGhMrR/FIFkYGyN1WEXpAsLpcElTt82WK2/eRj1wykA=;
	b=gR58iEXf87v6Ije6MoyDXXHR4fCN10pP2pKXVierG5OIQAaTujbCWe/N6JM9IDg4oRXX
	 8E6bf4jUTMqNofudNs/PslTbDGrFzGWpzlYpyA8T11BwCUNTekt1saqfK1yBDbmTFQlLt
	 WPavp5SZ2kBGsiNWLvK4kEcBz2szL9UI83RltazUXWw+SsnACCEWXuMxQpjp5PtlKKAan
	 Ax1fV6FHjf5hTfAlT7UEaNa445C80wu3RPO0yNbUABh+RC/tRt+lCGq3rXctwAEzjcRyd
	 YfDF2BVDhkcn8oU6mbBEGs0x2JJRvjTdlhZepyJO7UijAAMHzpkWXhP3prPsa4CRnhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3iIqR8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF01606A931;
	Tue, 10 Nov 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3iIqR8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FE51F008A4;
	Tue, 10 Nov 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302669;
	bh=DGhMrR/FIFkYGyN1WEXpAsLpcElTt82WK2/eRj1wykA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3iIqR8sQs9cBe9flMY4iztLcyCZeyVT4VGACugHQM/OFh0nPCLUphfbfvDRWYZeU
	 s7sHjGHnRkgMi9WwtKaEq4qXcKidaWf8+ud0F4VrY3fXKJj/V+a0G/+x7qN94fjF2a
	 6jZrtNARabY6MW23N+yOg/TS1QzOqmZay+qPJvk88SWWbmqtR4w+rkpctG2hLWcvEz
	 eh7OOfb4003pFl4GtQ9O9L1nnY058V3gGjWDEO2VI5mC/FoRVs7PDW2S3suBECGWOI
	 bh84pDclmdTUYdl4F2gvUJiyoVg1j+/LDzYaSe/eewm+9DNd1jJWTIizR1X+k1fU29
	 2MVs0fdqv1GlQ==
Message-ID: <sashiko-outbox-206730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D15

