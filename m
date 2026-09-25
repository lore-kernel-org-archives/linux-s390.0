Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB748D86E;
	Fri, 25 Sep 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341390; cv=none; b=blEGFWpQJARQXjslwBe3XCK85/Dir4FSRb82zaezcte3jEIzQJtNmaTZU4ETtIAzTWip2a8G3SXSN5SbneQPICksJm9jYFvYt1kud5OX/x3rU+csEVa97gz9dtqGgWAQ6r3TsZwoIhdXvfoqpX4VNbLVTeJPVDu78B8d0ug1gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341390; c=relaxed/simple;
	bh=EGuyb9F6r+KylcUwxyOFiSCGEKoqfoc20Mm4eTrXLE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CW8imZw2EshTHW3ZFPtQYhrGwVmkO98yZJ0dyzbSsh7sGgtaHUALOclqon8ncYOmY0yp90pFGfVclpxpji25aDx2nXICWrGbWwu8hiuHhv3H+8AFK33gGAj+pINnuokjD+/x4AXy+yvcTC+2/zJgafkjAi8k+Jhtky2/sBv6vKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSp6HHFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSp6HHFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D988B1F000FF;
	Fri, 25 Sep 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341389;
	bh=VdVpGypdOborRTs6aMZgX/4R1iWBP8q+oMOK0hbNEw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BSp6HHFrW9kRFsOtqLE53mANrjg61rRkP/XCEiNiyFnB7MLKz04uQKheSlq9rNHid
	 yKWH2lFu7fQbOOEx/TL6yvTsIcPaHyh8PTBJDk8i5uLWMPzZL0jRDLFhONV0D/c85N
	 mVgZFUhNp7BJrmY5UQeCORiERkiut7oD9ZBketXWWIWeJcr5M5Hy1j+IpT2zVud7YN
	 u5I3svxQrOBlGN4EpmrQ54PR85L4VruLrvaLwppllr4nBleWvNE3Sf5Asq0CZSoO0t
	 PMXP+PYcbSva1JPCQq+aYtrYfZcpdsRW5UssH+8K1H9Zqomjn5skxnGZ5bpocST0n9
	 4I1MfJTTVt/Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] s390/vfio-ap: fix queue state leakage to guest
 and host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925124551.665448-6-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:03:08 +0000
Message-Id: <20260925130308.D988B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] crypto: vfio: Use-After-Free of vfio_ap_queue in vfio_ap_on_qstate=
_transition
- [High] crypto: vfio: TOCTOU on q->matrix_mdev leads to unprotected KVM st=
ate updates and deadlocks
- [Low] crypto: vfio: Incorrect comment for __drv_notify_qstate_transitioned
--

commit 6964322bafaab43ec603a04a262b5d1370b6779d
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix queue state leakage to guest and host

This patch limits the wait for a queue reset to complete and prevents the
leakage of queue state to a guest. It introduces an on_qstate_transition
callback to track queue state changes and restricts queue passability to
fully zeroized states.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index d82df5b4e2db3..a53cfad3543eb 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
[ ... ]
> @@ -1979,6 +1979,28 @@ static inline void notify_scan_complete(void)
>  			 __drv_notify_scan_complete);
>  }
> =20
> +/* Helper function for notify_config_changed */
> +static int __drv_notify_qstate_transitioned(struct device_driver *drv, v=
oid *data)

[Severity: Low]
Is this comment accurate? It states this is a helper function for
notify_config_changed, but the function name and usage indicate it is a
helper for notify_qstate_transitioned.

> +{
[ ... ]
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index ffc2d8715bd96..cd4a436c43194 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -3309,3 +3310,46 @@ void vfio_ap_on_scan_complete(struct ap_config_inf=
o *new_config_info,
> =20
>  	mutex_unlock(&matrix_dev->guests_lock);
>  }
> +
> +/**
> + * vfio_ap_on_qstate_transition:
> + *
> + * AP bus callback notifying the vfio_ap device driver that the state of=
 a
> + * queue has transitioned.
> + *
> + * @qstate_trans: the object containing a reference to the queue device =
and the
> + *		  state to which it transitioned.
> + */
> +void vfio_ap_on_qstate_transition(struct ap_qstate_transition *qstate_tr=
ans)
> +{
> +	struct vfio_ap_queue *q =3D vfio_ap_find_queue(qstate_trans->queue->qid=
);
> +	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
> +
> +	/*
> +	 * If the queue is not bound to the vfio_ap device driver, then it won't
> +	 * be passed through to a guest; so, no need to continue.
> +	 */
> +	if (!q)
> +		return;
> +
> +	get_update_locks_for_mdev(q->matrix_mdev);

[Severity: High]
Can this dereference a freed pointer?

If vfio_ap_find_queue() reads the device's drvdata and drops the device
reference before returning, q has no reference count. Because
vfio_ap_on_qstate_transition() holds no locks, a concurrent sysfs unbind
can invoke vfio_ap_mdev_remove_queue(), which clears drvdata and calls
kfree(q).

This would cause a use-after-free when reading q->matrix_mdev.

Additionally, is there a TOCTOU race when reading q->matrix_mdev without
locks?

If q->matrix_mdev is NULL here, get_update_locks_for_mdev() will skip
acquiring kvm->lock. If another thread concurrently updates q->matrix_mdev
to a non-NULL value while waiting on guests_lock, this could lead to issues
later in the function.

> +
> +	switch (qstate_trans->new_state) {
> +	case AP_QUEUE_CONFIG_ON:
> +	case AP_QUEUE_CHKSTOP_OFF:
> +		vfio_ap_mdev_reset_queue(q);
> +		flush_work(&q->reset_work);

[Severity: High]
Does this also cause a use-after-free for the same reason? Passing the
potentially freed queue object to vfio_ap_mdev_reset_queue(q) and flushing
its work struct could trigger further memory corruption.

> +
> +		if (q->matrix_mdev) {
> +			if (vfio_ap_mdev_filter_matrix(q->matrix_mdev, apm_filtered)) {
> +				vfio_ap_mdev_update_guest_apcb(q->matrix_mdev);

[Severity: High]
If q->matrix_mdev changed concurrently after get_update_locks_for_mdev()
was called, could this update the KVM guest state without having acquired
the proper KVM locks?

> +				reset_queues_for_apids(q->matrix_mdev, apm_filtered);
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	release_update_locks_for_mdev(q->matrix_mdev);

[Severity: High]
If q->matrix_mdev was modified between the initial acquisition and here,
would this call mutex_unlock() on a lock it did not acquire, or leave
an acquired lock perpetually locked?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925124551.6654=
48-1-akrowiak@linux.ibm.com?part=3D5
