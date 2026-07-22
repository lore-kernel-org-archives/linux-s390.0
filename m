Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F740DB33
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734397; cv=none; b=tOKZMLtznuu/FKPLu2II1qHnmGkjqUFpYLrkfU/UvqXsMHU8Do0Ds+3g0qOXnWkqkjHkcNP3Gw72oWoHecWjauqqFzs3k32BbODeGNGir4hlRWNfliJcbnzh+HxQOlQgsHsjjymBwcb2Soc2vItyCN2usjdBWqe3YyCJEkqJtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734397; c=relaxed/simple;
	bh=JuOX7XifXh0yd5cyyAooI7T185br6D/DisPLf+OzwFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vpkd5q0w5WhiRtMhWFDwGwFGn8JwgE20HWweeJDUXXC86Bp7yYvK7GcrpSHeJqqvbU1itLK9vQrMjqX57hWCe3MUg8AEaTgHVDzVjz+Ymp0DnVlNLS6gNZvgjngWiXtKv3DnEaxEYYB4ChKZ6xA8txiYDTodvOElQXgI0Mv+dxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvE/QIIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvE/QIIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C012C1F000E9;
	Wed, 22 Jul 2026 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734396;
	bh=nkiSmcgn42OPN52cCj8QBcMROCH7jMX1ScSUij7yIQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvE/QIIj2G4nP6M9xpFYy5gAjb84YzDteWMkxCTRqV3CD6UdidVWeswEJDk2ihvYi
	 ihf6oUCfEIfnbUiW1dztyYWV+pmicUiWXs1JLQM0GgUP8EkvU3rTnJrJWoLgc7UV8M
	 gC36D+npqRDUUId9lmOgtrpPqC1Pvx5uY7JdQQ22oAoMgrJ9RxlZX1Fqh5O4NV/UOR
	 PcqRTcA44UE3YUDMiqBiycz+92oQFpXsShufyBd6lkhhjWBBY/qR7iU6RjmkolK0dt
	 qvWcdPxvZIKmOzbPPgfXAYXCEOtO4URX0NnLXjxz9rONfTdmZ1pQq7AOlvUmOzaySS
	 BwAZ3v//4UBwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/dasd: Restrict discard support to virtual DASD
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Volkan Unal" <vunal@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260722151651.292621-3-vunal@linux.ibm.com>
References: <20260722151651.292621-1-vunal@linux.ibm.com>
 <20260722151651.292621-3-vunal@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:33:14 +0000
Message-Id: <20260722153315.C012C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `DASD_FEATURE_DISCARD` flag is not explicitly cleared for ph=
ysical FBA devices, leading to stale state across device unbind/bind cycles.

Pre-existing issues:
- [High] The patch fails to disable discard support for physical FBA device=
s because the block layer discard limits are controlled by a static discipl=
ine flag, ignoring the `DASD_FEATURE_DISCARD` feature bit.
--

--- Patch [2]: [PATCH 2/3] s390/dasd: Restrict discard support to virtual D=
ASD devices ---
commit f569dc59ce446ed69c2b0f0ac3f1918f27f26ea3
Author: Volkan Unal <vunal@linux.ibm.com>

s390/dasd: Restrict discard support to virtual DASD devices

Enable discard operations only for virtual FBA DASD devices with control un=
it
type 0x6310. Physical FBA DASD devices do not support discard.

> diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
> index 45a488db897fe..2869f93ac0ed6 100644
> --- a/drivers/s390/block/dasd_fba.c
> +++ b/drivers/s390/block/dasd_fba.c

[ ... ]

> @@ -167,8 +172,9 @@ dasd_fba_check_characteristics(struct dasd_device *de=
vice)
>  	if (readonly)
>  		set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
> =20
> -	/* FBA supports discard, set the according feature bit */
> -	dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 1);
> +	/* Virtual and EDEV FBA supports discard, set the according feature bit=
 */
> +	if (cdev_is_virtual_or_edev(cdev))
> +		dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 1);

[Severity: Medium]
Does this code leave stale state if the devmap is reused across device unbi=
nd
and bind cycles?

Because dasd_devmap_from_cdev() reuses a persistent devmap keyed by bus ID,=
 if
a virtual device is unbound and a physical FBA device is bound to the same =
bus
ID, the physical device might incorrectly inherit the DASD_FEATURE_DISCARD
flag.

Should there be an else branch here to explicitly clear the flag using
dasd_set_feature(cdev, DASD_FEATURE_DISCARD, 0)?

[Severity: High]
This is a pre-existing issue, but does the block layer actually evaluate the
DASD_FEATURE_DISCARD flag when configuring limits?

Looking at dasd_state_basic_to_ready() in drivers/s390/block/dasd.c, the
discard limits are configured based on a static discipline flag:

drivers/s390/block/dasd.c:dasd_state_basic_to_ready() {
    ...
    if (device->discipline->has_discard) {
        unsigned int max_bytes;
    ...
}

And in drivers/s390/block/dasd_fba.c, this flag is unconditionally true for
FBA devices:

drivers/s390/block/dasd_fba.c:dasd_fba_discipline =3D {
    ...
    .has_discard =3D true,
    ...
}

Will physical FBA devices still receive discard requests because the block
layer limits configuration completely ignores the DASD_FEATURE_DISCARD feat=
ure
modified here?

> =20
>  	dev_info(&device->cdev->dev,
>  		 "New FBA DASD %04X/%02X (CU %04X/%02X) with %d MB "

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722151651.2926=
21-1-vunal@linux.ibm.com?part=3D2
