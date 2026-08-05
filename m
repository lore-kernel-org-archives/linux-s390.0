Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076663F23A6
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958467; cv=none; b=QOMuCBQNzdFUvk3m/8BEzZ1nFnvpU445s7KUN+pkzT+w2n7sYbn/XH8WCFwzlnrv+z5mt9VTWtgjCAiJFAQ/Fl24sH1s1yjsHgyh1tFTZ2RFywSNubfpB7fNL/DuDnBHaiqP67yxncifQ8Zxsp8tqtE/qE5JVlk/Kj6zkblN28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958467; c=relaxed/simple;
	bh=aVkcD6Jkl4JoKZLyWLNpWjqSt5jO6Yzg49D9D19E+0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=biaU7iIGObQ4zfGN+APKFe+JUZQmDCcjYIji5RgipwSJQ6P+dCC9ko+euwJF0n8DhfRHEYbTC3nr3ARku9cK+tug3HsvZrH86x49JmwWK3PbtXe3bpA+CNXNksEtYedGCB9QMxii6sH1zGVQbaRy5QVzMpxkB2CY2NvP6GUvroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myCjTe5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myCjTe5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F071F000E9;
	Wed,  5 Aug 2026 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785958465;
	bh=DaFVvaD98tGfnYr2ObTCDtMKP2n8egqPxYoI6cQSBqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myCjTe5Nak9allXTJcTEFmdPSXFWV/4wP1HFXPc4RTwEQBHUpvcGrJFb8JCb9/5Wr
	 dIF1yysyB/xq+JOZIJYSE9A+X+67hfGhxWpb9IdgVjqalUUQmU+4zgRJv9iYyfRfeb
	 yFspfdh0XShvQtJ3kpnbUw7FhRcIqjJjs09XsRMj5CBRZa009RaKozvPY9u/dpRKTk
	 GxEJJgMziGE5Hf4+UMhwUvmxtHFhckHLuEUffKggAGKqLYyRIbS5NDWSYXxraCfzt5
	 F/e6dI13JLlckzt2pftiM4Lo9bT8joJe0N2vHMQc1l6m16xyCTd0uRjuKtV4X6kiCg
	 KkVD05chq3+mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/19] s390/dasd: Detect ESE volumes from the on-disk
 format label
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-17-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-17-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 19:34:24 +0000
Message-Id: <20260805193425.62F071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Stale ESE label cache after a full format without CDL or with larg=
e block sizes.
- [Medium] Missing memory barrier when publishing `ese_label` and `ese_labe=
l_valid` leads to data race.

Pre-existing issues:
- [Critical] Heap buffer overflow in `dasd_eckd_build_format` for multi-tra=
ck formatting with specific intensities.
- [Critical] Use-After-Free of `device->private` due to concurrent sysfs re=
ad and `set_online` failure.
--

--- Patch [16]: [PATCH 16/19] s390/dasd: Detect ESE volumes from the on-dis=
k format label ---
commit 8d23af7219b60eb10fdf0ec87204766573d15885
Author: Stefan Haberland <sth@linux.ibm.com>
Subject: s390/dasd: Detect ESE volumes from the on-disk format label

This commit introduces the ability to read the format label from track 0
record 4 during device bring-up to detect Extent Space Efficient (ESE) volu=
mes.
It caches this label and uses it to correctly handle thin volumes even when
copied across different hardware, while also updating sysfs attributes to
expose on-demand formatting status.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 25a9055b97a2c..d5854ed0076e3 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -1687,6 +1688,53 @@ static int dasd_eckd_is_ese(struct dasd_device *de=
vice)
>  	return private->vsq.vol_info.ese;
>  }
> =20
> +/*
> + * Whether the volume is to be handled as ESE (thin). This reflects the =
state
> + * of the data, not the hardware: a volume copied off ESE storage onto o=
ther
> + * hardware still needs ESE handling. The on-disk format label is author=
itative
> + * when present; without it (e.g. a volume formatted by an older driver)=
 fall
> + * back to the hardware ESE field.
> + *
> + * Only the F_ESE flag gates this. An ESE volume is thin regardless of w=
hether
> + * it was quick- or full-formatted (tracks are allocated on write, and d=
iscard
> + * re-thins a full one).
> + */
> +static int dasd_eckd_is_ese(struct dasd_device *device)
> +{
> +	struct dasd_eckd_private *private =3D device->private;
> +
> +	/* sysfs may read this during set_online before private is allocated */
> +	if (!private)
> +		return 0;
> +
> +	if (private->ese_label_valid)
> +		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_ESE);

[Severity: Critical]
This is a pre-existing issue, but can this lockless access to device->priva=
te
in dasd_eckd_is_ese() result in a use-after-free?

During device initialization in dasd_eckd_check_characteristics(), if an er=
ror
occurs (like a failure in reading configuration), the error path out_err1
calls kfree(device->private) and sets it to NULL.

However, if a sysfs read for attributes like "ese" or "on_demand_formatting"
calls dasd_eckd_is_ese() concurrently, it might read the private pointer ju=
st
before it's freed:

	struct dasd_eckd_private *private =3D device->private;

And then dereference it after it is freed when accessing
private->ese_label.flags here. Should there be synchronization against sysfs
readers during the error paths of device initialization?

[Severity: Medium]
Could this read stale or uninitialized data from private->ese_label?

The writer sets private->ese_label_valid =3D true in
dasd_eckd_fill_format_label() immediately after populating private->ese_lab=
el,
but does so without a write memory barrier.=20

Because this reader checks private->ese_label_valid and accesses
private->ese_label.flags without a read memory barrier (like
smp_load_acquire()), could the CPU or compiler reorder operations such that
this function sees the valid flag as true but reads uninitialized label dat=
a?

