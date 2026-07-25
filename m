Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB13314C4;
	Sat, 25 Jul 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994157; cv=none; b=dx/c+4QANlvhIixzYZHWRUAJ4knf/ygGXTOxTqJmYCmqMQrty/uN8xt4iYtSbCKGzNrNEeBLsTwQ2ks4XGY5kdn2wQEjbJ2ZIZ0XWzPoB1gyIGHUXdd5jnAaostXwrbEw2E7F+VsMICHsq+tnKupAltTnqFTzVUk1AgwCn70HPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994157; c=relaxed/simple;
	bh=XevTl8bv+oZOUecTqDREevIH4VAEVTHwLBXLBvCMSE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOaYR3spLuS4t+8BSuNLSR9CEYCdWpZFSFhllytmoJZZud78jP6GFUwRt+jBm5qq9Qk5nYsfJlfv1cGOCIy4LaksSIIPoKSvDngfVLLD3e3h5M4+JUWbYWBEfBmXN4UIEI92ObBcb2zcHaJaHHLHuIogXcwjmVKgoS/LnCPGJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDIE3HZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDIE3HZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF021F000E9;
	Sat, 25 Jul 2026 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994155;
	bh=6b2BTXwpIJY5wHDTB+aKUcJz/8ugab1hviXwEgrnewE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDIE3HZji33SK3arbXg25AwjeOfBgckJteP5kvyvpg73ZE3OyaD3lDs0EW5Lbl0vf
	 Dbu76owkDFAScVeodP5Jj5Cyi3rt3YC5CtXPnYDjsMSM0R3Spx4JKeOcf8V2qR5vwP
	 PxQst8dZ6a9sbF5K97U6DZJKR1JnR+wfwJUH4qfhmnoWwX/Bcbgx3iaNNQCn4Vddlw
	 rposiM/dW794Mu5r2JDxOyw4ZacUbbnSlQIiBPMel3QAazE6W+FPD0p4hqJz27feFA
	 VxTcLzxaHTQbELzoHLYZ+MLfrFqA8JFLdShincom7lnvW9G/fu+e72LbXUFxB5EQ1U
	 5rnuwn6mthAPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260725152705.3958100-7-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:42:34 +0000
Message-Id: <20260725154235.1BF021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing `cancel_work_sync` allows `crw_work` to execute after =
the device is freed, leading to a Use-After-Free.
--

--- Patch [6]: [PATCH v4 6/9] s390/vfio_ccw: ensure index for read/write re=
gions are within range ---
commit 9f53752835377d5ad4247b37c995e0a1051a888e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

This commit adds bounds checking for read/write region indices that were
missed during the capability chain introduction. It also applies
array_index_nospec to prevent speculative execution issues.

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 45ec722d25ea6..032a1cdf4df70 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but while reviewing the changes in
vfio_ccw_ops.c, I noticed a potential use-after-free in the device
teardown sequence.

In vfio_ccw_mdev_release_dev(), the private structure is freed, but there
doesn't appear to be a call to cancel_work_sync(&private->crw_work):

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_release_dev() {
	struct vfio_ccw_private *private =3D
		container_of(vdev, struct vfio_ccw_private, vdev);
	struct vfio_ccw_crw *crw, *temp;

	list_for_each_entry_safe(crw, temp, &private->crw, next) {
...

Concurrently, if a channel path event triggers vfio_ccw_chp_event() just
before the private pointer is cleared, it can queue the work:

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
    ...
	list_add_tail(&crw->next, &private->crw);
	queue_work(vfio_ccw_work_q, &private->crw_work);
}

Could this race allow the pending crw_work (vfio_ccw_crw_todo) to execute
after the private structure has already been freed, leading to memory
corruption when it accesses private->crw or private->crw_trigger?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D6
