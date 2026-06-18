Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11033630B2
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794850; cv=none; b=JGARTsJ8ZazpXr6vrg10//jgFxUDC2s3p2ld+B6A5m/JI+fL9O7QS9irka/NFSlueF5rJ8I9tZhmf2jLqFRsz7v7Sc2kP2Pz+5LyL8XDVKB/Pths/B1vd5CR9tZ0h581mVDQjEGK5HJ9dXEqvHf1iZMNlxkI6XJgmIrxAfo6hAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794850; c=relaxed/simple;
	bh=TDe21b8iBGh2gaCTGX3Onz8HkqYiaoE+H9NjermVUa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ADrUwsTxznSUjVG5uSocOo3erK6QCLvB108LAvGxqDH+YZAGNQej5/DOMsRZUUjd57CwO117mfA76O5HShwv/odEmTkc4JHRwoZMaAIFnVSl7TDqaWqgqq/UAif/H7Ig/l/jNLatdxSCnXttk4sml9zcYqmcJodq9sXrrfsZbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNH5S59i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNH5S59i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F396A1F000E9;
	Thu, 18 Jun 2026 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781794849;
	bh=IvYk+CfhHPhrJCTeWP2MpV6aTP6itruEmWgSTct2rok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNH5S59iel16MTQzyWH8OzuZeaG7tfQPEHqPZJygv3wx1khsYvUajsVxsZAKYU6RD
	 LlmfddTmKQuHCuGRLt9f3vxYjacOKUG2NL9K9gCzIYVu1C+U26fSXsBmnOA7y2QxiZ
	 KisOEr3yyIR25FkeUSQRcvOUc7w693mqaXEV2ixYyWgD6Z8vFGtSmfsZ07lTi0HDd2
	 MMC/Ng19wScYV1CJ4amNGeNxgm2WDlTCf/9G3uPEYSJsL6JYqgk/tF0EfSJK2cRMkC
	 u4VX/TusS8aHoP9akUUwoJrWJlhQNkfn/wsm+ODkChDPYluUsjIYKWug5ZDWnGQUr6
	 Et4BzBEjcfhEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next v4 3/4] mm/kasan: Introduce helpers for lazy MMU
 mode sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <0d76139923a280617a21839b7e3f3e7735b58fdf.1781789772.git.agordeev@linux.ibm.com>
References: <cover.1781789772.git.agordeev@linux.ibm.com>
 <0d76139923a280617a21839b7e3f3e7735b58fdf.1781789772.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:00:48 +0000
Message-Id: <20260618150048.F396A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new KASAN_LAZY_MMU_PTE shadow value is not mapped to a bug t=
ype in the KASAN reporting logic, resulting in uninformative "unknown-crash=
" reports.
--

commit 7d8731323b7762279e28d0aef3b1b3c457449b81
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm/kasan: Introduce helpers for lazy MMU mode sanitizer

This commit provides helpers to allow architectures to poison and unpoison
PTEs during lazy MMU mode. It introduces a new KASAN shadow tag to track
and catch direct PTE manipulations that improperly bypass the correct
accessors.

> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fc9169a547662..8ba0fbabd75b2 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
[ ... ]
> @@ -144,12 +144,14 @@ static inline bool kasan_requires_meta(void)
>  #define KASAN_PAGE_REDZONE	0xFE  /* redzone for kmalloc_large allocation=
 */
>  #define KASAN_SLAB_REDZONE	0xFC  /* redzone for slab object */
>  #define KASAN_SLAB_FREE		0xFB  /* freed slab object */
> +#define KASAN_LAZY_MMU_PTE	0xFD

[Severity: Medium]
Since this adds a new shadow tag value, does get_shadow_bug_type() in
mm/kasan/report_generic.c also need to be updated to handle it?

Currently, if KASAN catches a direct PTE access and reads this shadow
value, it looks like it will fall through the switch statement in
get_shadow_bug_type() and default to reporting an "unknown-crash".

Would adding KASAN_LAZY_MMU_PTE to the switch cases ensure we get a
more descriptive bug type instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781789772.gi=
t.agordeev@linux.ibm.com?part=3D3
