Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3641CB46
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525124; cv=none; b=de9IoPxyVnwM3BQfAgcvzRsFBU95JAgMaSthLrZ6ikk+801w7oGguxoLhgw2FtZNMqoj0vJNmhz+5I0/vZfFkCWpS1Pqd6hAKUDHj9NgzEGCB+xMJBFS1qH7c29uqy+lRH36MSkQH4PFY0HbdsVNtgkqkKnmg8XtYPZk4M9pnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525124; c=relaxed/simple;
	bh=J0abimNOSxxIeTntrBcjIV3CunZWyrhvafRoqRfP8fU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hV9ULkeew0ISNWaZpb2ME1RMBaJcMVOljfnqZNhvKqmJHQoqIoUG3XDLIO1w2UX2HMDX63zFQBNFJBqs+zTSbqY57WvL/HzI4QaAc3qqhuQ/ECvZLWCI6toBFCf1r0Iumah85RmMQEnjboLnAqC/06sIviI/E3kRlcWLZ75yjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR5vkIWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR5vkIWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C111F00A3F;
	Wed,  8 Jul 2026 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525122;
	bh=h+IqMSnRUgv2J54WmZJHir72YK5D4WY6VBExYHYK1uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fR5vkIWn2etZLjF1+LHhMC+Na1NrCaAdO3oMI+G0J9hIr39vQRcWOro28aaUvyUS1
	 EVFAxOhsIyiZc4oyT5WftoeOnSnDxBmfz5I3xVeRRyS9WNK/tH+Uf2az/JJ5jW9aZk
	 4Z9mV82s3xLLXq4cr264NTpH5HV+tT9/eC8dO+JqN96BM4jzDW7n5vQOxlckTKqwdd
	 1tc3coIxMCDUzIZjXkBdfg3r8i7VedD2AmY+IWF7+h64udve9v7jjNjhbqWt/9j61S
	 dfn7rVM2WIHkwQI44PSyLiDktVHTQqEfYccixfCbfEgMx/nXt1QDiPn542o6JQbNwJ
	 H/5GPG/ckD4OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260708-bootmem_info_part2-v1-7-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-7-156ce4986598@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:38:41 +0000
Message-Id: <20260708153842.93C111F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete feature removal leaves behind dead code.

Pre-existing issues:
- [High] Page tables and vmemmap target pages are freed to the buddy alloca=
tor before their page table entries are cleared, causing a Use-After-Free r=
ace with hardware page table walkers.
--

--- Patch [7]: [PATCH 07/10] x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE -=
--
commit 4f73978273a221d985e72d75af30f38db0280de6
Author: David Hildenbrand (Arm) <david@kernel.org>

x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
   =20
CONFIG_HAVE_BOOTMEM_INFO_NODE now essentially doesn't do anything.
So let's remove support for CONFIG_HAVE_BOOTMEM_INFO_NODE.

> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 1b17dcf781e66..ab4c5a02326f7 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c

[ ... ]

> diff --git a/mm/Kconfig b/mm/Kconfig
> index f794a341d7422..592003a258bad 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -590,7 +590,6 @@ endchoice
> =20
>  config MEMORY_HOTREMOVE
>  	bool "Allow for memory hot remove"
> -	select HAVE_BOOTMEM_INFO_NODE if X86_64

[Severity: Medium]
Since the intention of this commit is to remove support for=20
CONFIG_HAVE_BOOTMEM_INFO_NODE, should the definition of the config itself=20
also be deleted?

Currently, `config HAVE_BOOTMEM_INFO_NODE` remains in mm/Kconfig as a dead=
=20
`def_bool n` option. Additionally, `mm/bootmem_info.c` and its build rule=20
`obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) +=3D bootmem_info.o` in mm/Makefile a=
re=20
left behind as dead code.

>  	depends on MEMORY_HOTPLUG
>  	select MIGRATION
> =20

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the memory=20
hot-remove code in arch/x86/mm/init_64.c, I noticed that page tables and=20
vmemmap target pages appear to be freed to the buddy allocator before their=
=20
page table entries are actually cleared.

In arch/x86/mm/init_64.c:free_pte_table():

	/* free a pte table */
	free_pagetable(pmd_page(*pmd));
	spin_lock(&init_mm.page_table_lock);
	pmd_clear(pmd);

And similarly in arch/x86/mm/init_64.c:remove_pte_table():

			if (!direct)
				/* We never populate base pages from the altmap. */
				free_vmemmap_pages(pte_page(*pte), 0, NULL);

			spin_lock(&init_mm.page_table_lock);
			pte_clear(&init_mm, addr, pte);

Does this open a use-after-free race window where hardware page table walke=
rs=20
or speculative execution could access the recently-freed memory and interpr=
et=20
arbitrary data as page tables before the clear operation completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bootmem_in=
fo_part2-v1-0-156ce4986598@kernel.org?part=3D7
