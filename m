Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6553B1B3;
	Tue, 28 Jul 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203593; cv=none; b=CE0a3iqiYWCBTsHyub/R/i35IcbvWuZqO9JPuD/ykByCooMuJcfyuFJnTX/NPoL3yzoYZfaY8r4z9qwA267SRXMLa3id2HILnL4r7A3M0SBEGCl0TQrt8gIwvKdFX3hXCj3vKK5hH7HEFemzyqdtAONFvwKeQc45SHMTo0Q09Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203593; c=relaxed/simple;
	bh=Wy/iHRDfSAkLrTICb6YjW2wkIcMRPYEs5syK02yE880=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJ9J86zSvdpZ0KRDkiYZT5avRYwsryObLNHjWSi9rRWKWw7D9v/k1hsrQCfboI/deLLc3dikKykWpX/hvDs4dthDj1OayJi3W91JgoloBT6+jtDfMCPItC9hHKexGEMhvdQIw9R/tHEifgWNETLXdCgu0/P2MVD/TvhGfUXamb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5bTwyGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5bTwyGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D721F000E9;
	Tue, 28 Jul 2026 01:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203591;
	bh=rFQjlvpeUcY66+bITHUU7uBWYasqPOebxwj+zrlmNTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5bTwyGBEZQGTckjEEfS4H5aPKdklPaeFgKsHib7hOZ8Yrbj6Teb/egPm9ldghUVf
	 BdHOGrQHJuh3I3RxbKuQ47MrCGaJsEd8kJv8laLXG4im8Lhbps2RupXPZLXcw/zw9c
	 gqABVlZrDIs/6oDJx8qtCF2XVdwj9lzAOX+g8gtwMVcxMorULtqu6DBPVHMNRf5lWb
	 w6IFTv5emh4wHFVyxnpQ86yF7+h8/UaGdvB60oGPUC4+GzlDygzyJ40HzHB+t0jqgh
	 JmZ+bfh5mFptqVadQrDmYZ94QRTZRVjam9kqfGaf/p5lhsTq7lGG3LH7NBTmK09z+t
	 9RbQaZxtYvfWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/10] s390/vfio_ccw: cancel existing workqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-8-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:53:10 +0000
Message-Id: <20260728015311.32D721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between mdev_remove and CSS callbacks allows work t=
o be queued after cancel_work_sync(), leading to a Use-After-Free.
- [High] Concurrent lockless modifications to the private->crw list cause l=
ist corruption.
- [High] Eventfd contexts for IRQ triggers are leaked upon device close and=
 release.
- [High] Unsynchronized clearing of `private->completion` can lead to stack=
 use-after-free in the interrupt handler.
--

--- Patch [7]: [PATCH v8 07/10] s390/vfio_ccw: cancel existing workqueues -=
--
commit 713bc2489172cb8218b7c8bfb484ab3caaed51a1
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: cancel existing workqueues

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 032a1cdf4df70..bc8eb485d03fd 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -131,6 +131,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  	struct vfio_ccw_crw *crw, *temp;
> =20
> +	/*
> +	 * Ensure these work items are fully drained, so none can
> +	 * fire after being released.
> +	 */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);

[Severity: High]
This is a pre-existing issue, but does this fully prevent the work from
being dispatched after the private struct is freed?

If vfio_ccw_mdev_remove() clears drvdata without holding sch->lock:

vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    ...
}

And a concurrent hardware channel path event triggers vfio_ccw_chp_event()
which fetches the private pointer locklessly:

vfio_ccw_chp_event() {
    ...
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
}

Could vfio_ccw_chp_event() queue private->crw_work after this
cancel_work_sync() call has already finished, leading to a use-after-free
when private is subsequently freed?

> +
>  	list_for_each_entry_safe(crw, temp, &private->crw, next) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to iterate and
delete items from private->crw without holding a lock here?

In vfio_ccw_queue_crw(), elements are added to the list while holding
sch->lock:

vfio_ccw_queue_crw() {
    ...
    list_add_tail(&crw->next, &private->crw);
    ...
}

However, vfio_ccw_crw_region_read() removes items without holding sch->lock
or any other synchronization:

vfio_ccw_crw_region_read() {
    ...
    if (crw)
        list_del(&crw->next);
    ...
}

Can concurrent asynchronous hardware events and userspace reads corrupt this
doubly-linked list?

>  		list_del(&crw->next);
>  		kfree(crw);

[ ... ]

> @@ -202,6 +209,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> =20
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
> +
> +	/*
> +	 * Ensure these work items are drained, in the event the
> +	 * device is re-opened instead of released
> +	 */
> +	cancel_work_sync(&private->io_work);
> +	cancel_work_sync(&private->crw_work);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the
eventfd contexts for the IRQ triggers?

Userspace sets IRQ triggers via vfio_ccw_mdev_set_irqs(), which takes a
reference to the eventfd_ctx.

If userspace exits or crashes without explicitly disabling the IRQs, neither
vfio_ccw_mdev_close_device() nor vfio_ccw_mdev_release_dev() appear to call
eventfd_ctx_put() for io_trigger, crw_trigger, or req_trigger.

[Severity: High]
This is a pre-existing issue, but can the unsynchronized clearing of
private->completion lead to a stack use-after-free in the interrupt handler?

In vfio_ccw_sch_quiesce(), if wait_for_completion_timeout() times out, it
clears the pointer without holding sch->lock:

vfio_ccw_sch_quiesce() {
    ...
    private->completion =3D NULL;
    ...
}

Concurrently, fsm_irq() might read the non-NULL pointer:

fsm_irq() {
    ...
    if (private->completion)
        complete(private->completion);
    ...
}

If quiesce returns and destroys the on-stack completion frame before
complete() executes, could the interrupt handler corrupt the stack?

>  	vfio_ccw_unregister_dev_regions(private);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D7
