Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684F305666
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610251; cv=none; b=U1TxJU5htDhUYpqwwOFQyMbqOmVkWzuhgD1Wd/UCadVTCUuxtMYzqO2+1IexIOFAgt633bkDrltzAnYaBQK9QkUkMOoGSE+fjH4PFmyqOxqGgStQDpwV4WPwTD7B5qtwnsFnhd0wLWdKXjwcm8/I4PVaa4AuXhDWRUDgKeKuAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610251; c=relaxed/simple;
	bh=K7yqDSlDA+eoPRlfpO8v4GZLFl6QyNLdWhLOlnZMN4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cyU2I0ZGUE8s5grJcjt5X9ukC/+NHWe4FpjaZHLwgcAuGkhKgqKe5xvJ2/BqJ7IWMVa0dv310RcOuEeHbvoLG5sJY5RRtDdcR8ObazVTuq1OvSMk5JIBOW/ml708KK69g46bzxFs7kB5JUfl1Mx03KwhgRNrFhAvNzi0ekNNex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/PTn5pJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/PTn5pJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1FF1F00AC4;
	Sat,  1 Aug 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610249;
	bh=N2RNrX8yMqER7LcOCfoeZj12BS3K80kZQ9gdotPOGWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/PTn5pJLGhuL+hXpnoW+AnDtmagHNbxS6ip3Bk7wptP0CSAnTD6QFJ1w1YabQ18B
	 Sh01upCy5rhGdsENyLqLqeYdx5M6IgMqK9xwypDVJCk7jKyi8skU4DC0qqne+wqBGf
	 p0aHOif8e0RqqODlBQIqrTl86O5tcv6RcTRCaLrH3VEopLqX4/dmlWbiS3o6czGEqJ
	 XCxXTWYjpW1zVNpnlv6c9GIuUZRFeF1DOCDtJvdecYlAdRLkWetuiwC6h3rENjGraV
	 siO3l1EebEgwXpEzL7KXF4cuqc8mIY0ZggVOtritGMc2vxheAvIVQdzGuCki3gj8it
	 o6Qkq4+LcCXTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/19] s390/dasd: Read cached unit address and LSS in
 the CCW build path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801180033.3679412-20-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-20-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:50:48 +0000
Message-Id: <20260801185049.5D1FF1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless `memcpy` of `private->conf.data` in the IOCTL path is vul=
nerable to concurrent free/NULL assignment by the reload worker, potentiall=
y leaking kernel heap memory.
- [High] Unsynchronized access to `private->conf.gneq` in `get_fcx_max_data=
` can lead to a Use-After-Free or NULL pointer dereference during a sysfs p=
ath reset.
--

--- Patch [19]: [PATCH v7 19/19] s390/dasd: Read cached unit address and LS=
S in the CCW build path ---
commit 7b581c029d591219eb5fa66365930df6650b52f4
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Read cached unit address and LSS in the CCW build path

The CCW build path reads the base address and LSS straight from conf.ned,
which can be concurrently freed by the reload worker. Read the cached copies
instead, which are refreshed under the ccwdev lock.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 57e927926be1a..d9c5c02c3af18 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -588,8 +588,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_ec=
kd_data *pfxdata,
>  		return -EINVAL;
>  	}
>  	pfxdata->format =3D format;
> -	pfxdata->base_address =3D basepriv->conf.ned->unit_addr;
> -	pfxdata->base_lss =3D basepriv->conf.ned->ID;
> +	/* cached copies - conf.ned may be freed under us by the reload worker =
*/
> +	pfxdata->base_address =3D READ_ONCE(basepriv->ned_ua);
> +	pfxdata->base_lss =3D READ_ONCE(basepriv->ned_lss);

[Severity: High]
This is a pre-existing issue, but since we are fixing reload worker races
here, does the same race apply to the IOCTL path in dasd_eckd_fill_info()?

The BIODASDINFO2 ioctl locklessly reads private->conf.len and
private->conf.data for a memcpy():

dasd_eckd_fill_info() {
    ...
    info->confdata_size =3D min_t(unsigned long, private->conf.len,
                                sizeof(info->configuration_data));
    memcpy(info->configuration_data, private->conf.data,
           info->confdata_size);
    ...
}

Concurrently, the reload worker frees the memory and clears the pointer:

dasd_eckd_clear_conf_data() {
    ...
    private->conf.data =3D NULL;
    private->conf.len =3D 0;
    ...
}

Could this result in a NULL pointer dereference or copying freed heap memory
to user-space if the ioctl races with the reload worker?

[Severity: High]
This is also a pre-existing issue, but does a similar race exist with
private->conf.gneq during a sysfs path reset?

Writing to the sysfs path_reset attribute can invoke get_fcx_max_data()
locklessly:

dasd_path_reset_store() {
    ...
    if (device->discipline && device->discipline->reset_path)
        device->discipline->reset_path(device, (__u8) val);
    ...
}

get_fcx_max_data() {
    ...
    fcx_in_gneq =3D private->conf.gneq->reserved2[7] & 0x04;
    ...
}

If the reload worker calls dasd_eckd_clear_conf_data(), it frees the
underlying buffer without clearing the conf.gneq pointer itself (only
conf.data is set to NULL). Could a concurrent path_reset write trigger a
use-after-free here?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D19
