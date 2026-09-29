Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8525237AC;
	Tue, 29 Sep 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685497; cv=none; b=C0M/Kqp6tz8m1IcZ+WvmqETLzY5qZSGmXKZvKHCcV9itaE9KWH0SNLubDt3n02P4vzel0n4OiJOHZG+2Kvww4t/7Fnqt7kjYjMbSRHF+HD/ayM2VgYEGkqk5KELCDA2hJlUfX4F8/HV99HnJaVOwRfvGyZk5mglLwmfJcNDnBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685497; c=relaxed/simple;
	bh=QC6jOU0Eop0si3mSmGrevxCUesIX0AnJPoftRANAN3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrfqNzduH/l7vNsANQ/YWuV/71A8djXAR71siAWYboSRbjBcJvjpvPIza8JcS6GZMqH1O4Ylh/YQxrD2QBWS0qo0hSO05wi8JRCnw02a6IkVLU97FSCx49RSycWL6xQr+CgMYqd2IvECQ7iMabImEz0iiZyQnIEV+y29pPb+JjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6uTziWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6uTziWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287871F000FF;
	Tue, 29 Sep 2026 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685495;
	bh=avk3euovDkGkIFMTXibqpEymbUBwVEAyF3XiMpQtO+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6uTziWD1gfFGkbrcduSdrFsiwguETVdUNx4OtGc3KGs62mNDwKlXey2zFWfRMg4P
	 qJbGksvESSh4M3z2uwUWcL1sjxGWE9qAH9FLXc+KG/FJHxgYXwQljdO0mrtEl1jy9v
	 F6/pclAwhXCcR9zYqRP/eJdw8zBdCl2VcwpylnkCnFu5Tzq4gRrYmL2oApSgpNX0nF
	 cARfbKcMhdOAhpkSWVD7ozWUQoiDZWZ2AHT0nynASO4wo/ze9LVNBSQoFe8foHZQi2
	 W2b9aPXEdixuMIr935KWjb4ZTHHCAsh5pHyODrtkxcenAhnx4scdg62I8YhixN4KUZ
	 2TQBKDSX2gjLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929121837.2715710-4-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:38:14 +0000
Message-Id: <20260929123815.287871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] crypto: zeroization bypass and DMA vulnerability if ZAPQ retur=
ns BUSY
- [Critical] crypto: Use-After-Free of vdev pointer after reset timeout
- [High] crypto: resource leak and erroneous WARN when ZAPQ returns BUSY
- [High] crypto: zeroization bypass if non-reset state change completes at =
timeout
- [Medium] crypto: spurious ZAPQs from conflating TAPQ and ZAPQ BUSY respon=
ses
- [Low] crypto: dead code setting fallback reset status on timeout
--

commit 625818127ace62cbd33b251880fe0f1f6d732f69
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

This commit fixes an unbounded wait loop in the apq_reset_check() worker by
adding a 2000ms timeout. It also updates TAPQ status checks to accurately
verify asynchronous queue zeroization completion before freeing AQIC
resources.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 087e8474a34ab..07fbfa6f10152 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2164,6 +2164,12 @@ static int apq_status_check(int apqn, struct ap_qu=
eue_status *status)
>  		return -EBUSY;
> =20
>  	case AP_RESPONSE_BUSY:
> +		/*
> +		 * The queue is busy with something unrelated to a reset and our
> +		 * ZAPQ was rejected outright. Re-issue the ZAPQ.
> +		 */
> +		return -EAGAIN;
> +

[Severity: Medium]
Does returning `-EAGAIN` here trigger spurious ZAPQs by conflating TAPQ and
ZAPQ BUSY responses?

`apq_status_check()` evaluates the output of `ap_tapq()`. If `ap_tapq()`
returns `AP_RESPONSE_BUSY`, it means the read instruction itself was
transiently rejected. However, this code appears to incorrectly assume it
means the previous ZAPQ was rejected outright, returning `-EAGAIN`.=20

This forces the worker loop to immediately issue a new `ap_zapq()`, which
overwrites `q->reset_status` and destroys the correct queue state tracking,
likely leading to further failures.

[ ... ]

