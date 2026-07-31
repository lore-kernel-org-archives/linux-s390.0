Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77D45D5E2
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516218; cv=none; b=BCnkPe36L0RTT2N4E/I1jhQgiU/F950aui8Nw8r2W2V6jS9FcadVsmX0B2awZ1L3dCq4DL60S2T+9C2F4sIzuiz55WonA1iyKgePPVdY9uB1ujrNdqjQPAVtPCbYwGYn1UwUEvtWS1WG4WPLP2XplReWxeRBx3HVtzf7WPZ2Wlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516218; c=relaxed/simple;
	bh=QLWvzS+dEaY/vX7ANuwTux4uGSlOzUAEXMAWjpbkxYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l29qGfW73xRBHJjF7VY3Y2Gy+gpqJAJRFy4rvfsCSkhZ6vq2IwLP0WO5O+TfKLy6dMVO8zaqh+JuDlcyviKh81VVizH0K6NSD/2/LGjKWTToGy09KrjVI4ms5xJybwXJgRi6DF1/iH2Fk/9oQy/sFz8P3b+MDNV9SBnN3NZziO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbuAHavr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbuAHavr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE6C1F00AC4;
	Fri, 31 Jul 2026 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785516217;
	bh=aV+GwVtsNt6k6SjQMHNoDnKGHlAC4HMBnB6QfgIvvgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbuAHavrQkO6xCOQ75NIhIiTvQoivqrcLsbAUjPFsdPjiYFogV3AGP6/JFqKkouIv
	 fLTlZDPUsQTKOYWw7/NOksazctZun4VEjsnRu2KFO6ImsnS26jpKTH92K1ott1XzYe
	 1SMbyBgWOHqUlTmCbEG09ZUeKqOKDbUlDgNbB8nbpd0MI3JGkksmJ7S8muKqyudK3C
	 Pmd1b/w5opF8eSRs5qxXktk7KeRR/zIeDJ8nIarAssg6jA8kOGiNpN+v7aSZH9njuT
	 HC1PerGCikhzxAQ4Qt976efLMvfpUIr1OSqHNvgcmyVKMMnSISoYxlp6Nmykh/U8Sz
	 lMbWPKmwEPxnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] s390/dasd: Detect ESE volumes from the on-disk
 format label
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731153842.1729627-15-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-15-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:43:36 +0000
Message-Id: <20260731164336.CDE6C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Unconditional dereference of `device->private` in `dasd_eckd_is_es=
e()` causes a kernel panic when accessed via the `full_track_bias` sysfs at=
tribute on an initializing or offline device.
- [High] Valid on-disk ESE label cache is incorrectly invalidated on early =
format failures, breaking thin-provisioning state.
- [Medium] Concurrent execution of dasdfmt and sysfs reads leads to data ra=
ces and torn reads on the 512-byte `ese_label` structure.
- [Medium] The `ese_label_valid` cache is not invalidated when track 0 is f=
ormatted with LDL (intensity 0x00) or invalidate-track, leaving stale in-me=
mory state.

Pre-existing issues:
- [High] The `dasd_release_space()` ioctl helper triggers a NULL pointer de=
reference when called on a device whose discipline does not implement the `=
is_ese()` callback (e.g., FBA devices).
--

--- Patch [14]: [PATCH v5 14/17] s390/dasd: Detect ESE volumes from the on-=
disk format label ---
commit 6689b09c2730c7fa8fae2e18e3bbf4f3671425e2
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Detect ESE volumes from the on-disk format label

This commit reads the format label from track 0 record 4 at device bring-up
and caches it to determine if a volume is ESE. It also updates sysfs
attributes and format handling to reflect the cached label state, ensuring
volumes copied off ESE storage are still handled as thin.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1686,6 +1687,49 @@ static int dasd_eckd_is_ese(struct dasd_device *de=
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
> +	if (private->ese_label_valid)

[Severity: High]
Can this cause a NULL pointer dereference if device->private is not yet
allocated?

The full_track_bias_store() sysfs function can indirectly call
dasd_eckd_is_ese() during the initialization window before private is
allocated, or if allocation fails:

full_track_bias_store()
  dasd_ft_bias_apply()
    dasd_eckd_is_ese()
      private->ese_label_valid

> +		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_ESE);
> +
> +	return dasd_eckd_ese_capable(device);
> +}

[ ... ]

> @@ -2730,7 +2843,12 @@ static void dasd_eckd_fill_format_label(struct das=
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
>  }

[Severity: Medium]
Does this introduce a data race that could lead to torn reads?

Sysfs readers accessing on_demand_formatting or full_track_bias can call
dasd_eckd_is_ese(), which reads private->ese_label.flags locklessly. If a
format is concurrently updating this 512-byte structure here, could a
reader observe ese_label_valid =3D=3D true but see stale or partially writt=
en
flags?

[ ... ]

> @@ -3224,23 +3349,35 @@ static int dasd_eckd_format_device(struct dasd_de=
vice *base,
>  	struct dasd_eckd_private *private =3D base->private;
>  	int rc;
> =20
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

[Severity: High]
Does this incorrectly drop the valid in-memory label state on early format
failures?

If dasd_eckd_format_process_data() fails early due to sanity checks (like
invalid parameters where stop_unit is out of bounds) before any I/O is
issued, rc will be non-zero and the cache is cleared. Would this cause
subsequent writes to unallocated tracks to fail with 'No Record Found'
instead of triggering on-demand formatting?

[Severity: Medium]
Does this leave a stale cache in memory if the format succeeds but destroys
the on-disk label?

If track 0 is formatted using the LDL format mode (intensity =3D=3D 0x00), =
it
skips writing the label but rc will be 0. Would this leave the old
ese_label_valid state incorrectly set to true?

[ ... ]

While reviewing these changes, I also noticed a pre-existing issue in the
dasd ioctl handling:

[Severity: High]
This is a pre-existing issue, but can dasd_release_space() in
drivers/s390/block/dasd_ioctl.c trigger a NULL pointer dereference?

If a device lacks the is_ese callback (such as dasd_fba), this logic:

	if (!device->discipline->is_ese && !device->discipline->is_ese(device))
		return -ENOTSUPP;

evaluates to true for the first condition when the pointer is NULL, and
then attempts to call the NULL pointer in the second condition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D14
