Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC11A5B9D
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609059; cv=none; b=XDNLoWaSQ1dfRzW4fzQddzRHCDOPOIeX8GMaue9ruBeHpK0/NJhGNtQwZKQj6+76XBpzORA5LvXuCZ6MMvL0INONR9y1yl0VOHFNvyawtgseB4c3J7VXEj+P61BoSTenOb3VQAtFHFMy13/loQRTsiQAnGWi+NeGI5pn+Et44R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609059; c=relaxed/simple;
	bh=TzNqmqMmfgHmlOQZ4wx6Qw63LzTu40t2+BptVMjJU9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YA3aVh8g3bz3NWis0U4/WHOCXcEal9drIcpjQxZtWS/ev7pBi82lIpZMeNw/+dDeSDF+ZIjAO8wjT5an7F2dndjBrjwGUbckoTCQeLHIhvFg5osQ1E/aWFws4TIphkSFa7T8G+nSt7rA7+bOs1eriQYgzpn+oels+aH4f24HKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om5xyy7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om5xyy7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DD51F00AC4;
	Sat,  1 Aug 2026 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785609058;
	bh=9bWG1f6poMTw8hXJQJMu+bJ4wP9TiOpKF9p8J8do/ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Om5xyy7ZaCQd3LmHqr9cdo9FV4mlvdpw5ijNPSwvFsODUT43/VG+LVrfdtampQ5ph
	 usPaK8cq3x7vzXxUCisD5DKH5M8D131Spz2lcQ8r1QpVVb6o1L1psVu/rC2+zt3wFJ
	 zAoKkkfdHl0+sk+im5LPGR2r7MD1xLtCxGQqc/lhC1l6AwUPVwV7nxPu0Ibr4dsbNh
	 orRdPzlfZ8fkDo0lvpjpuzHeba58zIqj6tXmLxsrmgc7CVgtni5b1abZgmglj5s/sn
	 tGoi4X7WFe7klD4ltvSSDrwVsJ5hLr7noJhfrl74WcHAcy230UYgTb4AjwTpIKfnUY
	 ZW/WJvzhyOr7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/19] s390/dasd: Do not complete a failed ESE read
 as successful
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-2-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:30:57 +0000
Message-Id: <20260801183058.22DD51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] When `dasd=3Dfixedbuffers` is enabled, `dasd_eckd_free_cp()` o=
verwrites the zeroed bio buffer with uninitialized kernel memory from the b=
ounce buffer.
- [High] Missing Timer Cleanup & BH Schedule on early error paths in dasd_i=
nt_handler stalls the device queue.
- [High] Calling `rq_data_dir(req)` on `callback_data` causes a kernel pani=
c for internal driver requests because their `callback_data` is a special t=
ag (`DASD_SLEEPON_START_TAG`), not a `struct request *`.
--

--- Patch [1]: [PATCH v7 01/19] s390/dasd: Do not complete a failed ESE rea=
d as successful ---
commit 0082fb828aa2cab07732e010fb549548d0fd5d72
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Do not complete a failed ESE read as successful
   =20
dasd_int_handler() completes an NRF read of an unallocated ESE track by
calling ese_read() and unconditionally marking the request
DASD_CQR_SUCCESS. dasd_eckd_ese_read() can return an error before it has
zeroed the destination buffer: a failed sense-data parse or a current
track outside the requested range both return early, leaving the
destination pages untouched. The request is still completed successfully,
so the block layer is handed stale / uninitialized memory instead of
zeros.
   =20
Check the ese_read() return value and fail the request through the normal
error path instead of forcing DASD_CQR_SUCCESS.
   =20
Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned d=
evices")
Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 3181c06d91ce3..dbe3caa1e0b4a 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -1691,15 +1691,17 @@ void dasd_int_handler(struct ccw_device *cdev, un=
signed long intparm,
>  	if (dasd_ese_needs_format(cqr->block, irb)) {
>  		req =3D dasd_get_callback_data(cqr);
>  		if (!req) {
>  			cqr->status =3D DASD_CQR_ERROR;
>  			return;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but this early return path seems=
 to
miss cleaning up the timer and scheduling the bottom half.

If !req is true, the request is marked as DASD_CQR_ERROR and returned
early without clearing the timer and scheduling the bottom half via
dasd_device_clear_timer() and dasd_schedule_device_bh() in dasd_int_handler.
Does this leave the request stuck in the queue and stall the block device
queue until the timeout triggers ERP?

>  		if (rq_data_dir(req) =3D=3D READ) {

[Severity: High]
This is a pre-existing issue, but can this dereference an invalid address?

If an internal driver request (like space release via
dasd_eckd_release_space_trks) is initiated using
dasd_sleep_on_queue_interruptible(), it sets cqr->callback_data to a
special tag (DASD_SLEEPON_START_TAG, which is (void *)1), not a valid
pointer.

Since dasd_get_callback_data() would return 1, the !req check above is
bypassed. Would rq_data_dir(req) then dereference (void *)1 in
dasd_int_handler, causing a kernel panic?

> -			device->discipline->ese_read(cqr, irb);
> -			cqr->status =3D DASD_CQR_SUCCESS;
> +			if (device->discipline->ese_read(cqr, irb))
> +				cqr->status =3D DASD_CQR_ERROR;
> +			else
> +				cqr->status =3D DASD_CQR_SUCCESS;

[Severity: Critical]
This is a pre-existing issue, but is there a potential information leak when
dasd=3Dfixedbuffers is enabled?

If a user reads an unallocated area of a DASD device with dasd=3Dfixedbuffe=
rs
enabled, the driver allocates bounce buffers using kmem_cache_alloc without
__GFP_ZERO.

When dasd_eckd_ese_read() successfully zeroes the original bio buffer, this
request completes with DASD_CQR_SUCCESS. During cleanup, does
dasd_eckd_free_cp() unconditionally copy the uninitialized bounce buffer
back over the zeroed bio buffer for READ requests?

drivers/s390/block/dasd_eckd.c:dasd_eckd_free_cp() {
    ...
				if (dst !=3D cda) {
					if (rq_data_dir(req) =3D=3D READ)
						memcpy(dst, cda, bv.bv_len);
					kmem_cache_free(dasd_page_cache,
					    (void *)((addr_t)cda & PAGE_MASK));
				}
    ...
}

Could this overwrite the zeros populated by ese_read() with uninitialized
kernel memory, which is then handed to userspace?

>  			cqr->stopclk =3D now;
>  			dasd_device_clear_timer(device);
>  			dasd_schedule_device_bh(device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D1
