Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C511A5BAE;
	Tue, 28 Jul 2026 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203426; cv=none; b=G6NjXWO4G79yKkVAW+o0H/sZrvvUl+h/DqjCgyYwsyyhVnS2Tibt6jPyircDSy1E5IftqwBFBQDww70Jq6N9eujPQ7GKGWkkqQTD74UyZpkYmB5kJEA1WMYUkrylBMPyiPd/LlZ5fsjszrSA7TCZk7aOXRDcJKelDFxwNO3Pq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203426; c=relaxed/simple;
	bh=xLIL0Liq443hYr43mO8PHq4gaTHjVtFeyEHTANbwQ1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s1inTlz59pfCTH2m8rtp08kjZ1cZhBxLE52SEQi3loHRh7lL1gpXS8vv5l/0tyn1oqC12SK7APzPyp/5h6cs3t/WaFdr2ME5qvtr37J+j+55TLmdzt/VeA0+DtixXWaBUIMMw15oX/Ydl3cUXIPrIX8sCe0OD+tJPqEeFnmbSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8dCdX9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8dCdX9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33A71F000E9;
	Tue, 28 Jul 2026 01:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203425;
	bh=UJjq6KVWNwoHpyHWhEIL8BuLpOqY1V5j9wswjJxAXCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8dCdX9S2Xmik4caXSI8p6HZ51OIJmy1xOMG457/5MuV3cnMhAdbvlZmaZmzTICWG
	 ZzNwJBekGRl/5plhsgCpQ+4NmgI43c+8AXHTfXiiJl7aWw431hGVUHHPlibIsR4c36
	 dq6cig/QqpGTOt/JArC+XPU0YgqfBeN0diMgw/E35DqSR1UMgYDONwT3+V5jwp6rpl
	 3m2gZfoFBJyIULIhT7i82Jv+V+3LCTegVi4Z3dG6eSqAE0vCl4Vh0ywT7aOK4hkvQH
	 3awxCeqFZxU0EEbw+Eg6s1kmWH3vmEotgx6UXh/LTRke2nzVO437lZJW9i1a7cMeR+
	 JVQdLWAhDIhLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/10] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-4-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:50:24 +0000
Message-Id: <20260728015024.E33A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally attempts to read a full 2048-byte chunk=
 (256 CCWs) from guest memory, which will fail if a valid, shorter channel =
program is located near the end of mapped guest memory.
--

--- Patch [3]: [PATCH v8 03/10] s390/vfio_ccw: fix out of bounds check on C=
CW array ---
commit f979cac6ff9095b28670a21c1bdc95dfaa156466
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: fix out of bounds check on CCW array

The routine ccwchain_calc_length() counts the number of channel
command words (CCWs) that are chained together in a single channel
program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.
The loop is restructured to avoid checking memory outside the valid range.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 1c2890d139c6b..af632f9d54535 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -377,11 +377,9 @@ static void ccwchain_cda_free(struct ccwchain *chain=
, int idx)
>  static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>  {
>  	struct ccw1 *ccw =3D cp->guest_cp;
> -	int cnt =3D 0;
> -
> -	do {
> -		cnt++;
> +	int cnt;
> =20
> +	for (cnt =3D 1; cnt <=3D CCWCHAIN_LEN_MAX; cnt++, ccw++) {

[Severity: High]
This is a pre-existing issue, but since we are modifying the CCW bounds
checking here, could the unconditional 2K DMA read in ccwchain_handle_ccw()
inadvertently reject valid channel programs?

The driver unconditionally attempts to read a full 2048-byte chunk (256 CCW=
s)
from guest memory before calculating the actual length:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_handle_ccw() {
    ...
    /* Copy 2K (the most we support today) of possible CCWs */
    ret =3D vfio_dma_rw(vdev, gcda, cp->guest_cp,
                      CCWCHAIN_LEN_MAX * sizeof(struct ccw1), false);
    if (ret)
        return ret;
    ...
    /* Count the CCWs in the current chain */
    len =3D ccwchain_calc_length(gcda, cp);
    ...
}

If a guest uses a strict vIOMMU mapping and places a valid, shorter channel
program near the end of a mapped IOVA region, won't this read cross into an
unmapped page and fail with -EFAULT? This appears to render the device
partially or fully unusable for guests configuring their mappings this way.

>  		/*
>  		 * We want to keep counting if the current CCW has the
>  		 * command-chaining flag enabled, or if it is a TIC CCW

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D3
