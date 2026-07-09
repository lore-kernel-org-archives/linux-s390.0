Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BB312825;
	Thu,  9 Jul 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606171; cv=none; b=TyFMZc5njtlqTo9SQzHWqwKwsFBnhvhJg6f/6aW+oDZrt2PU79hEq+9arDPHhQLRCVrWV3QJgH17llS1jfu2HLVMkYzU3cpoWVNTuKbRmwEarvLula3sA6r0ETcIiIvWbCYr01Th4nUbm3dvO8AhBiZaEojqXj8+DX61A2VKCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606171; c=relaxed/simple;
	bh=vRmhWWKAB9d+YtMpB3+J8kuOHmaJqUZtp/apnb4FltQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YsTWhE7BYNS6VIZpsyfuOEj5b4TsjTSAmhtBrpch9R/Q38Hl9CDDrr08svyni2WfIQS2a5Jxa1CQLKdfmQLJYjAkyMhXZRWhBj2Dg+L7cSbU1/b07OfPqOU1J44PywtTXZEa4vuigvpmYtBRvPplVevzjnVtVhHLwH/NGdhc0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhZQlxcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhZQlxcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4241F000E9;
	Thu,  9 Jul 2026 14:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606170;
	bh=TXVvdxcXeATy//QnGOBaFqatq7A0To30xQbihef8nfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QhZQlxcvO7/JBlFCG5w4C8/Qs8JB2ZgA6uGuzY6IrWVQFMSIZ0f+55p9zTyTZPrdh
	 +wPwdKaEmMUUJ9+uoQkvCf5MgMZX/4Q/QSqGAwLolQKLG0kJ5CMxI/bWoq/Z6ISuzN
	 5bHEGqEbxjPfNysBS9ENYzqSc/XKJ5maexqWFAnhA0Qx+PeCf3i0QL4UwBzuXWqW9B
	 326Pr0fDZQCjv82dLuHAOtqPFbsqsz+7xJ1QDGYMkJS5DMKkgJaarI2j4ZO/1teXbE
	 ZokvhQ2dTAmF9ozAMhi87kYxw7nLMK9Osm1PmCuAQNNoN6QFU9wQmdVb9N9kvsr0ZA
	 megYHHOA3vc2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: pci: Fix handling of AIF enable without AISB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Rosato" <mjrosato@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260709135404.2255136-1-mjrosato@linux.ibm.com>
References: <20260709135404.2255136-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:09:29 +0000
Message-Id: <20260709140929.CA4241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing state check allows repeated `KVM_S390_ZPCIOP_REG_AEN` =
ioctls to leak resources and create dangling pointers.
- [Critical] Unvalidated guest-supplied offsets for the Adapter Interrupt B=
it Vector (AIBV) can cause the host firmware to write beyond the pinned pag=
e boundary.
- [High] Error paths for `account_mem` and `airq_iv_alloc_bit` do not set a=
n error code, leading to silent failures, and bypass memory accounting roll=
back.
- [High] Unchecked return value of `airq_iv_create()` leads to a kernel NUL=
L pointer dereference on memory exhaustion.
- [High] The memory accounting functions `account_mem()` and `unaccount_mem=
()` leak a reference count to the `user_struct` on every call.
- [High] Failure in hardware configuration via `kvm_zpci_set_airq` bypasses=
 local cleanup labels, leaving resources allocated.
--

--- Patch [1]: [PATCH] KVM: s390: pci: Fix handling of AIF enable without A=
ISB ---
commit 770cb99be23b8c546be19f495246867591501586
Author: Matthew Rosato <mjrosato@linux.ibm.com>

KVM: s390: pci: Fix handling of AIF enable without AISB
   =20
