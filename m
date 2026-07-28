Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C874380FD7;
	Tue, 28 Jul 2026 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211540; cv=none; b=lG6B7Xyh8mkfbVAAuPc17HF4qKlPXjoWlaBGNO0zMIzujn3WwoVbLtcSRqGX9BZHuGt+BuRksWZL8KooBGCOFeJwDg6GPRy3BVCBnXx2gCIHh3yay19WPjGTeH/qHeIXW6ndHyVkBgEUvmKzruKGeBn0RoBpAQBivHVj5xO2iXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211540; c=relaxed/simple;
	bh=hnnVSPHIQ5HsHmtOozxWiWBt31Se9p7NegGybRAMtZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lH446IZU7xG583tVzUg1QRqsgJJuwmjlq6zP0MD0TVleAs2vFPN8xXnDmkCKFlbresrYomyAzQqBq3ELAOJsbw0fJAJ2NpF06/OKM1MCcCxADC/xwsyHZm5O8ho3SH65H9XG+A+pLxE1phHlQ99twqrSmuhKliz4dDa3sE410dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJYsellM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJYsellM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879F01F000E9;
	Tue, 28 Jul 2026 04:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211538;
	bh=mQx2bslWMyi7VkCYMYu+m+lJ+WSnzKnGb9GrwX16f6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJYsellMpca5pzxosoSA+Y599y89GT1EzGjG4FaXVRRfHD+RpII1WgOnuE/ZPAwKu
	 uNB9WkBczZ8fMvpEZDOprspkUAC7nspJNXzY+y2B4LLzR8/3I2OZBLMC9G3zg7IRXb
	 Z83bNFFAfB7DxeRgW9LuMUorgamxu81uSc6Z7zgrsH9WzTaBhxnRFV0ElcC1QObUP9
	 6hJUvZuSSFBzxPGKEP+9VbYajD3cnOen6JD4c6FeKAgw/Sn4Ul/NeuYwzliy911B5f
	 SO3GFlZlu62BVD750gUpbej1wrEV9wDHCMW4i72SAwgizK2dwRdrduaFSxyRzI0YMz
	 gKTpE0T98v46A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/10] s390/vfio_ccw: selectively expand io_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-10-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:05:38 +0000
Message-Id: <20260728040538.879F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete locking of `private->crw` list mutations, leading to li=
st corruption.
- [High] Race between `vfio_ccw_sch_event()` and device removal leads to Us=
e-After-Free of `private`.
--

--- Patch [9]: [PATCH v9 09/10] s390/vfio_ccw: selectively expand io_mutex =
---
commit d6adad0fd2f3370cc987cc74322451109b224ff2
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: selectively expand io_mutex
   =20
The io_mutex was originally defined to serialize io_regions, but has become
associated with I/O resources due to their close relationship. This patch
expands the scope of io_mutex to close remaining race windows. It also takes
advantage of workqueue element deferral for cp_free().

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index f3015132d4b5f..9269b54f5cfd4 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
> =20
> +	mutex_lock(&private->io_mutex);
>  	crw =3D list_first_entry_or_null(&private->crw,
>  				       struct vfio_ccw_crw, next);
> =20
>  	if (crw)
>  		list_del(&crw->next);
> =20
> -	mutex_lock(&private->io_mutex);

[Severity: High]
This isn't a bug introduced by this patch, but does expanding the io_mutex
to cover this list manipulation still leave a data race?

While the reader side now holds io_mutex, the writer side in
vfio_ccw_queue_crw() adds items to the list without acquiring this lock:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
    ...
    list_add_tail(&crw->next, &private->crw);
    queue_work(vfio_ccw_work_q, &private->crw_work);
    ...
}

Since vfio_ccw_queue_crw() executes from asynchronous CSS driver callbacks,
can it run concurrently with the reader and lead to linked list corruption?

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> index 4d47a3c7b9a06..5fd94e9d5c618 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -170,6 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state =3D VFIO_CCW_STATE_NOT_OPER;
> =20
> +	/* This routine could be called from IRQ context, so defer */
>  	queue_work(vfio_ccw_work_q, &private->notoper_work);
>  }

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free and
subsequent workqueue list corruption if the device is being concurrently
removed?

In vfio_ccw_sch_event(), the private pointer is fetched locklessly before
acquiring sch->lock:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_event() {
    ...
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
    spin_lock_irqsave(&sch->lock, flags);
    ...
    if (private)
        vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
    ...
}

If the device is unbound via sysfs concurrently, vfio_ccw_sch_remove() can
clear the drvdata and free the private pointer before vfio_ccw_sch_event()
acquires the lock.

When fsm_notoper() is then called, it will queue the embedded notoper_work
struct on the freed private pointer. Could this corrupt the kernel workqueue
lists?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D9
