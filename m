Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304942A792;
	Wed, 12 Aug 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532308; cv=none; b=nLhAvAJiEhINNo8XsWjUfZ8VGeA47/8wgBBPjLtVhsihbVYBXr8L+5ly3afolXiGp7tUWbrgHjtas5g9Y/YxYwUsECb/JFQG5DpsPXtuRcOerRNMWgfVPID8MxjFGDFqW3X6Pxrl8pTIHNYJxhZzT049GgeCz4r2hnT0U5uCnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532308; c=relaxed/simple;
	bh=NvuyN0dq6Y8uKQB08sY18UMqMal3FcVkNK1qfLQjgPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1ulJZTxnD0ptMJz8hHfJ/uja2E6cpixU63N+Adczh74lRNbGoaKF8v/ZWxImBd6hTp/IKbsgtYD17tLjkepsPnuM8jVlB8eJbzQ4Mr89PWISgvnrCo+9sNiyJ2oHP+hruefodw1kk3zrfY9ocbDi1a8v3hP0xjZMyHowZ9Q4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeCbI1WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeCbI1WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0D11F000E9;
	Wed, 12 Aug 2026 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786532306;
	bh=avJ8zzQc/ljZu9mHtfgzxe61EmXMNd3ekMMU6gcfrrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jeCbI1WU3+xxuO7e57nFANJd7vkaoiZJXkZ1thP7c3gzxtrFrz/QbEFbBcQysHHX+
	 VEtQhaIDz8Qi9vXGH9f1b/A7njexK0YQvjXgvzSZ3rH5JnZRcEkzZ8uluLPhka49Cs
	 ppWdzpQJvs5j1S71xDNNvMubuuLFel2cKll1uYUOk83SQEM7/4oUFM7PwzCLTlLrUC
	 Twl7jdqk2npKdCQmV7QZM8tOGIMYQ934hJRBiTa4NL6QzLaPkmAv7Pwh7RxMm4JCLi
	 0kHif4+kzHOPmR8DeD/uTHVHAVlSPvuK9LWVWrrQ2nY8IAoSmveENappUtHVR+Oehl
	 S7PWyHbkifnWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] KVM: s390: Use srcu in
 kvm_arch_vcpu_unlocked_ioctl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812104436.109741-3-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:58:25 +0000
Message-Id: <20260812105826.2E0D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kvm_s390_inject_vcpu() can sleep while holding a spinlock when han=
dling a KVM_S390_SIGP_STOP interrupt, leading to a kernel panic.
--

--- Patch [2]: [PATCH v2 2/9] KVM: s390: Use srcu in kvm_arch_vcpu_unlocked=
_ioctl() ---
commit 9a55f0a8064e7c3f8972e52233d190eda6c12400
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()

kvm_arch_vcpu_unlocked_ioctl() is called without further locks held, but
kvm_s390_inject_vcpu(), which is called from there, needs either the
kvm->srcu or the slots lock. Fix by taking the kvm->srcu.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5463,7 +5464,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp=
, unsigned int ioctl,
>  			return -EFAULT;
>  		if (s390int_to_s390irq(&s390int, &s390irq))
>  			return -EINVAL;
> -		rc =3D kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		scoped_guard(srcu, &vcpu->kvm->srcu)
> +			rc =3D kvm_s390_inject_vcpu(vcpu, &s390irq);

[Severity: High]
This is a pre-existing issue, but can this call path sleep while holding
a spinlock?

If userspace calls the KVM_S390_INTERRUPT ioctl with type KVM_S390_SIGP_STOP
and the KVM_S390_STOP_FLAG_STORE_STATUS flag, kvm_s390_inject_vcpu()
acquires a spinlock and disables preemption:

arch/s390/kvm/interrupt.c:kvm_s390_inject_vcpu()
    spin_lock(&li->lock);
    rc =3D do_inject_vcpu(vcpu, irq);
    spin_unlock(&li->lock);

While under the spinlock, do_inject_vcpu() triggers a guest memory write:

arch/s390/kvm/interrupt.c:__inject_sigp_stop()
    if (irq->u.stop.flags & KVM_S390_STOP_FLAG_STORE_STATUS)
        rc =3D kvm_s390_store_status_unloaded(vcpu,
                    KVM_S390_STORE_STATUS_NOADDR);

This initiates a write to guest memory that can fault and sleep:

arch/s390/kvm/kvm-s390.c:kvm_s390_store_status_unloaded()
    if (gpa =3D=3D KVM_S390_STORE_STATUS_NOADDR) {
        if (write_guest_abs(vcpu, 163, &archmode, 1))

Could this underlying __copy_to_user() call (via write_guest_abs) cause a
'scheduling while atomic' kernel panic by sleeping while li->lock is held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D2
