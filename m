Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72E4279F8
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131647; cv=none; b=RezUm/OT66mq5nICCmP9t+0QVqjN3zAaJbxMlRondJf3c5U/KcDfwT3bqD/hiSK4hfYIwQmyksn4sW7HbAbQkhRMkdiJdZtBkkTMLkRkOVZ3rBIMq/lHetgHINsU1IILZqIVh6xQlnj0GJdBsRYR4CvOueeorQrCCYgMo43735Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131647; c=relaxed/simple;
	bh=y/25pRgwdQ2hOrsJJp+taqdU+gTMSOzyx9aO4JPbAVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RI7Nwdo64UqyDD1p96lLAetJPyp3fDxrCSklaknJFd07eJc+HxD9B0JtSvzXbfrTQeWGs6sN1YFH4g3uNH0QH+HOjqfvBvjoHQeOXbPOYVwK1F1hrr3fKOmPa2hVVf3fnHr3qYGMlEw+MN/7M/GeB3OSs2uMly4RPDY9nsvfWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMfRY0so; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMfRY0so"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B4A1F00A3A;
	Wed, 19 Aug 2026 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131642;
	bh=+8ivSSkhywJ6mCtq7gPEz0tTv7rsCRltdH5EyzeRT4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMfRY0soH+ebQ8KMOGu4BM/luhdf8hr2/YhEnszgQhxIJmb2xZq/nKvzbUiezVImY
	 4oKOtMCllg/UOAha6I9Ghp/CSsRbArfIo1koHQe5UR0hrKanGuAf83dPg1dOqKah3I
	 uqiPZ4oQ2a4W76VAd3kToRpAkKFtf2vS4I140Vry3syxF6nA9Gh/9R1WX9S6KXKqS3
	 j7NMvlthswY7oiVlw7xezk6FJX5Jm4ZFTjtvLtUd8VZ16cj+exk9syc/MXCwFBBNlX
	 QXYA20TIHi2BvwsvFNaBUjw1XrJUfHsQWorSX8N3Hr8H3TKBNYFkXLfRuCErfXwALN
	 LU7nfzPDbVNcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] s390/crypto: Fix use of mutex in atomic context
 in PAES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260819091734.7331-4-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:27:22 +0000
Message-Id: <20260819092722.79B4A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The standard AES CTR implementation uses `mutex_trylock()` and `mu=
tex_unlock()` in a context that may be atomic, which violates core kernel l=
ocking rules.
--

--- Patch [3]: [PATCH v4 3/7] s390/crypto: Fix use of mutex in atomic conte=
xt in PAES ---
commit d6ba4976a19245fd83ba5c797399a6bd57d986bb
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/crypto: Fix use of mutex in atomic context in PAES

The PAES CTR implementation used a mutex to lock one page of exclusive
memory for fast CTR processing. This commit replaces the mutex with a
binary semaphore, since a mutex is not safe to use in atomic or interrupt
context.

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index d075b0241f1f5..e8bbfc376ebb1 100644
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
This is a pre-existing issue, but does the standard AES implementation in
arch/s390/crypto/aes_s390.c suffer from this exact same problem?

Looking at ctr_aes_crypt() in arch/s390/crypto/aes_s390.c:

	locked =3D mutex_trylock(&ctrblk_lock);

	ret =3D skcipher_walk_virt(&walk, req, false);
	while ((nbytes =3D walk.nbytes) >=3D AES_BLOCK_SIZE) {
	...
	}
	if (locked)
		mutex_unlock(&ctrblk_lock);

Network traffic processing (e.g., IPsec) executes SKCIPHER operations from
a softirq context. Unlocking a mutex in an interrupt context triggers a
kernel panic or BUG on PREEMPT_RT kernels, and lockdep warnings on
standard kernels.

Since this patch successfully fixes the issue for PAES, should a similar
fix be applied to arch/s390/crypto/aes_s390.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D3
