Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC61799F;
	Wed, 19 Aug 2026 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107454; cv=none; b=kVcexltX0TcSglxeuJiqRUNW4bztpSk0Qa+xVvvO5iAksdrt09a379wcYQLWD+0BF1aHkmJSJqrL2xV2NkadYTU3Jvq+0HGZVqRcd0PJCkyia7I2TNbFQPfd8FOXpD7BnsmLUGmw6+NvRahz2VSsJ2bRLYDTEbrWyzo23bgFxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107454; c=relaxed/simple;
	bh=6+N7Ld7BhqHRhUtsLoVE0NAfGPBdOmotw2VX1cQj5QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ir3aSQLJEwCb7Yb+fjjJYNy4O0Q6wQvpTQucUEYVUiIAwfyFBcqoVKts/mLGSCi5miKrdOSykgcr45fsqlrIdJ1FXg0McgRTtqzba5rXwuh5P01jQC7d8PHJK2PAdqFLKOd8Q5uhcz29J8gPqXGs8Mdb61j2uAxXIWZwBVh+VmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu1yILn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu1yILn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E61F000E9;
	Wed, 19 Aug 2026 02:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107452;
	bh=cyE56HF031URvM1Ocs2mt0bMXWiGj/l7t3lzJ8owoJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bu1yILn04ORGR8pnFKfOT8SOkVarkoEuUv27jFoWqqVcUlLtdFUK6Wy8mt2fBOyKC
	 A3cVuiR7jG5BjMmCNuvx5T8mVjDVvhtJpaeTATgA+t3c+7qnmCr63Tt7Xd0FRsok0g
	 L0DyhbiHBwVenaXex9dT8xN/IPwTybuQqPSzgKTbftIWSpRQixEYbMdMnS8jAMflLl
	 C0GLODgJzwV0RgukDVIjjQeVNGV/q2xYpwZ1PqsZHi5Bqqu/JlYPqCqO3KZsRQ8z2l
	 n+dzwPHyh0ZrApwsLTHCGenHEnohIxcWuM3Oiwsfq3AULEJsDMIlOtDmxkkp8g/lfk
	 mMpDAMh80jxVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 05/13] sysctl, parport: update register_sysctl()
 callers with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, bpf@vger.kernel.org, mptcp@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-5-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-5-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:44:11 +0000
Message-Id: <20260819024411.C41E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless traversal of the `port->devices` list can lead to a use-a=
fter-free if a device is concurrently unregistered.
--

--- Patch [5]: [PATCH RFC v2 05/13] sysctl, parport: update register_sysctl=
() callers with template arguments ---
commit 511c6de215c54187a5a0e65c0208aa20775855cf
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl, parport: update register_sysctl() callers with template arguments
   =20
Update callers with dynamic table/path to use template arguments.

> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index cda3221e386ed..7c048e9a973aa 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could reading the active
device sysctl lead to a use-after-free if a device is concurrently
unregistered?

In drivers/parport/procfs.c:do_active_device(), the port->devices list is
traversed locklessly:

    for (dev =3D port->devices; dev ; dev =3D dev->next) {

Concurrently, parport_unregister_device() in drivers/parport/share.c can
remove a device from this list and free it:

    device_unregister(&dev->dev);

Since there is no synchronization (like taking port->pardevice_lock)
between the sysctl read and device removal, couldn't the lockless traversal
dereference a freed pardevice pointer?

This missing locking is also explicitly annotated in another lockless
traversal in drivers/parport/share.c:parport_release():

    /* !!! LOCKING IS NEEDED HERE */
    for (pd =3D port->devices; !port->cad && pd; pd =3D pd->next) {

Could an unprivileged user trigger this by repeatedly reading the sysctl
while a device is unregistered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D5
