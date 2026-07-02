Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBD353A71;
	Thu,  2 Jul 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006479; cv=none; b=F7Im0TzSBQCn8OIA3wUdpJiXKeXzkGGZyHxJK3p+CgFVajn3r7c9Zo/pp/vzIdZDM6uCp/UKf+SH+Tq6WxRibZgMoodq894jIWP/i2zFi9eDyTmaNbDYzYasM2qTkAKMtppLcLAEZyG+sOm3FEMlU3/AQzA6dWkXW3g7H0Y0zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006479; c=relaxed/simple;
	bh=m+JWyHuFaAW3tquVfaNXx8Zt8r6ST97WjmK8DegVi7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdWEOosk85H6hs1P72wbcBYGTOxmPnMDV6ETHKlHEFzSgCWlak1sysj0WmbdHclmBp0bepzPUSc0/FQrVI9ESd1snqxxGCJPi1w+0s5+1yA/kvhRimzchqePIPsDnz1OHIJIE99S1zomaSrSIrumI+D2k43g1xyoJSQAjFohR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7hR8+dO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7hR8+dO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A171F000E9;
	Thu,  2 Jul 2026 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006478;
	bh=XWmtLC9ycY37iLe0Nc3F/yjVI0mioWGVpASP58QeZBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7hR8+dOo8ys2VlebZ1VxwnvvSSPwREEhywh42khXcAxO5Tsdy6/H9e3L0Lks04Il
	 KfglL5+X5/mS3gg3hv11qI7gElIFG6N+iCLr5AVdtn5TP0ZQiO9VSZx2+I/nhcT253
	 /ThTywvOdRAlsC3DbmZ5RHlWhgR/Aigufa1JsHcd6ZQxYDmgfhpQVXViIXeDEOtkrR
	 2cWoYJ4scieVOwnrYjqTFDXfJgtYtJN2LW8VHWybv+EWy/lKGdDHC9JTMAkQSXlcZO
	 EEuKVm4ExJa5YPpFi2O4VBwRalmf//Vh5r2Y9jg77n9krmay7x3xpAXzzJtEIpA25e
	 n7XR27GrKJNCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260702152406.204782-6-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:34:37 +0000
Message-Id: <20260702153437.A5A171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Acquiring `kvm->slots_lock` inside an SRCU read-side critical sect=
ion causes an ABBA deadlock.
--

commit e40855b84f2ee647bcced37d340b4d6805640050
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix race in __do_essa()

This commit addresses a race condition between __do_essa() and VM migration
or dat_get_cmma() by acquiring kvm->slots_lock before calling __do_essa().

> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -1260,8 +1260,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  		/* Retry the ESSA instruction */
>  		kvm_s390_retry_instr(vcpu);
>  	} else {
> -		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> -			i =3D __do_essa(vcpu, orc);
> +		scoped_guard(mutex, &vcpu->kvm->slots_lock)
> +			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> +				i =3D __do_essa(vcpu, orc);

[Severity: High]
Does acquiring kvm->slots_lock here introduce an ABBA deadlock?

Looking at handle_essa(), it executes within an SRCU read-side critical
section, as verified by the lockdep assertion at the start of the function:

static int handle_essa(struct kvm_vcpu *vcpu)
{
	lockdep_assert_held(&vcpu->kvm->srcu);
	...

If a concurrent memslot update acquires kvm->slots_lock and then calls
synchronize_srcu(&kvm->srcu), it will wait on the SRCU lock held by this
thread, while this thread blocks waiting for kvm->slots_lock.

>  		if (i < 0)
>  			return i;
>  		/* Account for the possible extra cbrl entry */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152406.2047=
82-1-imbrenda@linux.ibm.com?part=3D5
