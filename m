Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCED3921D1;
	Mon, 24 Aug 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609490; cv=none; b=Gu07h+xB4dBlnYOCDJuE6rkWjs01e91m9xfscFC55Qoq9f00kWb/bIJs5A9EXcEQgLVQgxXldTeB/nG5ieZ2512rfpFGi4UvnkWRFHqeYkIT++XBzrO3U8n1otZdR/4GA8hrYNxkBDel+I4YG1CTAFLZP/3BVpLS4GshnXe7di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609490; c=relaxed/simple;
	bh=QgAJYynJHPMCFH16dmZknvrCHMGU134ieOJBzZA8TUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onnxUrjF+yes79lRUzEZGR8/XDE7+i+YdEsWxjBno83/MOBl71oQAoi1jpCFEXvu8CDKxDj1nZz3ahs/50LIBbGJPlrXdqhXykuUXZGSCHx/It6fI4I6Z7Ig2gXeEnku+S/x/uLmGVMgssLTAQoN0YrFHIyemn4sSCeXlXeF4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeP7kCww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeP7kCww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891FB1F000E9;
	Mon, 24 Aug 2026 22:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609488;
	bh=cDO+eKVgZXd3XdGFXti8nFkINeQKsZcJEbgNizM8i40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jeP7kCwwjmeaiKN12TpM5r2zJliXgeAeEYfpV9umc2Lin7VUyphVqwnq1TwYmEzNU
	 lBeUN4h4OA9AL1al7gHuxEHrby0MYhQTd8GbE3HwedJ85/U9oi8R8Lj6ljRfmmr91F
	 m2TSaDpRZXFQ/AgrvLVGzeoDPbXK7w3QaviThwMOBJZql5W2bydCGucjS7tKzXj4YZ
	 xdAmxQ8zcvEBwD6dWoAER5HPJcgZEU7n7kx7owOf359HbbGTwC/c0+L4iV2ycIRg6A
	 7rQOnrHkWwOPozmYaO9hbM/atgZF8frg+IZE85PpWQ+KJopfpofGr5afN3XD3EpIw0
	 Q1E806QKhkU1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260824215603.819379-4-akrowiak@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
 <20260824215603.819379-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:11:28 +0000
Message-Id: <20260824221128.891FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] The timeout mechanism intentionally skips unpinning the NIB pa=
ge to avoid a driver-level UAF, but fails to realize the VFIO core will aut=
omatically unpin and free the page when the device is closed, resulting in =
a critical hardware DMA Use-After-Free.
- [Critical] The timeout handler leaves `q->saved_iova` and `q->saved_isc` =
populated with the old guest's state, leading to cross-guest resource corru=
ption when the queue is assigned to a new mdev.
- [High] The timeout error path deliberately leaks the registered guest ISC=
 and pinned NIB page, which permanently exhausts ISCs and directly causes a=
 host kernel WARN when the KVM guest terminates.
- [High] The worker can still loop indefinitely because the new timeout che=
ck is bypassed in the 'else' branch when retrying the reset via ap_zapq().
- [Medium] The commit message explicitly claims that AQIC resources are fre=
ed on the early exit path, but the code does the exact opposite.

Pre-existing issues:
- [High] The worker returns early on `-EIO` without writing the final hardw=
are status back to `q->reset_status`.
--

--- Patch [3]: [PATCH v2 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset=
_check() ---
commit 84304c1f304fd7bd597c0aa370c7ee8ddc904d98
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix unbounded loop in apq_reset_check()

This commit introduces a maximum wait timeout in the apq_reset_check worker
to prevent indefinite loops when the hardware continuously returns a busy
response. On timeout, the function writes the busy status back and breaks o=
ut
of the loop.

> Fix this by introducing AP_RESET_MAX_WAIT (2000ms) and breaking out
> of the poll loop when elapsed time reaches that threshold. On
> timeout the final busy status is written back to q->reset_status
> so that callers inspecting reset_status.response_code after
> flush_work() see a non-zero value and can return an appropriate
> error. vfio_ap_free_aqic_resources() is called before returning
> to release any KVM ISC registration and pinned NIB page,
> consistent with all other early-exit paths in the function.

[Severity: Medium]
Is this description accurate? The code in the patch explicitly omits calling
vfio_ap_free_aqic_resources() on the timeout path and includes a large
comment explaining why it must leak these resources.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 3f99b239fa959..7a9b5448e90a0 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1971,6 +1972,27 @@ static void apq_reset_check(struct work_struct *re=
set_work)
>  					      status.response_code,
>  					      status.queue_empty,
>  					      status.irq_enabled);

