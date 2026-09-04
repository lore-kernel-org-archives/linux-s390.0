Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995B1F427C;
	Fri,  4 Sep 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515011; cv=none; b=aDuVNcXQfbfN50GBTQb4KvflMWXNg/dvu0itw7j+d6bnWRuE3sLBDpA41DOr8g2JyA+NfQw5hlcd/W1NokSQ8HXTuHdTfgCt9sBxvNpS5CMr+LT5EFV9bAKJfjWFFO246OqPPY9ZD6lEB4V3wPmLB+J3nplNz+Sro+ckYawDocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515011; c=relaxed/simple;
	bh=zftpislYH5iACsXAi/mgQa3XKhEvDmdkAGc1VYYACJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b6BwsBjbkkcWT+8gITyDDjiDlnoGyTVMucZnKT9KzG5w42MXrXnINhV+wxbm+x1pDkezgsMi5p8PIoI78pCbXZL5NtQ6FvCIOeoluKPpGqsYUishaN5XMyTOWcsQd/yoS7hC3f6BmoYZUdUvyytB3nvfRjFf/0v4xRJSEabgEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghfm11B+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghfm11B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D764E1F00A3D;
	Fri,  4 Sep 2026 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515010;
	bh=bl14P9EdDEDOWBtOuiQ1Pbd3ainAHAsd24pmIpBNQ3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ghfm11B+9mdEcY/sHVAaU4Q+lGYDUQ6h4UkXVcPSx9wXUImGFJwdJioCfbC3hsr9x
	 IxknXBQSCkudZ7evIl+YcqVCsyZWy5zbdOsqPMDLj0IYMEWNzrmDY1h6W8cNZc0CPd
	 6+7sL3a99Y2akLsNoxh8uex5Ui3vXeMv0RMYZBlmrD0G8j9MA2nSjkLDvNwRswXywE
	 krPVxxyiQpvDGluy1sO2Q5eYWhulh6hWho6wFqusukNK+ToMMfpG78uhduojn7sY9K
	 tHO4ff0feZbZSTEnulzqsG6AlPSudkfxh4L5GxuFd7fDZOk6nf9jpKw2i5rN1eNDJL
	 57XmN90wXZz0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260904093435.1161402-3-akrowiak@linux.ibm.com>
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:43:29 +0000
Message-Id: <20260904094329.D764E1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904093435.1161=
402-1-akrowiak@linux.ibm.com?part=3D2

