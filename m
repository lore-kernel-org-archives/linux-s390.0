Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10448551A;
	Thu, 27 Aug 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847063; cv=none; b=YFwefWPc7IKeiKdBzNKOtDm9IqdCmRz8SRh2izJP14rkxQim7475Wo33kM8mSE+ZoBiULdBSenqEuWi42QmQTzwRUaazguD8C/kyB+97BEMEvlhrJ2+1zgdTSDHUf5+fb907QYUqRxcwQFXeCCZ5P3V8qLQUPv5ShxF9wInNWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847063; c=relaxed/simple;
	bh=LhWl1XE3JG8CEXENv+unAsb/4hOeV/y6aHUOHorklYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sqbSucwUZXE9rmlaGxALqYXIRh/m+N7LKbzlfKfeQRX2+25MsSKGj7Ny3ruqXtwSvJlA22ZV+kNxQTMZ2F98f1DeVSYcS2RLxx1JeGdqWmfQHtJWq5E0HKl8g3/4XGzVXfNPhI8IoLig+1DbnocnmCqBv4b02JtiedqVBxoo0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5ZPZjMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5ZPZjMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F981F000E9;
	Thu, 27 Aug 2026 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847061;
	bh=tz+4XY7U+YO9JgqRnqvqjOl283JKUDCBbXUtFnYx/hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5ZPZjMikW3rUjB6RMhtG8lWtMaxDH6pii8tGWlp5qhXPNPsgzCDIkiLluHn2L0Tf
	 A8FaYVm7vbj/NJyPOfGpxIY1kk19HsD7UBKhbjDMdMADKR5yPisDOvvEZ3vO/Bhmuq
	 5fzqU/9lSGeqzbGUenJIGq6CrG76N2iPyKa53Hy+bavSYdxUxHSiJpkoWtvIRypeL3
	 h73O0MosUUb5EbPHJ06OpyGGJvoEUgv0oFo7d48UMrXRyYEfl1W9XJaX7GzmyVu++C
	 lFNN7CMkCftdw8yoqLG0AdmS4S5LUTYNLxBiXJQ/ysULLrbDNzQlX1qCHFfcuitCSg
	 nkt/y1/xjwLJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-19-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-19-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:11:00 +0000
Message-Id: <20260827161101.02F981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Permanent leak of a vsie_sca slot and pinned guest pages if xa_ins=
ert() fails.
--

commit 9c76bda9b524933159b82f0ac0c72c08101c18e1
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE shadow stat counters

This commit adds new stat counters to VSIE shadowing to verify and monitor
functionality. It tracks the number of allocated and reused SIE control
block (SCB) and system control area (SCA) shadows.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 3a839154fdfed..f8dff6846fb3c 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
[ ... ]
> @@ -1134,6 +1134,7 @@ static int get_vsie_sca(struct kvm_vcpu *vcpu, stru=
ct kvm_s390_sie_block *scb_o,
>  		kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] =3D vsie_sca;
>  		kvm->arch.vsie.sca_count++;
>  		atomic_set(&vsie_sca->ref_count, 1);
> +		kvm->stat.vsie_shadow_sca++;
>  	} else {
>  		/* reuse previously created vsie_sca allocation for different osca */
>  		vsie_sca =3D get_vsie_sca_unused(kvm);

[Severity: High]
Does this code leak a vsie_sca slot and its pinned guest pages if
xa_insert() fails?

Looking at get_vsie_sca() later in this function, if xa_insert() fails
(e.g., due to -ENOMEM):

arch/s390/kvm/s390/vsie.c:get_vsie_sca() {
    ...
    rc =3D xa_insert(&kvm->arch.vsie.osca_to_sca,
                   vsie_sca->sca_gpa >> SCA_ALIGNMENT_SHIFT,
                   vsie_sca, GFP_KERNEL_ACCOUNT);
    if (rc =3D=3D -EBUSY)
        rc =3D 1;

out:
    up_write(&kvm->arch.vsie.vsie_sca_lock);
    if (vsie_sca_new)
        free_vsie_sca(kvm, vsie_sca_new);
    if (vsie_sca)
        *vsie_sca_out =3D vsie_sca;
    return rc;
}

The error path falls through to the out label without calling unpin_sca()
or put_vsie_sca(). The vsie_sca struct is left with a ref_count of 1 but
is not added to the osca_to_sca xarray. Because its reference count is > 0,
get_vsie_sca_unused() will never reuse it.

Since xa_insert() allocates with GFP_KERNEL_ACCOUNT, could an unprivileged
guest hitting memory limits systematically exhaust the capped pool of
vsie_sca structures, permanently breaking nested virtualization for that VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D19
