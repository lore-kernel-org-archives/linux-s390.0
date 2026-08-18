Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6B275AFD
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036940; cv=none; b=V++/9goN1yIQqxvAJgRfCbW6wsJ3GgsTJ6ZPDb4bc2RO29iPWDNPDZVHEjIZ2d0YpMporeBxuqT5ZETYDpUZeRD8FNn7bC25Y2gkkcWWi6E9ZAh0ff0BIvJucSKGj563On6zT+kiLEniWGr+l5dB7hrwE164iao1x29jxhx1u54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036940; c=relaxed/simple;
	bh=fC3NdcpwjAOQH9HFbAFd2k0YcWK8lJB39E/zzm7ZsHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SF38PT90zARBFPZxrcVrVqMXhAPEJHPG9z9N76CKs9DLxOTdgR5uiYB4wf8xyI7mdFv087qeM3lftmBYNSR7pTenRBA6i1Zmi3K7UmEVdcQU+xRDnhx6QGQarx950dJlX4Ucmp6aRL1Xm9ymUlnPmefmDOpKaP3cEIKDye+G1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgGJ7ffe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgGJ7ffe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE81F000E9;
	Tue, 18 Aug 2026 07:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036939;
	bh=cCQdLdqwKmBEvVC0FmpsDusAXP2UAQT4qDILXng3WBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JgGJ7ffeVg6TgLDtUeo4iG3luZSQq/4ekxQ6Sa/jrQraNl1TTr13qG90voW08MucU
	 oYya4XYoVUVjmQgV2V1iSXXt8TV4PbMcBOGpBC57Myc8fbOCSABYlJJeQZ+HeQTUqX
	 c8GcexjdTJdbE2PISPMBB4TAUb+ijF7FJPxtTc2gqbV9boQRABWJZ+X76B2LmCL/ze
	 v6aqBrXjG/7QBFpilAceiQr7gaPb4zgG2ZvgYFTm6utMWTyzg+NAtoCSzauk6uE1rQ
	 jpMS6Pydq58Se7hqCJPSLpMLMW2Vu155luWahFw5mh22ot/2LqOZx9cdT6rg/yNrt/
	 ytmbNgqF4Xxhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: raw3270: Handle allocation failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818070023.1654606-1-triet.hoang.dev@gmail.com>
References: <20260818070023.1654606-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:08:58 +0000
Message-Id: <20260818070858.D5DE81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Freeing `rp` on the `ccw_device_enable_console()` error path leave=
s a dangling pointer in the global `raw3270_devices` list.
- [Medium] The newly added allocation error paths leak the previously creat=
ed `cdev` console device.
- [Medium] Adding complex memory allocation failure handling to an `__init`=
 function is unnecessary and violates early boot guidelines.
--

--- Patch [1]: [PATCH] s390: raw3270: Handle allocation failures ---
commit 461fe23d860b7a48d2ce561a29cd0a5780d12446
Author: Triet Hoang <triet.hoang.dev@gmail.com>

s390: raw3270: Handle allocation failures

This commit adds return value checks for memory allocations in
raw3270_setup_console() to prevent NULL pointer dereferences. It also
adds error handling to free allocated resources on subsequent failures.

> diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
> index aa9c4d81225cb..69e0f69a3e149 100644
> --- a/drivers/s390/char/raw3270.c
> +++ b/drivers/s390/char/raw3270.c
> @@ -814,15 +814,26 @@ struct raw3270 __init *raw3270_setup_console(void)
>  		return ERR_CAST(cdev);
> =20
>  	rp =3D kzalloc_obj(*rp, GFP_KERNEL | GFP_DMA);
> +	if (!rp)
> +		return ERR_PTR(-ENOMEM);
> +	ascebc =3D kzalloc(256, GFP_KERNEL);
> +	if (!ascebc) {
> +		kfree(rp);
> +		return ERR_PTR(-ENOMEM);
> +	}

[Severity: Medium]
Since raw3270_setup_console() is an __init function executed early during
boot, is it necessary to handle these memory allocation failures?

Usually, at this stage, if the system is out of memory it cannot boot anywa=
y.
Adding complex error handling to early init paths can introduce dead code or
accidental regressions.

[Severity: Medium]
If this error handling is kept, does returning ERR_PTR(-ENOMEM) directly he=
re
leak the console device (cdev) that was created earlier in the function?

ccw_device_create_console() allocates cdev at the start of
raw3270_setup_console(). It looks like ccw_device_destroy_console(cdev)
should be called before returning here to avoid leaking the device and its
associated resources.

>  	rc =3D raw3270_setup_device(cdev, rp, ascebc);
> -	if (rc)
> +	if (rc) {
> +		kfree(rp->ascebc);
> +		kfree(rp);
>  		return ERR_PTR(rc);
> +	}
>  	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
> =20
>  	rc =3D ccw_device_enable_console(cdev);
>  	if (rc) {
>  		ccw_device_destroy_console(cdev);
> +		kfree(rp->ascebc);
> +		kfree(rp);
>  		return ERR_PTR(rc);
>  	}

[Severity: High]
Does freeing rp here leave a dangling pointer in the global raw3270_devices
list?

In raw3270_setup_device(), the successfully initialized rp is linked into t=
he
global list:

drivers/s390/char/raw3270.c:raw3270_setup_device() {
    ...
    if (rp->minor =3D=3D -1 && minor < RAW3270_MAXDEVS + RAW3270_FIRSTMINOR=
) {
        rp->minor =3D minor;
        list_add_tail(&rp->list, &raw3270_devices);
    }
    ...
}

If ccw_device_enable_console(cdev) subsequently fails, the added error path
calls kfree(rp) without first acquiring raw3270_mutex and unlinking rp with
list_del(). On the next list iteration, this will cause memory corruption a=
nd
a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070023.1654=
606-1-triet.hoang.dev@gmail.com?part=3D1
