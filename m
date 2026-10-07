Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC813C3F5F
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373882; cv=none; b=LqKvKp37vyd21gjyIGcg3V4Vhazb9ENdaSj3qdn4Pdtr2eSxbTmE1P4zvzW0nY8NaHVciT2PzPu96UTe0yR7pGOFCtFUdXcvQZy/J8GnVVd6sHmjZTWxoJokaa7Rong23xKr51MH6o0MHGhYVq68kTdCo0m/vz/F1chcSjGXLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373882; c=relaxed/simple;
	bh=s95ZO6ucoYYjg5gnUCtWOTdQpf2Es0z2kbcEqDq+yTo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=C2ikEktPa7G4nOo3p+xc2OlMb21/isXXNUmiMbK30ePt77TwgGMlYI57nF8gYmcnRImAh2wVGoSJAUb6DKjkDZELSRVjkIblZydu1NpECYAgP0zE1Bbrco1a5keClyVkR0UjfI+zPR98aqArKg9dbHjYky9g7mukUhQt90H5RXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EveHRtmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EveHRtmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E9E1F0089B;
	Wed,  7 Oct 2026 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373873;
	bh=E0h9zc1/igye7IWlRektWx46O5GaVfAdAPmm8HNS9JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EveHRtmR/fk4Hs1vQ6zxvTj0k4YJYwx95MA46DakzRQ++GHQrioV91FTOno0datIS
	 sSLl9AAnRGAso4qy4EqJM3+WoALF/kGB1/4pkTXeplcmlT9thGGmuq+kn9SimS0s1S
	 BcYeDWWMlANgprNuysd+2ycS2ERQu/IbFpNB1pV8JQFhDtvzK6JfxqjAkK95I3gsHK
	 DvXGcP7mFprVA6WEuuV/VD7p8lQ3sMiNrsz12BssVkVeRnEJF4bRqobeDEm+gJVS5+
	 LWJfTWy4PXSpaXwEH2ruCaCak13U32Mke4UVGTpRPcM0vMT7chCTUjg14c3gkS7K17
	 9s7y0cJC5oWlA==
Message-ID: <sashiko-outbox-162942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] mm: add hw_pte_val for HW PTE storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <ae6e2f07e41059e78c0fd2b265cc63a284b53878.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <ae6e2f07e41059e78c0fd2b265cc63a284b53878.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:51:12 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: hw_pte_val expands to rvalue breaking lvalue API contract
--

commit 5410dae6e74b38457df98b3df5924d0050eb76a9
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

mm: add hw_pte_val for HW PTE storage

This commit adds a hw_pte_val() macro to expose an lvalue for hardware PTE
storage. It accesses the wrapper's __pte member when hw_pte_t is distinct,
and uses pte_val() directly otherwise.

> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> index d6c5a7548550b..ee4eace5c3e1c 100644
> --- a/include/linux/pgtable_types.h
> +++ b/include/linux/pgtable_types.h
> @@ -9,9 +9,13 @@
>  #ifdef CONFIG_ARCH_HAS_HW_PTE_T
>  typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
>  #define __pte_from_hw(pte)	((pte).__pte)
> +
> +#define hw_pte_val(x)  pte_val((x).__pte)

[Severity: Low]
The commit message states that hw_pte_val() is meant to expose an lvalue.
However, on architectures where pte_val() is implemented as a static inline
function rather than a macro (such as x86), doesn't pte_val() evaluate to
an rvalue instead?=20

Will taking the address of hw_pte_val() in generic code yield an "lvalue
required" compiler error on those architectures?

>  #else
>  #define hw_pte_t pte_t
>  #define __pte_from_hw(pte)	(pte)
> +
> +#define hw_pte_val(x)  pte_val(x)

[Severity: Low]
Similarly, does this also evaluate to an rvalue on architectures where
pte_val() is a static inline function, breaking the expected lvalue API
contract?

>  #endif
> =20
>  #endif /* !__ASSEMBLY__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D6
