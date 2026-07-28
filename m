Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27D25C818;
	Tue, 28 Jul 2026 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203358; cv=none; b=NUq2N76I32tnCFTctk+WRlOLq7SFKjQKvjvh87ae2+UjQXGCXova68Ke1k5WSTf3exuTRAg4y7p4VFnAcvVosro90e0l/kOz8czEziCBeLobXS95HOBjp3TcSWV0COcGgnDSPlbn2SuYv35iH6XwvMrS8Lr3hIHdX6ZNY2SLIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203358; c=relaxed/simple;
	bh=xT4XkISPkOnRoa7soU/FZz6gZqJ53qyYOO2Ww/dUql8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tNgGzPOPdyBwvOZhkgrz1jZcuJ+3ncrz0lQKztUIOZeLE2J6sy0RsS1njo8snFCD6c2iYYNHMhGn0+nemeXwSbvJY6wZnUBt1ye2O74cF9Dsjyl+r4Hun4ysP3bPBfO4nVpSJHjdESrrOdzjQDJShcV74fGU4izP+9oDn+8ex0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyuPP9lo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyuPP9lo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F411F000E9;
	Tue, 28 Jul 2026 01:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203357;
	bh=5N1+qjs0S2sSq5nbX32/oF6MWTBp+5dN/eZKWMKabCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WyuPP9loIKdS6nKOnA2UTV40plsa0aG0kq39/dAGhN4LcHbU+RmntRtiSFr0uDp+u
	 fzyWf9R3hUHd8UbnYvd51Du/gtXcjpgdeVM/JEa+IDE8QTBqOlEsx5bcJaz5is8/vS
	 xwIx1FZ5DhOjIneKolu/Pzel1xPamhXwaYkGtNj3GbNHc7ooJwzIupesQ+q4wlv9hh
	 I7r0AsbMaOWYWpCODIG6u8SsBEiNgxDsPS60CKO7c1LNKI8k+oCzK5M+N1MvZAsFaU
	 0rOhJH8nQNutI2CsTw/kBS0poj95nQtPJJwIByii8ml58IPAza8Ra9BQGnwIs7t1SE
	 1+azdavIwcFGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260728013509.1551753-9-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:49:16 +0000
Message-Id: <20260728014916.D8F411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Failure to cancel pending `notoper_work` during device release cau=
ses a workqueue leak and use-after-free on the `private` structure.
- [High] Missing `io_mutex` locking in `vfio_ccw_notoper_todo` leads to a d=
ata race with concurrent channel program operations.
--

--- Patch [8]: [PATCH v8 08/10] s390/vfio_ccw: move cp cleanup out of not o=
perational ---
commit bf6c617fa515fe63ff2d80efc36831d26b7cdedc
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: move cp cleanup out of not operational

The fsm_notoper() routine is called when the device has been lost, and is
no longer operational. Push the cleanup of the private->cp resources to a
workqueue, where it can be done safely under a common locking mechanism.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
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
> +

[Severity: High]
The commit message mentions performing the cleanup safely under a common
locking mechanism. Could this lockless call to cp_free() lead to a regressi=
on
with concurrent channel program operations?

If userspace initiates an I/O request, vfio_ccw_mdev_write_io_region()
holds io_mutex and processes the request via fsm_io_request() and
cp_init() / cp_prefetch().

Concurrently, if a hardware event triggers fsm_notoper() and queues
notoper_work, this worker executes vfio_ccw_notoper_todo() and locklessly
calls cp_free(&private->cp).

Should this function acquire io_mutex to prevent a data race with the
allocation and initialization of ccwchain structures in the I/O path?

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -133,7 +134,9 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
> =20
>  	/*
>  	 * Ensure these work items are fully drained, so none can
> -	 * fire after being released.
> +	 * fire after being released. The notoper_work struct is
> +	 * only meaningful if the device had been opened, which
> +	 * means it would have been cleaned in an earlier close.
>  	 */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);

[Severity: High]
Is the assumption that notoper_work is only meaningful if the device had
been opened always correct?

If a machine check or path loss occurs before the mediated device is opened,
vfio_ccw_sch_event() transitions the state from STANDBY to NOT_OPER via
fsm_notoper(), queuing notoper_work unconditionally.

Since the device was never opened, vfio_ccw_mdev_close_device() (which
flushes the work) is never called.

When the device is subsequently removed, this release function omits cancel=
ing
notoper_work. This could allow the workqueue to execute vfio_ccw_notoper_to=
do()
after the VFIO core frees the private structure.

Should cancel_work_sync(&private->notoper_work) be added here to prevent a
potential use-after-free on the private structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D8
