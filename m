Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443224;
	b=hjORljda1ZmZXSvSx672k0qnkF4NrY4cKc4uyB3ojK3slTCE+S0qJPWNs8xSaHxJ+r4q
	 D4wbHKzRJAJUff0/IdEYbTOq7fXQoAAIFmdVmZ+2zgbY5d1NWlTelpMWYs7aBQD2T7ITc
	 L9KnOFh/Gh+68iTAH69lXeYIe/gYQZbq86RngVh9jFbAgQe1kaIM1yClrxkNtgxjdkgi2
	 O9ZsaPxcDWidgSIpieLyGb/LzoGGemDTEwtKDmSYpkGdj82c6H/ZhIHbUq5zhNgcbKjvl
	 QCAPTXAbzVAlqaXzrlWOWCiPz+lmJJ5r/lg0EYtCtQ5zhifQ5KpfrSsGDU8ZX6SICmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HUXGBqAKUUw/5UV1ZkJ1Lmv7bu7TigkjFVaDq86o/Ps=;
	b=nggaBN5Nc17hU5wTBCOaw66LMNCYl+w9/lMpncg1cVONvf4K/ukSjL2dlJDrNicjgN35
	 4l/3r9DszwFRXG0A3TlKi8RN/Sf3SaBNVVuMRZiz98dprnh1q0ziXHHT+qyEn1ilEoBp2
	 7M0AdpKrhOxin/5tPnMZ9ZGZO5QEFkrO1e+M4dc8BEP7ZZYXqIrqtvbJCltgunRWSsIvg
	 He9Jl9kvtYX09pni9Fs3rZo01x+u+I9KrpmrOEpkYFOXjnx+yLJ4XshIzd/PfCR0xl9Kr
	 IB88fd79wY/3brpW5gxmH2T8TdS374RXTNPHRVZxHPYNnd3cs5vQ9cJIZ7YBe3GHctA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHC4AR0W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDDD606A326
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHC4AR0W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6959C1F000C4;
	Mon, 19 Oct 2026 20:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443223;
	bh=HUXGBqAKUUw/5UV1ZkJ1Lmv7bu7TigkjFVaDq86o/Ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHC4AR0W2/8XZJFp6NZdZpbwVUZbkbQrxkjsBzvf6I0bLlarwM/SSV4XFH7aW6/+1
	 zHP0ncO8J0U4iC62xr5a0rghzz7e4gxluOtk+28Ys1gUhkk16R+YU/6shsCBS0iRWW
	 s9lpsLAghqkUp1qjNAEt3MkzLcyzrZcNvazKo3gdFGRzMJYgx7OdpnVx1fxW6mjxZR
	 CI4GvPb7rGXCwKCfxRBJp7m+jrgPFwF45ScOnSOuSv1XnhU516gU7TCc3IeqoMb+34
	 C+TnBiG+PTr9SdC+ioXhifrVhHWIu7j4MLFtNb4D5w2rcQnnG5bkQFmdRhu4NI9BsC
	 Ok+6Q55UsGaHw==
Message-ID: <sashiko-outbox-178195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/tape: cancel delayed work before freeing device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019203458.1365046-1-tristmd@gmail.com>
References: <20261019203458.1365046-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:53:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] s390/tape: sleep in atomic and deadlock in tape_put_device()
- [High] s390/tape: unsafe and incomplete delayed work cancellation in tape=
_put_device()
--

commit e3b5b4c025b8afebd3737fb5bf4782522c4d545f
Author: Tristan Madani <tristan@talencesecurity.com>

s390/tape: cancel delayed work before freeing device

This commit adds a call to cancel_delayed_work_sync() in tape_put_device()
when the reference count reaches zero to ensure the delayed work tape_dnr
has finished before freeing the tape_device structure.

> diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
> index bd8e3deb11993..e3aacfab2cc7a 100644
> --- a/drivers/s390/char/tape_core.c
> +++ b/drivers/s390/char/tape_core.c
> @@ -532,6 +532,7 @@ tape_put_device(struct tape_device *device)
>  	DBF_EVENT(4, "tape_put_device(%p) -> %i\n", device, count);
>  	BUG_ON(count < 0);
>  	if (count =3D=3D 0) {
> +		cancel_delayed_work_sync(&device->tape_dnr);
>  		kfree(device->modeset_byte);
>  		kfree(device);
>  	}