[Severity: High]
This is a pre-existing issue, but does the early return on -EIO just above
this block need to update q->reset_status before returning?

If ap_zapq() initially succeeded, q->reset_status.response_code would be 0.
If a subsequent ap_tapq() results in an -EIO from apq_status_check(), the
function returns immediately. Will the caller vfio_ap_mdev_reset_queues()
incorrectly assume the reset was successful because it sees a 0 response co=
de?

> +			if (elapsed >=3D AP_RESET_MAX_WAIT) {
> +				/*
> +				 * Timed out waiting for reset to complete.
> +				 *
> +				 * The AQIC resources associated with this queue - the pinned page
> +				 * containing the NIB and the registered guest ISC - cannot be freed
> +				 * here. The NIB is the active DMA target for AP interrupt delivery
> +				 * until the reset completes; freeing the pinned page while the
> +				 * hardware may still write to it would result in a use-after-free
> +				 * kernel crash.

[Severity: Critical]
The comment mentions leaking the NIB page to avoid a use-after-free, but do=
es
the driver hold an independent reference to the page?

When the user process terminates and the VFIO container is closed, the VFIO
core automatically unpins tracked pages. Will the physical page be returned=
 to
the buddy allocator while the active hardware can still perform a DMA write=
 to
it, potentially corrupting memory reallocated to other processes?

> +				 *
> +				 * If the reset eventually completes, interrupts will be terminated
> +				 * and the pinned NIB page and ISC registration will be leaked. This

[Severity: High]
By intentionally skipping vfio_ap_free_aqic_resources(),
kvm_s390_gisc_unregister() is never called. Does this mean KVM ISCs are
permanently depleted for the guest?

Also, when the KVM guest is torn down, will kvm_s390_gisa_destroy() trigger=
 a
host kernel WARN due to the non-zero alert mask?

> +				 * is preferable to either a use-after-free or waiting indefinitely:
> +				 * apq_reset_check() holds the matrix_dev->mdevs_lock mutex, which
> +				 * serializes access to all mdev objects system-wide, so blocking
> +				 * here would stall all other guests using AP queues.
> +				 */
> +				memcpy(&q->reset_status, &status, sizeof(status));
> +				return;
> +			}

[Severity: Critical]
If the timeout handler leaves q->saved_iova and q->saved_isc populated, what
happens when this queue is assigned to a new mdev?

When the new guest enables interrupts, vfio_ap_free_aqic_resources() will
process the old guest's saved IOVA and ISC using the new guest's KVM and
VFIO container. Could this unpin an active page in the new guest or corrupt
its GISA state?

>  		} else {
>  			if (q->reset_status.response_code =3D=3D AP_RESPONSE_RESET_IN_PROGRES=
S ||
>  			    q->reset_status.response_code =3D=3D AP_RESPONSE_BUSY ||
>  			    q->reset_status.response_code =3D=3D AP_RESPONSE_STATE_CHANGE_IN_=
PROGRESS ||
>  			    ret =3D=3D -EAGAIN) {
>  				status =3D ap_zapq(q->apqn, 0);
>  				memcpy(&q->reset_status, &status, sizeof(status));
>  				continue;
>  			}

[Severity: High]
Does this bypass the timeout check entirely if apq_status_check() returns
-EAGAIN?

The loop will drop into this else block, re-issue ap_zapq(), update the
status, and continue without evaluating the elapsed time. Will the worker
spin indefinitely if the hardware continuously returns a state that triggers
-EAGAIN?

>  			if (q->saved_isc !=3D VFIO_AP_ISC_INVALID)
>  				vfio_ap_free_aqic_resources(q);
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824215603.8193=
79-1-akrowiak@linux.ibm.com?part=3D3
