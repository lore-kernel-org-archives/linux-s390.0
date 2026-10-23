Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773392;
	b=MC5oWyWVIJK8+s6a77rfx+S/NGRYehlb8oMe60s/tH6wh7X1yH7D52Dfis3oMNNExrCm
	 gd6UZQzn/h7u8A8Yca12MDT7Qe8mzfiIv+p5xifrdRZd2auHq/hGLLm88ogIFvoVMKQe4
	 KwCKeuoJwnT3F5dUbgVHitv9HQFFSQR4z1IUtKHvHG3KviKTtTblKj1rRbSs0cV7G7Nwa
	 IclCxsYamKxRe1Wf9uNpT2nJPXCEbgqqWGIwBDHjFE0t3bLTMi9QNGtNu5Hz+OTtWU/P5
	 ys3MEKRKXYcGFgl3cj0xQqQVViUskSnW2hzcAlCgeEiU7fqxM0n8j4KwJ4o/r7D8uFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZJ6vr5Z9Ihr3l11AfNnsTmxdBovqYtu6jMkAfy7n9GI=;
	b=StI4dtUVJv4s/D2KfSRSOeu/Cu0uowZLuuaBErCD5jMBd1MmybXo1RHWjWYSpnZgoEva
	 L68ad9ybRa0U0SY33JEeJXIGHSbxFn2HwY85ikH3OcxHGpp9tdp3eVOTkvyOVuMFo6iRs
	 K/K/WhV3mdH+wrTflqcxlZwVVDp5yrlyYY00AVul2DBxvIKz/+VKi8ZKwK//E+cmr8Ay4
	 MEK4ab9mwy63jO3UA242wSK4mdgSlMunInoPqSNUpxQ3uZzlNqMM0FQNpaL32ryCdaM8m
	 wkx+6Y7znSQyP0GKXLTsPZ9qCgNStZ/l9FuOr2xsVUuEIyD3xn2BMsYWMcgIxXJDqQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqSZkF5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B606606A31A;
	Fri, 23 Oct 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqSZkF5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FE81F01825;
	Fri, 23 Oct 2026 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773391;
	bh=ZJ6vr5Z9Ihr3l11AfNnsTmxdBovqYtu6jMkAfy7n9GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RqSZkF5vjyBMZerFP/0ElwakLeTKKOF5wQgOw/qEyZRiOB0UAPJRr1gWq1be2TjZc
	 G7Z2PaxqVL/3oADnTr/JrZ/ocG643C2uJnMeoowoLDiSJZpND/AYvRXk7cnYKXu2jP
	 3iIMm+HpsXjgztx5n+rplDuCUyv1y/X088wUbFc6Y5kyTZbRNnZJO9/yaxpMXAYTf7
	 HP5yNR3nyZ+4IDsPVDyGV/9Cuj52nFBUGlfnlo0Bc1BSuqiei1IkdhuO17DiOkzm3G
	 kL24WuXX7L+nthovURlwb6xAe0J0jyjh+3KlvFDAuOCYfruUpjicvjS9G1sxAkH2J/
	 Z2oV9vmaxPQAQ==
Message-ID: <sashiko-outbox-182955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] KVM: s390: Enable 1M pages by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-11-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:36:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: s390: missing hpage check in kvm_s390_set_mem_control() for=
 CMMA
- [Low] KVM: s390: missing kernel-parameters.txt update for kvm.hpage defau=
lt change
--

commit ecd16cdb4adaf78710af05b565a1375d75d2ce7b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Enable 1M pages by default

This commit changes the default value of the hpage module parameter in
arch/s390/kvm/s390/s390.c from 0 to 1 so that 1M hugepage backing for
guest mappings is enabled by default.

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 280310870dac3..71d79b4437ac0 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -212,7 +212,7 @@ module_param(nested, int, S_IRUGO);
>  MODULE_PARM_DESC(nested, "Nested virtualization support");
> =20
>  /* allow 1m huge page guest backing */
> -static int hpage;
> +static int hpage =3D 1;

[Severity: Medium]
With hpage enabled by default, KVM_CAP_S390_HPAGE_1M is now available by
default to userspace VMMs. If userspace enables KVM_CAP_S390_HPAGE_1M (or
KVM_CAP_S390_HPAGE_2G) in kvm_vm_ioctl_enable_cap() before enabling CMMA via
KVM_S390_VM_MEM_ENABLE_CMMA, does kvm_s390_set_mem_control() allow mutually
exclusive hugepage and CMMA support to be active at the same time?

In arch/s390/kvm/s390/s390.c, kvm_vm_ioctl_enable_cap() checks
kvm->arch.use_cmma when enabling KVM_CAP_S390_HPAGE_1M:

	case KVM_CAP_S390_HPAGE_1M:
		mutex_lock(&kvm->lock);
		if (kvm->created_vcpus)
			r =3D -EBUSY;
		else if (!hpage || kvm->arch.use_cmma || kvm_is_ucontrol(kvm))
			r =3D -EINVAL;
		else {
			r =3D 0;
			set_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);

However, kvm_s390_set_mem_control() only checks kvm->created_vcpus and does
not check whether GMAP_FLAG_ALLOW_HPAGE_1M or GMAP_FLAG_ALLOW_HPAGE_2G is s=
et
on kvm->arch.gmap->flags:

	case KVM_S390_VM_MEM_ENABLE_CMMA:
		ret =3D -ENXIO;
		if (!sclp.has_cmma)
			break;

		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
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
		break;

Prior to commit e38c884df921 ("KVM: s390: Switch to new gmap"),
KVM_S390_VM_MEM_ENABLE_CMMA checked kvm->mm->context.allow_gmap_hpage_1m and
returned -EINVAL.

When 1M or 2G leaf DAT entries are installed via gmap_link(), no 4K page
tables or PGSTEs exist for those mappings, causing dat_perform_essa() and
dat_set_cmma_bits() in arch/s390/kvm/gmap/dat.c to fail with -EFBIG when
walking to TABLE_TYPE_PAGE_TABLE without DAT_WALK_SPLIT:

	if (dat_entry_walk(NULL, gfn, datt, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &pt=
ep)) {
		*state =3D (union essa_state) { .exception =3D 1 };
		return -1;
	}

Should kvm_s390_set_mem_control() reject KVM_S390_VM_MEM_ENABLE_CMMA with
-EINVAL when GMAP_FLAG_ALLOW_HPAGE_1M or GMAP_FLAG_ALLOW_HPAGE_2G is set?

>  module_param(hpage, int, 0444);
>  MODULE_PARM_DESC(hpage, "1m huge page backing support");

[Severity: Low]
Since this changes the default behavior of the kvm.hpage kernel command-line
and module parameter, should Documentation/admin-guide/kernel-parameters.txt
(as well as the kvm.hpage notes in
Documentation/virt/kvm/x86/running-nested-guests.rst and
Documentation/virt/kvm/api.rst) be updated to document this parameter and i=
ts
new default?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D10
