Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBBA468C17
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933851; cv=none; b=A/ArxQ8OdICDYcNOmMM/oDchtmXV4E2djDsYaa3vEYfR101JKRZFIPHiv2fLanFMB0voqDHP4EX8k3PSMGdrYmg1BtbF4YF7Ew1WMxGPjbfTn16N/94XyB8GbiUNlOvZxSESn3TatD5iEYjk8zpccus7ozPLx5NocZUpsatec7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933851; c=relaxed/simple;
	bh=QOKwCIzSCMVfNZuBhAmNJ1OJITkCHDcE1hanXXO5Pbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DwewzW+LIil9PLmbw3P1ycS48K/zA+mOIn1RlrSVY0fv2RnqWBOHal0wXNTg8mmqomq/E0QyFcTWfSdWbzMnRyFt6Bdbbdxvc3bx14NmmDoLTJl3w5mDkJcM3ay72X2WrmouQiI3W2DOEYFezKtfu72Hmiy0yRcC8GYKHosE3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULMXWvu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULMXWvu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112A81F000E9;
	Wed,  5 Aug 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933850;
	bh=YTlj0etYJvXaai/H6ZBm6FGVW11vzZ2JiXwLVLcMvDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULMXWvu9gjWztbe8se4Did911+ullZjfWE7xqpjxpyqx5L4ipKJU/ghO9K3AOr7ms
	 jZb4tqRHPxnBfFkS6qJzOgwaec8Wp0k6E8O9a+JvtUQWNL1I6Io7djttXQWsbi94MT
	 fGa+giQiN32KxeSXFS93wNvsfH+X/L/73ugd1dnh5BynUdld9OSJoo9+iVa0n6UtD4
	 ALjUPOb4FhLIKSeGEmxvzABNKp1mjjEyW+aNIZOJI98D0mb3uDvYlBF8tZtT5KbG/O
	 /6AZIH3Ot3aOBYp9dgzsCbI6Em7mhY1iVsDTzgQ3EafpoiHGWfglaFY0QOmfYSvIVI
	 qC7jYA5PFVXUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/19] s390/dasd: Guard sysfs discipline callbacks
 against unallocated private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-4-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:44:09 +0000
Message-Id: <20260805124410.112A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but a Time-Of-Ch=
eck to Time-Of-Use (TOCTOU) Use-After-Free vulnerability exists in world-re=
adable sysfs handlers when the initialization function `dasd_eckd_check_cha=
racteristics()` encounters an error.
- [High] The patch fixes NULL pointer dereferences in world-readable sysfs =
show handlers by guarding them against an unallocated `device->private` dur=
ing `dasd_generic_set_online()`. However, it misses the `copy_pair` sysfs s=
tore handler, leaving it vulnerable to a NULL pointer dereference.
- [High] The patch leaves a vulnerable window where `device->private` is al=
located but its internal pointers (like `private->conf.gneq`) are still NUL=
L, causing a NULL pointer dereference when a sysfs attribute is written.
--

--- Patch [3]: [PATCH 03/19] s390/dasd: Guard sysfs discipline callbacks ag=
ainst unallocated private data ---
commit 3d2b943842a29d7f0ee2ab694c84c9d52b911329
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Guard sysfs discipline callbacks against unallocated private data

Several sysfs show/store handlers call a discipline callback that
dereferences device->private, either directly or through the
DASD_DEFINE_ATTR() macro. During dasd_generic_set_online() the discipline
is assigned before check_device() allocates device->private, so an
unprivileged read of one of these world-readable attributes in that window
dereferences a NULL pointer and panics.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index d356a9f8f016f..b64ca714b53e7 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1492,6 +1492,8 @@ static void dasd_eckd_reset_path(struct dasd_device=
 *device, __u8 pm)
>  	struct dasd_eckd_private *private =3D device->private;
>  	unsigned long flags;
> =20
> +	if (!private)
> +		return;
>  	if (!private->fcx_max_data)
>  		private->fcx_max_data =3D get_fcx_max_data(device);

[Severity: High]
This isn't a bug introduced by this patch, but does this leave a window
where private->conf.gneq is dereferenced while NULL?

In dasd_eckd_check_characteristics(), device->private is allocated and
assigned, but then blocking I/O (dasd_eckd_read_conf()) occurs before
private->conf.gneq is set.

If a sysfs write for reset_path occurs during this sleep, the new !private
check passes and get_fcx_max_data() is called:

drivers/s390/block/dasd_eckd.c:get_fcx_max_data() {
    ...
    fcx_in_gneq =3D private->conf.gneq->reserved2[7] & 0x04;
    ...
}

Can this cause a kernel panic if private->conf.gneq is still NULL?

[ ... ]

> @@ -1647,6 +1649,9 @@ static int dasd_eckd_is_ese(struct dasd_device *dev=
ice)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
> =20
> +	if (!private)
> +		return 0;
> +
>  	return private->vsq.vol_info.ese;
>  }

[Severity: Critical]
This is a pre-existing issue, but does this lockless check introduce a
Time-Of-Check to Time-Of-Use (TOCTOU) Use-After-Free?

If dasd_generic_set_online() is running concurrently and
dasd_eckd_check_characteristics() encounters an error (like an I/O failure),
it manually frees private:

drivers/s390/block/dasd_eckd.c:dasd_eckd_check_characteristics() {
    ...
out_err1:
    dasd_eckd_clear_conf_data(device);
    dasd_path_remove_kobjects(device);
    kfree(device->private);
    device->private =3D NULL;
    ...
}

Since sysfs readers like dasd_eckd_is_ese() don't hold a lock protecting
device->private, could private be freed immediately after the !private
check but before private->vsq.vol_info.ese is accessed?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the copy_pair
sysfs store handler is missing a similar safeguard.

If an administrator writes to copy_pair concurrently with
dasd_generic_set_online(), it executes dasd_copy_pair_store() which
locklessly accesses the discipline:

drivers/s390/block/dasd_devmap.c:dasd_copy_pair_store() {
    ...
    if (device->discipline->pprc_enabled) {
        pprc_enabled =3D device->discipline->pprc_enabled(device);
    ...
}

If device->discipline is NULL during the window before it is assigned,
could this cause a NULL pointer dereference?

Furthermore, even if discipline is assigned, dasd_eckd_pprc_enabled()
unconditionally dereferences device->private without checking if it is
allocated:

drivers/s390/block/dasd_eckd.c:dasd_eckd_pprc_enabled() {
    struct dasd_eckd_private *private =3D device->private;
   =20
    return private->rdc_data.facilities.PPRC_enabled;
}

Should these locations be guarded as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D3