[Severity: High]
Can calling cancel_delayed_work_sync() in tape_put_device() sleep in atomic
context and self-deadlock?

tape_delayed_next_request() holds get_ccwdev_lock(device->cdev) with
interrupts disabled while calling __tape_start_next_request():

drivers/s390/char/tape_core.c:tape_delayed_next_request()
	spin_lock_irq(get_ccwdev_lock(device->cdev));
	__tape_start_next_request(device);
	spin_unlock_irq(get_ccwdev_lock(device->cdev));

When starting or cancelling a queued request fails,
__tape_start_next_request() invokes request->callback while still holding
get_ccwdev_lock(device->cdev):

drivers/s390/char/tape_core.c:__tape_start_next_request()
		if (request->callback !=3D NULL)
			request->callback(request, request->callback_data);

For asynchronous requests such as medium sense queued via
tape_3490_medium_sense_async() (which __tape_start_request() permits in
TS_UNUSED and TS_INIT states), the callback __tape_3490_medium_sense() calls
tape_free_request() -> tape_put_device(request->device).

If tape_generic_remove() runs while the device is in TS_UNUSED or TS_INIT, =
it
does not call __tape_discard_requests(device) before dropping its reference:

drivers/s390/char/tape_core.c:tape_generic_remove()
		case TS_UNUSED:
			tape_state_set(device, TS_NOT_OPER);
			spin_unlock_irq(get_ccwdev_lock(device->cdev));
			tape_cleanup_device(device);
			break;

This leaves request->device as the final reference on struct tape_device wh=
ile
device->tape_dnr is still pending. When tape_delayed_next_request() runs and
__tape_start_io() fails on the non-operational device,
__tape_3490_medium_sense() -> tape_free_request() -> tape_put_device() drops
ref_count to 0 inside tape_delayed_next_request() under spin_lock_irq().

At that point, cancel_delayed_work_sync(&device->tape_dnr) sleeps with
interrupts disabled and deadlocks waiting for the currently executing
tape_delayed_next_request() work item to finish (and if it returned,
kfree(device) would free device before tape_delayed_next_request()
dereferences device->cdev in spin_unlock_irq()).

Similarly, __tape_do_irq() -> __tape_end_request(),
tape_long_busy_timeout(), and __tape_discard_requests() also call
tape_put_device() while holding get_ccwdev_lock(device->cdev) in hardirq or
softirq context. If count =3D=3D 0 is reached there, cancel_delayed_work_sy=
nc()
will sleep in atomic context and deadlock if tape_delayed_next_request() is
waiting on get_ccwdev_lock(device->cdev).

[Severity: High]
Also, is cancelling device->tape_dnr only when device->ref_count reaches 0
sufficient to prevent tape_delayed_next_request() from accessing a freed
struct ccw_device?

In tapechar_open(), an open file descriptor holds a reference to struct
tape_device in filp->private_data:

drivers/s390/char/tape_char.c:tapechar_open()
	rc =3D tape_open(device);
	if (rc =3D=3D 0) {
		filp->private_data =3D device;
		stream_open(inode, filp);
	} else
		tape_put_device(device);

If the ccw_device is removed via tape_generic_remove() while the character
device is open and device->tape_dnr is scheduled:

drivers/s390/char/tape_core.c:tape_generic_remove()
	device =3D dev_get_drvdata(&cdev->dev);
	if (device) {
		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
		dev_set_drvdata(&cdev->dev, NULL);
		tape_put_device(device);
	}

tape_put_device(device) decrements device->ref_count to a non-zero value
because filp->private_data still holds a reference, so
cancel_delayed_work_sync(&device->tape_dnr) is not called during removal.

Once tape_generic_remove() returns, the driver core can release and free
cdev while device->tape_dnr remains pending. When tape_delayed_next_request=
()
subsequently runs before the user closes the file descriptor, won't
spin_lock_irq(get_ccwdev_lock(device->cdev)) dereference the freed
device->cdev?

Would it make more sense to cancel device->tape_dnr (and discard any queued
requests across all states) during device teardown in tape_generic_remove()
after dropping get_ccwdev_lock(device->cdev), rather than inside
tape_put_device()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019203458.1365=
046-1-tristmd@gmail.com?part=3D1
