Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45AF357D09
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944582; cv=none; b=D3G9prgFgLALtLdm7yyNs/0WpeIX0nxp2n49suuVTh/Q88b1w+5kLzpdGuA0pibY24D5EKldIKVpQ5By284bLHGfJi6PJRvBs8gmE1cShNyEzOF1jI6oTSmgmXCUzS3YM81PxCALTnT/r8ZkKOKtNs8VIzvKakBAHXU+vve4AOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944582; c=relaxed/simple;
	bh=S30V9j/zBv7kh7eiuoJVUe5H0Y9rrtAHcU0K2vE0ig0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HikUdMHft+0IO26Q9cyl95cwMNpAOGP6FZKTft3LL8EnoADDywDl0l0TdF1BrbdfW/IZpe7xjgz3SoHEDWqUUieag60EEdS0GbrGNMvdPjiZO1OC8VHZK2A5vIT3Znqx+V4pe7RAz+DbbdmkIe33YksNNuhTEwqhYdNug68K3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hicxVes/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hicxVes/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2A51F00A3A;
	Wed,  9 Sep 2026 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944581;
	bh=rcX9gJSBhlqYE9nj6l3XEasDdOvnfuPZNBg+qOvEFmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hicxVes/8JmwJUnua4wbAmQpes3R9WPxH7toyjMmqvL/63OE4yADJLuYrGBhSJl6O
	 2sptt79hhYDEHuDRIlC9r9OWZInbpj/I8MALMDV8jBu9lnaIccs2iwVTQnveDvbs9X
	 qGBKmmJ+7xmBQgHl4PU63z81/DB/+aLVl/X+CtFfMO9NnZtgrcpzGNvzXptpBsu599
	 Fmk5pA6AIatBJeiQR8SFsUYRJeUgBI5/4m0RDBBi5zZDJe3JNQu8kh+f941v4Zs0wQ
	 VO6anP607UVCZxyOnw/oZk/Nga6QqactRg9UJV41MUdCMHfEkAKYyg2HiHKkliuEHr
	 NdOYQUA+n6j9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] vdso: Move the kernel-side time update helpers to
 a new header
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-1-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-1-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:03:00 +0000
Message-Id: <20260909090301.3D2A51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The kerneldoc for `vdso_time_update_begin()` still references the o=
ld function name `vdso_update_end()` instead of `vdso_time_update_end()`.

Pre-existing issues:
- [High] kvm_clock_sync() accesses KVM's vm_list locklessly during stop_mac=
hine(), which can race with VM creation/destruction and traverse a corrupte=
d list.
--

commit a658f5b7a653ebec860c6e97f450e6c3c3e5c2a1
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

vdso: Move the kernel-side time update helpers to a new header

The vdso/ header namespace is meant for symbols which are usable from
vDSO userspace code. However vdso_update_begin() and vdso_update_end()
are only usable from the kernel. Move them into a new header in the
linux/ namespace. Also rename them to make clear that they are only
for time-related data.

> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index 2b989bebd220a..161628f6906fe 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
> @@ -527,7 +528,7 @@ static int stp_sync_clock(void *data)
>  			cpu_relax();
>  		rc =3D 0;
>  		if (stp_info.todoff || stp_info.tmd !=3D 2) {
> -			flags =3D vdso_update_begin();
> +			flags =3D vdso_time_update_begin();
>  			rc =3D chsc_sstpc(stp_page, STP_OP_SYNC, 0,
>  					&clock_delta);
>  			if (rc =3D=3D 0) {
>  				sync->clock_delta =3D clock_delta;
>  				clock_sync_global(clock_delta);

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing severe
issue. Does stp_sync_clock() running via stop_machine() race with VM
creation or destruction and lead to list corruption?

If a task is preempted while modifying vm_list under kvm_lock during VM
creation or destruction (since kvm_lock is a mutex and leaves preemption
enabled), the list pointers could be left in an inconsistent state.

Because stp_sync_clock() runs via stop_machine(), it can preempt such tasks.
stp_sync_clock() calls clock_sync_global(), which triggers the epoch notifi=
er
and causes kvm_clock_sync() to blindly traverse the corrupted vm_list
locklessly:

arch/s390/kvm/s390.c:kvm_clock_sync() {
    ...
    list_for_each_entry(kvm, &vm_list, vm_list) {
    ...
}

Can this lead to a host kernel panic or an infinite loop during lockless
traversal?

>  				rc =3D __store_stpinfo();
>  				if (rc =3D=3D 0 && stp_info.tmd !=3D 2)
>  					rc =3D -EAGAIN;
>  			}
> -			vdso_update_end(flags);
> +			vdso_time_update_end(flags);
>  		}
>  		sync->in_sync =3D rc ? -EAGAIN : 1;
>  		xchg(&first, 0);

[ ... ]

> diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
> index aa59919b8f2c2..12e205d86e7f3 100644
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -177,7 +178,7 @@ void vdso_time_update_aux(struct timekeeper *tk)
>  #endif
> =20
>  /**
> - * vdso_update_begin - Start of a VDSO update section
> + * vdso_time_update_begin - Start of a VDSO update section
>   *
>   * Allows architecture code to safely update the architecture specific V=
DSO
>   * data. Disables interrupts, acquires timekeeper lock to serialize agai=
nst
> @@ -188,7 +189,7 @@ void vdso_time_update_aux(struct timekeeper *tk)
>   * Returns: Saved interrupt flags which need to be handed in to
>   * vdso_update_end().
     ^^^^^^^^^^^^^^^
>   */
> -unsigned long vdso_update_begin(void)
> +unsigned long vdso_time_update_begin(void)

[Severity: Low]
Should the kerneldoc for vdso_time_update_begin() be updated to reference
vdso_time_update_end() instead of vdso_update_end()?

>  {
>  	struct vdso_time_data *vdata =3D vdso_k_time_data;
>  	unsigned long flags =3D timekeeper_lock_irqsave();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D1
