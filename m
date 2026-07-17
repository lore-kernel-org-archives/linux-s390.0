Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478593F0774
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295590; cv=none; b=NXSoUccaknEGoWJTaFvTspN/FOtM3M+AxTouV3kX3wiOLT0UOzXJMvwYX1FBYBq8/x+Efyik+en8cB8OGt4hANfT7XxiiXQbKSscEl9F8nrEMNbYRo2cKi4rrIlgjqxNl1hzxvxvPzFVv792kPy4j9UJw8GdIL50vGHRZLdnEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295590; c=relaxed/simple;
	bh=EJztutzzQgt13pslQnYpROW6606cCqtAp2uL4A6LFoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nbw8chrTI+InI/HvWVkDbg7kJ1/9gfs0s+30pD4kH0JkacpqFBGgUhSoyCZgaVxO+2R7QKIjSt5x1e+0Wom9dDVcpdq/avhaU4USBh4uqEdPrTyeBaVnB9UzyPIFRNcI6BIi2P7hgz9xYExsTmejj/w0LvNolSEzx4oAEga2a1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9XPJVsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9XPJVsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EF81F000E9;
	Fri, 17 Jul 2026 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295586;
	bh=cAUClTpr7oKobljn4c3sOA7NJFD4TyI/ZKYfQ53jv5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9XPJVsEY26bsgY0/XxIP/S5aMiaDKBCBmE2uuazwepVPQf2zfdmTgvxXQTROMkUG
	 erFmgpVFfvaj8EA8vyNie3FLWSd+U2eA0A3sv/EjS6rjLn/A5DsUHUUIEWrQ1PQG/z
	 b64ZUIixCcKUS0104xqYQtSGVwU062LFM77KWBkj4FokpcVSdWpiqkpVQ4tdz5Gkwo
	 9WutBfGtKsVFUyNaraF7i9j8tVRv3pzmBxCZN7GTpXk2Vf6AnGATv/DBz2jbTakvdb
	 AX93B4kmEqDwYTr9w8r/2rIaYgCkulLzkuzELYiM87/4mWqZKn1DgwpndMieIro+mm
	 cXWr/jrVQHYFQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] s390/mm: implement __ptent-aware pte_t type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <2580c0c643125fb89247f255ff42803bea44e4c3.1784292223.git.agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
 <2580c0c643125fb89247f255ff42803bea44e4c3.1784292223.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:39:46 +0000
Message-Id: <20260717133946.83EF81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `set_pte()` when `STRICT_MM_TYPECHECKS` is defined, the `_PAGE_=
UNUSED` bit is incorrectly left asserted on present PTEs because a stale sn=
apshot of the PTE is written to the page table instead of the updated value.
--

--- Patch [4]: [RFC PATCH 4/4] s390/mm: implement __ptent-aware pte_t type =
---
commit 7300d6f6725c9361fd35e232d50cadaf34b8a823
Author: Alexander Gordeev <agordeev@linux.ibm.com>

s390/mm: implement __ptent-aware pte_t type

This commit introduces a new pteraw_t type to enforce strict mm type checks
for PTEs on s390, modifying how set_pte() and other helpers handle page
table entries.

[ ... ]

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> index e882663a58e77..473e6f58ff9e8 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h

[ ... ]

> @@ -978,6 +978,49 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  	WRITE_ONCE(*pmdp, pmd);
>  }
> =20
> +#ifdef STRICT_MM_TYPECHECKS
> +static inline void set_pte(pte_t *ptep, pte_t pte)
> +{
> +	pteraw_t *pteraw_ptep =3D (__force pteraw_t *)ptep;
> +	pteraw_t pteraw =3D __pteraw(pte_val(pte));
> +
> +	if (pte_present(pte))
> +		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
> +	WRITE_ONCE(*pteraw_ptep, pteraw);

[Severity: High]
Does this WRITE_ONCE() write the unmodified original pte instead of the
cleared one?

Since pteraw is captured from the initial pte argument before clear_pte_bit=
()
is called, it looks like the _PAGE_UNUSED modification to pte is completely
ignored when writing to memory.

Should pteraw be updated with the modified pte before calling WRITE_ONCE()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784292223.gi=
t.agordeev@linux.ibm.com?part=3D4
