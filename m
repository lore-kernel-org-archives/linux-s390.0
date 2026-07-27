Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BD3D091C;
	Mon, 27 Jul 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182304; cv=none; b=gvm5gNLGNGO5XcYcOWN55lnCKhATWy2grdj/clqciJuc3L3S9a5wZWYPAq0oFYMcpjHNfAWTmo2Rm0MIuaONLfLibdTR5uRx0bK5a0omvDleEvxWE02kKYEUdwM++qyW2G7qi7kXhX6bsnvbcZYiW6Go6v/8eOcWPn2saCYDXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182304; c=relaxed/simple;
	bh=MTFT8s8QKR2PV+6n7WYg7Cp5VAmQ5TBIvScO0OyAuL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndTI6cHW89n0+Wd3G9ckURDE6Ap7iKf35pNYUFCnGMRiSF8Rrv8JxNQkoccfg3EBAPWcifv7h2Yu3u6RWO6Nk6R7P+/W4Zk8DHEZ9VdGTk7EUjFCiCmZRfc977KJEMHHsKvnZNRhuxJ26e0r35oHo+nw8rgBnpQjtG2wUdD72eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNYYrjFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNYYrjFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ADC1F000E9;
	Mon, 27 Jul 2026 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182300;
	bh=EtWfhk0Ef8u+TYkbzQnVK36zplVRgLHrKSWhjhtGjrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNYYrjFVsM1A14IuWEN/KcqhOGdK9SjbDGX/qwYnzwnjOwUacp2SSYWngSmJN3nuf
	 GYbiyR5rQLdyQ+bRRoMDQpvqwG+3XDgVJsQKcGyhbgavotTXmnnOJ866SyfUjq5lDz
	 iAfpAjgrHl93khAV8b3BaWBALz7oZp1EwVOh8+3SjHSJIYDWvOsaewetyclGCQ/mK0
	 tyCGoOVIDB/T0U7haA9R/frLHEw5f8UHXkL145S5qu9rE7sAWzluxRlRlUNwG7JCkp
	 f6n9Lj9ethlofUnwb1wNcpQtHE4vCEGUqG38imqmHBSarm3cO3Y219VEw37dOfHB9X
	 +kR/n2tOnCXmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-2-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:58:18 +0000
Message-Id: <20260727195819.66ADC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded mutual recursion between `ccwchain_handle_ccw()` and=
 `ccwchain_loop_tic()` allows guest-triggered host kernel stack exhaustion.
--

--- Patch [1]: [PATCH v7 01/10] s390/vfio_ccw: free all memory if cp_init()=
 fails ---
commit 13d15b9ae0c6f03c0097ee35d98be7a7415af06e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

This commit updates the cleanup logic during channel program initialization
to prevent memory leaks. It extracts the memory freeing into a separate loop
over the allocated segments rather than handling it inside the recursive
ccwchain_handle_ccw() function.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
>  	/* Loop for tics on this new chain. */
>  	ret =3D ccwchain_loop_tic(chain, cp);

[Severity: Critical]
This isn't a bug introduced by this patch, but does this mutual recursion
have a depth limit?

If a guest provides a channel program with a long, nested sequence of
Transfer in Channel (TIC) commands, each pointing to a new CCW chain,
the execution path appears to cycle endlessly between these two functions:

ccwchain_handle_ccw()
  -> ccwchain_loop_tic()
    -> ccwchain_handle_ccw()

Could this unbounded recursion exhaust the host kernel stack?

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D1
