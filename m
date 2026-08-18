Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225163F485E;
	Tue, 18 Aug 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055306; cv=none; b=jS/091Lwhrl7EiDC8nyeErYdMv3z9MBbelDnTgdGsXSp20JHutWC27g6yCRQzG5Vnm99eH2QGlT42ejRS5gOHeHyZTeDZ+jttJx7xYVI3fn8jwggH46ENlgbbLsOqtUtM5eYsH6tl+/y2AF57/AdFyYfR11GARrwdS8l6IbMmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055306; c=relaxed/simple;
	bh=GQcIsAzyqaf/NcpAy02J7ddNw9Thdxu3omG+z9qvVX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r512lxBU9Q9cKYBqygNY/Euw6MqVdiIGKgkYCax6lXA5LBatG/RVsO/dBVzYb3AtHkCV+gVqN/T5axlaUwanFtQsTEtaNqa3Xln5xi8lFnuxd7fNlQddbzlCUxBsK2arxdPSKbhCvFqnleWxZG0mlSJbafGpbcyGL7kJvDlWctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxW3LFIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxW3LFIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E571F000E9;
	Tue, 18 Aug 2026 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787055303;
	bh=vdfta/89Egg8GgJxFtGw/9GfvDW9gUWBNTIXFxmLI1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WxW3LFIZsNM6agXY/unOny5m2+sYleSgRpJ6f/rae2/27wQ6oJcMsWIY0cC6RbX9C
	 meAHWpCwqCHTbptOWgAnVSvbB6z4NU9YKBSt4WQ0YHLc9oqYJkQs5Ox6bODE+OjPj9
	 rbHFRvQZJZAUjQFItHFlniFdW8U/Dw5SoFDBAvO9UuXWyKLFj/GmuhwtrQ9jfZ2l5U
	 WpLvY5XIHwzUbsuVlenNaoJCP3+ql/tosqoUpGgsaUPGtUK+QJiLbS4auWcx4ZEZ7R
	 WoR922TxSqjFnoHwUszw+RDEp44dSPbdszLtIVdStrd+6cWW8yT0rokbdisWAvlO9H
	 UzJYolUwr9BWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Fix leak of KVM GISC resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818115819.1656595-1-akrowiak@linux.ibm.com>
References: <20260818115819.1656595-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 12:15:02 +0000
Message-Id: <20260818121503.06E571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free of `q->matrix_mdev` due to dangling pointer lef=
t after unassigning an adapter or domain for a queue not present in shadow_=
apcb.
- [High] The patch fixes KVM GISC and NIB page leaks when a queue is synchr=
onously reset by handling AP_RESPONSE_Q_NOT_AVAIL, but it misses the asynch=
ronous reset polling path, leading to the same resource leaks.
- [High] The apq_reset_check workqueue function loops indefinitely without =
a timeout while waiting for an AP queue reset to complete, causing a KVM pr=
ocess deadlock if hardware fails.
--

--- Patch [1]: [PATCH] s390/vfio-ap: Fix leak of KVM GISC resources ---
commit c19d4565d7b440cb8eddb06c5a8a375c867d24ea
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix leak of KVM GISC resources

Two related problems exist in the handling of KVM interrupt and page
resources when a queue is removed from the host's AP configuration
while assigned to a mediated device (mdev). This patch addresses the
AP_RESPONSE_Q_NOT_AVAIL response from ap_zapq() and fixes the
vfio_ap_free_aqic_resources() cleanup.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..e277062e92bea 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -2004,6 +2004,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap=
_queue *q)
>  		break;
>  	case AP_RESPONSE_DECONFIGURED:
>  	case AP_RESPONSE_CHECKSTOPPED:
> +	case AP_RESPONSE_Q_NOT_AVAIL:
>  		vfio_ap_free_aqic_resources(q);
>  		break;
>  	default:

