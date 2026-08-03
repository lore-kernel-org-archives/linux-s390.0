Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34127384CE8;
	Mon,  3 Aug 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775165; cv=none; b=lmzknZ5wh2SANvgwl49Lww979VJQUhdXvvb1kaHexelUsxh23QQN6xB29iXiQMRDWZ7Jo8LuEfD2bfywQntTtDXDSL5ycL15FWJZ2+pxw6V7CLqaoqf22nlvSP7ufmjMPtvqjHdzQF+wvDQexdtBwU83Q9zlBCMBQdTlpXsmc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775165; c=relaxed/simple;
	bh=QmJeBR5NajlMTGDZPK9ikL1f0g7LSpVaMDpAuEcPRtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dafR7Jq2HKXqepk5wmKx+owWehjqLZmdGJnJVDdzDs5/4H8L5GgR4hARX2CIhvAdRuzuGnQ4y1UmEM9jicML4NQmjZmSaJ04vXa7vr/v/MO5wxk6rTKluVWlLYCp4tNfGp2aQ4gmvFx+7n8IUouyLe5QTCyPN+NgwPX8IP2GHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4iRJVk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4iRJVk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CD61F000E9;
	Mon,  3 Aug 2026 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775163;
	bh=BmHfcOTwwzAQisbraQLPO8xtl7B8sM/d3lwmRjh3uxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4iRJVk21OH+JTUNL0+SRNyQgTuTB1HRbLE/QVKyflgNmRoXAb36DqSZCtGM5RO6t
	 7Qv07306HFu2rExvuCFILIiTxW0SDPRTWsyfuWhPzThVZbqkS8uX8jcrbvBKpQKBB8
	 HDXawtLYcrhOkGJdGlMyY+ruytCmBXvepCuFbwPyztQNKItruhdGyICsGh53TR543W
	 pMfh1DoTiAnagGlxN3Wg7f1XFQD8VCsEm2LS++NeA85tmMo1RnipADbctKTmpFWfYv
	 9S0MpW1gCOwereJ5tJ0XwVMcW0YwE0hSsQHbNGoE6FifYIr3DSMRixb75S6GkzyC1b
	 t51vRddAK7PNQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 08/23] s390/vfio_ccw: Move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803160924.236807-9-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:39:22 +0000
Message-Id: <20260803163923.66CD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `cp_free()` can lead to a double-free of c=
hannel program resources due to missing locking.
- [High] A TOCTOU race between subchannel events and mdev removal allows an=
 asynchronous event to queue work on a freed vfio_ccw_private structure.
--

--- Patch [8]: [GIT PULL v1 08/23] s390/vfio_ccw: Move cp cleanup out of no=
t operational ---
commit aa01cda35a6813e56642eb80e4a1779189d3de13
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Move cp cleanup out of not operational

This commit moves the cleanup of channel program resources out of the
not-operational state machine event and defers it to a workqueue. This avoi=
ds
potential locking issues with the cio subchannel lock when the device is lo=
st.

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

[Severity: High]
This is a pre-existing issue, but making the cleanup asynchronous
significantly widens the vulnerability window for a double-free.

Since vfio_ccw_notoper_todo() does not acquire io_mutex before calling
cp_free(), what happens if userspace concurrently closes the VFIO device fi=
le
descriptor?

If a device becomes not-operational, triggering vfio_ccw_sch_event() which
queues vfio_ccw_notoper_todo(), and concurrently vfio_ccw_mdev_close_device=
()
calls fsm_close() -> cp_free(), both threads could enter cp_free()
simultaneously.

Because the !cp->initialized check in drivers/s390/cio/vfio_ccw_cp.c:cp_fre=
e()
is non-atomic, both threads could bypass it and proceed to double-free the
channel program resources.

Could we acquire private->io_mutex before calling cp_free() here?

> +}

[ ... ]

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

[Severity: High]
This isn't a bug introduced by this patch, but transforming this cleanup in=
to
a queue_work() call exposes a specific use-after-free vector via a TOCTOU
race.

Looking at vfio_ccw_sch_event() in drivers/s390/cio/vfio_ccw_drv.c, the
private pointer is read locklessly via dev_get_drvdata(). If the thread is
preempted after obtaining this pointer, could a concurrent sysfs mdev_remove
call execute vfio_ccw_mdev_remove()?

If vfio_ccw_mdev_remove() clears the drvdata, flushes workqueues, and drops
the final reference to private, the memory is freed.

When vfio_ccw_sch_event() resumes, it would dereference the freed private
pointer to call fsm_notoper(), which then executes queue_work() on the freed
memory, potentially corrupting the global system workqueue.

Is there a way to ensure the lifetime of the private structure during this
event processing?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D8
