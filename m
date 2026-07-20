Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDB3C98B5;
	Mon, 20 Jul 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579468; cv=none; b=lKRZ+Ic1lv78XLg3L2nk0yC8HPdhPSEaCL803Wrowmbcm3Yc7IPd6WM8MsvSBnUxIRRaoPWF/AHbkSF65eWCWQEhilU2Ybyi3WlVGCoxe88pdNpewBhDIduTjZIqvTEJtoGWQakNrVS97cdc+acDywJJr8kVqiN8lw/jBHPfazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579468; c=relaxed/simple;
	bh=3EgOCkADAac8YVe6ZyOdYNW8Dr7yIiHyjdPIuq9gLgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CFEHCUi84dS+NVAy2J1zXhBfaGd2tgqkqzsO6UFjAVAid/S0R8qFGQ6ehi5W0IYUldnleYHJu35l6G4yg+Idbsf1rnrxJcdk5YAlYn/UsDs9jhzdp5B/lGZBCOEyq2mI8Hs/G0jQfciCqdCGAgBH5FtRqrX5V7wcmffKGQK5kJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcQe0TId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcQe0TId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655431F000E9;
	Mon, 20 Jul 2026 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579466;
	bh=pAOE+8XXjldwI2yf2wEDDwMuFUZMS/1DSvtuDYdKQJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dcQe0TIdx6dzFhn1EKpV2G/3N67H2eFwPHxeS8x2qgziC6byULmfSXMD+/yD82JbL
	 tFVp2N1E3ngqDDnZdFLq0tdRHQLjQdRwtjN8pd4b24qJKlCWBpZNiyMLrKxjbL2MgF
	 LYVLPkZTvKb9c7ijvqb8tBMMLndEk/h2dyrsr46ZFzHJVOONz7mfJraTKT/15D+Idi
	 MyH9lLFP66iaVOheYoehb3ShgniQCtFMDgA3hIdrD/67YIbHwUpYS0KWJOxGi5mUGA
	 zOECypxxKuwarLpOXW4FnlifpIp2ZQHUtxj6YvbIHZKiI4y1Q1Chw3ekIdd4fF/ZEC
	 OtO6/w7ejeeSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260720201931.976660-2-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:31:06 +0000
Message-Id: <20260720203106.655431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An untrusted guest can cause kernel stack exhaustion or memory exh=
austion (OOM) by providing a channel program with a deeply nested, linear c=
hain of Transfer in Channel (TIC) CCWs.
- [High] An off-by-one loop condition in `ccwchain_calc_length()` causes an=
 out-of-bounds heap read.
--

--- Patch [1]: [PATCH v2 1/7] s390/vfio_ccw: free all memory if cp_init() f=
ails ---
commit 6db32c0a42b6a98e43b665d960a38dfaf7572bca
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

This commit updates cp_init() to address a memory leak when initialization
fails. It performs the cleanup outside of the recursive handling logic to
avoid leaking segments created by Transfer in Channel (TIC) commands.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 7561aa7d3e017..086d1b54bdb05 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
>  	/* Loop for tics on this new chain. */
>  	ret =3D ccwchain_loop_tic(chain, cp);
> =20
> -	if (ret)
> -		ccwchain_free(chain);
> -

[Severity: High]
This is a pre-existing issue, but can this recursive call to
ccwchain_handle_ccw() cause kernel stack exhaustion?

Looking at ccwchain_loop_tic() in drivers/s390/cio/vfio_ccw_cp.c, it
recursively calls ccwchain_handle_ccw() for each forward-jumping TIC:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_loop_tic() {
        ...
        /* Build a ccwchain for the next segment */
        ret =3D ccwchain_handle_ccw(tic->cda, cp);
        ...
}

Since this happens without any depth tracking or overall chain count limits,
could an untrusted guest cause a panic or OOM by providing a channel program
with a deeply nested, linear chain of Transfer in Channel (TIC) CCWs?

[Severity: High]
This is a pre-existing issue, but does this off-by-one loop condition
in ccwchain_calc_length() cause an out-of-bounds heap read?

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
        ...
        } while (cnt < CCWCHAIN_LEN_MAX + 1);
        ...
}

If a guest VM supplies exactly 256 CCWs that all have the command-chaining
flag enabled, will the loop evaluate !ccw_is_chain(ccw) on the 257th
iteration?

This appears to dereference ccw one element past the allocated array on
cp->guest_cp, which could trigger memory debug splats or crashes.

>  	return ret;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D1
