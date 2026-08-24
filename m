Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C1393DEE;
	Mon, 24 Aug 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609253; cv=none; b=g8kL1c87JVZqZMxjUAlK3Kcrm8t5WOAn8Iyl8iP1+6wwGAPJEDT+et6IaK9Hj2MwBeOW0kYnbWwH/Syy6yCsKZTgxVU0r3nrTgl0eblUe6yvbaqT74AN4dLV1VMJSfJVgoWv9iTvSINnSs4qz/qmZlBbQ+iOLsEQ1IdW/qXVOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609253; c=relaxed/simple;
	bh=uFhD3le88TvWTwGWcreJqKMf4QKeEiz0fLP7+8MOBKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H7eJeOzv4aGTHNKfrGO/UcGaSlcCDHAdMkp0rQwhk+MTv4MSqEcadD0AKDvI9LwOk2n/JdPVAU/U1PtQQ2F0X0bYcuLYjApwwg59X1egnZirYdoSBbeqojICnqoD3Cg4y+/Fo0TLaGA8QfaYdBZxjbOK9IwYkkPrruIlDtmf6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+/i0ouh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+/i0ouh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78201F00A3A;
	Mon, 24 Aug 2026 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609252;
	bh=qMuCMeoUPbyRJo/O+LlSHGcBGUB8d83kXEJDZ8zPgyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+/i0ouhEkS4nvX4M0xqU02R+IWhfvsU5YZw/Ih/APi+0kuF2ZRnKRnUf8+Pd6Qr5
	 ckHMyFVn6BMRsE+m4mP7iDAjWBKWVj5BhtCvhYYFOYHFoeQCJB8mZWr0R63ybM9ZXT
	 1NOas0O1m85NtVqGn5w+g9KhtsOSieqYfXLk3VdeOS4vwNBtO932FgjNNjD1ooaRAQ
	 0Nl/kc8WB3OS7Zz+UYCsvNRoFrKjwo0P2ADEluH00BIUdYN7n39HGS3m1mqTVSkvi3
	 ftWVtHIXv9KUjomHsl3AuPKpcyz8pZxhIV5fMjjoj1qwmAzRZJ4kkEN82c6jQJrqXy
	 i1YYwEFAYq3eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260824215603.819379-3-akrowiak@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
 <20260824215603.819379-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:07:31 +0000
Message-Id: <20260824220731.E78201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When userspace registers IRQ notification eventfds via the
> VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
> vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
> takes a reference on the eventfd_ctx and stores it in
> matrix_mdev->req_trigger and matrix_mdev->cfg_chg_trigger
> respectively.
>=20
> These references are dropped only when userspace explicitly replaces
> or clears them via a subsequent SET_IRQS call.  If the device is
> closed without that explicit teardown - because the guest exits,
> the VM process crashes, or the device file is simply closed -
> neither vfio_ap_mdev_close_device() nor the remove path releases
> these references.  The eventfd_ctx backing objects and their
> associated file references therefore leak for the lifetime of the
> kernel.
> [ ... ]
> releasing the device file before invoking close_device().
>=20
> Fixes: bf48961f6f48e ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioc=
tl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824215603.8193=
79-1-akrowiak@linux.ibm.com?part=3D2

