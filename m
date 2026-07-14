Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481D2DB78C;
	Tue, 14 Jul 2026 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072321; cv=none; b=q7YaG/a/YN4upJB+JqwqeuWopFUOn0zJU1aGGR2HVhgcY/9YTGZzK35t9On9WQQB1ujG6K2eSMdW8OP6mxMLOiK/gxjMMtfzBhTlyZL9JKLU5SoKAYp25mxY1cpDd+oYQnoGMZu8dQxuI9Y56dQ1tLInGPfQ1oYjplYViPXJ3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072321; c=relaxed/simple;
	bh=RSQYiyqkQ2M5pMxmKyggFZjZLsmVo/pUAevbAv1Asmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Va4/NKPAZSRQOWCuxHfDmxOvoAhr+C3pr+qKHTJZ7KmcIDstvFlsu7gvtgSEwoFvtygk07vCRGIhH3W1VTAA0YEBW0e98fM1r2wYdOeeFS951euO7WsWCbohS2Te0r0QarxyHWFmG/FglR9ZMMFHczE6ryG9AiEley/k3AO7aQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9QG0Nt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9QG0Nt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C801F000E9;
	Tue, 14 Jul 2026 23:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072320;
	bh=W2UU9/eDXLkW3p99QB71mk3IBM0LIgW1LG4y5PSGJoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9QG0Nt9QC4rppkVwJMS8l2x/oYUkA3kXUdx+iWwQtDirLSsrd7w3sFTgjsDbe9lj
	 Zv2LglijGmXzHRyC1XNBVK1ac3AmH9qppYfihFW37S2TOMY+EgjAHw9nTezP9nligO
	 sPuo1p9vbP1XWOJOwMxIdZwBe1z3NrSnB8l0ycvbgG7LXtQfxwyvjpQu7tCbvtmjin
	 XUf+f7DuXsrOR+L9x3pzMPBE6363iJPu4KL8NECySEMajQI+i3hDEaEno5w9dkTm4M
	 s6pVr8h0BEQ/LySisUTEyw5oObawpQ/bRGElBiJh1ZUm6GclOfY9N2gbKDWKh0Tata
	 J4nvYxk17PVtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/6] s390/vfio_ccw: limit the number of channel
 program segments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714232208.1683788-3-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
 <20260714232208.1683788-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:38:39 +0000
Message-Id: <20260714233840.04C801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A memory leak in the channel program translation error path allows=
 an unprivileged guest to deterministically exhaust host kernel memory.
--

--- Patch [2]: [PATCH v1 2/6] s390/vfio_ccw: limit the number of channel pr=
ogram segments ---
commit 60b67e17bbec7656c3dc68a47e90805965d6fb93
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: limit the number of channel program segments

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 80c3d87f54822..76632b18fc37c 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -319,6 +319,9 @@ static struct ccwchain *ccwchain_alloc(struct channel=
_program *cp, int len)
>  {
>  	struct ccwchain *chain;
> =20
> +	if (cp->ccwchain_count >=3D CCWCHAIN_COUNT_MAX)
> +		return NULL;
> +
>  	chain =3D kzalloc_obj(*chain);
>  	if (!chain)
>  		return NULL;

[Severity: High]
This is a pre-existing issue, but does this new limit make a memory leak
trivial for an unprivileged guest to trigger?

If a guest constructs a channel program with multiple Transfer-In-Channel
(TIC) CCWs, an early TIC might successfully allocate and link a chain into
cp->ccwchain_list.

If a subsequent TIC in the same loop hits this new CCWCHAIN_COUNT_MAX
limit, ccwchain_alloc() will return NULL, and the error will propagate
back to cp_init():

drivers/s390/cio/vfio_ccw_cp.c:cp_init() {
    ...
    /* Build a ccwchain for the first CCW segment */
    ret =3D ccwchain_build_ccws(orb->cmd.cpa, cp);

    if (!ret)
        cp->initialized =3D true;

    return ret;
}

Since cp->initialized remains false on error, when the subsystem later
calls cp_free(), the cleanup is skipped:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    if (!cp->initialized)
        return;
    ...
}

The next I/O request then unconditionally wipes the list, permanently
leaking the orphaned chains:

drivers/s390/cio/vfio_ccw_cp.c:cp_init() {
    ...
    INIT_LIST_HEAD(&cp->ccwchain_list);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714232208.1683=
788-1-farman@linux.ibm.com?part=3D2
