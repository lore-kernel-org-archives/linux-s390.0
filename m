Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEC23D2A1
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138560; cv=none; b=MAYb9S5AjIKUmqay6dgx0bwozMDPBX/8EOfrtkElluoeywlUG05XcHdKy96926DmpI6CqMTkuV8pcOr9ScJE7eO6XVkZJzgTS7O2VaF0+GZqgp0IHJp5Kbfw8UG5MXh7R45iA0hrnMgLV+5V71FkuwJsxdBiudn0ZjrdHJ6JXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138560; c=relaxed/simple;
	bh=cjZcj8iNSCzYvy+ieu76oUIeO5lrczt4siODHdYnCxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fP6RgUeY/TgfBkKnPAv9phPybPXlYNmFGEU4JpcPsyigBsB18cZc6/BMfQvB2KNlPlhARlZytmTlmPZekb8e1T68KCJ6RF2p01SA6ZJ6n0+BGRzoBs5zmg7kDwlZp83gllwnrKX8+jxzkFV7ZK6pKiPDYP21QlDxcN7+wKD7t/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPMYkUtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPMYkUtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A18D1F000FF;
	Wed, 23 Sep 2026 04:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138558;
	bh=Dgi9TD52Dzj0Oxp0Clnzq8HPZH/w4JlvE13Il/pKSyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPMYkUtbx8wNsuphY1CYq+qAtQ7Z17oe6gbAzGjKHaJo2oCImmOyBO7tv911KMfCa
	 QfesnfdVnvQADSueec1ue3EeUW4bzkWIs6iEf145k3OedN5heoEhXMx8y6zDzNL/lF
	 6aExWmvUcpmlrzHZgQrVEN3LH0v9JiejLGyLhHJBTJ4hlOySp7UqIlp/Rj2y9q4U/C
	 Uob3u+7RgOxDskQJ8SExpT2o3yy0ENtRhghw4SQ6RdXfMpyLVEKjVWfTL3KLdXZXy9
	 hka7o46fLu2QJnDnaQGXNr1gi+Y+E+DKL2837Sg0CKr+iSpJ2NYIq002EYFhpH8Oin
	 GvhYaZ+1C6iAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] parisc/mm: Drop all pxdp_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anshuman Khandual" <anshuman.khandual@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260923043226.331880-4-anshuman.khandual@arm.com>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
 <20260923043226.331880-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:42:38 +0000
Message-Id: <20260923044238.6A18D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: unnecessary out-of-line conversion of ptep_test_and_clear_yo=
ung()
--

commit 6892dae5d3895dcd59fc83328a1aca2f33ba942b
Author: Anshuman Khandual <anshuman.khandual@arm.com>

parisc/mm: Drop all pxdp_get()

This commit drops the redundant platform-specific pxdp_get() helpers in
favor of the generic MM header definitions. It also moves dependent functio=
ns
like ptep_test_and_clear_young() out-of-line to avoid build failures.

> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index be3380c9bcdae..3da7d8def9435 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -992,3 +992,16 @@ struct execmem_info __init *execmem_arch_setup(void)
>  	return &execmem_info;
>  }
>  #endif /* CONFIG_EXECMEM */
> +
> +bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long addr, pte_t *ptep)
> +{
> +	pte_t pte;
> +
> +	pte =3D ptep_get(ptep);
> +	if (!pte_young(pte))
> +		return false;
> +
> +	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
> +	return true;
> +}

[Severity: Medium]
Is there a reason this function was moved out-of-line instead of dropping
the custom implementation entirely?

This implementation perfectly matches the generic inline default provided in
include/linux/pgtable.h. Since this path is called heavily during memory
pressure and page reclaim, such as from page_referenced_one(), moving it
out-of-line introduces function call overhead for every PTE scanned.

Could we instead remove the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG definition
in arch/parisc/include/asm/pgtable.h? This would allow the compiler to use
the generic inline fallback and avoid the performance regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043226.3318=
80-1-anshuman.khandual@arm.com?part=3D3
