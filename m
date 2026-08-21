Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59201429817
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302597; cv=none; b=GwvfKm9qsmnnkTaeGH+ntO60TBfKllT5ZhhdAh0LtAz9OtbQg5RQ1YY8y8XXdxwG195x02yo5FRvrzky13edl4w69yZtFt+e740UabfhlkBAjoi3EreYuk15l5Bi0q+ZLAYlUi8EL6zetTXyBIh8VGK6BtZ2mUPnDyxhHYxDMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302597; c=relaxed/simple;
	bh=QO8PvPgxI6dAcwBPVBZV2NhREHoksJa8G/hGpSJhDRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=odhRPkrylC1i9OL8ByZJq679rPP+0o+SveWmcipKQ9hg+XRu2Mkgh0cOvz502RmJd9wLkAj+iF8b3s3VAXJ2IEv4v0U09T5rt81eCvLSE/Ns/KLrOknRzq8F31MDfxkoUjyLDitp4z5Se5L771e66T8WUiJsSec7P7WJqfEpWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHOffjXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHOffjXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC61F000E9;
	Fri, 21 Aug 2026 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302596;
	bh=xdkoguNnDDA8xHr5YHeSIHZQM5AVo747SC7m1bhvXL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHOffjXCZBCC5czPNp/nMMm4eQd/ue8ZWBpBem0GHE96W5UJv/CfrU0DDXfvUzZFZ
	 nqLD7HVnnOabJMa+cguaMHFNYEWcS4pyG0BbUtQD0ZPaoe/GRBsYk1xxA/N9ZLCOzm
	 mcRwO8R85x/8e+tOHp3ijHqFpQlt+AMtBvDSQs7FA7LWDIFhLhEoiHrcJ1ljnperfK
	 uoQgFwe9xb1VVlpHsmYzuXky+21T3E6VhNVWcER484nQmeFHjUaZUPCLGLC0kN5tob
	 2nIPaDUrZqEOYRj3TzgRDZAHh0m89VwE0HIetBvy6yYAvdubwaX16Ed0+emWTiA46q
	 4Te1odiBLbysA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821084648.23222-4-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:56:35 +0000
Message-Id: <20260821085635.D6BC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `aes_s390.c` module contains the exact same locking bug in ato=
mic context that this patch fixes in `paes_s390.c`. The `ctr_aes_crypt()` f=
unction uses `mutex_trylock(&ctrblk_lock)` and subsequently calls `mutex_un=
lock(&ctrblk_lock)`. As the patch's commit message notes, mutexes are not s=
afe to use in atomic or interrupt context. Synchronous skcipher algorithms =
like `ctr-aes-s390` can be invoked directly from `softirq` context (e.g., b=
y the IPsec stack). Calling `mutex_unlock()` in `softirq` is a strict viola=
tion of kernel locking rules.
--

--- Patch [3]: [PATCH v6 3/9] s390/crypto: Fix use of mutex in atomic conte=
xt in PAES ---
commit 425e8f1d3532a176433992d286f917e0fd14ff9e
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

This commit fixes a locking issue in the PAES CTR implementation where a
mutex was used in atomic or interrupt context. It replaces the mutex with
a binary semaphore which is safe to use in such environments.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
[ ... ]
> @@ -45,7 +45,7 @@ module_param_named(clrkey, pkey_clrkey_allowed, bool, 0=
444);
>  MODULE_PARM_DESC(clrkey, "Allow clear key material (default N)");
> =20
>  static u8 *ctrblk;
> -static DEFINE_MUTEX(ctrblk_lock);
> +static DEFINE_SEMAPHORE(ctrblk_sem, 1);

[Severity: High]
This isn't a bug introduced by this patch, but arch/s390/crypto/aes_s390.c
appears to have the exact same bug that this patch is fixing here.

Looking at ctr_aes_crypt() in aes_s390.c:

	locked =3D mutex_trylock(&ctrblk_lock);

	ret =3D skcipher_walk_virt(&walk, req, false);
	while ((nbytes =3D walk.nbytes) >=3D AES_BLOCK_SIZE) {
		...
	}
	if (locked)
		mutex_unlock(&ctrblk_lock);

Since synchronous skcipher algorithms like ctr-aes-s390 can be invoked from
softirq context (such as by the IPsec stack), would calling mutex_unlock()
here trigger a lockdep splat or crash, especially on PREEMPT_RT where
mutex_unlock() must be called from process context?

Does aes_s390.c also need to be converted to use a binary semaphore?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D3
