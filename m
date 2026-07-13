Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E63914E0;
	Mon, 13 Jul 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956602; cv=none; b=s/Wlb3f/+t4AAotTJagwayiAv6/J3Q1mpZ9jVtjYzkG8cUygVTnlGLCJ/AKaUbF90G04gG+dkpdokPBKzvklcRiD3nuJ5fv/Eu45V9I7pwODTGl9c6asuNHTJbT/3DSwEPiXhoM4uGbZ4u2ZrjegYEerjuZ9b94tmsqC12pn//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956602; c=relaxed/simple;
	bh=oy/Tqq4XcTBCulcsFZWd773SuCRHvJBHsBVHHqAIv6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAdgub/uyo+tnt+K5BKA7cDyNVPbakwSuNlje3mPpcCN1QpVZzBLWRkSaoN8aEugfgfiZzTeEMgZVcR2YfUlpUySptB2oC0sSEyhTGliqsam1UXTq99TXOcLIbzbrx93/Sz3+SPrDiFiwJ3m9SUF+2prY9O9Qz4O1bsSWYIgRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KadTou72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KadTou72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5C71F000E9;
	Mon, 13 Jul 2026 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956601;
	bh=MJOO1NWY46zrORn66Zmaqh5yEBKXn2Gn2/JA88xTPz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KadTou72bINTMt+/RP7yq4Ak0pbpNLJEIXIBVMvWZH8ZbmhSW9xlJFwzT+hKAq/jj
	 b+DH9ermfzfh/WGk6CfzFGl/JvSRKn8UfEWumnihAN9BBF0hBOD9l4sXRjhVBfGUv3
	 oaWkQ47S+lDwOP9MzMq+HqrL9MS17lr/kB2MgwtBs7o29vkcEet55eZ/+sDthjopnb
	 WRf3ya7+F7VeQOMzh435GXtH0JNeHHbKJ/tpgWoKoPZujHjrxWf0vR5J21XHr+PZ/A
	 aFJj3rcLt0z4veJPcLbYRIxyoo2UwTaVutB8cLy3nAq6GqxhN4YHOgiDJy681iNrVy
	 dBuwo3QrsZajQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] KVM: s390: ucontrol: Add missing locking around
 gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713150857.269954-6-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:29:59 +0000
Message-Id: <20260713153000.AB5C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a scoped_guard() into a function that already =
uses goto-based error handling.

Pre-existing issues:
- [High] Missing cleanup for vcpu->arch.mc in the error paths of kvm_arch_v=
cpu_create().
- [High] Preexisting memory leak of vcpu->arch.pv.stor_base and sida_addr i=
n kvm_s390_pv_create_cpu() on UV call failure.
--

--- Patch [5]: [PATCH v2 5/7] KVM: s390: ucontrol: Add missing locking arou=
nd gmap_remove_child() ---
commit 08ba9ce959b1a049a33ef520bb8230d16cec1943
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()

This commit adds missing locking for the parent gmap's children_lock when
calling gmap_remove_child(). This fixes an issue in the error handling path
of kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -3866,7 +3866,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  out_ucontrol_uninit:
>  	if (kvm_is_ucontrol(vcpu->kvm)) {
> -		gmap_remove_child(vcpu->arch.gmap);
> +		scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
> +			gmap_remove_child(vcpu->arch.gmap);

[Severity: Low]
Does this mix scoped_guard() with goto-based error handling?

The cleanup guidelines suggest converting all resources that need a goto=20
cleanup to scope-based cleanup, or converting none of them, rather than=20
mixing them in the same function.

>  		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
>  	}
>  out_free_sie_block:
>  	free_page((unsigned long)(vcpu->arch.sie_block));
>  	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but does this error path leak vcpu->arch.mc?

When kvm_arch_vcpu_create() allocates vcpu->arch.mc via=20
kvm_s390_new_mmu_cache(), does the out_free_sie_block path miss freeing it=
=20
before returning rc?=20

Since kvm_arch_vcpu_destroy() isn't invoked on creation failure, it seems=20
vcpu->arch.mc might remain permanently allocated.


[Severity: High]
This is a pre-existing issue, but does kvm_s390_pv_create_cpu() leak=20
vcpu->arch.pv.stor_base and sida_addr if uv_call() fails?

In arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu():

    if (cc) {
        ...
        kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
        return -EIO;
    }

If this fails, it calls kvm_s390_pv_destroy_cpu():

arch/s390/kvm/pv.c:kvm_s390_pv_destroy_cpu():

    if (!kvm_s390_pv_cpu_get_handle(vcpu))
        return 0;

Since vcpu->arch.pv.handle is only populated on the uv_call() success path,=
=20
will this return early and skip cleaning up stor_base and sida_addr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D5
