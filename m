Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDA440A2F
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513129; cv=none; b=j5c0aE2Cyb5Rma96PdLEstMrvJUWxKbBxh5EvOdJd2TIauC2a/Vx8oRotdsVPJGCa8rXHZdV8mmj/R0u0JkrEJaFwOSA3z27DsB68nRo4oObJNNcSDYXrh3Z3DlngMZPN56GZDlokDLJlYZTaMdgI//wWowNaxAfsJGqKy0Z+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513129; c=relaxed/simple;
	bh=1R6LjitgFNMUQ29DLRTAprNTOdev5gcHlFnuat9XXm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m83Hl5sjsb7QsxrfCH34mjjebHt5EJGcSG2GSlc3X/FDNT42PHnHpw+q42Ji/M4juQAMutXLLpERAF+YY6md0w7YLvgSV+cwzBwqzLX/OGR6xs3O1uR//23oqH/Ll2np08lCnyC+9QSlnshjtztAeZ4/0uiBBsi/xzw0Mu2qMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWpaJ20Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWpaJ20Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79E81F00AC4;
	Fri, 31 Jul 2026 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513128;
	bh=zUklisTFcvCJC+LRuSukpEx7BdE3ByFxtMkNJ7Q3MWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWpaJ20QTbW/GobBjoU4e0T0NUVBwrGQGuZ1vx92G5FjvD61VQhzComCBqNkRA9Fi
	 uHBdJ8fnTgfM/BReqyFWgMO77tRc9s/uFJGHXqTEkoYODzWqlPKAbKoc+Icvr6DvTL
	 VhM6cJExCBedARinKdyinilvQLX5zMGKMWTJheWKYPAJOjgj0doHrAotCmGUN/mIKz
	 0JQjre23dtbuK+2ISpNAOAJH8Mc4CPmTu5kEhMCmPI2jiGBa0R3OCZHKGBCr5cV7md
	 ujd/N3FifYXzP2bOzyXz9xG1wtW01rZ1Ra1Uk66n6jTtrYxYLsyLMPM0rGqD/cL0Da
	 prKfwUtwdQlaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] s390/dasd: Use GFP_KERNEL in
 dasd_alloc_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-5-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-5-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:52:07 +0000
Message-Id: <20260731155207.A79E81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing timer synchronization in teardown allows the device timeou=
t handler to run concurrently with or after the device is freed.
--

--- Patch [4]: [PATCH v5 04/17] s390/dasd: Use GFP_KERNEL in dasd_alloc_dev=
ice() ---
commit 476054dc9b8482264c4038c62c8c82f3d75106b4
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Use GFP_KERNEL in dasd_alloc_device()

This commit changes the allocation flags in dasd_alloc_device() from
GFP_ATOMIC to GFP_KERNEL. Since the function runs in process context,
using GFP_KERNEL is more reliable for large DMA allocations.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -86,25 +86,25 @@ struct dasd_device *dasd_alloc_device(void)
>  {
>  	struct dasd_device *device;
> =20
> -	device =3D kzalloc_obj(struct dasd_device, GFP_ATOMIC);
> +	device =3D kzalloc_obj(struct dasd_device, GFP_KERNEL);
>  	if (!device)
>  		return ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but does the device teardown path lack timer
synchronization for this allocated device?

During teardown, dasd_device_clear_timer() calls non-synchronous
timer_delete():

void dasd_device_clear_timer(struct dasd_device *device)
{
        timer_delete(&device->timer);
}

Because this does not wait for a concurrently executing timer handler on
another CPU, and the timer does not acquire a reference on the device when
armed, could dasd_delete_device() complete its wait for the reference count
and free the device while dasd_device_timeout() is still running?

If dasd_device_timeout() executes on another CPU and accesses the device:

        spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);

Could this result in a use-after-free of the device and its associated
structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D4
