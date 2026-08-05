Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BB3C8C46;
	Wed,  5 Aug 2026 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929441; cv=none; b=UzqJyUTL8kZtgxA+YdQk1ACMqwMkOtOQeWG7fyXOYjD1CkNp8CvO6huwHpXq5nxu6+AamiX3XX1bRsTysA00XLsLFhVQWT6AE0p0fca24UMtJpi3jcvXaZ+2miXgu3oqJevbLGMLmlQQZU/REJgHET+fJFqHmu/KjcIaoGXL6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929441; c=relaxed/simple;
	bh=Y5Nni8sUBJRVEYDPH7cnpExgo8duf6pFwFTeEq1O27I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hd2tvFXojP3BRtxr2J4ZHJan/ltxpnDb+kaIoZKzbMlBwqR+G4TXKetqRKT559yJb26wRhVZTZtfupHoKYR+AevpC589qnwoOe+d5GPQFN2jqUpBhx3v2sMfl/WiCN4VO0aBIiiYFCCnuDRhHfcH4pSzg8pnvGyQvAC5c1q4/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLoG6gIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLoG6gIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21851F000E9;
	Wed,  5 Aug 2026 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929439;
	bh=rpLerTlMlhCBDpV5C7ZYAPEDEP/5AR6955GoqAOfWaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLoG6gIi0m64n3DMRpZeMaYWglTWu1vzIEEJNA2tsgkPammlXNjyL58uLqotUj3Ir
	 B+afxqMlqGny+bhGMCUik62kTn9YGgm49n71ll+x4Sob+UyUlWMnddOKLiXK0BqY5J
	 yHaeZiXxQhnNCWIu3ARXDbWbWJXoKDHPxl6uY3GySyhfjFC0MqXMW60RLxBkaxAIKW
	 kgSrKlPf7EIySMPM/hidH3ADZaZ+WQtbUtUT1B4brVFdkLioWmZtBFYaCvJXXzrDQd
	 qDk/E0Bjs981b/lPorT5ab3CTeOu3/WIWcf7qYW2b6SDz2jlYlDT0UUcbWOwTO/3Wq
	 nRWReF8btmTGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] KVM: s390: Fix old_data leak in guest debug
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805110455.7200-6-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
 <20260805110455.7200-6-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:30:37 +0000
Message-Id: <20260805113038.D21851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing SRCU lock when accessing memslots during guest debug setup=
 leads to Use-After-Free.
--

--- Patch [5]: [PATCH v3 5/8] KVM: s390: Fix old_data leak in guest debug e=
rror path ---
commit efad1ff98c2af0fcd50545a3067b444c29f0bc33
Author: Christian Borntraeger <borntraeger@linux.ibm.com>

KVM: s390: Fix old_data leak in guest debug error path

__import_wp_info() allocates a per-watchpoint old_data buffer to back up
the original guest memory contents. If a later watchpoint of the same
KVM_SET_GUEST_DEBUG request fails to import, kvm_s390_import_bp_data()
jumps to the error label, which frees the wp_info array but not the
old_data buffers of the entries that were imported successfully. Up to
MAX_BP_COUNT - 1 buffers of up to MAX_WP_SIZE bytes are leaked per failed
request, and the request can be repeated.

Create error handling for cleaning up all created old_data memory
areas.

> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index 4c02dbebb2eb3..f7c94d54efbe2 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -252,7 +252,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  			ret =3D __import_wp_info(vcpu, &bp_data[i],
>  					       &wp_info[nr_wp]);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
__import_wp_info() here without holding the SRCU read lock?

__import_wp_info() in arch/s390/kvm/guestdbg.c attempts to read guest memor=
y:

arch/s390/kvm/guestdbg.c:__import_wp_info() {
    ...
	/* try to backup the original value */
	ret =3D read_guest_abs(vcpu, wp_info->phys_addr, wp_info->old_data,
			     wp_info->len);
    ...
}

This ultimately accesses the KVM memslots array.

Because the KVM_SET_GUEST_DEBUG ioctl entry point doesn't acquire the SRCU =
read
lock before calling kvm_s390_import_bp_data():

arch/s390/kvm/kvm-s390.c:kvm_arch_vcpu_ioctl_set_guest_debug() {
    ...
		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
			rc =3D kvm_s390_import_bp_data(vcpu, dbg);
    ...
}

Could a concurrent memslot update (such as another thread calling
KVM_SET_USER_MEMORY_REGION on the VM) free the memslots array while it is b=
eing
accessed by this debug ioctl, leading to a Use-After-Free?

>  			if (ret)
> -				goto error;
> +				goto error_wp;
>  			nr_wp++;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110455.7200=
-1-borntraeger@linux.ibm.com?part=3D5
