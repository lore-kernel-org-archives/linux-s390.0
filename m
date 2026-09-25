Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494749E145;
	Fri, 25 Sep 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341233; cv=none; b=P7P9Q9PF5sj+XAWHWVNu6DOAsPKWVB2ThW+sjbtEGqDfoPHrW97QDIWIfr2+u/uMJrIqp0IHt+eQ5mU2B8IeK8dvuYoKZ3MEbOveJ/urToT1iVKiMINip8oRkYAST+s9V1diyYJP4/O8iyhP0viBZKSYOqlJBUdET0+ARk/hY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341233; c=relaxed/simple;
	bh=+WTOigZLktiCSvymHZ7o1bYy2KlD03AH7QEsZh5Qpuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nefbwiYXc0XlbPYc/rcp+HnMn4S6VaPl7i9z5WPO2Jk4mixZgeK01VKGebRYaU4QqlO/Y8JkFsSLFTGWE4LXwd9fN4zQHaah1BzDQcD7V7tKYQzrgYzUVoAeqqKEaAO35+Ub6fJ/jxMRkdnJ6FbupckPl9UrT9ORemFYCty7TFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9rPyvLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9rPyvLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B01F00898;
	Fri, 25 Sep 2026 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341231;
	bh=yJYewbvsT0JXwrQQaQUclJtjVrcX1k2l/ZCBbGgAI7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9rPyvLZPM5MGZP83qgaX8oF8qenn2EX83xXNAVJsRR4zmNeYa90pEM45ba+tHEpl
	 YuBLmjUueS1i+V891hwsstZewM7M9W7QiJ0AZ2l1vlOG4SxmVP/DvYGuGVTXI/zfj9
	 d7bX2S7C4ueYGzEaV5a2JM5K3wbTzWf+x3x4hc4Hs5u/CzljIcbHUV+TQngl5B6X8v
	 JwZtKb5OZ9zHW3Em5qebzRNx8ErHQ7rufN6hgzpmyftDatVuTcKw2vWk5ajFFcbNws
	 9VUqxO+Ixc1QzAf48sRXOulKZPRyYiPvlscQHhKIvdOL07SYTKsTqQpAfVfvjmoR9d
	 hUDPS4BIHfoSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260925124551.665448-4-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:00:30 +0000
Message-Id: <20260925130031.739B01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] s390/vfio-ap: unmap_iova() defeats timeout leak, causing wild =
DMA write
- [Critical] s390/vfio-ap: vfio_ap_mdev_reset_queue() abandons reset on AP_=
RESPONSE_BUSY
- [Critical] s390/vfio-ap: apq_reset_check() falsely reports zeroization co=
mplete
- [High] s390/vfio-ap: apq_reset_check() infinite loop on AP_RESPONSE_BUSY
- [High] s390/vfio-ap: cross-guest resource corruption due to dangling IOVA=
/ISC
- [Low] s390/vfio-ap: dead code and ineffective state handling on reset tim=
eout
--

commit 3205ec637b4cfa8d70d28a8f5abc909aba0bd19c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: Fix unbounded loop in apq_reset_check()

