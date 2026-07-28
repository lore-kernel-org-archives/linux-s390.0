Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014E3A59A3;
	Tue, 28 Jul 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259288; cv=none; b=rXoO6MfnakXul19Q5bREY+kDRTQgs7Sf5Wyrk7ge4EH+peSCq//VvWHaG+NjC7/Yx26LKEBXN0c69TzVOxgJKXU93IV6LPUrDEApH6ALmi701GyajJkn519B2vqfQJFyp1m54B7avJZA3dt2I7C/eDuGt7SHCga2AwuZ8n2iLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259288; c=relaxed/simple;
	bh=e2yjGuVdFB51b7TfmtRBokvwPtAhNwntyERG6mR2N5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRxC1v/LVQNblxb4Z10QskS++Nnji2c307KIpCfZumwjhpir5MFjArsDBT8YXG8fnF09E9+HN7ZT14SXok9zdZISAg5ocyRJnAo58EH3B6dyctu9UAjxCG3uXPHokm6vYMHnyNVpl9/1mvs0HCJ9fddhP6/R7qi6SJBm/KTGxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs5Ww7Bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs5Ww7Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F91F000E9;
	Tue, 28 Jul 2026 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259286;
	bh=9d+tYCqIJV3B5CtwayaQ8/XgBimbnLvCvTUFW6jom9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fs5Ww7Bqi2Vg2xv10dffktLgVkeqHr5e7N5qobUDTIJWGWqYau9QnH+JQFfbO7xWy
	 zCECmYpwN0oRFMKLIvsYZfYhGUUk+f/vpNYiiQ7BVMOdiAPn9YVuXRA2cGszrWzhKG
	 32cu4U9eQI+0REXqAGqiAYnZqUud1fh/fNJBLCuttVSC3cXKh7DrgiE4liwp/KF6G7
	 AetYSVPV2eRKuiKgp2ra15678PIJufigLy3ZweZ0hjnj/BD3LPcCNbB+6hy07mOhp7
	 XRo7Ley02Ab0PHpimJcxaCOK+GZqfPWwEj4jcY3fEUZe1Nopq/DhMcLwcgvzW5NI0J
	 LDn1OAvM3p4Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-4-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:21:25 +0000
Message-Id: <20260728172126.3F1F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code, documentation, and commit message mismatch rega=
rding which lock is used.
--

--- Patch [3]: [PATCH v4 03/13] KVM: s390: Fix race in __do_essa() ---
commit 44561620d155e5433777595f8bc3b2d06087934d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix race in __do_essa()

This patch fixes a potential race condition between __do_essa() and the=20
migration and CMMA state handling functions. It transitions the affected pa=
ths=20
to use the architecture-specific slots lock via scope-based guards.

> KVM: s390: Fix race in __do_essa()
>
> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>
> Fix by locking kvm->slots_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.

[Severity: Medium]
This isn't a bug, but the commit message states the fix uses kvm->slots_loc=
k,
while the code changes actually use kvm->slots_arch_lock. Should the commit
message be updated to reflect the use of the architecture-specific lock?

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 89de085f39670..1952f592a80a1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1298,7 +1298,9 @@ static int kvm_s390_vm_set_migration(struct kvm *kv=
m,
>  {
>  	int res =3D -ENXIO;
> =20
> -	mutex_lock(&kvm->slots_lock);
> +	guard(srcu)(&kvm->srcu);
> +	guard(mutex)(&kvm->slots_arch_lock);

[Severity: Medium]
This isn't a bug, but the function documentation for kvm_s390_vm_start_migr=
ation()
and kvm_s390_vm_stop_migration() (which are called from here) still states =
they
must be called with kvm->slots_lock held:

arch/s390/kvm/kvm-s390.c:kvm_s390_vm_start_migration():
/*
 * Must be called with kvm->srcu held to avoid races on memslots, and with
 * kvm->slots_lock to avoid races with ourselves, kvm_s390_vm_stop_migratio=
n(),
 * and kvm_s390_get_cmma_bits().
 */
static int kvm_s390_vm_start_migration(struct kvm *kvm)

Since these paths now use kvm->slots_arch_lock instead, would it be helpful
to update those comments to match the new locking behavior?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D3
