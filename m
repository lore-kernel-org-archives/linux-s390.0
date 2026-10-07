Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994F248C400
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374243; cv=none; b=tIBxxRUikVnrZeqjgVDGHKSr0Qm1LWO3eXRyzav981ApVkZBnq/xYrUQECG/In61guYwVpkhUqnie0ZgV0To5IK14AynwmZJaFzhyX/i9xBBffNSp1lX7dq0Zx8lpL1X7aHe+CGNglrzxI06kLzyPHTwXn3gOsfOMDk3IgTj7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374243; c=relaxed/simple;
	bh=g5DjjZ6XX61+ZlExcB/v2gqeVWv66ViBX4hFCBUTSbY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EL1qiSqOePDKRBduf/xOALXvKweIK85/yx6uu5r8lT1Uhu1jgvUHDEbZZNcpVZNabQJS/oJ1zVZknYmP3mkRMWy+5WDRlyrWIAvNfZBJiUY9nFXkkbl3Th+hrDwNaWC9+278xbuHQ7SREyb+rBu/S4vsz0oylPgCLcVSz4/clDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrhoapZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrhoapZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1F61F0089B;
	Wed,  7 Oct 2026 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374234;
	bh=aNN35yYspv6KwuDrlkkbzVPecYtFbySE/0Lco6jfPho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrhoapZbKzFXqYQviqB0IwqVsGXQm4IE1fU9bZugg/ZFOaqbhVPEDVXeQuWYPQrLR
	 j9fWn3DTjjedzGdG4fsTc+imBSV6/I/cd4C7ZQEiB1vy87o2WDWD7laHCYslLdWZ2Q
	 jCWw0qDRBncP/0jPuEbMK9lrbmhQGS54qctBOapG8PlKW/jh5PRURmkZiM+TG6qnLq
	 M5GRjnbLV4mli/8kecIdLzOWLIOJIiELNeCqzK1PI6gjEDLUL5hoisX4Ziqt4fcUYu
	 H062yFJQ1Anb7q+PoqL32XncS59CWuFhFsFt1guMxKnF1i1fdHrL7UAU3EiJTEAh3e
	 2ArTXJuSMOP2w==
Message-ID: <sashiko-outbox-162958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/15] s390: Distinguish hardware and software PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:57:13 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/mm: set_pte() discards _PAGE_UNUSED clearance
--

commit a9d06a7ccc3dae14aa4eb7e5a46302fce251265b
Author: Alexander Gordeev <agordeev@linux.ibm.com>
s390: Distinguish hardware and software PTEs

This commit introduces the hw_pte_t type for hardware PTEs on s390,
distinguishing them from software PTEs which continue to use the pte_t type.
It updates various memory management functions and callbacks to enforce this
type separation, similar to ARM64. It also enables the ARCH_HAS_HW_PTE_T
configuration for the architecture.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> index e882663a58e77..c47264f3abf21 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h

[ ... ]

> @@ -978,17 +978,19 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  	WRITE_ONCE(*pmdp, pmd);
>  }
> =20
> -static inline void set_pte(pte_t *ptep, pte_t pte)
> +static inline void set_pte(hw_pte_t *ptep, pte_t pte)
>  {
> +	hw_pte_t hwpte =3D (hw_pte_t) { (pte) };
> +
>  	if (pte_present(pte))
>  		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
> -	WRITE_ONCE(*ptep, pte);
> +	WRITE_ONCE(*ptep, hwpte);

[Severity: High]
Does this discard the _PAGE_UNUSED bit clearance?

Because hwpte is initialized before pte is potentially modified, the
WRITE_ONCE call writes the original snapshot to the page table, ignoring
the update from clear_pte_bit.

If this _PAGE_UNUSED bit incorrectly remains set on an active page, could t=
he
hypervisor (z/VM or KVM) reclaim its backing physical memory and cause sile=
nt
guest data loss or memory corruption?

>  }
> =20
>  #define ptep_get ptep_get

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D11
