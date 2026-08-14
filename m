Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F2350A0F;
	Fri, 14 Aug 2026 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719130; cv=none; b=I5+fBnTt9bE3L5NOdYtY+OAgP03PPGBoBIOM+/QVJ/XJZSclvYLjpxpVMRTLP+9mFAn6vAZXVy3DfhXQ8RLTN3AXE4Len+pZTEGHvlw0a3Anh0L5wTLEwgMd33gA8bYP+7BGj73UCbvrGZH5GjDceWPOphHWC2vpGgBQPDX0eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719130; c=relaxed/simple;
	bh=Nu4lDlswLvlt3iXJ+0I9ZSHHKq1hRFmhYGD9J/jE9Lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjUE3OZHpUxreIZBOaxRlTuWPaK1fwIQcHAjvGqwExQO16+hw6u1/KD6YkGqEuHeYNMM+WVMwQZ9iNdqDQUTjWlcdntc5AGD4NJjzXSnNs8g9zVTyI6MNHQIxA/fWqmiSm4XKbNTKHgUyeQV75GR8G0H9cDDjW8mnhtFpK1/lXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osSzU/QI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osSzU/QI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3251F000E9;
	Fri, 14 Aug 2026 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719124;
	bh=x3C6+eZK/jXq6r9MuXREy6LvmQyQ9F8udlckJCWJxsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=osSzU/QIIhOKCiB6VPqGyAIK4aBAlRxK24eRMgwkY3S4/MWF4lhSvVayEyiVQQiLi
	 bY6f1p6ymZb7AB5bnRLM3OJMhFo3YYDhaTf+XoTYpxDj1JN6LatS9F0J1BHuHz3KQ+
	 gpVKDHPOYzDGnjFfXPQ8R47yek1aA9O4l5fOlm8trJS8FZ2nw0PXD9W1lEZfgFebCP
	 uvsClYPFUl8azi/Tr5f1VILSrMaLgAGJ6d7M2MyxGZppXIF0C8u+oHURuFYPhYqaFd
	 7FZG1I0OvUL0uAPbaClhWfIbjZBx2qFEUIrA+o44qtKYgeivov59PgYZMjPXy5X+8m
	 dQERyu9ubZ2hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] KVM: s390: Add missing srcu in
 kvm_arch_vcpu_ioctl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814144041.169025-6-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
 <20260814144041.169025-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:52:03 +0000
Message-Id: <20260814145204.0B3251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Circular deadlock between KVM SRCU lock and userfaultfd during cop=
y_from_user().
--

--- Patch [5]: [PATCH v1 5/6] KVM: s390: Add missing srcu in kvm_arch_vcpu_=
ioctl() ---
commit 4558246eff181af6ab8735d60c453a1298252bfe
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Add missing srcu in kvm_arch_vcpu_ioctl()

This commit adds an SRCU read lock around kvm_s390_set_irq_state()
in kvm_arch_vcpu_ioctl().

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 50eb72447fd53..7fb5a566e2d85 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5697,9 +5697,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  			break;
>  		}
>  		/* do not use irq_state.flags, it will break old QEMUs */
> -		r =3D kvm_s390_set_irq_state(vcpu,
> -					   (void __user *) irq_state.buf,
> -					   irq_state.len);
> +		scoped_guard(srcu, &vcpu->kvm->srcu) {
> +			r =3D kvm_s390_set_irq_state(vcpu, (void __user *)irq_state.buf,
> +						   irq_state.len);
> +		}

[Severity: High]
Does this scoped_guard result in calling copy_from_user() while holding
the SRCU read lock?

Looking at kvm_s390_set_irq_state() in arch/s390/kvm/interrupt.c, it
performs a user copy:

int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, in=
t len)
{
	...
	buf =3D vmalloc(len);
	if (!buf)
		return -ENOMEM;

	if (copy_from_user((void *)buf, irqstate, len))
		return -EFAULT;
	...
}

If userspace passes a userfaultfd-managed region as the irq state buffer,
copy_from_user() can block and wait for the userfaultfd manager.

If that manager then attempts an operation that updates KVM memslots
(such as KVM_SET_USER_MEMORY_REGION), it will acquire the slots lock
and wait on synchronize_srcu().

Could this cause a circular deadlock between the SRCU read lock held
here and the slots lock acquired by the userfaultfd manager?

>  		break;
>  	}
>  	case KVM_S390_GET_IRQ_STATE: {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144041.1690=
25-1-imbrenda@linux.ibm.com?part=3D5
