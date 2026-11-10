Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302796;
	b=4BJJ5SVkIZc4klmv4+SWpo/dn9sT4IehdqhaupVU8VZQW0jFEJQNf+IGC4WABxVgNNi5
	 js4QlEm+xdyVbpynvBCxJPFiviMTogqmjMHDLsMynFZo5/ENr0SOgUIus/ltxrbFYR/Fd
	 62RqzpkbQLTOcg1IXttg1qgKdwurjck/i4R9nfZT5+BATYE3Ixnwuk4zHeQXHpmVN2MkM
	 izjRuNvcwqQn1jRuKF9sHOF1ZIvBkaROfl28feBMhqMMd1uXUqV8LUqdC3EfcnOFwAEKC
	 YsA3bnp5E506uTA0SvEq11jMW7gfn/H1/KomOQjO6DA6AEUfJYEkTf8cdiZX9oI3TZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302796;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5R8J1HoaHNx1BOh4lYxf/jvENSGMlUsUWA1d9L8Giww=;
	b=fRD/Xer4BG9MehMkDnWWTZQ3odDapoJrIVyZaKxmYy0QtMVRfoEIzW/z4WXCNsG8H0Gu
	 jRybpuMsK6yaLMDwoqe9du9a2GM1ts1goPUYTRGnCwQ3X1ZomN4aabxkcEoH89oERS2VM
	 UoaEPNZSDG8KYYGqN88YEnC/yBYN8/00jSNjxuJEkeKjg/AtJgqT6MWo907AuWwYiI0CN
	 TmeBd7I/Ye5zVgB4Z0dku4dEasITx9ngMvn7tkvYGVxW/jOX6U7eBj/eqNMYYSDi/sOK/
	 hlUgaXSVYLmXhyn6god77/O+VLduh0cq0B2wCTSOCp16TOUOLdvZURiR6T6sEPMM6pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH+AJrrC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5E606B14C;
	Tue, 10 Nov 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH+AJrrC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC9C1F008A3;
	Tue, 10 Nov 2026 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302795;
	bh=5R8J1HoaHNx1BOh4lYxf/jvENSGMlUsUWA1d9L8Giww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eH+AJrrC1RT0SQ6sjufFuxYRlgRjXSLEvyrvZ4k21/F+mZBB/1+AsSpvNpTRzpVAz
	 2b8A3yJ2/VEhn2YMY3SduGZ3Bg/t5QkFM2wIhz7/g4U8y4rWtkvrZJ5aGUhuwpxGWC
	 qI1mSK4GlRWqQR+FlWM5OUFNEmbHQhihVu4x3XNzC4JEOFm7TGk3io766MRJwbuao1
	 VvwzS93L4qs5lXIXpRdxrX+PCbddTdcDhUMZyOk4jbvaDmLf5lEXMT5+k9AX0Nk34n
	 o/dTKuzdGSCC4XdAcKZIcLFxVI/+D36sneo57qo0jpjBXschZ/UmlfX3NeNEM1nVJy
	 gEH8CBL/YHr0Q==
Message-ID: <sashiko-outbox-206750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 27/41] openpromfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-27-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-27-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D27

