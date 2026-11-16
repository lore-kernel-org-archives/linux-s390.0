Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827724;
	b=0xbwqvU3bpCbDoo9/OMSZVjA4+8bzUhaSEBV/8o74Vr0u8y2rr4fZ0RZ4kFrTKNZrYU0
	 wyeofVsDG+BbrjMLPew95/7js3TifXJ6N64i3kqjdgYfOR7MQ0FjnI4Vi/yC8YZS/SMKQ
	 iFvcJHsv6cPcfLCsue3eKvNYjh8GEEXSgVk5tWMfLIHoweguQ1O8klqBa82PmR1DeJwWg
	 3D/KEkpIAGIJgWFr2Lv5Dibzh8dWwslg83fXmpPQVuYx9SDpY4du+YVOlol4/JsIdVxRX
	 e0QyaqkBGJ3RjarkhZh5QTJhLue8Ag14fpQazdFX4iBAg8er+HenX7DBibE8WGdqhGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y692GUTll3ip3M1Uq7RbigHzpwPDLeAep7pfgPp7e+I=;
	b=0XhCOKcTRKjM8k7lcAWojfwED53PldzVsy9zIXJmFJOePUAr6oTYYCuII9wy9wtQdQup
	 FXlENEc6DcrGIU7jOBX6PzXm1K5ZYWHRvV3Gv9EDkI8IYyEKfOgsN84foB9cMDyDrJlw6
	 IS3WR1NKDTkDcScpv9L12tgBtAp85zNjeEg7B5bnkSv85wx5bVgpCNxNk9UubLvW6y95f
	 2S4Ce2342781pSyhF6bcrwUNUwhszTxPY0dWLebnzvy+37vel+RMjsFz7eKRuiShVXJnp
	 MBzgQ951uE35eg8K/gH2397AyS7dXingV0UvY5LGsdL6nfImW8wn55pcPq00lxOQAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViXxuT8C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E3606BE18;
	Mon, 16 Nov 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViXxuT8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A631F000C4;
	Mon, 16 Nov 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827724;
	bh=y692GUTll3ip3M1Uq7RbigHzpwPDLeAep7pfgPp7e+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ViXxuT8CBSakVY3H2PZyLNkDcXGl3sj9sc8+ulU2AE42qWpsSLA9lVGtOLF5HlIr0
	 sZIHIumaAX8ScEKSRLI3NVrPwYZ4kFpYCrlxhUsLLCqKgvidcAOup0O/CqbLn9ku1x
	 hZiOIoWdLFoDpCTYy9ub2ic6G/9fFReNOXIT5+XfT7N5QzJjAkV2hu1itPbe7XrJGW
	 dmlzhMExcdm0L88AATx2ypzlUl/Kknj7NXa2RSV5W6teU4IlUt4ce3AKAPtIZiAIUd
	 pmcPldfBlcRlJ/aHP55PWcdj7H1DJIPaWoTfrZ9t0Xfzft3/qRET0+Gz19ZqW3Tf1n
	 4DQ6CqQW+2XjQ==
Message-ID: <sashiko-outbox-216866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:15:23 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The file backend calls ->read_iter() and ->write_iter() of the backing
> file directly but never checks that they exist. Everything that isn't a
> block device ends up in the file backend. So a namespace pointing to a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such files.
>=20
> Refuse them when the namespace is enabled the same way zloop does since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D2

