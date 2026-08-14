Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC033C0610;
	Fri, 14 Aug 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719936; cv=none; b=n2L4pGe7qoLzTKZPYOC6kM2VC3vii88OSKGd/BHPU0EkIk11bsJcH6Nkjzup+hKpn2P98Ukx78X36wHiGOyYUyttEXywh6GNSqfoEyJMTot88zwJI1S7gSF+abc76fGJEaEi8hZ0XOI9f8i5QE06acVG/YhL1BU8qtWxjcedwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719936; c=relaxed/simple;
	bh=SelrbgT+9DlX/QXLtlXRGP5vSK5N3U0L5Izp0m2ufMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oe0mqu8rjr0/vfz1RJZ8xuhRMoYsThEn+BxpTD3F99VzA5TF9UbrlBHSQC/sml01tt9rrysj6gldsYzAWihGPVdlHd+2n/oC25B2/YAwXwYUhleVMf+W1gE/4T1E8Xe0pYIBiRVwsfR3O/FvzIzS6N+UTogmKstAmQbgX96q4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzeQug0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzeQug0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE961F000E9;
	Fri, 14 Aug 2026 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719935;
	bh=YdO5Cfjdsvaj0/XCKVQ1LYMZv68GR6T2IXrV/4p5dHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HzeQug0UkCY6mhdnLP4xXb23Uk8y4YW+7lLksxiW6y0BHSjKg2yOIcWBFd3tKrNjc
	 Oxnizo0BCgGyWduh3t0D16dZRg+oxmdC83DYttU2/BL0zB/hBYt7jbMwfNrUDMY+CN
	 1kEMyfiUMLzznI4iJMepRMWxEtwl+DZQ3y+Qo2vaw2JXQnkOWH4fGh+/HzkQVfZq6W
	 RFVtY61HsNrJxuB/eeujelrHXaqaF9aWVFN+Ep0OPOliC4/cB/JMDFcjy/e3BY+LcD
	 Dds0NHPHBVQrZtUMPwUZ/UXotsm0WYxVCvstijLaaJzyAu7BJUhg/zE6kkhlVVrep9
	 m+0FlHRIggTpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] KVM: s390: Fix potential race in
 dat_cond_set_storage_key()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814144041.169025-7-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
 <20260814144041.169025-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:05:34 +0000
Message-Id: <20260814150534.EAE961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Identical TOCTOU vulnerabilities remain in `dat_set_storage_ke=
y()`, `dat_reset_reference_bit()`, and `dat_get_storage_key()`.
--

--- Patch [6]: [PATCH v1 6/6] KVM: s390: Fix potential race in dat_cond_set=
_storage_key() ---
commit 5e22031091ce720a5918edc8a96db1b780f83398
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix potential race in dat_cond_set_storage_key()

This commit addresses a race window in dat_cond_set_storage_key() where a
large page could be concurrently split between the page table walk and the
dereferencing of the crste pointer. By reading the entry exactly once and
checking if it is still a leaf, it prevents passing an invalid physical
address to the storage key functions.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 7e5dd5a1eb1ef..b467b95689b21 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
[ ... ]
> @@ -725,7 +727,11 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cac=
he *mmc, union asce asce, gf
>  	if (!ptep) {
>  		if (!oldkey)
>  			oldkey =3D &prev;
> -		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), sk=
ey, oldkey,
> +		crste =3D READ_ONCE(*crstep);
> +		/* A large page has been split concurrently, try again */
> +		if (!crste_leaf(crste))
> +			goto again;
> +		return page_cond_set_storage_key(large_crste_to_phys(crste, gfn), skey=
, oldkey,
>  						 nq, mr, mc);
>  	}

[Severity: Critical]
This is a pre-existing issue, but do other functions in this file suffer fr=
om
the exact same TOCTOU race that this patch fixes?

Looking at dat_set_storage_key() in the same file, the pointer is dereferen=
ced
directly without a READ_ONCE() and leaf check:

arch/s390/kvm/dat.c:dat_set_storage_key() {
    ...
    page_set_storage_key(large_crste_to_phys(*crstep, gfn), skey.skey, !nq);
    ...
}

If a concurrent split occurs here, large_crste_to_phys() will return -1, wh=
ich
can result in an invalid physical address access.

Similarly, in dat_reset_reference_bit(), *crstep is dereferenced a second t=
ime:

arch/s390/kvm/dat.c:dat_reset_reference_bit() {
    ...
    skey->skey =3D page_reset_referenced(large_crste_to_phys(*crstep, gfn))=
 << 1;
    ...
}

Does this TOCTOU window also pass -1 to page_reset_referenced() if a concur=
rent
split happens between the read and the usage?

Finally, in dat_get_storage_key():

arch/s390/kvm/dat.c:dat_get_storage_key() {
    ...
    crste =3D READ_ONCE(*crstep);
    if (!crste.h.fc || !crste.s.fc1.pr)
        return 0;
    ...
}

Instead of retrying the walk via a goto loop like the fix in
dat_cond_set_storage_key(), it returns 0. Could this silently give a false
storage key to the guest if a race occurred?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144041.1690=
25-1-imbrenda@linux.ibm.com?part=3D6
