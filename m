Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E913806C2;
	Tue, 28 Jul 2026 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211235; cv=none; b=r00LVH5BtAT5YhquGiH2aWqaqLT1THGcs6Rwnf+WyVoSDfo39bQcw7kcC4OhxfaEZu0E+klTQLEwl5Pw0+I5N8AfYJYberodysEo9NuV4uKzu89gV6UtDhBNSmSFUBeauecc1+Jp0FRSE395q+FkpkyNRyj8n0C3DHaFTQKFTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211235; c=relaxed/simple;
	bh=8kfjHanlLQMKyfw4K6XqDZ+K47AbeC8oRTyFPmmp9bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmna8qnOiasvz4qymyQaOZb92ug+bMqWBofnmqIyW+tI/pL/fAEFl6ouKJGN0PBGQwG/cjOtsAD83lGcYZ6prhafVH0EXi1j6y9j59haoNzcSyG1qe0QU0oKExcGEHZRO3Z0gMVmvHuzbJjxTYVqOVT7htc+IImZGg5EkVNqtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG1+ZuzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG1+ZuzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752DC1F000E9;
	Tue, 28 Jul 2026 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211234;
	bh=wgTdaHbSeM2GekQRqidqoQIuFQaPF0130E49BdAlM+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fG1+ZuzVqI1wTmP2j2elQhZZpRMgTnRgBtIhk4QB/PCsxWPgTnqzXtcjGrFlT3Rni
	 3IrKIYOkoQCxm3iFVwFb0qTqXPwUCIn7WMoA9jv1cjY7aY/yIMibS/vSnxjwqTCCAB
	 H7PFYVZaR1hskQGdp1WT9E95DaBlve5uM+8PuvJKwUWC93eEL/ALA4BdH01xibhxts
	 maH9BWfs+ziSWTbRM6ASsm7YAhjBBCGVnMz1/P6TzVSI61P6672J7xojXi3XsWCi0k
	 vFr9YI6Xxt/B1jgkukk0VeR4OqsS8eAm0/l/r+zYwZtW/PkKopni4LYSCy/jD/Yc+z
	 tGJsZ3Aq6vCbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/10] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-6-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:00:32 +0000
Message-Id: <20260728040033.752DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unprotected state modification of `private->state` in the workqu=
eue handler causing a data race.
- [Medium] Untranslated guest IOVAs are passed to the hardware for skipped =
data transfers.
--

--- Patch [5]: [PATCH v9 05/10] s390/vfio_ccw: calculate idal length based =
on idaw type ---
commit 02ef53680a2ab9a5c4dcb63aa0840ed5676edddc
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: calculate idal length based on idaw type

Sashiko pointed out that get_guest_idal() unconditionally calculates
the length of the IDAL presuming everything is a Format-2 IDAW.
The output of vfio-ccw is always Format-2, but the input can be either
Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
the size of the guest IDAL may be incorrect and should be trimmed down.

Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 6275794751cb4..5ef082b8289af 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source,=
 unsigned long len)
>  }
> =20
>  #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
> +#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u3=
2))
> =20
>  /*
>   * Helpers to operate ccwchain.

[ ... ]

> @@ -593,7 +594,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
>  	struct vfio_device *vdev =3D
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	u64 iova;
> -	int size =3D cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
> +	int size =3D get_idaw_size(cp);
>  	int ret;
>  	int bytes =3D 1;
> =20

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential address translation
issue later in this file. In ccwchain_fetch_ccw(), when a guest submits a
channel program with a CCW that skips data transfer (e.g., READ with
CCW_FLAG_SKIP):

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_fetch_ccw() {
	...
	if (ccw_does_data_transfer(ccw)) {
		ret =3D page_array_pin(pa, vdev, idal_is_2k(cp));
		if (ret < 0)
			goto out_unpin;
	} else {
		pa->pa_nr =3D 0;
	}

	ccw->cda =3D virt_to_dma32(idaws);
	ccw->flags |=3D CCW_FLAG_IDA;

	/* Populate the IDAL with pinned/translated addresses from page */
	page_array_idal_create_words(pa, idaws);
	...
}

Does this bypass translation and pass untranslated guest IOVAs to the
hardware? If ccw_does_data_transfer() returns 0, the idaws buffer
might be filled with raw guest physical addresses, which the hardware will
interpret as host physical addresses and throw an addressing exception.


[Severity: Medium]
This is also a pre-existing issue, but is it safe to modify private->state
without holding the io_mutex or sch->lock?

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo() {
	...
	if (cp_is_finished)
		private->state =3D VFIO_CCW_STATE_IDLE;
	...
}

If vfio_ccw_sch_io_todo() executes concurrently with an asynchronous event
like vfio_ccw_sch_event(), could this locklessly overwrite the state to
VFIO_CCW_STATE_IDLE after the event handler has already set it to
VFIO_CCW_STATE_NOT_OPER under the sch->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D5
