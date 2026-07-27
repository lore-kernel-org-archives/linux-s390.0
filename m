Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0B3CFF73;
	Mon, 27 Jul 2026 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182658; cv=none; b=vFln4BntVgWo9jnXcJGIGkbajzadsV1RFbQMNuiso0q6vpMDyzJDz+UFtwbg0dp8Cf+tD/PKfOMAWKKt25N+qQFnzKZVib1UUJaEHGgVMtTWVykF2AM+IWtWCveBCNPCgWdl0KSJDmFEZzqp/KXPlUQn9koEZhBFL9z+qeHFFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182658; c=relaxed/simple;
	bh=XLDJiv2AFZRL3Lsv6slBQrM4fWc2aw5A+s5aRnasFdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sFrQOPspgNBHFtRfZoqNQfoBkQyRPuiinhWD2CdoORDDi8LL6RaqU9WeCPXzqB1hqXzQiOo1PdqecGk6l1kGEVSijVn+agHNulkh1Vvyv70l4fVrCqDuPnGJMjJffpY0EEdm48oMT1QVtWjF6BQJuqg7s/bE0Eza9OYJaYuQOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3oS2hlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3oS2hlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383341F000E9;
	Mon, 27 Jul 2026 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182656;
	bh=Atq3qOksgVbPnOndK/3gfnZD5OSi5e4anEwuxyBVTfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3oS2hlGOekV50sckEan9HzXXD05+wo3g0ZVpFKBqUJvYlEVuHUFfAY6Va5e4JpQ2
	 MENrGJb8fy0+hzjQpgRKZ0Sd08phK0P/Srq5GJSmVaZ3TxJKC+9uNug9DRdNzLaZpt
	 BKPNvxZJMQbkxTUZN0WsuJOwVWbRNt87AGnHb4aC/uCWoxbsAwbgVz9xdzrI9exJy6
	 20CoDqfcwfIwMni8q4J+yghhllxc4PAcoHBtaNcHh2aAaSm7N0CQLfL5RcVJbZQueQ
	 Xn65X20Ct2BaKsBGjd6vOWJIukSokLnpDlr0NgXEf2WiJSfFiLkjzvXc0izKtq+Whr
	 Xu8S3Rt/3NLWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-9-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:04:15 +0000
Message-Id: <20260727200416.383341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Concurrent execution of `cp_free()` via `notoper_work` without=
 synchronization leads to data races and double-free of channel program res=
ources.
- [High] Canceling `notoper_work` during device release or close permanentl=
y leaks channel program resources if the work is pending.

Pre-existing issues:
- [Critical] A TOCTOU race in `vfio_ccw_sch_event()` can queue `notoper_wor=
k` on a freed `private` structure during concurrent device removal.
--

--- Patch [8]: [PATCH v7 08/10] s390/vfio_ccw: move cp cleanup out of not o=
perational ---
commit 553f8e3a76925556dafb452c43ea6719ddd97d0b
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: move cp cleanup out of not operational

The fsm_notoper() routine is called when the device has been lost, and is
(by definition) no longer operational. Push the cleanup of the private->cp
resources to a workqueue.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 1a095085bc728..c197ad5ab5805 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
[ ... ]
> @@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
>  		eventfd_signal(private->crw_trigger);
>  }
> =20
> +void vfio_ccw_notoper_todo(struct work_struct *work)
> +{
> +	struct vfio_ccw_private *private;
> +
> +	private =3D container_of(work, struct vfio_ccw_private, notoper_work);
> +
> +	cp_free(&private->cp);
> +}

[Severity: Critical]
Does this introduce a double-free race condition?  The new workqueue
callback invokes cp_free() asynchronously without acquiring io_mutex or
the subchannel lock.

Concurrently, fsm_close() might also execute and call cp_free(). Since
cp_free() checks and updates the initialized flag locklessly:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    ...
    if (!cp->initialized)
        return;

    cp->initialized =3D false;
    ...
}

Could both threads proceed to double-free the channel program resources and
double-unpin guest memory pages?

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> index 4d7988ea47ef0..4d47a3c7b9a06 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -170,8 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state =3D VFIO_CCW_STATE_NOT_OPER;
> =20
> -	/* This is usually handled during CLOSE event */
> -	cp_free(&private->cp);
> +	queue_work(vfio_ccw_work_q, &private->notoper_work);

[Severity: Critical]
This is a pre-existing issue, but could this queue_work() trigger a
use-after-free due to a race with device removal?

In vfio_ccw_sch_event(), the private structure is fetched locklessly:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_event() {
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
    ...
}

Concurrently, if userspace initiates device removal, vfio_ccw_mdev_remove()
clears drvdata and frees the private structure via vfio_put_device(). If
vfio_ccw_sch_event() is preempted after fetching the pointer but before
acquiring the lock, could it pass a freed private pointer into
vfio_ccw_fsm_event(), which then queues the notoper_work?

>  }
> =20
>  /*
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index bd488e40e1531..8ec6b175d9914 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
[ ... ]
> @@ -139,6 +140,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
>  	/* Should be empty, but just in case */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	cancel_work_sync(&private->notoper_work);

[Severity: High]
Does canceling the deferred cleanup synchronously here leak the channel
program resources?

If the device transitions to VFIO_CCW_STATE_NOT_OPER, queue_work() schedules
this cleanup. If the device is subsequently closed or released before the
workqueue executes, cancel_work_sync() will abort the pending cleanup.

Furthermore, because the state is VFIO_CCW_STATE_NOT_OPER, the normal close
handler is bypassed:

drivers/s390/cio/vfio_ccw_fsm.c:vfio_ccw_jumptable
    [VFIO_CCW_STATE_NOT_OPER][VFIO_CCW_EVENT_CLOSE] =3D fsm_nop,

Does this completely bypass cp_free() and permanently leak the allocations
and pinned guest memory pages?

> =20
>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D8
