Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF826C3BD;
	Fri, 17 Jul 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295914; cv=none; b=nFdEtzgmTvoPNllVcvoFjyJ6X+hug/BD1XDafoy+MT0hU6PIHzx5IUBYYGDVTowEG9HPYD0MaOUkQVn2jmE7FzdyB/b7xj+HW4bS1vVEBGWKnZRK85HrYhIB55No4GcHzVckJtfeGXXkEr+1J+AF71RzDU6JD+t0nuK+Sp/xdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295914; c=relaxed/simple;
	bh=G8plNeQf1S6P70kn9by8gVwodiGiPDktsRxvAhZIyy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fGGPY5jOypytDE7dG3s2I9oCo3OdCkeolvnJLSGGaDlqO8GsoYoLaVp/Lcx10Ww1wgiJ94+JVO+kTZWtvsrIAnDytaTaZ86zqYUdkVpe/eGgWYYryyRvdVOSTK6EIOKY4S2rsd3elLUVseIphC4b0+9hfj0f+34WOSyO2wxC1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiVQ1t1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiVQ1t1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CBB1F000E9;
	Fri, 17 Jul 2026 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295911;
	bh=UGaEe+fbFt3fs+MoHCpgv0K8027b/ZYLWt++RI/JliA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HiVQ1t1hHJ6B/sdw6vH2iskdVM9Q+lAAwif09GOyI5wTLDHTLujAZ4af6+9Jnvr1+
	 unTPKYDT+SRiZ1xDUd3kRoACJ8ARwlFCHtzWGkBpBSY84IWmXLOT3gxsETODR3B8d4
	 NYlETq3AjjsjAIwOmlBnklUtMc/pFoMQH+ewaEAGLf3w3TJYPk91XY4D06a5ptM3Pv
	 4jOitBaL8/VOCzVr7YspCA3CU//74PEsPHjHOYX1kOxRk0u8I2tyNYVfsg6xFUyaqB
	 V3VFnZblXvoNP2gzeBpJx0lmmZUAksdrOp5f88rLzo1Y1qxgzfh0rRahU0LrHY77CR
	 m7uHvUOI4LvhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: s390: pv: ignore ultravisor donated storage for
 kmemleak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260717133136.5188-1-borntraeger@linux.ibm.com>
References: <20260717133136.5188-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:45:10 +0000
Message-Id: <20260717134510.A8CBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: Kmemleak will crash the host when scanning KVM PV =
variable storage (stor_var)
--

--- Patch [1]: [PATCH v2] KVM: s390: pv: ignore ultravisor donated storage =
for kmemleak ---
commit f3ecf0128072e5354e12f9c00c85c0768e09acaa
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: pv: ignore ultravisor donated storage for kmemleak

This commit fixes host kernel crashes that occur when kmemleak scans the=20
ultravisor base storage memory. It explicitly tells kmemleak to ignore the=
=20
donated memory by calling kmemleak_ignore_phys().

> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index a284f98d97168..7dde37c365a99 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c

[ ... ]

> @@ -70,6 +71,7 @@ void __init setup_uv(void)
>  			uv_info.uv_base_stor_len);
>  		goto fail;
>  	}
> +	kmemleak_ignore_phys(__pa(uv_stor_base));

[Severity: High]
This isn't a bug introduced by this patch, but does the same problem apply =
to
the per-VM variable storage allocated in KVM?

Looking at kvm_s390_pv_alloc_vm(), it allocates stor_var using vzalloc():

arch/s390/kvm/pv.c:kvm_s390_pv_alloc_vm() {
    ...
	kvm->arch.pv.stor_var =3D vzalloc(vlen);
	if (!kvm->arch.pv.stor_var)
		goto out_err;
    ...
}

This memory is tracked by kmemleak and is subsequently donated to the
Ultravisor in kvm_s390_pv_init_vm():

arch/s390/kvm/pv.c:kvm_s390_pv_init_vm() {
    ...
	uvcb.conf_virt_stor_origin =3D (u64)kvm->arch.pv.stor_var;
    ...
	cc =3D uv_call_sched(0, (u64)&uvcb);
    ...
}

Once donated, the underlying physical pages become secure and inaccessible =
to
the host. Will the kmemleak background thread scanning the vmalloc space at=
tempt
to read this secure memory and trigger a hardware exception, just like it d=
oes
for uv_stor_base?=20

Could a call to kmemleak_ignore(kvm->arch.pv.stor_var) be needed here to ma=
ke
the fix complete and prevent similar host crashes?

> =20
>  	if (uv_init(__pa(uv_stor_base), uv_info.uv_base_stor_len)) {
>  		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717133136.5188=
-1-borntraeger@linux.ibm.com?part=3D1