The commit introduces a 2000ms timeout to apq_reset_check() to prevent
indefinite spinning when the hardware continuously returns a busy response.
If the timeout is reached, the NIB page and ISC registration are intentiona=
lly
leaked to avoid memory corruption from potential wild DMA writes. It also
corrects the confirmation logic by checking multiple status bits returned
from TAPQ.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..47d4936fb9d7c 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1857,8 +2006,28 @@ static void unmap_iova(struct ap_matrix_mdev *matr=
ix_mdev, u64 iova, u64 length)
>  	int loop_cursor;
> =20
>  	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
> -		if (q->saved_iova >=3D iova && q->saved_iova < iova + length)
> +		if (q->saved_iova >=3D iova && q->saved_iova < iova + length) {
>  			vfio_ap_irq_disable(q);
> +			/*
> +			 * If IRQ disable failed or IR=3D0 could not be confirmed,
> +			 * vfio_ap_irq_disable() intentionally leaks the NIB to
> +			 * prevent a wild DMA write. But vfio core requires the
> +			 * page to be unpinned before dma_unmap returns, or it
> +			 * will BUG_ON after 10 re-notification rounds.
> +			 *
> +			 * Fall back to a bounded queue reset. The ZAPQ zeroizes
> +			 * the NIB pointer in hardware, eliminating the DMA risk
> +			 * that justified the leak. Once the worker finishes (or
> +			 * times out with a reset confirmed in-progress), the
> +			 * hardware no longer holds a reference to saved_iova and
> +			 * it is safe to unpin unconditionally.
> +			 */
> +			if (q->saved_iova) {
> +				vfio_ap_mdev_reset_queue(q);
> +				flush_work(&q->reset_work);
> +				vfio_ap_free_aqic_resources(q);

[Severity: Critical]
Could this sequence unconditionally free the AQIC resources immediately aft=
er
the timeout completes, defeating the deliberate leak?

apq_reset_check() intentionally leaks the NIB page on timeout because hardw=
are
might still be actively writing to it. However, unmap_iova() executes
flush_work(&q->reset_work) and then unconditionally checks q->saved_iova.

Because the timeout path didn't clear saved_iova, unmap_iova() immediately
unpins the page via vfio_ap_free_aqic_resources(). Returning an active DMA
target to the page allocator could cause host memory corruption via wild DMA
writes.

> +			}
> +		}
>  	}
>  }
[ ... ]
> @@ -1959,8 +2220,77 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  		elapsed +=3D AP_RESET_INTERVAL;
>  		status =3D ap_tapq(q->apqn, NULL);
>  		ret =3D apq_status_check(q->apqn, &status);
[ ... ]
> +		if (!ret || ret =3D=3D -ENODEV) {
> +			/*
> +			 * Zeroization confirmed (ret =3D=3D 0): the TAPQ status bits
> +			 * indicate the async portion of the ZAPQ completed
> +			 * successfully. Free AQIC resources and return.
> +			 *
> +			 * Queue non-operational (ret =3D=3D -ENODEV): the queue is
> +			 * deconfigured or checkstopped; interrupts are not
> +			 * possible so AQIC resources can be safely freed.
> +			 * Zeroization cannot be confirmed in this state, but the
> +			 * queue cannot generate interrupts, so the NIB page is
> +			 * no longer a DMA target and it is safe to free it.
> +			 */
> +			apq_reset_finalize(q, &status, ret);
> +			return;

[Severity: Critical]
Does this immediate return prevent the rejected ZAPQ instruction from being
reissued, bypassing queue zeroization entirely while falsely reporting succ=
ess?

If the initial ap_zapq() is rejected (e.g., returns
AP_RESPONSE_STATE_CHANGE_IN_PROGRESS), apq_reset_check() is queued without =
the
queue being zeroized. apq_reset_check() polls with ap_tapq().

Once the hardware state change finishes, ap_tapq() returns AP_RESPONSE_NORM=
AL
(queue empty). apq_reset_check() sees !ret, executes apq_reset_finalize(),
and returns success.

The ZAPQ command is never reissued. The queue is falsely marked as reset and
can be assigned to a new guest with the previous guest's cryptographic secr=
ets
intact.

> +		}
> +
> +		if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +			/*
> +			 * Timed out without being able to verify zapq completed.
[ ... ]
> +			 */
> +			report_aqic_resource_leak(q);
> +			/*
> +			 * Zeroization could not be confirmed; set
> +			 * reset_status to AP_RESPONSE_RESET_IN_PROGRESS.
> +			 * This is used internally to signal that the reset
> +			 * did not complete, and ensures that if the queue
> +			 * is reset again, the re-issue logic in
> +			 * apq_reset_check() will re-issue the ZAPQ.
> +			 */
> +			q->reset_status.response_code =3D AP_RESPONSE_RESET_IN_PROGRESS;
> +
> +			return;

[Severity: High]
Can leaving q->saved_iova and q->saved_isc populated after the timeout corr=
upt
cross-guest resources?

