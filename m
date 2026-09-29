Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234395208BE;
	Tue, 29 Sep 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685688; cv=none; b=Vou6PV2cre+Q6Y90sVAg5hMPUOB2q3d+w60vHQ0aP6XW6COuvF7TgroU4lSRONNgts0dkleOHrwiiKDHX1T+zJVAxIbVsFVuioNldgkS0Zc0BGEs+SRE21MpEw/uRatJm+d/cUEvmXusgn57plMOZhBn6wum5NBysww1mX3yBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685688; c=relaxed/simple;
	bh=Uhl/vM7TWPILR2Clki+AP9qjNTUVMOEdVvxJq7hyYOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nNIxUhRA4Xynyy241+KR6wA0CKBYMoYJ3oKhynB+mQgxIXvDqUr3DUytfZm2SDpIPbswbbQmWNPnmrfvZNCM0ao0XepbxHFVQf+mXkH9pPrBGTsMcCpVhouxrm8aDQn2avL+IIEKz4+LX0oXte3+32Qs9GX2a4FXggbaSbOub6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqpDPeUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqpDPeUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F571F000FF;
	Tue, 29 Sep 2026 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685686;
	bh=QrYN+KfFVNzB3DmmPmFm42rJ43sQtMx7T+AXgI14HqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NqpDPeUn9sOb60qQN+trQwTPn6mZdc12KdPC+K0aO6qS1dbF2rgSIS7eTSALWdnXT
	 Qloho/ajuLa+h86YTv+iGnG0AVilL/VOh0i47J67MqMXhziERvVwndXpBNVL6nvdcT
	 UZGnzk5qXo1OfDJsu+7ldKatfxeURPBkwrLgbT6e04jJ8AYveLn5k/Gq9Bk5kT9lii
	 hscZAthmc54uoBgkQs+ZFtRs3t7+Fvt11Ea4mn9JN5m47DPW4BGMlQ+PQSUuczYAZr
	 syZ9YCWgHhNIS7OPWfy0+FNV+HkAqhe9v1E3oN24ocv5V0Tw3JDY+HJ1yhtlvCRlkW
	 5zn1bmEptbsHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/6] s390/vfio-ap: replace guest-reachable WARNs with
 ratelimited warnings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260929121837.2715710-7-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:41:25 +0000
Message-Id: <20260929124126.71F571F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] vfio_ap: AB-BA deadlock between guests_lock and pqap_hook_rwsem
- [High] vfio_ap: returning negative errors from handle_pqap() causes guest=
-triggerable VM crash
- [High] vfio_ap: clobbering guest registers before fallback to userspace b=
reaks emulation
- [High] vfio_ap: 3-way SRCU deadlock via guests_lock and kvm->lock
- [Medium] vfio_ap: dev_warn_ratelimited() uses static state, breaking per-=
mdev isolation
--

commit 5bf97ebc06bca2480f470ccf5163316139db70cc
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings

This commit replaces WARN and WARN_ONCE macros in code paths reachable by a
guest with ratelimited warning functions to prevent malicious guests from
flooding the kernel log. It also refactors handle_pqap() to hold both
guests_lock and mdevs_lock during execution, using a single exit point to
prevent one guest's mdev from suppressing messages for another.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 89efb73d70355..7b1da96146271 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -226,6 +226,58 @@ static struct vfio_ap_queue *vfio_ap_mdev_get_queue(
>  	return NULL;
>  }
> =20
> +static void report_tapq_rc(struct vfio_ap_queue *q, u8 rc)
> +{
> +	if (q->matrix_mdev)
> +		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
> +				     "PQAP(TAPQ) for %02x.%04x failed with invalid rc=3D%#02x\n",
> +				     AP_QID_CARD(q->apqn),
> +				     AP_QID_QUEUE(q->apqn), rc);

[Severity: Medium]
Will this actually provide per-mdev isolation?

The commit explicitly states that dev_warn_ratelimited() was chosen so the
rate limit state is per-mdev. However, dev_warn_ratelimited() relies on
dev_level_ratelimited(), which defines a static DEFINE_RATELIMIT_STATE at
the call site:

include/linux/dev_printk.h:dev_level_ratelimited() {
    ...
    static DEFINE_RATELIMIT_STATE(_rs, ...);
    ...
}

Does this mean any guest spamming invalid requests will exhaust the static
rate limit for this source line, silencing the warnings for all other guest=
s?

[ ... ]

> @@ -787,32 +836,39 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
> =20
>  	apqn =3D vcpu->run->s.regs.gprs[0] & 0xffff;
> =20
> -	/* If we do not use the AIV facility just go to userland */
> -	if (!(vcpu->arch.sie_block->eca & ECA_AIV)) {
> -		VFIO_AP_DBF_WARN("%s: AIV facility not installed: apqn=3D0x%04x, eca=
=3D0x%04x\n",
> -				 __func__, apqn, vcpu->arch.sie_block->eca);
> -
> -		return -EOPNOTSUPP;
> -	}
> -
> +	mutex_lock(&matrix_dev->guests_lock);

[Severity: High]
Does this code introduce an AB-BA deadlock between guests_lock and
pqap_hook_rwsem?

