Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524637F327
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752282; cv=none; b=EUu3NW65aL6tU376wkqO+4nF9U2FkFl0+6fMfsHcvjUvClE+CqE9KWk/QNn4R2K3qoYkM82XZnZdXeySwZdXirCYDUaAxTz9/s3NIqt7YGKOed5uB3Kzur8/M5DEskHfdjCh/a6EXy1O5gbhAXrxRZN7i75rofFKOiEVPgFSHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752282; c=relaxed/simple;
	bh=DRbvoqqzTsr9RLYmWqMkfcvglN2VpjaDNaNVSdHwZn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXr/pPjHTT+zfJqsHZtOD/1mMrRGsQGXohVSzGEAXRdvEZcMTLIA6oTpiElOlo4qBFvALYh7lF+vgCibCUXS0vBtj78R6P6RJWX+jtkdjZSoh/w1USKI721zmsAFtSKziACJNedDKsHDzHrIL9gN9Hh3/jBM+jVZL0pbxUt++sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKeao7KO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKeao7KO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552771F00A3D;
	Mon,  3 Aug 2026 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785752280;
	bh=GH3ce5vwhlE9X7mC9X1E8gf4EYC9P9HOlCdV0hh6j/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKeao7KOtXr4ofGE4y74cODIYwE0gZkw6y8sKxAlE3uhz6DQGqL2A35KZ2RxfvCnp
	 OWp25yPxC09bC/DLSXvZ0hEWq0bywbwS9+M5aq578CMD81EKH4hN7tEpC1PwIBhWLG
	 RqUERel+OH52yBZnP4euLZJi9OnYvf4nDZc+8wsb3SejcaoR4QqvsdpDPaYF74mu1n
	 jAy7BpG2iEp4pKSAmEJKqdV+qFC6D9/JX9op9+WlFL9KzBjeWdXmxImwlhO213b4FL
	 vq9BuF/c9Qd2Avmkz4gbQw+C+DcuQUK8PFt/aeQfQPRjBB1ivRdnGIc2kbE7tHUVpm
	 1AlJ8/bGDnsRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/pci: Rework__zpci_event_availability() to
 remove conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260803100723.2343688-3-hca@linux.ibm.com>
References: <20260803100723.2343688-1-hca@linux.ibm.com>
 <20260803100723.2343688-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:17:59 +0000
Message-Id: <20260803101800.552771F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `zdev` reference obtained via `get_zdev_by_fid()` is leaked wh=
en handling the `0x0306` PCI event.
--

--- Patch [2]: [PATCH 2/3] s390/pci: Rework__zpci_event_availability() to r=
emove conditional locking ---
commit abeb29e9ac48aa95001741be64e50a68bcadf6fd
Author: Heiko Carstens <hca@linux.ibm.com>

s390/pci: Rework__zpci_event_availability() to remove conditional locking

This commit refactors the __zpci_event_availability() function to avoid
taking the device state lock conditionally. The restructuring handles
different PCI event codes explicitly to resolve static analysis warnings.

> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 48fa26dcbee14..37acee2c7d257 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -390,18 +390,21 @@ static void zpci_event_reappear(struct zpci_dev *zd=
ev)
>  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  {
>  	struct zpci_dev *zdev =3D get_zdev_by_fid(ccdf->fid);
> -	bool existing_zdev =3D !!zdev;
>  	enum zpci_state state;
> =20
>  	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
>  		 ccdf->fid, ccdf->fh, ccdf->pec);
> =20
> -	if (existing_zdev)
> -		mutex_lock(&zdev->state_lock);
> +	if (ccdf->pec =3D=3D 0x0306) {
> +		/* 0x308 or 0x302 for multiple devices */
> +		zpci_remove_reserved_devices();
> +		zpci_scan_devices();
> +		return;

[Severity: High]
Does this early return leak the zdev reference?

If get_zdev_by_fid() finds an existing device, it increments its reference
count. By returning directly here when the event code is 0x0306, it seems we
skip calling zpci_zdev_put() at the end of the function. Could this prevent
the device from being properly freed during hot-unplug over time?

> +	}
> =20
> -	switch (ccdf->pec) {
> -	case 0x0301: /* Reserved|Standby -> Configured */
> -		if (!zdev) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803100723.2343=
688-1-hca@linux.ibm.com?part=3D2
