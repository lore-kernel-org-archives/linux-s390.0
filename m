Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED03D567A;
	Sun, 26 Jul 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087298; cv=none; b=mXIE9nEU5+egG29V42bjcMtFDeEWcSghbf/3Gzf7ZOGrE075GuhrZlrcuQQali+tOWcdGenKi0eQPgiW0xgWBdLg5qUTcVPv/xnpQexHj6B14kWmytIbcMozI9Rl2mSYFdN1J2FNkulVcf/oq/M++jiawO1URoN4YfXf0knewFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087298; c=relaxed/simple;
	bh=Ih+Yj7w+0lMHRxyTxgAukXOAvoDS04q+sJmE0+EYdOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4wW0QP9eh+LQI/JGuyYHo7HVcvMZKwtBrNiIoOxf4QDvXKMAg4yIIHie5vXQXByCYy5443jgBBTTs3R+gHCJD304zxoqYY04yNn0CktQfBbcLDQEyeSHw8WDzv0xmtpSVWJ7FLwqfRTH3ZgUEIgurozHHwuJoFYHwjsGYcMKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfy9R2Q1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfy9R2Q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FE01F000E9;
	Sun, 26 Jul 2026 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087297;
	bh=RuWkdpGQp825X59fqNX8BtycZCd5EXl3tEKRnzpAco0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfy9R2Q1BsE+sVxHiQZLn0vtcvRh8rAihmmwInekmuj3WB17cF5b+rSaNaipjh/ym
	 LvYRiKa53VZxj0lPTGZCKt4ulQV/MySAIkRLohtEpS4l2Q3n4IKLhsbci8+j7CW2Cl
	 kLsBOD+OYXMVT2E7cAD3Ol9O5NR773FafjGvmKIdkeMD2kQBz1A44nDlLFZRPBrqcI
	 /y7KGVfq/HPOFANFqWGKGaRFrXVa2eaUzz4bYurnhnIJUjjq+fTAzUjV5ldgZyp2c9
	 oONT4GJWK2cC+WlkuYo+eivlUGVAIxvS7p5WJMXSWtgXJWqhZ3ABInVukXr1ndSzHS
	 v6/82MK2/MVEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260726172153.1818056-2-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:34:56 +0000
Message-Id: <20260726173456.E5FE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded mutual recursion in ccwchain_handle_ccw() and ccwchain_l=
oop_tic() allows guest-triggered host kernel stack overflow.
--

--- Patch [1]: [PATCH v6 01/10] s390/vfio_ccw: free all memory if cp_init()=
 fails ---
commit b372b54349a3df82ccfde24a98d73048ed49e7f0
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

This commit fixes a memory leak in the channel program initialization by=20
moving the cleanup of allocated CCW segments outside of the recursive=20
ccwchain_handle_ccw() and ccwchain_loop_tic() logic.

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

[Severity: High]
This is a pre-existing issue, but does this mutual recursion between
ccwchain_handle_ccw() and ccwchain_loop_tic() in=20
drivers/s390/cio/vfio_ccw_cp.c have a bound to prevent a host kernel=20
stack overflow?

If a guest constructs a channel program with a long sequence of
Transfer-in-Channel (TIC) instructions, each pointing to a unique guest
memory page, it appears these functions will continuously call each other:

ccwchain_handle_ccw()
  ccwchain_loop_tic()
    ccwchain_handle_ccw()

Could an unprivileged guest exploit this unbounded recursion to exhaust the
host kernel stack?

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D1