> @@ -2223,30 +2280,73 @@ static void apq_reset_check(struct work_struct *r=
eset_work)
>  			 */
>  			memcpy(&q->reset_status, &status, sizeof(status));
>  			return;
> -		}
> -		if (ret =3D=3D -EBUSY) {
> +		} else if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +			/*Timed out without being able to verify zapq completed */
> +			if (!ret || ret =3D=3D -ENODEV) {

[Severity: High]
Does evaluating the timeout condition before the retry logic allow an
unrelated state change completion to bypass the required zeroization step?

If the initial ZAPQ returns `AP_RESPONSE_STATE_CHANGE_IN_PROGRESS`, the wor=
ker
polls until it completes before retrying ZAPQ. If the state change completes
exactly at `elapsed >=3D AP_RESET_MAX_WAIT`, `ap_tapq()` indicates the queu=
e is
idle, and `ret =3D 0`.

Because the loop evaluates the timeout condition `else if (elapsed >=3D
AP_RESET_MAX_WAIT)` before the ZAPQ retry logic, the timeout block executes
`apq_reset_finalize()`, forces the status to `AP_RESPONSE_NORMAL`, and retu=
rns.

The required `ap_zapq()` is entirely bypassed, leaving the queue unzeroized
while freeing AQIC resources, resulting in a DMA vulnerability.

> +				/*
> +				 * Zeroization confirmed (ret =3D=3D 0): the TAPQ status bits
> +				 * indicate the async portion of the ZAPQ completed
> +				 * successfully. Free AQIC resources and return.
> +				 *
> +				 * Queue non-operational (ret =3D=3D -ENODEV): the queue is
> +				 * deconfigured or checkstopped; interrupts are not
> +				 * possible so AQIC resources can be safely freed.
> +				 * Zeroization cannot be confirmed in this state, but the
> +				 * queue cannot generate interrupts, so the NIB page is
> +				 * no longer a DMA target and it is safe to free it.
> +				 */
> +				apq_reset_finalize(q, &status, ret);
> +				return;
> +			}
> +
> +			report_apq_reset_check_timeout(q);
> +
> +			/*
> +			 * Zeroization could not be confirmed; set
> +			 * reset_status to AP_RESPONSE_RESET_IN_PROGRESS.
> +			 * This is used internally to signal that the reset
> +			 * did not complete, and ensures that if the queue
> +			 * is reset again, the re-issue logic in
> +			 * apq_reset_check() will re-issue the ZAPQ.
> +			 */
> +			q->reset_status.response_code =3D AP_RESPONSE_RESET_IN_PROGRESS;

[Severity: Low]
Is this assignment to `q->reset_status.response_code` dead code?

The timeout logic assigns `AP_RESPONSE_RESET_IN_PROGRESS` to theoretically
trigger a re-issue during the next reset. However, the next reset requires
calling `vfio_ap_mdev_reset_queue()`, which immediately executes
`status =3D ap_zapq(q->apqn, 0)` and unconditionally overwrites
`q->reset_status` via `memcpy`.

> +
> +			return;

[Severity: Critical]
Does returning early here skip cleanup and leave `q->aqic_resources.vdev`
as a dangling pointer?

`q->aqic_resources.vdev` points to the `vdev` embedded in `ap_matrix_mdev`
without holding a reference count. When the new timeout mechanism returns
early without calling `apq_reset_finalize()`, it leaves
`q->aqic_resources.vdev` populated.

When the mediated device is removed, `vfio_ap_mdev_remove()` flushes the
worker and calls `vfio_put_device()`, which frees the `ap_matrix_mdev`.
This turns `q->aqic_resources.vdev` into a dangling pointer on a surviving
`vfio_ap_queue`.

Later, if the AP queue is unbound or reused, `vfio_ap_free_aqic_resources()`
unconditionally dereferences this pointer via
`vfio_unpin_pages(q->aqic_resources.vdev, ...)`, which could trigger a
use-after-free on the host.

> +		} else if (ret =3D=3D -EBUSY) {
>  			pr_notice_ratelimited(WAIT_MSG, elapsed,
>  					      AP_QID_CARD(q->apqn),
>  					      AP_QID_QUEUE(q->apqn),
>  					      status.response_code,
>  					      status.queue_empty,
>  					      status.irq_enabled);
> +			continue;
>  		} else {
> -			if (q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_PROGRES=
S ||
> -			    q->reset_status.response_code =3D=3D AP_RESPONSE_BUSY ||
> -			    q->reset_status.response_code =3D=3D AP_RESPONSE_STATE_CHANGE_IN_=
PROGRESS ||
> -			    ret =3D=3D -EAGAIN) {
> +			if (ret =3D=3D -EAGAIN ||
> +			    q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_PROGRES=
S ||
> +			    q->reset_status.response_code =3D=3D AP_RESPONSE_STATE_CHANGE_IN_=
PROGRESS) {

[Severity: Critical]
Is it possible for `AP_RESPONSE_BUSY` to be missed in this retry check?

If `ap_zapq()` inside the worker loop is rejected with `AP_RESPONSE_BUSY`,
`q->reset_status.response_code` is set to `AP_RESPONSE_BUSY`.
On the next iteration, if the queue becomes idle, `ap_tapq()` returns
`AP_RESPONSE_NORMAL` (ret =3D 0).

Since `AP_RESPONSE_BUSY` is missing from the retry condition, the worker se=
ems
to skip re-issuing the ZAPQ. It would fall through to `apq_reset_finalize()=
`,
falsely overriding the status to `AP_RESPONSE_NORMAL` and freeing the AQIC
resources. Can this leave secret keys intact and expose the host to wild
DMA writes?

> +				status =3D ap_zapq(q->apqn, 0);
> +				memcpy(&q->reset_status, &status, sizeof(status));
>  				continue;
>  			}


I also have a question about `vfio_ap_mdev_reset_queue()`:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_reset_queue() {
    ...
	switch (status.response_code) {
	case AP_RESPONSE_NORMAL:
	case AP_RESPONSE_RESET_IN_PROGRESS:
	case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
    ...
}

[Severity: High]
Does lacking `case AP_RESPONSE_BUSY:` here cause legitimately busy queues
to fail in the default case?

If the queue is transiently busy, ZAPQ returns `AP_RESPONSE_BUSY`. Execution
falls to the `default:` branch, triggering a host WARN (falsely claiming a
hardware bug) and intentionally leaking AQIC resources without queueing the
worker to retry. Could this allow a guest that keeps the queue busy to cause
resource leaks and kernel warnings on the host when the device is removed or
reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929121837.2715=
710-1-akrowiak@linux.ibm.com?part=3D3
