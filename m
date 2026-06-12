Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22729391E5B;
	Fri, 12 Jun 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280313; cv=none; b=Yqzb/aoUuRzBtS1jJb2osOLVg885S+5bXsn1XZdiUSOcj7rGKkcbGhNZzZy/xS6ZlcDlDxD+VFu6iM0i1ubZayCDG7i+EfxL59MM1h9FfvIoHqNIKOcnoIstvaw9UPTRo1hAdlZouEBhvg91byd/oDGSxw8qgejJkWnLbQoeJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280313; c=relaxed/simple;
	bh=jRcSZhdjW2n9VI50I1w0Kcv7cQL5bzw3mW5nIe5TGtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbaHIcavrfJPOjz6gt350+GGns8tXxW6wuKxiVN4JjEWfDhhYfuS706yjD7mABC2N2Ev4+FW3se2yAyaIaXdOFV8yVc+cm+lVvtRgIAWnhbZm5Dt7uo6bo+4Jylku1Ujd7zuxLlcZAPVtlkj3HvAGJVZCXblzSOEYnQRaHXZz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqMZBotc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqMZBotc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5101F00A3D;
	Fri, 12 Jun 2026 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280311;
	bh=l07fS9VgDLgMMxEiLe+PmpxkCgntnaR6UyN1wkidaPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqMZBotcDkmtYcrau4b04KAe7t0dTUecAPpYkmOQZU4q7XPff2zJKK1mWHNt/aK4Z
	 PWM7iv6YGG08QY8Ba/Eq1lTOOcNj67yHrw94bUlMs1VRi2Cj2GQaiG3u7otFv4cwQg
	 iKS1Ew4BycfPA9N/q8V59s6Jd/KPzfy5NGJ8m7U9Ly5pP0m9Dr70Pt82WFRoFx3Xml
	 hMSZxZXQbGKz/9FFz0nPXZsA5yY63CO6t3qkYVFqtM781zn4wg/64F4i8OyxWMUNi9
	 +gwCuOKsMTEvKEW9fJsY+z2PF/GnY7um+X8c8lypK7unStmwjBKI8DYPFqdamoVY2p
	 N/niSILW+An4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Bezenah" <wbezenah@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260612155407.199218-1-wbezenah@linux.ibm.com>
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:05:10 +0000
Message-Id: <20260612160511.1B5101F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] If deregistering indicators from the host fails with an error =
other than -ENODEV or -EINVAL (e.g., -EIO), virtio_ccw_drop_indicator() ski=
ps the cleanup of local adapter interrupt pointers, leading to a subsequent=
 use-after-free when virtqueues are deleted.
--

commit 6f54104d3533aa779587af76d171dec3ef8e1b8f
Author: William Bezenah <wbezenah@linux.ibm.com>

s390/virtio_ccw: Also suppress -EINVAL on device detach
   =20
This patch updates the error handling in virtio_ccw_del_vq() and
virtio_ccw_drop_indicator() to suppress -EINVAL along with -ENODEV
during device detach. This avoids spurious warning messages in the
kernel log when detaching virtio devices with multiple queues.

> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virti=
o_ccw.c
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -429,7 +429,7 @@ static void virtio_ccw_drop_indicator(struct virtio_c=
cw_device *vcdev,
>  			    vcdev->is_thinint ?
>  			    VIRTIO_CCW_DOING_SET_IND_ADAPTER :
>  			    VIRTIO_CCW_DOING_SET_IND);
> -	if (ret && (ret !=3D -ENODEV))
> +	if (ret && (ret !=3D -ENODEV) && (ret !=3D -EINVAL))
>  		dev_info(&vcdev->cdev->dev,
>  			 "Failed to deregister indicators (%d)\n", ret);
>  	else if (vcdev->is_thinint)
>  		virtio_ccw_drop_indicators(vcdev);

[Severity: Critical]
This is a pre-existing issue, but does this if/else structure create a
use-after-free risk during virtqueue deletion?

If ccw_io_helper() fails with an error other than -ENODEV or -EINVAL
(for example, -EIO), the first branch executes and logs the warning, but
the 'else if' branch is entirely skipped.

This means virtio_ccw_drop_indicators() is never called, failing to clear
the virtqueue pointers in the shared airq_info->aiv array.

Because virtio_ccw_del_vqs() subsequently proceeds to free these virtqueues
via vring_del_virtqueue(), the uncleared pointers in the shared airq_info
will point to freed memory.

If an adapter interrupt arrives later for this leaked bit, could
virtio_airq_handler() retrieve the dangling pointer and trigger a
use-after-free by calling vring_interrupt() on the freed queue?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612155407.1992=
18-1-wbezenah@linux.ibm.com?part=3D1
