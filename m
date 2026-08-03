Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484033A9E1;
	Mon,  3 Aug 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776084; cv=none; b=EOzw8DDMu1oEfk45Fj5lkNzcUWN4n1S/lvq3wUtcXyUsWpD/ODMRxUh6sOloJDssTlUXP43x8XKrRSJh/PHbhBtEBt8Tvivk3WZoC8Xla7CW/OOzv3Ok327tT6y5o+cgFamvXKt4jRJ7su7MXZqrmHpo1oi0Il8YTb53AD+jFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776084; c=relaxed/simple;
	bh=p0pZLQTtelx59b+Pf9/y2lhD2o6Y+Nwjdr9DoSo70pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NMWJx3xHXyc0+K5+ESBrVRdHr+1uZS/DagI709neH/9QmMR6H6kov8XG+/XI1gMAS3F1qcnbj4h6cJkmt9jsOrYzxGmR9JVxKSKup0rvMaJHmjjVgvD8srIVeZUp6pQqV5BUGo2p2Ljj9ADPvsovBhYtLmfTzrRDpd3+Bara4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhtgsWXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhtgsWXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF771F000E9;
	Mon,  3 Aug 2026 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776083;
	bh=qkzaHMxmi2LDaGWBPoHeBjZIC34xYhc2sBmxv7XrWdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhtgsWXoU6eGWDqBOBDbG7rQDuAEfAACP1WGM2SNq2YMKtTmOMJXCLpsfzrU+ezLz
	 Y5wpBKXg16Y4rRgRgl4YCfOdtmbA7Jx32ddsikEGrVIjvNIByQ0p/AaopyY3xqkxo9
	 /oIehqITwX1vHu9YlfIMOMtphh4o621MJmFmnqMdeUsEIctgBnF3zH72Neua5bgUk8
	 kpgyrVURV0x4g1U8GSDN/WBNgEx9YlxsnKiA1hg5byBVmSnyllmYC8K8FPc9/6T7U5
	 cabUg2/DTz9F01a7JO9nmHr5oJiMlAas0g7/ugPtoRajhvUfWAhEp+INaOlpL2wsKk
	 J2e1x5mL50thw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 13/23] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260803160924.236807-14-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-14-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:54:41 +0000
Message-Id: <20260803165442.0AF771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unrecoverable memory leak of `vcpu->arch.mc` during vCPU creation =
failure in `kvm_arch_vcpu_create()`.
- [High] Leaked `stor_base` and `sida_addr` memory pages when Protected Vir=
tualization (PV) vCPU creation fails.
--

--- Patch [13]: [GIT PULL v1 13/23] KVM: s390: Fix kvm_s390_vcpu_unsetup_cm=
ma() ---
commit 4fc054529959a7d0bf80c4a0b469e82c4a224bb3
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
   =20
This commit fixes an issue where a zero cbrlo value could lead to an attempt
to free physical page 0 when V !=3D R. It resolves this by checking that cb=
rlo
is non-zero before calling free_page().

Link: <20260803124040.126471-4-imbrenda@linux.ibm.com>

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1b3290a5ad1ae..9be27db0a21e6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -3678,7 +3678,8 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_v=
cpu *vcpu)
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>  {
> -	free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
> +	if (vcpu->arch.sie_block->cbrlo)
> +		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
>  	vcpu->arch.sie_block->cbrlo =3D 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the vCPU
creation paths in this subsystem, I noticed a potential unrecoverable memory
leak.

In arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_create(), the mmu cache is
successfully allocated:

    vcpu->arch.mc =3D kvm_s390_new_mmu_cache();

However, if a subsequent operation fails and the function jumps to the error
path, it appears to miss freeing the cache:

    out_free_sie_block:
        free_page((unsigned long)(vcpu->arch.sie_block));
        return rc;

Does this leak the struct kvm_s390_mmu_cache and its internal allocations
when the core KVM code skips calling kvm_arch_vcpu_destroy() on an
arch-level creation failure?

[Severity: High]
This is also a pre-existing issue, but looking at the Protected
Virtualization code in arch/s390/kvm/pv.c, there might be another memory
leak during vCPU creation failure.

In kvm_s390_pv_create_cpu(), if the UV call fails, it attempts to clean up:

    if (cc) {
        u16 dummy;

        kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
        return -EIO;
    }

Because the handle is only populated upon success, it is still 0 during this
cleanup call. kvm_s390_pv_destroy_cpu() checks the handle and returns early:

    if (!kvm_s390_pv_cpu_get_handle(vcpu))
        return 0;

Could this leave the stor_base and sida_addr memory pages permanently leaked
if userspace repeatedly exhausts UV limits to fail the call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D13
