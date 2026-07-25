Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DF186284;
	Sat, 25 Jul 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994151; cv=none; b=cBUQnk0MHZsGaY3Plkc6Zv/KvMF4rzk/JUq/3qOUk0Zkwz62U6aOOM022PDCJUJMu/ut6UdWB6K23nxsUBgNRia4vGweopD9b5LDdnHeB8w2xrZmQKzNiM3RYUESTndbvtIVUZtUwTjQnoqvi6nGo0B07jBowkiZptz1aM0OmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994151; c=relaxed/simple;
	bh=A/HvRMcgSyAtX9GmptpgWQVt1H+e8LfOhhKn/mZWfRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzH86z8LzoiGlPhbTNfvmr0udLNk4dQJNWQIVdBRV7NwMf1SnPKhXyNecQDRyhABp8xw9uco9MRtWtT118ziaNJ5lhAC8Z398bdTH2EkoQr8Um/28gaPC06ATJnvAgZ9WfiXnb/W6iMu8uAKBwudhQlreRS9z34N8YvO0TVV8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1RtKC1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1RtKC1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41ECF1F00A3E;
	Sat, 25 Jul 2026 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994149;
	bh=vLvnzDbwETTjNzBXVpUT5Ddwrj2sia4LhnWl+xKqYjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1RtKC1b9OYenT1TKDtOYyYCBWwj6NTLkrq35RG9gcvv0bVD4SgJ32DJLHcro9CUS
	 kNDUVkertKUlIH19exrs78FYTTeeJ4PYFJUmUlGVRy0Qe/QUHSRUdg2s2j0fPpcjjK
	 szSG0QExQti+TT4IfS+DHIYolfLs0nN5xfXj5jY/csOKOM8uZkG1SNyEfJxLYbQyBi
	 +HdarGnrUE5OB21LzQqV33w/xlQb9teI3bg5lLsZtCfT8Gf2gCKi/Lt3/DcAIigL+K
	 eDZxS9nffgfpbzvcPOUqBNIwE7supzoCI38aNcch+zsn07vDifTYQpso3qqsoaXoEl
	 j4ptsjyrlNGwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260725152705.3958100-2-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:42:28 +0000
Message-Id: <20260725154229.41ECF1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded recursion between `ccwchain_handle_ccw()` and `ccwchain_=
loop_tic()` can exhaust the host kernel stack.
- [High] An off-by-one error in `ccwchain_calc_length()` causes a heap out-=
of-bounds read past the end of the `cp->guest_cp` array.
--

--- Patch [1]: [PATCH v4 1/9] s390/vfio_ccw: free all memory if cp_init() f=
ails ---
commit 8ee92e1dc4c9d7d0f67c0ba543dd404b37f81dcc
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

This commit addresses a memory leak where CCW segments created as a result
of a Transfer in Channel would not be properly freed if cp_init() fails.
It moves the cleanup logic outside the recursive ccwchain_handle_ccw() and
ccwchain_loop_tic() loops.

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
This isn't a bug introduced by this patch, but can this unbounded recursion
between ccwchain_handle_ccw() and ccwchain_loop_tic() exhaust the host kern=
el
stack?

If a guest constructs a channel program consisting of a long linear sequence
of TICs (Transfer in Channel), where each TIC points to a distinct, previou=
sly
unvisited address, could this lead to a kernel panic from stack overflow?

Since there is no limit on the recursion depth, ccwchain_handle_ccw() and
ccwchain_loop_tic() recursively call each other until the stack overflows:

ccwchain_handle_ccw() -> ccwchain_loop_tic() -> ccwchain_handle_ccw()

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but does an off-by-one error in
ccwchain_calc_length() cause a heap out-of-bounds read past the end of the
cp->guest_cp array?

If the guest provides a CCW chain of exactly CCWCHAIN_LEN_MAX (256) element=
s,
with all elements having the chain flag set, the loop logic permits
evaluating the chain flag on the out-of-bounds index before realizing
the maximum limit is reached:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
    ...
    } while (cnt < CCWCHAIN_LEN_MAX + 1);
    ...
}

Could this lead to a kernel Oops if it crosses a page boundary into an
unmapped page, or trigger KASAN panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D1
