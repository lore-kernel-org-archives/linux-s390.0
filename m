Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46C48382B
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031557; cv=none; b=kAQtI0DM5R3WX8zADNYZKKVTcPhs+BfDXpj3bjYf6lu+fcqOiICZIEJQpcu7pvsz3gUyUlbRizkqUIcCJH3EHm0sJGCch2IiQR4Verd7YjihO/ijrRJfLkWA3g2/FT1oinJ7/Sk2Q/6G16ExJUPmrxJf8qizTJZfR0SOEsQjhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031557; c=relaxed/simple;
	bh=+SK1Quulhdtbf/VpFtrY/8Rcg+uT18W3pPfm9fijvfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U5u95uby6WN77Kmy5GIZhuMy7jb8Taa/pT0q5qYlWXdU+d1h6gnWHdesxynH5XMQvN/BFp8p1uTSYaN2ZZMZlztifSHEJJrPiJqgLb11oZVrCXAbfs6X67MNS8/1Fax1/lIYWuNXEPykQ+DSHQ+zNai2wohNIq8Bog7sXTjhmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVhhSWlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVhhSWlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6B21F00A3A;
	Thu,  6 Aug 2026 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031544;
	bh=O17AqQFLTl7z5ib+33wxQq0niHxlFEIXp/1koU/O7PM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVhhSWlbQ3pdE46fJGWdjMx6in939pE9jkLmEadAzLvWm88zRQr8xBR0LHSd6zxKf
	 qZRkMWPGdZdLGaNdgYCkIeG2iibP/P/Cy6RBcgBI35nY+vu9OVlX3ooKbWqQ97x37t
	 3H0EYwdfpDl41fVNPDshJ7USNMuNulbV2sm/sPBhfWLgjDk/97IpsSKQxPmF4LgHyy
	 zuVuRstlwa9hquFLxipZndi+OkqpFP4s2t/UURcqx1v28sDXELl5XyXCzuEmXU5zrh
	 g07H1ahl4TgK5pROo++jWUpOnJuW90NZAfsfeN5hh87j/EQJbSYuz7aRtSkwh/YoDF
	 eKmdjTkR3QS3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-2-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:52:23 +0000
Message-Id: <20260806155223.BD6B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature loop termination in `vfio_ccw_sch_quiesce` due to re-use=
d completion without re-initialization.
- [High] Unconditional NULL pointer dereference in asynchronous subchannel =
callbacks.
- [High] Leaked workqueue items (`io_work` and `crw_work`) during device te=
ardown leading to Use-After-Free.
- [High] Lockless state access in `vfio_ccw_sch_io_todo` causes a double-fr=
ee of channel program (`cp_free`).
--

--- Patch [1]: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to vf=
io_ccw_sch_quiesce() ---
commit c7b4889a75b6cf11527a57bff8438c3c08dac9c4
Author: Heiko Carstens <hca@linux.ibm.com>
Subject: s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce=
()

This patch adds the __must_hold attribute to vfio_ccw_sch_quiesce() to
inform context analysis that sch->lock must be held on function entry.
This resolves a thread-safety-analysis warning during compilation.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 1a095085bc728..ed9ca77c5b23f 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -35,6 +35,7 @@ debug_info_t *vfio_ccw_debug_trace_id;
>   * Helpers
>   */
>  int vfio_ccw_sch_quiesce(struct subchannel *sch)
> +	__must_hold(&sch->lock);
>  {
>  	struct vfio_ccw_parent *parent =3D dev_get_drvdata(&sch->dev);
>  	struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);

[Severity: High]
This is a pre-existing issue, but does the completion handling in this loop
allow premature termination?

If wait_for_completion_timeout() times out, but a late interrupt arrives
and calls complete(), the completion's done counter becomes greater than 0.

On the next iteration of the do/while (ret =3D=3D -EBUSY) loop in=20
vfio_ccw_sch_quiesce():

do {
        ret =3D cio_cancel_halt_clear(sch, &iretry);
        ...
        if (ret =3D=3D -EBUSY)
                wait_for_completion_timeout(&completion, 3*HZ);
        ...
} while (ret =3D=3D -EBUSY);

Could wait_for_completion_timeout() see done > 0 and return immediately
without waiting, causing a tight spin loop calling cio_disable_subchannel()
since there is no reinit_completion() inside the loop?

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of a NULL
pointer dereference when fetching the parent pointer?

During device removal, vfio_ccw_sch_remove() sets the drvdata to NULL:
dev_set_drvdata(&sch->dev, NULL);

If an asynchronous event like an interrupt triggers concurrently before the
CSS core fully detaches the driver, could vfio_ccw_sch_irq() or
vfio_ccw_sch_event() fetch a NULL parent and immediately dereference it
in this sequence?

struct vfio_ccw_parent *parent =3D dev_get_drvdata(&sch->dev);
struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);

[ ... ]
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
> index 0501d4bbcdbd6..8db29519dbfde 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -127,7 +127,8 @@ struct vfio_ccw_private {
>  	struct work_struct	crw_work;
>  } __aligned(8);

[Severity: High]
This is a pre-existing issue, but does the device teardown path leak these
pending work items?

When a mediated device is removed, vfio_ccw_mdev_release_dev() frees the
private structure without calling cancel_work_sync() on io_work or crw_work:

static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
{
        ...
        kfree(private);
}

Additionally, fsm_close() can skip the global flush_workqueue() if
cio_disable_subchannel() immediately returns 0:

ret =3D cio_disable_subchannel(sch);
if (ret =3D=3D -EBUSY)
        ret =3D vfio_ccw_sch_quiesce(sch);

If a work item is left pending on the workqueue, could it execute after
the private structure has been freed, resulting in a use-after-free?

> -int vfio_ccw_sch_quiesce(struct subchannel *sch);
> +int vfio_ccw_sch_quiesce(struct subchannel *sch)
> +	__must_hold(&sch->lock);
>  void vfio_ccw_sch_io_todo(struct work_struct *work);
>  void vfio_ccw_crw_todo(struct work_struct *work);

[Severity: High]
This isn't a bug introduced by this patch, but does the lockless state check
in vfio_ccw_sch_io_todo() allow a double-free of the channel program?

The workqueue function vfio_ccw_sch_io_todo() reads private->state
locklessly:

if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
        cp_free(&private->cp);
        cp_is_finished =3D true;
}

Concurrently, fsm_close() holds sch->lock, changes the state to STANDBY,
unlocks, and also calls cp_free():

spin_unlock_irq(&sch->lock);
cp_free(&private->cp);

Since vfio_ccw_sch_io_todo() operates outside sch->lock, could both threads
evaluate their conditions simultaneously and concurrently execute cp_free()
on the same channel program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806153849.2622=
576-1-hca@linux.ibm.com?part=3D1
