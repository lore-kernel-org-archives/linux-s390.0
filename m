Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178501;
	b=Io5S1/7HC/+Z501ZefOKs9/2UL4CapdX+Y4J0XmH7tcGNOOo4wNqdirniKY7DzIcXQYR
	 6k61qOKe2XyerTv0jBQ7CZXpJnDguCHRQj7JiGf0z2kc2TZxsF2PlHJoCIp8rtwIJFNYp
	 WrfLstzkLIHMvagVTvnS2RcBSxVSEKkS91Iml8/7ewlUA+nBC7ctfjQveTadcIJs/B3Kg
	 6r/VnelSPOUjyoE2RmNfLhRKNGpB3tsHwZlmlxKDTIkNOdhGQJL+eDpcHT5oGLbPRIQYw
	 BZ+NdGzJNGZNqbeHUtfs3BTnC7SbzJPbKZfH/g1QC7kXlGjN58LF8YenTgDC+iP5Wmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178501;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W+C25VMNbvHb0Go1cIuAIal7A8mg2qLWfJhZwqg1I8I=;
	b=kRey8lSgRvuc/YFv+yStm9sYLOIY1ApkmvUyV68MUalcZI1vVxJBn5fG9kRIs6HNLrSM
	 BWcA4N2gl+ckZJqhQHPsRDPtSR+BIXwozdmgced05X5mCsMxfidphvG3mNh2OD6iIE0wM
	 aLo0D048NTiLQC2VxnrowU49/c6v5hYwkL46spit8PiU/GtvzwvQIb0Ejpkz9m63jy+Ps
	 cKBRzNn+7oMmFHsNtNQUMSZZ/WUUKBBJ0K5QrgxqAd3xoM1bxHuGXK3oMk67T/M9pEyXW
	 b7xtdXs1OZGQV3FqzmLF2tHUPYDmeEHq50kNQXUlQvptnbPMoTDpQO6tqDhIKkmIqYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7yY3esT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CEA606A31C
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7yY3esT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CE81F0089F;
	Sun,  8 Nov 2026 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178501;
	bh=W+C25VMNbvHb0Go1cIuAIal7A8mg2qLWfJhZwqg1I8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7yY3esTADKwFvRNaa85/Pgo7MxCEgxZrSuaKi85ct1a+Q0whlm5RknFkou3bQyvB
	 kIHqyq8Y3d7UdrJ0icD7joJp8KM3AFzQxjm44p2LkxcR2DgTzp9aZvGUFtnGIJR/Wj
	 HGThGEV0AMewyAJ/dFaEHqGlySrhRJHs56NGWYYMxDqIfbExdr6Y7hHiAWSovArG3M
	 t8MYHKF75aE6SyMH5nOCcY/U9ai7LoSV+tmLol8Za8xPFzD541sJuP/4vh3KWqt6+V
	 mu2JrIXdYjPx2ZOrRotcbMLPi2VQidu3vNEYAbyQ4yisbg+aMNvcWi8446mAZDJj/i
	 n4r6sNKQH10Zw==
Message-ID: <sashiko-outbox-204140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-4-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 22:55:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>=20
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>=20
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D3

