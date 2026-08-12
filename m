Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF634EEFD;
	Wed, 12 Aug 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532113; cv=none; b=cQjW3JqV9ukb5LO9MFuNQ0KPXFWJx8k3vTqctfmg8v9nps5R8Y/dkSFWXvJRopT3W2ILb9rnxvNk2VrqNhIJF6l8ge54q56uiSpfRQH9aYwagnQjDbxXhRLMuEhiA7lKXFSpOXXoqzcNgSmAbBmGZ4lMsG+Vj+H+/SWnhKKX3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532113; c=relaxed/simple;
	bh=pcxdqZEIitZeyjTIl76WzocWHsB5dZTeqkdhri0JWXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qE+9g9jPQ9Z1dDLSmYhE6YPhxG6mE4LfiC2EHe+MRl1AoOpS/FIcgxhXZGhUR2sEE0/yMSwhAQxdbnpaAsO9KhTKoWCixLfUCGdLbaXhmTXebCyeWOXWV3dicxP1tKEzasQLMBy3PpR/aARAu2MRT+q7AjbhKHqEqtLotMBVde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDimuOoR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDimuOoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7005F1F000E9;
	Wed, 12 Aug 2026 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532112;
	bh=WzpvRYCyd1BTZk39Dgf18X63hAU+hP80NTPD7zIAr3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDimuOoREecKxT710bWq3G7PfKR88S7u08VaXKZmBNpkZGmDajlFasdI/LvSwWGjp
	 KCdM5uKlcIwi8D1G/CQnWxN/emyRv+nFUlobJJJr9sZ0ucIf4uUHITtn6Z0EOz64tJ
	 yEpSWRpFKGF/x96uni1DUpSusJ+uiGFlyOWtxP7temq5C6laPJTAutnZB416pOO+mI
	 TplID7BYlWQzwJ+FUeHMkyoWbzdLPl7LqBSLW1eGD1FJwgxTx8Bcmn8a1TAeCDUlv2
	 CyU+6ZTz56MEtFq3b7OqQiD/pdwm/16JfTgJFSyUsZV6vwoO0vlI4g9i7Un/OdgiGT
	 86lPuQBEWpnwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] KVM: s390: Properly handle NULL pointer in
 dat_cond_set_storage_key()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812104436.109741-2-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:55:10 +0000
Message-Id: <20260812105511.7005F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Storage key reference and change bits are lost when executing SSKE=
 with MR (Merge Reference) or MC (Merge Change) flags.
- [High] Race condition when updating hardware storage keys on huge pages (=
lockless read-modify-write).
--

--- Patch [1]: [PATCH v2 1/9] KVM: s390: Properly handle NULL pointer in da=
t_cond_set_storage_key() ---
commit 4e6ac296606202ca3143d3677ec8bf9361312ec5
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()

Some callers pass NULL as oldkey. This commit checks for NULL and assigns=20
the pointer to a dummy local variable before calling=20
page_cond_set_storage_key(), preventing a NULL pointer dereference.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 3f2d6e8902d76..165c704fcf299 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -722,9 +722,12 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cac=
he *mmc, union asce asce, gf
>  	if (rc)
>  		return rc;
> =20
> -	if (!ptep)
> +	if (!ptep) {
> +		if (!oldkey)
> +			oldkey =3D &prev;
>  		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), sk=
ey, oldkey,
>  						 nq, mr, mc);
> +	}

[Severity: High]
This is a pre-existing issue, but does calling page_cond_set_storage_key()
for huge pages lack synchronization?

For regular pages, this function acquires pgste_get_lock() below to
serialize updates. However, for huge pages, page_cond_set_storage_key() is
called directly without a per-page lock.=20

Since page_cond_set_storage_key() performs a non-atomic read-modify-write by
executing page_get_storage_key() and later conditionally updating it with
page_set_storage_key(), can concurrent executions interleave and cause lost
storage key updates or lost change bits?

[Severity: High]
This is also a pre-existing issue, but do we lose the guest's reference and
change bits when the merge reference (mr) or merge change (mc) flags are
true?

In page_cond_set_storage_key(), if the new key differs from the old key, it
calls:

    page_set_storage_key(paddr, skey.skey, !nq);

The skey parameter does not logically OR the old reference and change bits
from oldkey when mr or mc are true. Since this writes directly to hardware,
won't the old hardware bits be permanently overwritten and lost?

Additionally, lower down in dat_cond_set_storage_key(), the software
tracking bits are unconditionally overwritten:

    pgste.gc =3D skey.c;
    pgste.gr =3D skey.r;

Could these assignments also drop the old.gc and old.gr bits when the merge
flags are set, potentially leading to a situation where a guest OS discards
a dirty page believing it to be clean?

> =20
>  	old =3D pgste_get_lock(ptep);
>  	pgste =3D old;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D1