> +
> +	return dasd_eckd_ese_capable(device);
> +}
[ ... ]
> @@ -2734,7 +2848,12 @@ static void dasd_eckd_fill_format_label(struct das=
d_device *device, void *data,
>  	memset(label, 0, blksize);
>  	label->magic =3D DASD_ESE_LABEL_MAGIC;
>  	label->version =3D DASD_ESE_LABEL_VERSION;
> -	if (dasd_eckd_is_ese(device))
> +	/*
> +	 * F_ESE records the hardware capability at format time, not is_ese():
> +	 * is_ese() is derived from the label, so using it here would let the
> +	 * flag flip on repeated quick/full reformats.
> +	 */
> +	if (dasd_eckd_ese_capable(device))
>  		label->flags |=3D DASD_ESE_LABEL_F_ESE;
>  	if (private->ese_format_quick)
>  		label->flags |=3D DASD_ESE_LABEL_F_QUICK;
> @@ -2744,6 +2863,13 @@ static void dasd_eckd_fill_format_label(struct das=
d_device *device, void *data,
>  	label->format_tod =3D get_tod_clock();
>  	strscpy(label->kernel_version, init_utsname()->release,
>  		sizeof(label->kernel_version));
> +
> +	/*
> +	 * Populate the cache directly from the bytes just computed instead of
> +	 * synchronously reading them back from disk after the write lands.
> +	 */
> +	private->ese_label =3D *label;
> +	private->ese_label_valid =3D true;

[Severity: Medium]
Could this update in dasd_eckd_fill_format_label() cause a data race with
concurrent sysfs readers?

This writes to private->ese_label and then sets private->ese_label_valid to
true without a write memory barrier (such as smp_store_release()).=20

Concurrently, dasd_eckd_is_ese() checks private->ese_label_valid and access=
es
private->ese_label.flags without a read memory barrier (such as
smp_load_acquire()). Could the CPU or compiler reorder operations such that
readers observe the valid flag as true but read stale or uninitialized label
data?

>  }
[ ... ]
> @@ -3228,23 +3354,35 @@ static int dasd_eckd_format_device(struct dasd_de=
vice *base,
>  	struct dasd_eckd_private *private =3D base->private;
>  	int rc;
> =20
> -	/*
> -	 * A full format (start_unit =3D=3D 0) returns the device to a fully sp=
arse
> -	 * state, so restart the heuristic from ft1 without an offline cycle.
> -	 */
> -	if (fdata->start_unit =3D=3D 0)
> -		dasd_ft_bias_apply(base);
> -
>  	rc =3D dasd_eckd_format_process_data(base, fdata, enable_pav, 0, NULL,
>  					   0, NULL);
> +	if (fdata->start_unit !=3D 0)
> +		return rc;
> +
> +	if (rc) {
> +		/*
> +		 * The format failed, so the label cached speculatively during
> +		 * CCW build may not match the disk; drop it so is_ese() falls
> +		 * back to the hardware field until the next successful format
> +		 * or bring-up.
> +		 */
> +		private->ese_label_valid =3D false;
> +		return rc;
> +	}
> =20
>  	/*
>  	 * The quick-format indicator was consumed by the label stamped into
>  	 * track 0; clear it so a later format that is not preceded by a full
>  	 * space release is recorded as a full format.
>  	 */
> -	if (fdata->start_unit =3D=3D 0)
> -		private->ese_format_quick =3D 0;
> +	private->ese_format_quick =3D 0;
> +
> +	/*
> +	 * A full format returns the device to a fully sparse state and has just
> +	 * committed a fresh label; restart the heuristic from ft1 on the now
> +	 * current is_ese state, without an offline cycle.
> +	 */
> +	dasd_ft_bias_apply(base);

[Severity: High]
Could the cached ESE label become stale here in dasd_eckd_format_device() if
the format does not write a label?

If a full format successfully executes but skips writing the label (for exa=
mple,
when intensity is 0x00 and write_label evaluates to false in
dasd_eckd_build_format()), the on-disk label is erased.=20

Because this success path does not clear private->ese_label_valid, the driv=
er
might incorrectly continue to use a stale in-memory label that no longer ex=
ists
on the disk. This breaks the on-demand formatting capability detection. Sho=
uld
the success path also conditionally invalidate the cache if no label was
written?

> =20
>  	return rc;
>  }

[Severity: Critical]
This is a pre-existing issue, but does dasd_eckd_build_format() in
drivers/s390/block/dasd_eckd.c calculate the memory sizes incorrectly for
multi-track requests, leading to a heap buffer overflow?

When handling ioctl(DASDFMT) with formatting intensities 0x01, 0x09, 0x04, =
or
0x0c, the calculation for the required CCWs (cplength) and buffer size
(datasize) seems to fall short when nr_tracks > 1.=20

For instance, with intensity 0x01:

	case 0x01:	/* Write record zero and format track. */
	case 0x09:	/* Write record zero and format track, use cdl. */
		cplength =3D 2 + rpt * nr_tracks;

But the formatting loop later consumes more CCWs:

		if (intensity & 0x01) {	/* write record zero */
			ect =3D (struct eckd_count *) data;
			data +=3D sizeof(struct eckd_count);
... ccw++;

This consumes (1 + rpt) * nr_tracks CCWs, which exceeds the allocated amount
and overflows fcp->cpaddr. Similarly, datasize only allocates enough space =
for
one struct eckd_count track header instead of nr_tracks, causing fcp->data =
to
overflow. Since this formatting ioctl can be issued by a privileged user, c=
ould
this deterministic overflow lead to memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D16
