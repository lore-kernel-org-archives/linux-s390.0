Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7205F411FB6
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768227; cv=none; b=W4lBZ5TC5yiMbLDrtmmhWEDLaM93HRmDglscHF7+hALJWMP7P17ZbQ7LJYWzHsLhV/0HkmaFeDtI86SbvkRkoH0+R4BtxWqSUqzSEwZgEK3/J0sTN4ZEjHRlBY3tcOlY9ujghOtsC7sNEo/eUaTHu2RqlS3PTHyBdSmuKRqx1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768227; c=relaxed/simple;
	bh=ycUPesYpLntyHRaJI2BPZ5a21n8IXAAkQizoRwkLePw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LPlQq0246hGOLU+lv55WIYJ90F6OUJsWXHbs8rr5rrDzBd2fazldHwRA7ZahasSjgh7CW/TGFs1o2RKpjB62TSk5k8RXBrZZSj9KceO1lsDWWvaoatOl935LMhpXqcos0fX4X3J74K1u7EpaZM8Ac97SYK2Veo+NpkRsbEnFJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6gab4qe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6gab4qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21991F00A3A;
	Mon,  3 Aug 2026 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768226;
	bh=EUOdmX6jt6JU3xlCju33ftb9r688noSbFj6eUzCH4zw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6gab4qevzWGJTp5asUHb2a3KWo8NK8FLI6LjrMcFhNeOrq0qE3vRAJ/f51/AjZtM
	 /rB/h/7swCKOkt33Pn+/aVXLHiHJzFxvb7TFHzwCvj1kOSMGCXQYNVthtxpif+1HPS
	 wm51vgttIOMAhKWheBw0dOrnG8Z3Kq5wJDWU4ioKcHiTuIi/ku9pNHBdzOPDwrMK3N
	 aLG4rnDgK1ZsL9QNzDvFpjVMtzo/fuuWbsKf/Viej1y12k5D1GSB69colTYBCu3pu/
	 +juFkLIMwvAHFcgBJGz7Ai2k2VbMqv8c0QET0B9+CNGc9z1BH9vf6QRlkC9ZOvkI2t
	 4rvB7QopvlXjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] s390/pci: Rework__zpci_event_availability() to
 remove conditional locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803142907.1771509-3-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
 <20260803142907.1771509-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:43:44 +0000
Message-Id: <20260803144345.F21991F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] zpci_remove_reserved_devices() calls zpci_device_reserved(zdev) wi=
thout holding the required zdev->state_lock, leading to a race condition an=
d double-put Use-After-Free.
--

--- Patch [2]: [PATCH v2 2/3] s390/pci: Rework__zpci_event_availability() t=
o remove conditional locking ---
commit f2856d16e29fb1c200332bdad2a6ab6ca714f024
Author: Heiko Carstens <hca@linux.ibm.com>

s390/pci: Rework__zpci_event_availability() to remove conditional locking

This commit reworks __zpci_event_availability() to eliminate conditional
locking of the zdev->state_lock, resolving a clang static analysis warning.
The handling for the 0x0306 multiple-device event is also moved to the
beginning of the function since it does not target a specific device.

> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 48fa26dcbee14..f96ee87405f98 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -389,19 +389,25 @@ static void zpci_event_reappear(struct zpci_dev *zd=
ev)
> =20
>  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  {

[ ... ]

> -	if (existing_zdev)
> -		mutex_lock(&zdev->state_lock);
> +	/* 0x0306 - No handle or fid stored */
> +	if (ccdf->pec =3D=3D 0x0306) {
> +		/* 0x308 or 0x302 for multiple devices */
> +		zpci_remove_reserved_devices();

[Severity: High]
This is a pre-existing issue, but does zpci_remove_reserved_devices() call
zpci_device_reserved() without holding the required zdev->state_lock?

Looking at zpci_remove_reserved_devices() in arch/s390/pci/pci.c, it
iterates through the remove list and calls zpci_device_reserved() directly:

arch/s390/pci/pci.c:zpci_remove_reserved_devices() {
    ...
    list_for_each_entry_safe(zdev, tmp, &remove, entry)
        zpci_device_reserved(zdev);
}

However, zpci_device_reserved() expects the lock to be held to safely
serialize state transitions and reference dropping:

arch/s390/pci/pci.c:zpci_device_reserved() {
    lockdep_assert_held(&zdev->state_lock);
    if (zdev->state =3D=3D ZPCI_FN_STATE_RESERVED)
        return;
    zdev->state =3D ZPCI_FN_STATE_RESERVED;
    ...
    zpci_zdev_put(zdev);
}

Can this lead to a race condition if two threads process events for the same
device concurrently (e.g., a specific 0x0308 event and a bulk 0x0306 event)?

If both threads read the state as STANDBY simultaneously, they could both
invoke zpci_device_reserved() and cause zpci_zdev_put() to be called twice
for a single reference, potentially leading to a use-after-free of the
zpci_dev object.

> +		zpci_scan_devices();
> +		return;
> +	}
> =20
> -	switch (ccdf->pec) {
> -	case 0x0301: /* Reserved|Standby -> Configured */
> -		if (!zdev) {
> +	zdev =3D get_zdev_by_fid(ccdf->fid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803142907.1771=
509-1-hca@linux.ibm.com?part=3D2
