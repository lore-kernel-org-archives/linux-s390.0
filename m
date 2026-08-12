Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4429370AC0;
	Wed, 12 Aug 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543457; cv=none; b=NUNl3RSCPas169RdUlOGzZYfUKgWD+cmxXqCQT7BX6S7REwD1XH4lt/IIg7JqzhOz+dUsV4GoRLT7nkqiA6TGX8gz6iHltJAiRUFyrKzBCwfxFq7gvvnmwBzl1I8OGx1J5gyUrKmIPffXhI1S/8/QS7FyspGSt8KNKreZXT8l7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543457; c=relaxed/simple;
	bh=cQ5+3s4MtucDcSgrZM6TrHnroNbQxIxOSm2H9XhdCCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KAScBv31+IX3rdCFJh4Y2gjqinr0WNIPh4Gp3Uazp3KoBDxyO1BBhRzYHZqh1YgU0J+uE7kZMyqDUF29QEYaPpRV7OpQA051WrpaATQ83T9DvfsRY0s+twamCcFq/JCz6ek7fdHlW3h5uayAdVSWW+yHOZ/56m4Np36hqqBwax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jufI6dX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jufI6dX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04BE1F000E9;
	Wed, 12 Aug 2026 14:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543456;
	bh=Nbn0df3+G2NIslIIjfg0jCLTUKPShSLgzvTfAlLwNjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jufI6dX7WNu7WS3Pv/f/WA0/v5+JoU65vgTvtQyc/kqZzjqu2er52R/IqOji1we50
	 45nZzvgA+7iwC/u3GT4IbNm47IbW+LYsSyvM0PHjBZ5pKc0hvC0ZtPB+rM6gmei43G
	 xDFYDSB5XpXrTZyvSRkQllCFUdXlMCgDmR3qVCQbfxXN8bde5Lfc+orvikKRMHMntc
	 n0sW2kSVsbo6dgk80KKCw6a1t1ZgP+NWzZimPYTVyywuKiZeQ+4PahO3c9N3ngcPiM
	 rlIz1MV6NHV2wQAV1/ZspdY/+cLcNKuxOYEUMqrwB3krXtfjC/hjfnDgVg2HwPaWis
	 RwMaTmeliOwZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/20] KVM: s390: vsie: Create helpers to alloc and
 free vsie_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-8-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-8-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:04:15 +0000
Message-Id: <20260812140415.E04BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When KVM recycles a `vsie_page` for a nested guest, it only zeros =
the `scb_s` field, leaving the `crycb` struct retaining data from previous =
executions. If an L1 guest runs an L2 guest with a format 2 CRYCB, `setup_a=
pcb11()` populates the full `apcb1` array. If the page is subsequently recy=
cled for an L2 guest with a format 0 or 1 CRYCB, `setup_apcb10()` only over=
writes the first elements (`apm[0]`, `aqm[0]`, `adm[0]`). Since KVM uncondi=
tionally sets `CRYCB_FORMAT2` for the shadow SCB, the hardware reads the fu=
ll `apcb1` array, unintentionally granting the second nested guest AP (cryp=
to) permissions from the first guest.
--

--- Patch [8]: [PATCH v4 08/20] KVM: s390: vsie: Create helpers to alloc an=
d free vsie_pages ---
commit 14607902bebe42835f13bc9f13b042b6aeeaca0f
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Create helpers to alloc and free vsie_pages

This commit encapsulates the allocation and freeing of vsie_page
structures into their own helper methods. This refactoring enables these
operations to be called from multiple code paths.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c935a375f57ca..805d28f0e7058 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -1558,9 +1576,9 @@ static struct vsie_page *get_vsie_page(struct kvm *=
kvm, unsigned long addr)
>  		if (vsie_page->scb_gpa !=3D ULONG_MAX)
>  			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
>  					  vsie_page->scb_gpa >> 9);
> +		/* Mark it as invalid until it resides in the tree. */
> +		vsie_page->scb_gpa =3D ULONG_MAX;
>  	}

[Severity: High]
This is a pre-existing issue, but when a vsie_page is recycled here in
get_vsie_page(), only the scb_s field is zeroed later in the function:

arch/s390/kvm/vsie.c:get_vsie_page() {
    ...
    memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
    ...
}

The crycb struct at offset 0x06f8 is left uninitialized and retains data
from previous guests.

If an L1 guest runs an L2 guest with CRYCB_FORMAT2, setup_apcb11()
populates the full apcb1 array. If the page is subsequently recycled by
get_vsie_page() for an L2 guest with CRYCB_FORMAT1, setup_apcb10() only
overwrites the first elements:

arch/s390/kvm/vsie.c:setup_apcb10() {
    ...
    apcb_s->apm[0] =3D apcb_h->apm[0] & tmp.apm[0];
    apcb_s->aqm[0] =3D apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
    apcb_s->adm[0] =3D apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
    ...
}

Because shadow_crycb() sets CRYCB_FORMAT2 unconditionally in the shadow SCB:

arch/s390/kvm/vsie.c:shadow_crycb() {
    ...
    scb_s->crycbd =3D (u32)virt_to_phys(&vsie_page->crycb) | CRYCB_FORMAT2;
    ...
}

Will the hardware read the full apcb1 array, unintentionally granting the
second nested guest AP (crypto) permissions from the first guest?

> -	/* Mark it as invalid until it resides in the tree. */
> -	vsie_page->scb_gpa =3D ULONG_MAX;
> =20
>  	/* Double use of the same address or allocation failure. */
>  	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_pag=
e)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D8