A guest executing PQAP causes KVM to call handle_pqap() under the read-side
of pqap_hook_rwsem:

arch/s390/kvm/s390/priv.c:kvm_s390_handle_b2() {
    ...
    down_read(&vcpu->kvm->arch.crypto.pqap_hook_rwsem);
    ...
}

This patch makes handle_pqap() unconditionally acquire guests_lock here.

Concurrently, a host thread executing a configuration change (e.g. via
get_update_locks_for_kvm()) acquires guests_lock and then attempts to
acquire the write-side of pqap_hook_rwsem:

drivers/s390/crypto/vfio_ap_ops.c:get_update_locks_for_kvm() {
    ...
    mutex_lock(&matrix_dev->guests_lock);
    if (kvm) {
        mutex_lock(&kvm->lock);
        down_write(&kvm->arch.crypto.pqap_hook_rwsem);
    }
    ...
}

[Severity: High]
Does acquiring guests_lock here also introduce a 3-way SRCU deadlock?

KVM holds srcu_read_lock(&kvm->srcu) when calling the instruction intercept
handlers. The KVM locking documentation explicitly forbids acquiring any lo=
ck
that wraps kvm->lock while holding KVM's SRCU read lock:

Documentation/virt/kvm/locking.rst:
synchronize_srcu(&kvm->srcu) is called inside critical sections for
kvm->lock ... These locks _cannot_ be taken inside a kvm->srcu read-side
critical section.

Can this result in a circular dependency where:
1. The vCPU thread holds SRCU and waits for guests_lock.
2. The mdev configuration thread holds guests_lock and waits for kvm->lock
   (via get_update_locks_for_kvm()).
3. Another KVM thread holding kvm->lock calls synchronize_srcu(&kvm->srcu),
   waiting on the vCPU thread?

>  	mutex_lock(&matrix_dev->mdevs_lock);
> +	matrix_mdev =3D vfio_ap_mdev_for_apqn(apqn);
> +	if (!matrix_mdev || !matrix_mdev->kvm) {
> +		ret =3D -ENODEV;
> +		goto out_unlock;
> +	}

[Severity: High]
Can returning a negative error code here cause a guest-triggerable VM crash?

If a guest executes PQAP for an unassigned queue or missing mdev, the patch=
ed
handle_pqap() returns -ENODEV or -EINVAL instead of returning 0 and setting=
 a
guest CC.

KVM's instruction intercept handler (__vcpu_run) propagates non-EOPNOTSUPP
negative errors directly to userspace:

arch/s390/kvm/s390/s390.c:vcpu_post_run() {
    ...
    if (rc !=3D -EOPNOTSUPP)
        return rc;
    ...
}

QEMU treats an unexpected KVM_RUN failure as a fatal error and terminates
the VM, allowing an unprivileged guest to crash its hypervisor process.

[ ... ]

> -	matrix_mdev =3D container_of(vcpu->kvm->arch.crypto.pqap_hook,
> -				   struct ap_matrix_mdev, pqap_hook);
> -
> -	/* If the there is no guest using the mdev, there is nothing to do */
> -	if (!matrix_mdev->kvm) {
> -		vfio_ap_le_guid_to_be_uuid(&matrix_mdev->mdev->uuid, uuid);
> -		VFIO_AP_DBF_WARN("%s: mdev %08lx-%04lx-%04lx-%04lx-%04lx%08lx not in u=
se: apqn=3D0x%04x\n",
> -				 __func__, uuid[0],  uuid[1], uuid[2],
> -				 uuid[3], uuid[4], uuid[5], apqn);
> +	/* If we do not use the AIV facility just go to userland */
> +	if (!(vcpu->arch.sie_block->eca & ECA_AIV)) {
> +		VFIO_AP_DBF_WARN("%s: AIV facility not installed: apqn=3D0x%04x, eca=
=3D0x%04x\n",
> +				 __func__, apqn, vcpu->arch.sie_block->eca);
> +		dev_warn_ratelimited(mdev_dev(matrix_mdev->mdev),
> +				     "PQAP(AQIC) for %02x.%04x: AIV facility not installed\n",
> +				     AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
> +		ret =3D -EOPNOTSUPP;
>  		goto out_unlock;
>  	}

[ ... ]

> @@ -835,7 +895,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
>  	vcpu->run->s.regs.gprs[1] >>=3D 32;
>  	mutex_unlock(&matrix_dev->mdevs_lock);
> -	return 0;
> +	mutex_unlock(&matrix_dev->guests_lock);
> +	return ret;
>  }

[Severity: High]
Does routing the -EOPNOTSUPP fallback through out_unlock clobber guest
registers and break emulation?

If the KVM AIV facility is not installed, handle_pqap() returns -EOPNOTSUPP
to defer emulation to userspace.

However, since this now passes through out_unlock, it unconditionally
executes memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus)).

Will this overwrite the guest's actual instruction parameters in gprs[1]
with an error code before KVM exits to userspace, causing QEMU to attempt
emulation with corrupted inputs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929121837.2715=
710-1-akrowiak@linux.ibm.com?part=3D6