[Severity: High]
This isn't a bug introduced by this patch, but does the same resource leak
happen when the asynchronous polling path in apq_reset_check() encounters an
AP_RESPONSE_Q_NOT_AVAIL response?

When an adapter or domain is removed from the host config while a reset is
asynchronously polling, ap_tapq() can return AP_RESPONSE_Q_NOT_AVAIL. The
helper apq_status_check() falls through to its default case and returns -EI=
O:

drivers/s390/crypto/vfio_ap_ops.c:apq_status_check() {
    ...
    default:
        WARN(true,
             "failed to verify reset of queue %02x.%04x: TAPQ rc=3D%u\n",
             AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
             status->response_code);
        return -EIO;
}

This causes apq_reset_check() to exit immediately, skipping the cleanup:

drivers/s390/crypto/vfio_ap_ops.c:apq_reset_check() {
    ...
        ret =3D apq_status_check(q->apqn, &status);
        if (ret =3D=3D -EIO)
            return;
    ...
}

Does the default case in vfio_ap_mdev_reset_queue() also need to call
vfio_ap_free_aqic_resources() to prevent a leak on an unhandled ZAPQ
response?

>  		WARN(true,
>  		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=3D%u\n",
>  		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>  		     status.response_code);
>  	}
>  }
[ ... ]

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free of q->matrix_md=
ev
if an adapter is unassigned that is not passed through to a guest?

If an adapter is unassigned, its bit is cleared from matrix.apm and
vfio_ap_mdev_unlink_adapter() removes the queue from the mdev's hash table.
However, if the queue's bit is not set in shadow_apcb, it is skipped from
qlist:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_unlink_adapter() {
    ...
        if (q && qlist) {
            if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
                test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
                list_add_tail(&q->reset_qnode, qlist);
        }
    ...
}

Because it is missing from qlist, vfio_ap_mdev_hot_unplug_adapters() skips
calling vfio_ap_unlink_mdev_fr_queue(q):

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_adapters() {
    ...
    list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
        vfio_ap_unlink_mdev_fr_queue(q);
        list_del(&q->reset_qnode);
    }
}

This leaves q->matrix_mdev dangling. Later, when the AP bus queue device is
removed, get_update_locks_for_queue() dereferences the freed pointer:

drivers/s390/crypto/vfio_ap_ops.c:get_update_locks_for_queue() {
    ...
    if (q->matrix_mdev && q->matrix_mdev->kvm)
        mutex_lock(&q->matrix_mdev->kvm->lock);
    ...
}

Can this lead to a kernel panic during normal operational reconfiguration?


[Severity: High]
This is a pre-existing issue, but will apq_reset_check() poll indefinitely
without a timeout if the hardware wedges?

drivers/s390/crypto/vfio_ap_ops.c:apq_reset_check() {
    ...
    while (true) {
        msleep(AP_RESET_INTERVAL);
        elapsed +=3D AP_RESET_INTERVAL;
        status =3D ap_tapq(q->apqn, NULL);
        ret =3D apq_status_check(q->apqn, &status);
        if (ret =3D=3D -EIO)
            return;
        if (ret =3D=3D -EBUSY) {
            pr_notice_ratelimited(...);
        } else {
            ...
            if (q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_P=
ROGRESS ||
                ...
                ret =3D=3D -EAGAIN) {
                status =3D ap_zapq(q->apqn, 0);
                ...
                continue;
            }
            ...
            break;
        }
    }
}

Operations like vfio_ap_mdev_reset_queues() schedule this work and synchron=
ously
wait for it while holding global locks:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_reset_queues() {
    ...
    hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode) {
        flush_work(&q->reset_work);

        if (q->reset_status.response_code)
            ret =3D -EIO;
    }
    ...
}

If the queue is stuck in hardware and continuously returns AP_RESPONSE_BUSY=
 or
AP_RESPONSE_RESET_IN_PROGRESS, will this permanently block the locks and
deadlock the host driver and KVM process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818115819.1656=
595-1-akrowiak@linux.ibm.com?part=3D1
