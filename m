Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B71A3172;
	Thu,  9 Jul 2026 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611168; cv=none; b=O4dD2UDPdeeiBGcfiXa/9QTaomtqY2rXUkgH8zRh58zd0r/3az8fh0m7kCy5OMs8SkGCxie0gvU4eSaxZsW/3JMYmCpr7sfTmzZM4I6twMolEkIrNgh6RxZYLgfHh9xEn1r7epQXbm4y8UQjSCEXaUIMm03oExlkY0ym/iXpXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611168; c=relaxed/simple;
	bh=rwSIc0Aw0nIRImN74d+g5NhbNIl0uwcH/lNLZ3CVRvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RYzd/CnWZPz2AEMzsm6/Md0ed1WUwREFgFS/JrEbSemQLA7k8ZRgG8isS27ov+ELp4cFOhwooWw3mjgvN64GwiuiNzXXFsqA6VMEhRZmqxLoGiwJQkd1REB6Xf3L7auouopI660HNOI0VvT9Vbl+7UQijgaCOs+4a+Fz/hY4anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYMxmc3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYMxmc3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901391F000E9;
	Thu,  9 Jul 2026 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611166;
	bh=cZhJBEq2mkXxmx9ex+z8p/FOM5ls4WmAB4iNumSJpdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYMxmc3UT4YQ6BK1z1O75Mt7Ths+agw8hicbkcobXLoY3TjwlaSnRmBw6TpMeeOPP
	 /lx/xdi7fgpbgHUIrHwgHRvkGIoFMNk0Cegxvw+KcBf37mwX/vc5Crqls3w58BDEI1
	 KCVDLZkA6zveyguuU5NXvsVsKqCN5lJ5/NGXoUs25nAd1LFjIwu1r8E8ho389QR8PU
	 CF1eAXAiuJmMwes9X9jclBBzAgAEeDMXLcCPiEh9GWJvuvHQaKjRIBSvYdQB94GWT6
	 h0jynlswy5pEE8qqzpjth+V/mm4PTvfRsOhVWKBWnuGfDmyw4/91HemWAnQbSYlg6A
	 gJ2W8KWf8yBZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/21] KVM: s390: vsie: Add vsie_sigpif detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-6-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-6-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:32:46 +0000
Message-Id: <20260709153246.901391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Truncation of host physical address in read_scao leads to use-=
after-free and memory leak.
- [High] Lost validity intercept during VSIE SCAO validation failure.
--

--- Patch [6]: [PATCH 06/21] KVM: s390: vsie: Add vsie_sigpif detection ---
commit 5159ce1359458442d26eeb7031f94445e04e2d6a
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add vsie_sigpif detection

Add sensing of the VSIE Interpretation Extension Facility as vsie_sigpif
from SCLP. This facility is introduced with IBM Z gen17.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index eea24562e7db2..97581b748a94d 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -72,6 +72,27 @@ struct vsie_page {
> =20
>  static_assert(sizeof(struct vsie_page) =3D=3D PAGE_SIZE);
> =20
> +static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
> +{
> +	return (scb->ecb2 & ECB2_ESCA);
> +}
> +
> +static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_bloc=
k *scb)
> +{
> +	unsigned long vsie_sca =3D READ_ONCE(scb->scaol) & ~0xfUL;
> +
> +	if (test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
> +		vsie_sca |=3D (u64)READ_ONCE(scb->scaoh) << 32;

[Severity: Critical]
Does this code truncate the host physical address if the guest lacks the
KVM_S390_VM_CPU_FEAT_64BSCAO feature?

When read_scao() is called from unpin_blocks() on the shadow SCB (scb_s):

arch/s390/kvm/vsie.c:unpin_blocks() {
    ...
    hpa =3D read_scao(vcpu->kvm, scb_s);
    if (hpa) {
        unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
    ...
}

The shadow SCB contains a 64-bit host physical address. If the L1 guest is
configured without the 64BSCAO feature, read_scao() will silently drop the
upper 32 bits of the HPA.

Could this truncated address then be passed to unpin_guest_page(),
causing it to unpin the wrong host physical page (use-after-free) while
leaking the actually pinned page?

> +
> +	return vsie_sca;
> +}
> +
> +static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
> +{
> +	scb->scaoh =3D (u32)((u64)hpa >> 32);
> +	scb->scaol =3D (u32)(u64)hpa;
> +}
> +
>  /* trigger a validity icpt for the given scb */
>  static int set_validity_icpt(struct kvm_s390_sie_block *scb,
>  			     __u16 reason_code)
> @@ -82,6 +103,25 @@ static int set_validity_icpt(struct kvm_s390_sie_bloc=
k *scb,
>  	return 1;
>  }
> =20
> +/* The sca header must not cross pages etc. */
> +static int validate_scao(struct kvm_vcpu *vcpu, struct kvm_s390_sie_bloc=
k *scb, gpa_t gpa)
> +{
> +	int offset;
> +
> +	if (gpa < 2 * PAGE_SIZE)
> +		return set_validity_icpt(scb, 0x0038U);

[Severity: High]
Can this validity intercept be lost during VSIE SCAO validation failure?

Looking at pin_blocks(), it calls validate_scao() and passes the guest
SCB (scb_o):

arch/s390/kvm/vsie.c:pin_blocks() {
    ...
    rc =3D validate_scao(vcpu, scb_o, gpa);
    if (rc)
        goto unpin;
    ...
}

When validate_scao() fails, it injects the intercept code into scb_o.
However, on the failure path, unshadow_scb() is called:

arch/s390/kvm/vsie.c:unshadow_scb() {
    ...
    scb_o->icptcode =3D scb_s->icptcode;
    scb_o->icptstatus =3D scb_s->icptstatus;
    scb_o->ipa =3D scb_s->ipa;
    scb_o->ipb =3D scb_s->ipb;
    ...
}

Would unshadow_scb() unconditionally overwrite scb_o's intercept fields
with those from the shadow SCB (scb_s), erasing the validity intercept
that was just written to scb_o?

Could this result in the L1 guest receiving an architecturally invalid
exit without an intercept code?

> +	if ((gpa & ~0x1fffUL) =3D=3D kvm_s390_get_prefix(vcpu))
> +		return set_validity_icpt(scb, 0x0011U);
> +
> +	if (sie_uses_esca(scb))
> +		offset =3D offsetof(struct esca_block, cpu[0]) - 1;
> +	else
> +		offset =3D offsetof(struct bsca_block, cpu[0]) - 1;
> +	if ((gpa & PAGE_MASK) !=3D ((gpa + offset) & PAGE_MASK))
> +		return set_validity_icpt(scb, 0x003bU);
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D6
