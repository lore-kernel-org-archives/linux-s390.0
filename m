Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4A383320
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374054; cv=none; b=ALNuh6KqcdlcP6F8BZ8QnoB0CmKw6RNz//eTE0U2St+vjEULfc7KPqvJ6yNJEUIhWnlzgT0OeocleWpIZ6N/j2LKWzuvjy1uaaBqC7r44ykw+Eg5C2InP8g3mxSOIfMhq8bpe5W2kaDMZr3t9xT80Omx5vRlPkVgKoSb1rsk6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374054; c=relaxed/simple;
	bh=oV3afxOTHUbLQoDrrfk2PIIIwYSybf9+6VfInJtDwn4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LgWZCjlenyTDb3lZSBrZ4Xsxy8D/syws0zayo7V/A3gLz42zYzpVLErvZCvOhz8J6rMhhPRZS6fGwsGbXgizxusImuJT/Zo9SWWr7h+ot2TNzD5t6rqKer0z6bZbizPx4qElm+dISoEedsaCvPIBtNYulPcYtDxKWF4dN6jpqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKzQxQSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKzQxQSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2991F0089B;
	Wed,  7 Oct 2026 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374044;
	bh=315UcgsILzNc3niyeQUnLsYH3hTXr2wO1iUQX3XjpVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UKzQxQSFTiuHLXg6nk30D5+BLK+aSmxmzTrRsuHftBktHdcqP1x+cItCjMtSHuKsI
	 CzdDDWHrFJQaLsCprKs0z5b8Q/wx+zhArw2iv5ebVWNP1vjLMemd5mMIyTgH+o2XjX
	 eabqK8KoMzNY4aZQ83yfWwlO34+bekNE+oX9qBDzRneh1/jMOX61z3KrdP+pSppQYN
	 WCdqWqa83+YtL05/4AFB2zSxblNpyrW6l5eEDZQXjBo4/DwCIy1KJSHYkB/bVEx8Zc
	 AqI6NuB24xZp4v4G2wSIQ5wPrM6R7wvs3bVKHbcbypIrIZiPRe4N2vATba6iHMb4DB
	 cAyB4UMsUkw/w==
Message-ID: <sashiko-outbox-162950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/15] mm: rename pointers to software PTE values as
 ptentp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <76c38f9eea5132fe56aafffc68d5c499f423a705.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <76c38f9eea5132fe56aafffc68d5c499f423a705.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:54:03 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: missed software PTE pointer rename in damon_hugetlb_ptep_mkold
--

commit a7aa8dc368dae477c79fe8a52a9e505b4cbf8802
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: rename pointers to software PTE values as ptentp

This commit renames pointers to software PTE values to ptentp in
certain functions. This ensures they are excluded from a subsequent
Coccinelle conversion of PTE table pointers to hw_pte_t *.

> Rename these parameters in the install_pte callback,
> write_protect_page(), and guard_install_set_pte() to ptentp. The later
> Coccinelle conversion skips pointers named ptentp, allowing it to convert
> the remaining PTE table pointers without changing these interfaces.

[Severity: Low]
Was damon_hugetlb_ptep_mkold() in mm/damon/vaddr.c missed during this
renaming sweep?

It appears the entry parameter in damon_hugetlb_ptep_mkold() is a pointer
to a software PTE value:

mm/damon/vaddr.c:
static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)

Because this wasn't renamed to ptentp, a subsequent Coccinelle conversion
to hw_pte_t * misses this parameter. Meanwhile, the caller
damon_hugetlb_mkold() is updated to use hw_pte_t *.

On architectures like s390 where hw_pte_t is a distinct struct type rather
than a typedef, this mismatch between the caller's hw_pte_t * and the
callee's pte_t * (as well as passing a pte_t * to huge_ptep_get_and_clear
which expects hw_pte_t *) triggers an incompatible pointer type build failu=
re
when CONFIG_HUGETLB_PAGE is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D2
