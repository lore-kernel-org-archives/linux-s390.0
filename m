Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793683;
	b=wxqa1cIwDYc4Fqi9YVKUL+1+u1kIBwY92TtkMTcXzuw9xaXgl1KA4881jk2FEq2S3pwc
	 CMs3Jhs+aC0cvgxYem83Cm4HmBk/v91THhVKF1HyoJvnszy7EaaSGDAJWg3pXPMlBded2
	 uMyYtcMYZbYJx+VOY1pcZI1tN8qVtPN6BKAReO60MeyEvVTAzkwpWVsFcVP8WLS5ojXsi
	 VNHZMc1ZaHBd5JNO+V3RHi6gkrUJzriV4KiFOpoJdtKQbTu3qCNZQXTI+Ag7ahagxKjG1
	 mlYRvdoMhMDEQxt8XgLi/u0Pw8N/4Q/AQ/vtjkNAKFyzrd7wDim+7W69Z0vpv5LdUmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dCxmJA+bOtAUrHZAkdzDbo5hhy+22EkKgE3jLjCcZjw=;
	b=DFYJZ3Y69f7gSJHHQjIzw087n350B4wDfz0CfWeIl28lINJCmjcHoa6bzyS70a5KBpcD
	 whpNwnqJgZPC+yF6QzZAtkWggT8ME8hVgHRkbKiWSN3mOvkxGTMfSHfp1bbGE7xGaWrE6
	 7DSC6utS0SnzouiRD60DFlU+ui61vdHGHAZUk3QZE0ur7B2Fo4knwXvmzCfUR+aasKwyX
	 1IRqeq3aKp5pcWGM869QLtsTXWHdHDvvXSVpDHgakVLPtYDHH6QMQj08d8mcdy+HB8jh1
	 9XWjSj8X98iTSyV7wOsD4fppZUg3nCfD/ucyNVVEkdVkWtTBxcvR6FDEYcBYF4yEklw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooW7Rt2l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC32606A31C;
	Fri, 27 Nov 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooW7Rt2l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720271F0089F;
	Fri, 27 Nov 2026 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793682;
	bh=dCxmJA+bOtAUrHZAkdzDbo5hhy+22EkKgE3jLjCcZjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ooW7Rt2l2Gj5sZD/ofrMPdrhCiiV4FIkO8Yga2VsB7ff/tQREgYIHBNH0AE/NCCD3
	 2Z3tVRBULJnfKncMlOEmET15XGWw+4+BrSGzqJhs7LpQF2AafyVNySYKzLlxMA4slJ
	 7i+pSTl6uV6W8zRhhNcXaUYolkWWeC8X9Y15R4wxIZ1L3XbLFUi+TIC6aadrtLk8aT
	 0/fa6+RNHS0MYEMAQB6XdzHtovXXwRtahGej6YaGcTlFHD1Vj7xWn1yahp4VO+v6dJ
	 WPoSGTROxaRFDl3SUehe3CZiTZkeitI6ggOQz6fabG8eG7QfhVKWads42kRczfUvz9
	 3cFaSXbk4kTBQ==
Message-ID: <sashiko-outbox-237754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/12] KVM: s390: Allocate page tables when CMMA is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127150411.221072-5-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
 <20261127150411.221072-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:34:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: s390: premature GMAP_FLAG_USES_CMM publication in
  gmap_enable_cmm()
--

commit 4eafe3dbf444099ded4397c5a1073f2aff0effc2
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Allocate page tables when CMMA is used

This commit calls gmap_enable_cmm() on the first ESSA intercept or
KVM_S390_SET_CMMA_BITS ioctl to preallocate page tables and split large
page mappings, and rejects KVM_S390_SET_CMMA_BITS on ucontrol VMs.

> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index f22612a127c96..e66fec89ac788 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
> @@ -1243,14 +1243,15 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
>  		/*
>  		 * CMMA is enabled in the KVM settings, but is disabled in
> -		 * the SIE block and in the mm_context, and we are not doing
> -		 * a migration. Enable CMMA in the mm_context.
> -		 * Since we need to take a write lock to write to the context
> +		 * the SIE block and in the gmap, and we are not doing a
> +		 * migration. Enable CMMA in the gmap.
> +		 * Since we need to take a mutex to write to the gmap
>  		 * to avoid races with storage keys handling, we check if the
>  		 * value really needs to be written to; if the value is
>  		 * already correct, we do nothing and avoid the lock.
>  		 */
> -		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> +		if (!uses_cmm(vcpu->arch.gmap))
> +			gmap_enable_cmm(vcpu->arch.mc, vcpu->arch.gmap);
>  		/*
>  		 * If we are here, we are supposed to have CMMA enabled in
>  		 * the SIE block. Enabling CMMA works on a per-CPU basis,

[Severity: Medium]
Can a second vCPU observe uses_cmm(vcpu->arch.gmap) =3D=3D true before
gmap_enable_cmm() has finished allocating page tables and splitting large
pages?

gmap_enable_cmm_already_locked() sets GMAP_FLAG_USES_CMM before walking
the memslots:

arch/s390/kvm/gmap/gmap.c:gmap_enable_cmm_already_locked() {
	if (uses_cmm(gmap))
		return;

	set_bit(GMAP_FLAG_USES_CMM, &gmap->flags);
	...
	kvm_for_each_memslot(ms, bkt, slots) {
		...
		for (gfn =3D start; gfn < end; gfn +=3D _PAGE_ENTRIES) {
			if (kvm_s390_mmu_cache_topup(mc))
				return;
			guard(write_lock)(&gmap->kvm->mmu_lock);
			...
			dat_entry_walk(mc, gfn, gmap->asce, flags, ...);
		}
	}
}

Because both handle_essa() and gmap_enable_cmm() check uses_cmm()
locklessly before taking slots_arch_lock, another vCPU intercepting on
ESSA while the memslot walk is in progress can skip gmap_enable_cmm() and
re-enter SIE with ECB2_CMMA enabled:

CPU0                                  CPU1
handle_essa()
  gmap_enable_cmm()
    mutex_lock(&slots_arch_lock)
    gmap_enable_cmm_already_locked()
      set_bit(GMAP_FLAG_USES_CMM, ...)
                                      handle_essa()
                                        if (!uses_cmm(...)) -> false
                                        sie_block->ecb2 |=3D ECB2_CMMA
                                        kvm_s390_retry_instr()
                                        <re-enters SIE and runs ESSA
                                         on unvisited segments>
      kvm_for_each_memslot(...)
        dat_entry_walk(...)

CPU1 then executes ESSA in hardware on segments that still lack page
tables or have unsplit large pages, triggering segment translation faults
and faulting in backing hugepages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127150411.2210=
72-1-imbrenda@linux.ibm.com?part=3D4
