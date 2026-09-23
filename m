Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090713932F9
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138507; cv=none; b=BJmz7ioqKc51CZUlAXhRD6ZLtugCMT7TJOfOQa23sxCNZJyPMZ55noFKxiS23LzwPqfSiaUxI1MQHlml+YX0KjfMKuncWx2lPMqQpHpeBYCJIhDIaVQ5xj5YjeTTeShz3GiIq6WdmR3LMnbuR92eqrjA1wHLkNciiA7lTcGuAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138507; c=relaxed/simple;
	bh=31L8uRuGZtLlVj8fVtavb1s0jseFtP9Qt2gH0yLiaZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CzZU19UZS5YHvDoGU7QykmYJpCVgPyc9pwXiS6CGPeMOZqsculCZXws5Qrpby8lgxJW91ytKkO07cnXlYDav4E7hpSF1Dzqv55f/oejS7nhq4zR3eUX6cHS6/RR+Abx6uB3ntk34jIzmZArkYmpYd525XE0VtSIxEyb2V8Oab7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9pjQpO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9pjQpO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0911F000FF;
	Wed, 23 Sep 2026 04:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138505;
	bh=VMcKGoJ5K8+1xipevoDZTIhDEKl4hTHPQXRF1eTGRBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9pjQpO/+7kBfcIJpgFNRj7sQbYC0BQt8lHGmPM4BZ9yI48p6oaeutpSDhIvN5pfN
	 PixUPrk+ifZYomL/ZjGfNlzqc6te1hWfnjMBYH5ygSmEPZ75X4ryX5LguHvFccOXCg
	 U0jA2KAM+ixVhoXaCh07Er2vpgssmcy/vviBGy85XRTdRM4G1sHbTSaG9jO9biqwUV
	 NcqcvDruYuLE1M5EMpFPscbpg0+4JSg14WKuCMFAJx23qdBwY8bVZt9MnfcEd9/j4x
	 jt2gIWhgnsurPa3WFxkFdQOvftWklPzDHTj4I+5XTCfVA/DzEv2mO73wUtuGBYV2aE
	 zek+JVxYU1SLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] loongarch/mm: Drop all pxdp_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260923043226.331880-3-anshuman.khandual@arm.com>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
 <20260923043226.331880-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:41:44 +0000
Message-Id: <20260923044145.2E0911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: performance regression from de-inlining pte_clear()
--

commit 5d80651056844549679369970919b58e26bc34bf
Author: Anshuman Khandual <anshuman.khandual@arm.com>

loongarch/mm: Drop all pxdp_get()

This patch removes redundant loongarch-specific pxdp_get() helpers, relying
on the generic ones from include/linux/pgtable.h. To prevent build failures,
it moves some dependent functions to out-of-line implementations.

> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index a05f6a4928dc6..b1060b86d5353 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h

[ ... ]

> @@ -378,12 +375,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  #endif
>  }
> =20
> -static inline void pte_clear(struct mm_struct *mm, unsigned long addr, p=
te_t *ptep)
> -{
> -	pte_t pte =3D ptep_get(ptep);
> -	pte_val(pte) &=3D _PAGE_GLOBAL;
> -	set_pte(ptep, pte);
> -}
> +void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);

[Severity: High]
Does removing 'static inline' and moving pte_clear() out-of-line introduce a
performance regression?

pte_clear() is a core memory management primitive executed iteratively in
extremely hot paths. For instance, zap_pte_range() processes up to 512 PTEs
per PMD during munmap or madvise. Replacing inline bitwise operations with
function calls during large VMA teardown introduces a significant overhead
for any unprivileged process allocating and freeing memory.

Could this be avoided by expanding ptep_get(ptep) to its equivalent
READ_ONCE(*ptep) inside the inline definition instead of moving the function
out-of-line?

[ ... ]

> @@ -618,16 +610,8 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>   * different prototype.
>   */
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
> -static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> -					    unsigned long address, pmd_t *pmdp)
> -{
> -	pmd_t old =3D pmdp_get(pmdp);
> -
> -	pmd_clear(pmdp);
> -
> -	return old;
> -}
> =20
> +pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm, unsigned long addres=
s, pmd_t *pmdp);

[Severity: High]
Does moving pmdp_huge_get_and_clear() out-of-line similarly negatively impa=
ct
THP teardown performance?

Like pte_clear(), this function operates on hot paths, and substituting an
inline definition with a function call introduces overhead. Could this also
be kept inline by expanding pmdp_get(pmdp) to READ_ONCE(*pmdp)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043226.3318=
80-1-anshuman.khandual@arm.com?part=3D2
