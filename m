Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13D1FF7C8;
	Tue, 28 Jul 2026 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203484; cv=none; b=eunKEPZNGC8qmGTFcsCePjvLqvdm6hyCWGYkrwrIhBbh+pComFRccPUfNJc36Gp+/CqVskls9BkSW68UfCBchQz8x7WwtbE4sfhK+YGRsYVv4ngFfhTiLR419tS3FezUf0e58tJWS6JT0iYeGpx+ZKdaDPC7FdZDVqMyA36/VJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203484; c=relaxed/simple;
	bh=3yMrAvLEllcvjQkRjcg6XVOswGKt9KPhDgWlnDwgORY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YjAo7Jo529efKx/1WuJEV7xF9OvM4ZkSj7a0XYgKXe3w5Cn0fHC/OSR6c7bbffDbEFekB4xXJ/wSjBgdYG0nG8LRS9x84t5sdL7+HmMn49qIoCsEYyiDD06SDBcWH9cZQSgFzZjzmLdDArKkv2uiOjIFzlOujI0YejntzNkuOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7s7tdK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7s7tdK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9821F000E9;
	Tue, 28 Jul 2026 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203483;
	bh=h/1pScK/iAGoTpXYf950BDRelNFDN3L3rUOh+Ch7CSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7s7tdK0tX7e0QwPG5Pv08U+ReiPRvTWJGlv7fRFqrpdITNOIgk1wiFe0ROdh52SV
	 no2WoadGwS8y6fsuATG7IuPdWroeGA1lIRMsPHL3fHgIKqYjqujV/S8sHsAPmo+mBO
	 3d11sCPihJ55LQd5pfBECuOB9Zre3u9tv1974diOq4M+3Qee8GwQGTlfxq7vNJmAbf
	 /T+oRAmi2SreplRpqI8pHpx9jwCtFhPSYP+P9rnm7zdfpBeunJl64xKsVHW52s2N3q
	 lEHz3oEu0Hjbxnefm09QVhoZ71hmS60i3NzdVASoOjFY0sr4ka38QgTsFxDdPy2nks
	 LukWQBuhe6Olg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/10] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728013509.1551753-2-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:51:22 +0000
Message-Id: <20260728015122.AA9821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded recursion in CCW chain processing allows a malicious=
 guest to overflow the host kernel stack.
- [High] Off-by-one out-of-bounds read in `ccwchain_calc_length()`.
--

--- Patch [1]: [PATCH v8 01/10] s390/vfio_ccw: free all memory if cp_init()=
 fails ---
commit 7b177e824046c97e78d70a5cb8daa7a37e59333e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

This commit addresses a memory leak in the channel program cleanup logic.
By moving the cleanup outside of the recursive handling functions, it
ensures all segments created by Transfer in Channel operations are
properly freed when initialization fails.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 7561aa7d3e017..086d1b54bdb05 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
>  	/* Loop for tics on this new chain. */
>  	ret =3D ccwchain_loop_tic(chain, cp);

[Severity: Critical]
This is a pre-existing issue, but does this recursive call chain allow a
guest to trigger unbounded recursion and exhaust the host kernel stack?

Looking at the code execution path:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_handle_ccw()
   ret =3D ccwchain_loop_tic(chain, cp);

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_loop_tic()
   ret =3D ccwchain_handle_ccw(tic->cda, cp);

If a guest constructs a channel program with a long sequence of Transfer
In Channel (TIC) instructions, each pointing to a distinct CCW chain
memory address, tic_target_chain_exists() will return false.

Could this cause ccwchain_loop_tic() to recursively call
ccwchain_handle_ccw() for each segment without any depth limits, leading
to a guest-to-host denial of service?


[Severity: High]
This isn't a bug introduced by this patch, but is there an off-by-one
out-of-bounds read in ccwchain_calc_length() which is called earlier in
this function?

ccwchain_handle_ccw() calls ccwchain_calc_length(), which has the following
loop condition:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
    ...
    } while (cnt < CCWCHAIN_LEN_MAX + 1);
    ...
}

Since guest_cp is allocated with exactly CCWCHAIN_LEN_MAX elements (256),
when cnt becomes 257 during the iteration, evaluating the ccw pointer
accesses guest_cp[256].

If a guest submits a chain of exactly CCWCHAIN_LEN_MAX length with the
command-chaining flag enabled on the last element, could this read past the
end of the allocation and potentially oops if it hits an unmapped page?

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D1
