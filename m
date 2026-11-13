Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579954;
	b=S8hL7WFUY2z4yAf3UGjvvHcr5IPR+R9xdOyOOhUkfAFCtRxMdImJDodF6wLlhDjv56Eo
	 jlkwMHtJha4wB+2m5j/iS+l80Sw5YK4OpBACcoMS26pTF7Nxvw3MpGQV1E/NHOGqVZG37
	 EdtN4At+QKrTdLwZXn4A/Q+TF2CZqH2M2nAXr9b11UgnUfdmQ40aC9HgLdyjPCHquH1VD
	 qvXMK0nik6n6+2tcV1H341DP4/4GuHJ2F2AJSnLlZYvW+G+umDIwRyIyrat3lyWDnrD9P
	 JIATHTRbOIL4TI2AMAdqLES5/YKQc5li3ay1ZaDsCEMqqTDAr3Jww+a5Cxg+lzp4XlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T36owPoCziDAk5Vyw/uyu4tP5OlXDkAufNJdCmV8yyE=;
	b=VwSaWQR5moCy6eo6oaXYZxaH53PNPgNBS9+lppem6vdEHWIL7tbYDr2L3L0uxBsGosC0
	 2WqTgk/Rbbw7HUGlScNS4l5F52GiUbGZXC81NI7PRrJ2g4Ekv1u4GHeSYyYVVKoYNOET+
	 qbyfzlIx/8c1w5faC34rAAvXjTe1Ib1MxtUBWE0uEeqWZ7OuuQjMTYPeZz6Vputq04R09
	 XEQNw4XEEMQypfupDuQC3N1QLBqaC6kTXWTQqXap3BFo6uoV8WbDR7K82RQaf/ivypwoG
	 Sl+28kJ4KBG3OejRE4l6Ek2gCynUlzoQNgMDZFR36LsQScXUxhEE5pKswSU3IU8+zkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEJswn8w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A49606A327
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEJswn8w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446991F000C4;
	Fri, 13 Nov 2026 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579954;
	bh=T36owPoCziDAk5Vyw/uyu4tP5OlXDkAufNJdCmV8yyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gEJswn8w1yXPiaf4IxobmfoXqWF1NNH5WCIiGm+6Rz43hl9ar6jVznhQD0ftbenB5
	 xh52bNNYkDoFKFd5zlnRsyk/7qwhrWuodQl9X2F/P16bEyuwtSr7pyk0oApe2H01fu
	 9Vn1VsJBM+dHpts/4c4fHxHEfEq3JKFXh+p/UW9bZ9t8b2oNjI1JoCZuUUVfFHEcob
	 sS00cpIYwOOfHYJhQrusyCExtzYcOYiUdW0ywUin5wouiNFCziEWG0bDapkHWMqBPU
	 0Wd/MlTYyVWLRCaBmK4gzhewTI/Pq9AstNqmmX243Gowq/Bqp4jT3DmrVljxsi2stZ
	 p06aLj3ofYxjw==
Message-ID: <sashiko-outbox-212977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] riscv: mm: add pud_soft_dirty()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112142039.907090-4-clopez@suse.de>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-4-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:25:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> riscv supports soft-dirty and PUD-sized transparent huge pages, but only
> provides pmd_soft_dirty() and not pud_soft_dirty(). Add it, so generic
> code can check the soft-dirty bit of a huge PUD.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112142039.9070=
90-2-clopez@suse.de?part=3D2

