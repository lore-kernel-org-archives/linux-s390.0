Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72173D7D6A;
	Sun, 26 Jul 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087629; cv=none; b=AmtkZgdiZxMdeADcNNYb+q+c1bZroKZq+H5L+k0QVSwtkRLSex++l0o9RepbxevcqmYpsh3/48Z6gFZj1EG1pPLQAoXjkfrTOFFluE1Sa6wfAVKJx+25WFOYjbgXlp1z47BiakfpC3bdXie1+AW2BrMRGmUJd4wF6V50XJ4b6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087629; c=relaxed/simple;
	bh=bZRT/GisX9xCjoMfl6nCo5kWFtGq+4d9HW5YEvgpI4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i0GMfZ65i4gkBGzelUcvXiYbR5SyIb/xidc1GWOMsdYzS6pR03PIA1i61A3/rOo2eUBErpzl0t0bpzVPm0V7bQDmojzFLG7B1kzYcBhm1gd6m/QCm5YhYrkHxDZ2FIh2CSiPMeAYi5CXntNodzJ2IB1MFHsWK8kCVszEgmItJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix62LDCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix62LDCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107171F000E9;
	Sun, 26 Jul 2026 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087628;
	bh=YFmzsHU/Ye6cXghhccEIWqBPkWfcFUua6jbXJeex950=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ix62LDCQmMELadN32Qz8UoAb7ymJO8W+CXrxReMwR9enceu7xnnbcxc20xRIVLCOa
	 RJV3Pp800vmTeXnY2MGeKu2MfmNdYEpoMpCKBXJkms9qoPQLAWhZp8N6PLwKOp0A+8
	 6o0A6eFynFHH14WqU9nN/8UI10mnRWQQlGUeQG/3oxhgDBdBoY3as4ekkwZ86KJZyb
	 aUC7GkOUpcjlqdQtinMXYNboAkJZoR+oGqVvQYBujwx2LKVZom68pke7fmCKvn3/IX
	 +kCgrziJMyCOolMUwJq1uIwkcVygS56W8TlwFFvcMhtIZza36oeVLulHmDdP5thz3J
	 Xyzd+wcx3nPFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260726172153.1818056-9-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:40:27 +0000
Message-Id: <20260726174028.107171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Memory leak / API violation due to pinned pages remaining indefini=
tely when `dma_unmap` is called on a not-operational device.

Pre-existing issues:
- [High] Use-After-Free or Double Free of channel program resources due to =
concurrent execution of `fsm_close()` and asynchronous workqueues.
- [High] Data Race leading to Use-After-Free between `vfio_ccw_dma_unmap()`=
 and `cp_free()`.
- [High] Data Race causing List Corruption in the `private->crw` list.
--

--- Patch [8]: [PATCH v6 08/10] s390/vfio_ccw: move cp cleanup out of not o=
perational ---
commit 95b263299e23889427ae40eed564ae801fb6f8d2
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: move cp cleanup out of not operational

This patch defers the cleanup of the private channel program resources
from the fsm_notoper routine to the closure of the MDEV device. This aims to
prevent lock contention issues when the device asynchronously becomes not
operational.

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> index 4d7988ea47ef0..248adf1e77073 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -169,9 +169,6 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
>  	 */
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state =3D VFIO_CCW_STATE_NOT_OPER;
> -
> -	/* This is usually handled during CLOSE event */
> -	cp_free(&private->cp);

[Severity: High]
Does removing this cleanup leave pages pinned indefinitely if the device en=
ters
the NOT_OPER state?

If a guest unmaps DMA memory after the device enters VFIO_CCW_STATE_NOT_OPE=
R,
vfio_ccw_dma_unmap() calls vfio_ccw_mdev_reset().

However, in the NOT_OPER state, the FSM maps VFIO_CCW_EVENT_CLOSE to fsm_no=
p.
This causes the reset to return -EINVAL without freeing the pinned pages.

Could this leak the memory and violate the VFIO API contract?

>  }
> =20
>  /*

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index bd488e40e1531..a717174675bd6 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -210,6 +210,15 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
>  	cancel_work_sync(&private->io_work);

[Severity: High]
This is a pre-existing issue, but can vfio_ccw_mdev_close_device() trigger a
use-after-free by dispatching the close event before canceling the I/O
workqueues?

In vfio_ccw_mdev_close_device(), vfio_ccw_fsm_event() emits the close event,
which invokes fsm_close().

fsm_close() unconditionally calls cp_free() before cancel_work_sync()
completes.

Concurrently, the asynchronous workqueue vfio_ccw_sch_io_todo() can execute
and also conditionally call cp_free() locklessly.

Does this cause a double-free or use-after-free of the channel program
resources?

>  	cancel_work_sync(&private->crw_work);

[Severity: High]
This isn't a bug introduced by this patch, but does the CRW list suffer from
data races that could corrupt the list?

Looking at the CRW region handling, vfio_ccw_queue_crw() adds items to
private->crw using list_add_tail().

Conversely, vfio_ccw_crw_region_read() removes items using list_del().

Since both operate locklessly without a spinlock or mutex, could concurrent
execution corrupt the kernel linked list pointers?

> +	/*
> +	 * Ensure that a not-operational device has indeed
> +	 * freed any resources. Normally the interrupt handler
> +	 * or FSM close should do this, but there exists the
> +	 * possibility that a device removed from the config
> +	 * would have left some of this about.
> +	 */
> +	cp_free(&private->cp);

[Severity: High]
This is a pre-existing issue, but does calling cp_free() concurrently with
DMA unmap operations lead to a use-after-free?

In cp_free(), the channel program list is traversed and its elements are fr=
eed
locklessly:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    ...
    list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
        ...
        ccwchain_free(chain);
    }
}

Meanwhile, vfio_ccw_dma_unmap() invokes cp_iova_pinned(), which traverses t=
he
exact same ccwchain_list without holding any locks.

If cp_free() unlinks and frees the chains while cp_iova_pinned() is
traversing them, could this result in a use-after-free?

> +
>  	vfio_ccw_unregister_dev_regions(private);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D8
