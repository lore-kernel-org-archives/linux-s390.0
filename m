Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A44A3418
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520544; cv=none; b=NEDsyjKuJZmbip8xpne1A9Xrejk7WKFE28HogjVQmXNbDL9Rl8J3DwkFRWQa2uTrLlNcDf5RUjMkEUliqIAL1ZG+oQlPGUMdGYL8iCRmWrbRfCySW+sSIhRVLkDas81HSXCwlYPWbzWTQIvvAS6jWNJwqugLBBpgV4XAwKlCe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520544; c=relaxed/simple;
	bh=RV7R66SJJujRmJUkWWa4wtjMVBGskFAa7B3hx4cJ7Sg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJ/JeHvgipncKiHJDV7SwureIomS5FYJMNApdQK6Byr7XMOb2bZDIpw75pkmj55Aj1dkFOHBulgqxpavcdmQUvkrZwVo6+Tt6rMQN5etuJlypd94mRiN2AD8MDEewkuS7JRJtpQRNNX92jGKaOUaO27Nd4HuNsHB4KzdjMbZwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrv52UIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrv52UIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA691F000E9;
	Wed,  8 Jul 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520542;
	bh=BpyhjmEtOs/o3UDHKKrSc2MYFG2E3oBLO3OzFC20iIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrv52UIs3yZgpTXTx1zjQw1XgGRX0JoYm+CvidqJ6T2FrFNL2K3qxCWyn3WVILkST
	 OuNIUZaqZt+InuWPm1Xk3zWGQ2/IO9VNmWQlrOdhdB8WBqt/446FV8U1wUP8l+9ob5
	 Zi9yj2ReLvtF9wZLjvENYbeJa28Jz1rkXFh1LfCx2aCzZstahUMk4mZwiV5eOYXVzd
	 QcKzF5dHFyth783GHJpCEAuW8h2EKrggB8cfMmUUZxTjcCNNEpcwMxQqBbGmPfpBwV
	 sC3VcQnGJcmDMY6I/hTTHiFjCo8fTQwmK3cU0IwgW2FB1ISWSz968cC78e+Ytxs9WY
	 fob6sCa+EXpNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] x86/mm: drop order parameter from
 free_pagetable()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260708-bootmem_info_part2-v1-1-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-1-156ce4986598@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:22:22 +0000
Message-Id: <20260708142222.8DA691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Page table pages are freed to the buddy allocator before their par=
ent entries are cleared, creating a use-after-free window for hardware MMU =
walkers.
--

--- Patch [1]: [PATCH 01/10] x86/mm: drop order parameter from free_pagetab=
le() ---
commit 9c29ffca799af465974343eaff811f5b52635f1f
Author: David Hildenbrand (Arm) <david@kernel.org>

x86/mm: drop order parameter from free_pagetable()

All callers pass 0, so let's drop the parameter.

> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index d57f29ca23a5a..69e36f02a663a 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c

[ ... ]

> @@ -1060,7 +1057,7 @@ static void __meminit free_pte_table(pte_t *pte_sta=
rt, pmd_t *pmd)
>  	}
> =20
>  	/* free a pte table */
> -	free_pagetable(pmd_page(*pmd), 0);
> +	free_pagetable(pmd_page(*pmd));
>  	spin_lock(&init_mm.page_table_lock);
>  	pmd_clear(pmd);

[Severity: High]
This is a pre-existing issue, but does calling free_pagetable() before
pmd_clear() create a use-after-free window?

The PTE table page is freed to the allocator before the PMD entry pointing =
to
it is cleared. If the freed page is quickly reallocated and populated with
arbitrary data, could hardware speculative page table walks or lockless sof=
tware
walkers (like ptdump) follow the still-valid PMD entry and interpret this
data as valid page table entries?

>  	spin_unlock(&init_mm.page_table_lock);

[ ... ]

> @@ -1078,7 +1075,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_sta=
rt, pud_t *pud)
>  	}
> =20
>  	/* free a pmd table */
> -	free_pagetable(pud_page(*pud), 0);
> +	free_pagetable(pud_page(*pud));
>  	spin_lock(&init_mm.page_table_lock);
>  	pud_clear(pud);

[Severity: High]
This is a pre-existing issue, but does this create a similar use-after-free
window for the PMD table page?

The PMD table page is freed to the buddy allocator before the PUD entry
pointing to it is cleared here.

>  	spin_unlock(&init_mm.page_table_lock);

[ ... ]

> @@ -1096,7 +1093,7 @@ static void __meminit free_pud_table(pud_t *pud_sta=
rt, p4d_t *p4d)
>  	}
> =20
>  	/* free a pud table */
> -	free_pagetable(p4d_page(*p4d), 0);
> +	free_pagetable(p4d_page(*p4d));
>  	spin_lock(&init_mm.page_table_lock);
>  	p4d_clear(p4d);

[Severity: High]
This is a pre-existing issue, but does this create a similar use-after-free
window for the PUD table page?

The PUD table page is freed to the buddy allocator before the P4D entry
pointing to it is cleared here.

>  	spin_unlock(&init_mm.page_table_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bootmem_in=
fo_part2-v1-0-156ce4986598@kernel.org?part=3D1