When a guest seeks to register IRQs without a summary bit specified,
ensure that the associated GAITE then stores 0 for the guest AISB
location instead of virt_to_phys(page_address(NULL)).
   =20
Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabli=
ng interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 686113be05309..720bb58cabe2e 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -300,9 +300,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
> =20
>  	gaite->gisc =3D fib->fmt0.isc;
>  	gaite->count++;
> -	gaite->aisbo =3D fib->fmt0.aisbo;
> -	gaite->aisb =3D virt_to_phys(page_address(aisb_page) + (fib->fmt0.aisb &
> -							      ~PAGE_MASK));
> +	if (fib->fmt0.sum =3D=3D 1) {
> +		gaite->aisbo =3D fib->fmt0.aisbo;
> +		gaite->aisb =3D virt_to_phys(page_address(aisb_page) +
> +					   (fib->fmt0.aisb & ~PAGE_MASK));
> +	} else {
> +		gaite->aisbo =3D 0;
> +		gaite->aisb =3D 0;
> +	}
>  	aift->kzdev[zdev->aisb] =3D zdev->kzdev;
>  	spin_unlock_irq(&aift->gait_lock);
> =20

[Severity: High]
This is a pre-existing issue, but does this error path properly set an error
code and roll back accounting?

In kvm_s390_pci_aif_enable():

    if (account_mem(pcount))
        goto unpin2;

    /* AISB must be allocated before we can fill in GAITE */
    mutex_lock(&aift->aift_lock);
    bit =3D airq_iv_alloc_bit(aift->sbv);
    if (bit =3D=3D -1UL)
        goto unlock;

If account_mem() fails, rc appears to remain 0.

If airq_iv_alloc_bit() fails, the code jumps to unlock and falls through to
unpin2. This successfully unpins the pages but bypasses unaccount_mem().

Does this permanently leak the user's memory limits?

[Severity: High]
This isn't a bug introduced by this patch, but does the return value of
airq_iv_create() need validation here?

In kvm_s390_pci_aif_enable():

    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
                                AIRQ_IV_BITLOCK |
                                AIRQ_IV_GUESTVEC,
                                phys_to_virt(fib->fmt0.aibv));

If airq_iv_create() returns NULL under memory pressure, zdev->aibv is
assigned NULL.

Immediately after, kvm_zpci_set_airq() is called, which appears to
unconditionally dereference it:

kvm_zpci_set_airq() {
    ...
    fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...

Could this lead to a NULL pointer dereference?

[Severity: Critical]
This is a pre-existing issue, but does the ioctl handler check if AEN is
already enabled before allowing another registration?

Looking at kvm_s390_pci_zpci_op():

    r =3D kvm_s390_pci_zpci_reg_aen(zdev, args);

If a guest repeatedly calls the KVM_S390_ZPCIOP_REG_AEN ioctl, it
unconditionally invokes kvm_s390_pci_aif_enable().

Inside kvm_s390_pci_aif_enable():

    zdev->aisb =3D bit;
    zdev->aibv =3D airq_iv_create(...);

Is it possible this overwrites previous bit indexes and pointers without
cleaning up the old resources? This looks like it might leave dangling
pointers in the global aift->kzdev array for the overwritten bits.

[Severity: Critical]
This isn't a bug introduced by this patch, but does this code restrict the
guest-provided offset within the single pinned page?

In kvm_s390_pci_aif_enable():

    npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
    ...
    gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);

Since only 1 page is pinned, if the guest offset plus the required interrupt
vector size exceeds the page boundary, can the hardware adapter end up
writing interrupt bits into unpinned host memory?

[Severity: High]
This is a pre-existing issue, but do these accounting functions leak a
reference count?

In account_mem():

    struct user_struct *user =3D get_uid(current_user());

And in unaccount_mem():

    struct user_struct *user =3D get_uid(current_user());

Both functions call get_uid(), which increments the reference count, but
they do not appear to call free_uid() to release it.

Additionally, unaccount_mem() uses current_user(), which might not be the
same user who originally accounted the memory if AEN is disabled by a
different process. Are we at risk of mismatched locked_vm accounting?

[Severity: High]
This isn't a bug introduced by this patch, but does an error from
kvm_zpci_set_airq() bypass the cleanup paths?

In kvm_s390_pci_aif_enable():

    /* Issue the clp to setup the irq now */
    rc =3D kvm_zpci_set_airq(zdev);
    return rc;

unlock:
    mutex_unlock(&aift->aift_lock);
unpin2:
...

If kvm_zpci_set_airq() fails, the function returns directly. Should the
function jump to the cleanup labels instead to prevent leaving pages pinned
and structures like airq_iv permanently allocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135404.2255=
136-1-mjrosato@linux.ibm.com?part=3D1
