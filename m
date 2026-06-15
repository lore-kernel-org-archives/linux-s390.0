Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEA3ECBEA;
	Mon, 15 Jun 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528725; cv=none; b=MsfdBfWZDD5jDrPt2WFZb3nLTfUlYMY/JT2Ty1BIm1TYRAR6S6gFfTvzN/vlyMIYXkX2A1Ck0InOjmeICTj12ic9USBgw7ORwS7c4aXp0a21iizdPG0HRNaKZBwBBAckFe5up1sICmTLkXC5pfzLxBC5Ks09tvhbhni7bMqjRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528725; c=relaxed/simple;
	bh=tCHNsusSp8NhTYMBilkODGANQcZ89jbCK7Wb5eQYQ3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u960GWTDE6X0ACw+pmmBRntRNI1aNKlQQBAokV4wF4eLhHxIIXuZ2/4BZZo2ZPmMGK7QrkgHmtF+QqdGBzjIpbiOwp2fhZUaJio6shRg9HtPev7RknKHRXS6fx3qKNCS2Tnf7RarglbGLJptnxsOPVUCrrCChsi5oiL03iLUeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5KBypGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5KBypGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00D21F00A3A;
	Mon, 15 Jun 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528724;
	bh=ZozzbB0cPdVmT1WKgILVIrojf5AgjvK8zIaHhlsybUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5KBypGAkPRAjT3iafNeHVTptKPXwoDhSSHItIpZWVhoTkNn7FEOk0R9LuRBt7rwj
	 Zrx4XRVU1dUvBoHoN5ZDWuKyrry+r6LOFtWovXcykYL/w6CiYSsSNTOxCeszCabVDv
	 39rgKhPX6LhgN4qYOucOO6KweE/TiOMohbWBzyuNyPS98cRRNHZdybgatjnsmrFdu2
	 M5ghlvMGNdawsL5JOn3NmzFns4zFLRNsYcOCW3xMlz8JiGALkIqOjDjfJK8vu8bZ0n
	 aG1NFXOJLtZIxO1EaP8WA6QLvQo7k6eNixQd61EFjwYAR3p5VN5UuKge/feZd02dDO
	 omFiB3ldtdbKQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 07/17] KVM: s390: Add capability to support 2G
 hugepages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260615124243.187614-8-imbrenda@linux.ibm.com>
References: <20260615124243.187614-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:05:23 +0000
Message-Id: <20260615130523.E00D21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Userspace can simultaneously enable both CMMA and huge pages (1M a=
nd 2G), bypassing mutual exclusivity, because KVM_S390_VM_MEM_ENABLE_CMMA d=
oes not check if huge pages are already enabled.
--

commit 98eba733f54412a163121c369883f11ed5ca35db
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Add capability to support 2G hugepages

This commit adds the KVM_CAP_S390_HPAGE_2G capability to signal to userspace
that 2G hugepages may be used to back the guest. It also implements the
necessary gmap flag enablement and propagation for the new hugepage size.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 49c330580dc88..35e5971a474f6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -902,6 +907,27 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct =
kvm_enable_cap *cap)
>  		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_HPAGE %s",
>  			 r ? "(not available)" : "(success)");
>  		break;
> +	case KVM_CAP_S390_HPAGE_2G:
> +		mutex_lock(&kvm->lock);
> +		if (kvm->created_vcpus) {
> +			r =3D -EBUSY;
> +		} else if (!hpage_2g || kvm->arch.use_cmma || kvm_is_ucontrol(kvm)) {

[Severity: High]
This is a pre-existing issue, but could userspace bypass this mutual
exclusivity check between CMMA and huge pages?

When enabling huge pages via KVM_CAP_S390_HPAGE_1M or KVM_CAP_S390_HPAGE_2G,
KVM correctly rejects the operation if kvm->arch.use_cmma is already set.

However, if userspace enables huge pages first, and then enables CMMA,
kvm_s390_set_mem_control() does not appear to verify if huge pages are
already active:

arch/s390/kvm/kvm-s390.c:kvm_s390_set_mem_control() {
    ...
    case KVM_S390_VM_MEM_ENABLE_CMMA:
        ...
        mutex_lock(&kvm->lock);
        if (kvm->created_vcpus)
            ret =3D -EBUSY;
        else {
            kvm->arch.use_cmma =3D 1;
            /* Not compatible with cmma. */
            kvm->arch.use_pfmfi =3D 0;
            ret =3D 0;
        }
        mutex_unlock(&kvm->lock);
    ...
}

Does this sequence allow the guest to run with both kvm->arch.use_cmma
and GMAP_FLAG_ALLOW_HPAGE_2G (or 1M) enabled simultaneously?

If so, and the guest executes the ESSA instruction on a huge page, would
this lead to KVM entering an infinite intercept loop that stalls the vCPU,
or cause undefined hardware behavior if migration mode is inactive?

> +			r =3D -EINVAL;
> +		} else {
> +			r =3D 0;
> +			set_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &kvm->arch.gmap->flags);
> +			/*
> +			 * We might have to create fake 4k page
> +			 * tables. To avoid that the hardware works on
> +			 * stale PGSTEs, we emulate these instructions.
> +			 */
> +			kvm->arch.use_skf =3D 0;
> +			kvm->arch.use_pfmfi =3D 0;
> +		}
> +		mutex_unlock(&kvm->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D7
