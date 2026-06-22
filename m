Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DF2C21F2;
	Mon, 22 Jun 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145181; cv=none; b=Dntfd8URyf8OYeyz2ijhs5DBzQtdm7ExjDMLXvOFe91xR88LpdK3giUqY5cNB8xwNnHAS/XdPxWyAUA18pKcHis7L0U/pIErRPuhnHjOYV4K77Czq4SfsPWA6rdbASSYibObwBrVANff0eIYyFWD+27gsO8QceUIxJHkv6xhby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145181; c=relaxed/simple;
	bh=sLbT6th8HNg4rw7taDUBIKUHUP4m7hQQ/0/9Wou64+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BBOEnfqGoIRjA+ubzlq91HLpngGARhF1HQIi+Dx7C6gbVwzrH8cYI38lxrzpqI1ltGlSPvOfYBLQYlpT2+Htc4aNSZXumX7vCR0NzipJTGsIPSd7sxe6tblzvYgTSPEW2sgaODc6ZwpcuKYgPd36BNOyOZpDOYq5gms5vPSdZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lohE3Uq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lohE3Uq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E71F00AC4;
	Mon, 22 Jun 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145180;
	bh=fjuiD63wezbHUx9p4+c9r+Ww1S8hjQmzlPuLPFA6HZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lohE3Uq9YEgBbt0PZ3G3M575C4gQEYg74cMXnKJ5bjNjW6+bHEQ6+aD6Hkq2R+hvW
	 JcPTQbws5soiL6jRfDF0KPZ0e0uscZrXb1D8yAHEWeyyqt54dmfC3Hj1u6+xEGDvfL
	 S7/EICITzOxK7YZfKR4UE/8z/PBfxRLvwUE04+5E7KQKZ3s0o8YS+YsuCheW+Yz/LJ
	 UXZs97NErVj2rH374yIwvZgjlP6MKDxFYrTfEVwS7xDV62rOn5FglnAndGFruk+TYN
	 EPzx37o8EBCY15imODAHnNo/2xhAGAANWhKzmdUUKwEvVUKpy4u7Q9Gqry9c6sFbvR
	 NuhLZbrjy9enw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] KVM: s390: Fix locking in
 kvm_s390_set_mem_control()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260622160739.202044-7-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:19:39 +0000
Message-Id: <20260622161940.4C2E71F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Holding `kvm->lock` across `get_user()` introduces a userfaultfd d=
eadlock risk and denial of service vector.
--

commit 86b3447d27dc01346bae78704ae167d2c9133c5c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix locking in kvm_s390_set_mem_control()

This commit refactors kvm_s390_set_mem_control() by moving the kvm->lock
acquisition to the top of the function using a scope-based guard, and adds
missing locking around dat_reset_cmma().

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -962,6 +962,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, =
struct kvm_device_attr *att
>  {
>  	int ret;
> =20
> +	guard(mutex)(&kvm->lock);
> +
>  	switch (attr->attr) {

[ ... ]

>  	case KVM_S390_VM_MEM_LIMIT_SIZE: {
>  		struct kvm_memslots *slots;
>  		struct kvm_memory_slot *ms;
>  		unsigned long new_limit;
>  		int bkt;
> =20
>  		if (kvm_is_ucontrol(kvm))
>  			return -EINVAL;
> =20
>  		if (get_user(new_limit, (u64 __user *)attr->addr))
>  			return -EFAULT;
> =20
> -		guard(mutex)(&kvm->lock);
> -

[Severity: High]
Does this new lock placement introduce a userfaultfd deadlock risk?

By moving the guard(mutex)(&kvm->lock) to the top of the function, the lock
is now held during the get_user() call in the KVM_S390_VM_MEM_LIMIT_SIZE ca=
se.

If a userspace application backs the attr->addr pointer with a userfaultfd
region, the kernel page fault triggered by get_user() will block waiting for
the userspace handler to resolve it.

If that userspace handler then attempts to execute another KVM ioctl that
acquires kvm->lock (such as KVM_SET_USER_MEMORY_REGION), could this result
in an ABBA deadlock that hangs the kernel thread and permanently locks the
KVM instance?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D6
