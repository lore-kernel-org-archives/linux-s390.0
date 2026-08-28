Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48C346E44;
	Fri, 28 Aug 2026 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954523; cv=none; b=APyDxYoxhKPsm7s3lmNpBvbVQc/YWgLYUxbHlF2POPa0RmhJQu4gQqrj70yJLE0jfkzcdMy5qBKbKOYAKFMbEPXzcq2MRBH84YZ47ABwey42xp4Kvw86zE0hqfLHFh1b8CMhlNR7dfKseFoYlJJnFeAnd9POHxrxz48jQWbNaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954523; c=relaxed/simple;
	bh=lUuqIWp2rYxyPbykwb/OElU//npe3EP43EBvCgs6NpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BS8JkSGnx9stYPU/x1wl5m8MuIIYpaln3/cf8/eTRUP54S2qbQRK38a2iq33e91XBtbRCGwOnCDoFveXloO7m6l8GCZSnFQa9+C023XM9Rjs9vtrQ/f39Km/mUz2BHVrbtCin2BEPeb2YLypHaAOzkbpn4NvmHmZqDta8/vBGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5rAIdeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5rAIdeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595A81F000E9;
	Fri, 28 Aug 2026 22:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787954521;
	bh=kNWk+WSHitRxuWneJYCylhPrq7BRvstaVo1bj+oAMpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5rAIdeThG1c8eIHx+1rA1UQ7ddKFsSwCu2NPtcp0QVh7RZWWvBpGKT8sWWG+YSsi
	 Eo2lWZSbtJ/6JafBVeYDPqrx43F6IYmEUsCEdwHpDF8P3CiY+8RkhpEWptRRbCLdX7
	 fzMsTjs8CHIvWEXrH5ldRRHoafhrrMq4OTXOVsJdStXw2qcqwn6/VzPOxdD6viilkf
	 FBXPF3YxMaeozKNcj+Ht0QMOh+FbhwfgJB3DLDjwUHX1ei5eY1aaSDiSpjFY+DcBad
	 wsuiXdXqFJI/9FMhKi98MFjN4zE4GeCipjArdThxYvtZvjStKDH7ae5ZuzXALFdtu2
	 /a2QWQ+4f7/cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260828214653.1087009-4-akrowiak@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
 <20260828214653.1087009-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 22:02:00 +0000
Message-Id: <20260828220201.595A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The timeout path incorrectly treats an idle queue state as a c=
ompleted reset, bypassing the necessary zeroize command and causing Use-Aft=
er-Free.
- [High] The reset operation silently reports success to callers when the r=
eset times out, masking the failure and misleading userspace.
- [Medium] The `elapsed` timer is not reset when a new reset command is iss=
ued, causing subsequent resets to prematurely time out.
--

commit 3ef072206a03ac06e2b0604371727e31f5cba1a8
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

This commit introduces a 2000ms timeout for queue reset operations in
apq_reset_check() to prevent indefinite blocking in the worker thread.
Upon timeout, it skips freeing AQIC resources to avoid a use-after-free,
leaking them instead.

Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue re=
set to complete")
Cc: stable@vger.kernel.org

The commit message states:

>    Note that on timeout, q->reset_status will hold the status from the mo=
st
>    recent reset operation so that callers inspecting
>    q->reset_status.response_code after flush_work() will see the value
>    and can return an appropriate return code.

Is this description accurate?

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 363d9e53e2490..3f5b012be450c 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2067,6 +2068,37 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  		ret =3D apq_status_check(q->apqn, &status);
>  		if (ret =3D=3D -EIO)
>  			return;
> +		if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +			/*
> +			 * If the status check determined that the reset completed
> +			 * successfully or the queue is not operational, clean up
> +			 * the AQIC resources because queue reset disables
> +			 * interrupts, or because interrupts are not possible on a
> +			 * non-operational queue.
> +			 */
> +			if (!ret)
> +				goto done;

[Severity: Critical]
Does this incorrectly treat an idle queue as a successfully reset queue?

If the queue is continuously busy for 2000ms, the initial ap_zapq() command
is rejected (returning AP_RESPONSE_BUSY). On the exact iteration where
elapsed reaches AP_RESET_MAX_WAIT (2000ms), if the queue finally stops being
busy, ap_tapq() returns 0.

Could this misinterpret the 0 as a completed reset, jump to done, and free
the AQIC resources? Since the queue was never actually zeroized, interrupts
remain enabled. Can this lead to a host kernel use-after-free if the hardwa=
re
writes to the freed NIB page?

> +			/*
> +			 * Timed out without being able to verify reset completed.
> +			 *
> +			 * The AQIC resources associated with this queue - the pinned page
> +			 * containing the NIB and the registered guest ISC - cannot be freed
> +			 * here. The NIB is the active DMA target for AP interrupt delivery
> +			 * until the reset completes; freeing the pinned page while the
> +			 * hardware may still write to it would result in a use-after-free
> +			 * kernel crash.
> +			 *
> +			 * If the reset eventually completes, interrupts will be terminated
> +			 * and the pinned NIB page and ISC registration will be leaked. This
> +			 * is preferable to either a use-after-free or waiting indefinitely:
> +			 * the caller of apq_reset_check() holds mdevs_lock while flush_work()
> +			 * blocks holds the matrix_dev->mdevs_lock mutex, which
> +			 * serializes access to all mdev objects system-wide, so blocking
> +			 * here would stall all other guests using AP queues.
> +			 */
> +
> +			return;

[Severity: High]
Does this return early on timeout without updating q->reset_status to indic=
ate
a failure?

If the queue reset times out and q->reset_status.response_code was 0 from t=
he
initial accepted command, it remains unmodified.

Would callers like vfio_ap_mdev_reset_queues() check this unmodified respon=
se
code, incorrectly assume the reset succeeded, and mislead userspace into
believing the VFIO device was successfully reset while the hardware is still
operational?

[ ... ]

> @@ -2083,11 +2115,13 @@ static void apq_reset_check(struct work_struct *r=
eset_work)
>  				memcpy(&q->reset_status, &status, sizeof(status));
>  				continue;

[Severity: Medium]
Is the elapsed timer supposed to be reset when a new reset command is issued
here?

If the queue is initially busy, takes time (e.g., 1980ms) to become idle, a=
nd
requires a retry of the ap_zapq() command, the next loop iteration will
instantly hit the 2000ms limit because elapsed was not cleared.

Could this prematurely time out subsequent legitimate reset operations and
result in resource leaks?

>  			}
> -			if (q->saved_isc !=3D VFIO_AP_ISC_INVALID)
> -				vfio_ap_free_aqic_resources(q);
> -			break;
> +			goto done;
>  		}
>  	}
> +
> +done:
> +	if (q->saved_isc !=3D VFIO_AP_ISC_INVALID)
> +		vfio_ap_free_aqic_resources(q);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828214653.1087=
009-1-akrowiak@linux.ibm.com?part=3D3
