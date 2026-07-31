Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF3290DBB;
	Fri, 31 Jul 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504288; cv=none; b=HdHdqKJ9AJ0gkS/LYosC3s9/7qfIVgBgKa+fEW1NsUVYKRxl5sklsriIHiAfSjjaO/u89qQi95yWSqeAj4aM4K6q0kPd8NsjX6PhWbBjRP1Dan8rxupykINjqJ9xpAjKgNGkrqhJCLKgzWw4A6tYzXQR8QaDwOCcfWsNXwGClAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504288; c=relaxed/simple;
	bh=6NXY0tjoV94HgytkVQDDz6H1lQjiE1ZDcfANuTM8rps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LPg0lX6muD39Bw+67cXl8ZFjbi3VXmadTBHrB+kzrsyTbSiwIXvMgbRX4R/G/hayfXn1YJaQ8KsYn9RhjRmSYLJXoXL7qjMK8c3Qsxz6n5SgAyVRfFuUTPIuNTvqwM9bg4+6oI/V4akrCbv7FP4aCsadesetlP41Qc0tWWyUT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHw4M8/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHw4M8/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3D01F000E9;
	Fri, 31 Jul 2026 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504287;
	bh=dCGnlQ3cMDloOfRWxkVbW+s3RW9yUgcsA1UqEqKutgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHw4M8/VmH5clWYIXIRe6znI/Axu9agShtiL6J0g1SZJh+Xp2RuoaWOiHCT9kAKID
	 DC2k81r2soZDNgYQIGdvMXawIWTOP6EyewfSgFajYwFMUId7czgJOH2582ky10J2FE
	 LrwdvoAI1V5iV00Ze/I+i+Rch9Nzv0RSuFqzy8TxgsdGTfigZvYwpCeG0EJdgwyodr
	 3Fy2z0bjJlBFbsNPyKg8XQ3IBigHzlC+L1DOttzQdlNRZ45aNgoscwQanBm7Nu/3+d
	 E5amTsFYS2GK/VO3D+m8j3o71UnmBRmU/90GF/oH8yKsIM86F8e8WZ4qKXt1euKMGK
	 /Sdn5/anNpnrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/14] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260731130138.173983-7-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:24:46 +0000
Message-Id: <20260731132446.7A3D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack variable `prev.zero` is leaked to userspace.
--

--- Patch [6]: [PATCH v7 06/14] KVM: s390: Fix leaking of PGM_ADDRESSING to=
 userspace ---
commit ed708d75cfaadb270c9e236e10c87fa7cbbb9d4f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix leaking of PGM_ADDRESSING to userspace

This commit modifies KVM memory ioctls (such as setting CMMA bits or storage
keys) to return -EFAULT instead of a positive PGM_ADDRESSING error code when
addressing outside a memslot. This restores the expected behavior from befo=
re
the gmap rewrite.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 21574f57be72e..e162efaa35b8f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -571,7 +571,7 @@ static int kvm_s390_keyop(struct kvm_s390_mmu_cache *=
mc, struct kvm *kvm, int op
>  	switch (op) {
>  	case KVM_S390_KEYOP_SSKE:
>  		r =3D dat_cond_set_storage_key(mc, asce, gfn, skey, &skey, 0, 0, 0);

[Severity: High]
This is a pre-existing issue, but does dat_cond_set_storage_key() leak
uninitialized kernel stack memory to userspace here?

When the KVM_S390_KEYOP ioctl is called with KVM_S390_KEYOP_SSKE, it calls
dat_cond_set_storage_key(), which populates a local stack variable:

arch/s390/kvm/dat.c:dat_cond_set_storage_key() {
    ...
	} else {
		prev.acc =3D old.acc;
		prev.fp =3D old.fp;
		prev.c =3D old.gc;
		prev.r =3D old.gr;
	}
	if (oldkey)
		*oldkey =3D prev;
    ...
}

The 1-bit prev.zero bitfield is left uninitialized in this branch. The enti=
re
1-byte union is then copied into *oldkey and returned to kvm_s390_keyop().
Could this value then be copied to userspace, successfully leaking 1 bit of
kernel stack memory?

> -		if (r >=3D 0)
> +		if (r =3D=3D 0 || r =3D=3D 1)
>  			return skey.skey;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D6
