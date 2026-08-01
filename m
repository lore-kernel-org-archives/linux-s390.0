Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AF305666
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608911; cv=none; b=Re5oR9I0e2PO8czZEg9LQHxpoAO678JfCs64oGtgHlhrp/XA1rjbGTyIsPMLVQfm/AvJadwOVR+LT72nzusNLC/ei5gPz98qG+vo+ScwFKjPxWialaxkeVC+U/HVza52s25sd6H92s6bzNSUdl198uKoPlw0uxy+yeu6ltGoH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608911; c=relaxed/simple;
	bh=jS5gjf4SsO9F7nESLYkQS0PPXVfjtYFk/MAPiK2NV8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uk30dKX7fQktsX5EI+AGVjf2ZSOJ2bl9rcqazfo+BikedhumL7WVZ0zxXDbAsIcB70Bej8a+u8js4LoYlXyjzTSBkuXjpf6KjX5mdol+/pd8FzfmiiNw5XfDHX59H4pswRTnw8ftckI7cIpBZPszFmQ4SGkDSCCCykdrIm1e5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF6J7zw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF6J7zw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC161F00AC4;
	Sat,  1 Aug 2026 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608910;
	bh=AaDe5+vxDmXyu7bUUZeAULzFpmlU4ImdrrUpC5qhDF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bF6J7zw5KKxq71A5ATHtAAF5p6PXmoPZ050s4q2gf/a+VkQMRGFkToWvmobB6OGdL
	 XIcU+XWU91uyQmZFUTk6KcFJcNBJmDK9iEoZBDc8oSVswCrQY/XUOPjJZPx7HGHH98
	 KOrxo2oEGUABmpVF0jaeo5w2l3v0OCZT1HUMI4ZH4yT/JEe2ZEIwBTTke2jnr2KD9V
	 PPpbL0su7YUAcpOX4VtEiEITDxKth1qSPYn9y99FM+6Lv99o358qJHNabPvqHUdnN3
	 ezRBqV3N8UZv3JFQkfLXW9Ra5lXMNhGDHEwqmFffS2QfRNa5hPySptpBubKxGHJyWb
	 QcwkrIOyjz2Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/19] s390/dasd: Extend prepare_itcw() to support
 WRITE_FULL_TRACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801180033.3679412-11-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-11-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:28:29 +0000
Message-Id: <20260801182829.DBC161F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardware protocol violation in newly added WRITE_FULL_TRACK supp=
ort
--

--- Patch [10]: [PATCH v7 10/19] s390/dasd: Extend prepare_itcw() to suppor=
t WRITE_FULL_TRACK ---
commit 957b430fd410ae687b07b4353fc0a1d151996c40
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK

This commit extends prepare_itcw() to handle the
DASD_ECKD_CCW_WRITE_FULL_TRACK command. It appends two extra bytes to the L=
RE
for the bitmask and sizes the prefix block buffer dynamically on the stack
to prevent allocation failures under memory pressure during writeback.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 678d6f353e882..b54d1858db160 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -4448,7 +4455,38 @@ static int prepare_itcw(struct itcw *itcw,
>  		 * data as well.
>  		 */
>  		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
> -			pfxdata.validity.time_stamp =3D 1; /* 'Time Stamp Valid' */
> +			pfxdata->validity.time_stamp =3D 1; /* 'Time Stamp Valid' */
> +		pfx_cmd =3D DASD_ECKD_CCW_PFX;
> +		break;
> +	case DASD_ECKD_CCW_WRITE_FULL_TRACK:
> +		dedata->mask.perm =3D 0x3;
> +		dedata->mask.auth =3D 0x00;
> +		dedata->attributes.operation =3D basepriv->attrib.operation;
> +		dedata->blk_size =3D blksize;
[ ... ]
> +		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
> +			pfxdata->validity.time_stamp =3D 1; /* 'Time Stamp Valid' */
>  		pfx_cmd =3D DASD_ECKD_CCW_PFX;
>  		break;
>  	case DASD_ECKD_CCW_READ_COUNT_MT:

[Severity: Medium]
Will this result in a hardware protocol violation when the new
DASD_ECKD_CCW_WRITE_FULL_TRACK command is processed further down in the
prepare_itcw() function?

After the command switch statement in prepare_itcw(), there is a catch-all
else block that handles lredata->auxiliary flags. For commands not explicit=
ly
handled by the preceding if statements, it falls into this branch:

	} else {
		lredata->auxiliary.length_valid =3D 1;
		lredata->auxiliary.length_scope =3D 1;
		lredata->sector =3D sector;
	}

Because DASD_ECKD_CCW_WRITE_FULL_TRACK is not explicitly excluded, it falls
into this branch and unconditionally sets length_valid =3D 1. Formatting
tracks mandates no single valid record length, requiring length_valid =3D 0
and length =3D 0 to avoid a Command Reject.

Should the conditions leading to this else branch be updated to properly
handle the LRE format protocol for WRITE_FULL_TRACK?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D10