If the queue is assigned to a new guest, q->matrix_mdev points to the new
guest's matrix_mdev. When the new guest enables interrupts,
vfio_ap_free_aqic_resources() is called.

It uses the new q->matrix_mdev to unpin the old q->saved_iova and unregister
the old q->saved_isc, corrupting the new guest's IOMMU pinning counts
and KVM ISC refcounts.

> +		}
> +
>  		if (ret =3D=3D -EBUSY) {
>  			pr_notice_ratelimited(WAIT_MSG, elapsed,
>  					      AP_QID_CARD(q->apqn),
> @@ -1968,18 +2298,15 @@ static void apq_reset_check(struct work_struct *r=
eset_work)
>  					      status.response_code,
>  					      status.queue_empty,
>  					      status.irq_enabled);
> -		} else {
> -			if (q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_PROGRES=
S ||
> -			    q->reset_status.response_code =3D=3D AP_RESPONSE_BUSY ||
> -			    q->reset_status.response_code =3D=3D AP_RESPONSE_STATE_CHANGE_IN_=
PROGRESS ||
> -			    ret =3D=3D -EAGAIN) {
> -				status =3D ap_zapq(q->apqn, 0);
> -				memcpy(&q->reset_status, &status, sizeof(status));
> -				continue;
> -			}
> -			if (q->saved_isc !=3D VFIO_AP_ISC_INVALID)
> -				vfio_ap_free_aqic_resources(q);
> -			break;
> +			continue;
> +		}
> +
> +		if (ret =3D=3D -EAGAIN ||
> +		    q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_PROGRESS=
 ||
> +		    q->reset_status.response_code =3D=3D AP_RESPONSE_STATE_CHANGE_IN_P=
ROGRESS) {

[Severity: Low]
Is this condition checking dead code because earlier flow control guarantees
ret =3D=3D -EAGAIN is always true here?

The code attempts to signal a failed reset by setting
reset_status.response_code =3D AP_RESPONSE_RESET_IN_PROGRESS on timeout.

However, vfio_ap_mdev_reset_queue() overwrites reset_status unconditionally
with the result of a new ap_zapq() call on the next reset attempt, rendering
the signal useless. Furthermore, the conditional check for this status insi=
de
apq_reset_check() is completely unreachable because execution only reaches =
that
block if ret =3D=3D -EAGAIN, which short-circuits the OR condition.

> +			status =3D ap_zapq(q->apqn, 0);
> +			memcpy(&q->reset_status, &status, sizeof(status));
> +			elapsed =3D 0;

[Severity: High]
Will this repeatedly reset the timeout counter when dealing with busy
responses, bypassing the timeout logic?

If the hardware continuously returns AP_RESPONSE_BUSY, apq_status_check()
maps this to -EAGAIN. In apq_reset_check(), if ret =3D=3D -EAGAIN, the elap=
sed
timeout counter is reset to 0, completely bypassing the new 2000ms timeout
logic.

This causes the worker to spin indefinitely, deadlocking the host system as
callers hold global mutexes like mdevs_lock while waiting on flush_work().

>  		}
>  	}
>  }
[ ... ]
> @@ -1995,18 +2322,27 @@ static void vfio_ap_mdev_reset_queue(struct vfio_=
ap_queue *q)
>  	switch (status.response_code) {
>  	case AP_RESPONSE_NORMAL:
>  	case AP_RESPONSE_RESET_IN_PROGRESS:
> -	case AP_RESPONSE_BUSY:
>  	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
>  		/*
>  		 * Let's verify whether the ZAPQ completed successfully on a work queu=
e.
>  		 */
>  		queue_work(system_long_wq, &q->reset_work);
>  		break;

[Severity: Critical]
Would removing AP_RESPONSE_BUSY here cause the flow to fall through to the
default error case?

If the initial ap_zapq() returns AP_RESPONSE_BUSY, it falls to the default
case, aborting the reset and not queueing the reset_work.

This leaves the cryptographic queue unzeroized, leading to an information
leak when the queue is reassigned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925124551.6654=
48-1-akrowiak@linux.ibm.com?part=3D3
