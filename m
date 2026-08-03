Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8203BCD05;
	Mon,  3 Aug 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777300; cv=none; b=eys/XLnNi0xXpuz111Ey4rgEdRl/jxsp5Ui5oyf6sgjyZSWBQ1Ml5f5ZnV/U++eQdRmetbJvyYETUdNhVQEHBYuFXQ+ODzNi7b4i24AqRavgwPpRGdbel2Z8q9Bv7mU/m6H6aZAfq3ESPEPSR0TM52GJ/OKAZFr1s4G1SNAgiu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777300; c=relaxed/simple;
	bh=Bijcf9pv5BUQkVnNWLOxqyfZqfc6W9YpgovvAKVM0Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjGFi3oy9DRhgx6ZGje7zsSLl9AOilawVj3B9eOFziaERj//vnD7ffD4/z4RWVFitmqpx3sOQPq5XBMS7ygHOExWb6E2ZgDjQES3sA08/fK4rhEZACnKH+e2d3P3iI8Fg8qeE2ObEodl9WnZ6NJ6ETBtYpKIugbDaRlSrJv91/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSgq4xvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSgq4xvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADB71F000E9;
	Mon,  3 Aug 2026 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777299;
	bh=7sOGc6Lu0z8hQ6b8lsn/oFGTgeTFy75CZPMYvGOT5pg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSgq4xvoiCmHnPpNnms/Hc9ty2EDfk6APW38jtHqC84bucWM7UynkDJBkuBqU50Wk
	 peO5+Racg5hSZlJHagJcv001sTAFWyL+W8x0XK8g7XA17m3cQCL3OtCIfvXEEOKRgY
	 WDigr7CPLHiVohYAJtsbx1ykofi2phbCZ9aIAWevlOiH/xEnfUuN822j76ZoMuorzp
	 woShDbherK9QgVb5Yv+DB6/pLyZyIFOSmKK+BFSgMmD/uOeXkoSai+ye1QFvmxuCRR
	 2O3/6OX+eUNZSPXKVOouTbf0klsNe6FDd8ZT43GcCfS9Si4FU514U5iV2KAF4gLOtX
	 htSRIfnw+CXVA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 16/23] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-17-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-17-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:14:58 +0000
Message-Id: <20260803171459.4ADB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 1-bit kernel stack memory leak to userspace via uninitialized bitf=
ield in union skey.
--

--- Patch [16]: [GIT PULL v1 16/23] KVM: s390: Fix leaking of PGM_ADDRESSIN=
G to userspace ---
commit 74696629bd13e2265747961c02030c7ac8a442d4
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

    KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
   =20
    If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
    memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
    value. Fix by returning -EFAULT whenever the return value would be > 0.

Link: https://lkml.kernel.org/r/20260803124040.126471-7-imbrenda@linux.ibm.=
com

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 21574f57be72e..e162efaa35b8f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -571,7 +571,7 @@ static int kvm_s390_keyop(struct kvm_s390_mmu_cache *=
mc, struct kvm *kvm, int op
>  	switch (op) {
>  	case KVM_S390_KEYOP_SSKE:
>  		r =3D dat_cond_set_storage_key(mc, asce, gfn, skey, &skey, 0, 0, 0);
> -		if (r >=3D 0)
> +		if (r =3D=3D 0 || r =3D=3D 1)
>  			return skey.skey;

[Severity: High]
This isn't a bug introduced by this patch, but does returning skey.skey here
leak uninitialized kernel stack memory to userspace?

Looking at dat_cond_set_storage_key() in arch/s390/kvm/dat.c, a local union
skey prev is declared without initialization:

	union skey prev;

When ptep->h.i is true, it assigns values to 4 of the 5 bitfields in prev,
but the zero bitfield remains uninitialized and retains kernel stack garbag=
e:

	} else {
		prev.acc =3D old.acc;
		prev.fp =3D old.fp;
		prev.c =3D old.gc;
		prev.r =3D old.gr;
	}

This prev union is then copied to *oldkey:

	if (oldkey)
		*oldkey =3D prev;

Since oldkey points to the local skey variable here in kvm_s390_keyop(),
does returning skey.skey eventually leak this uninitialized zero bitfield to
userspace when the result is copied via copy_to_user()?

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D16
