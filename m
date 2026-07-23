Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A53515FE;
	Thu, 23 Jul 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831524; cv=none; b=GgTvgQsb3fxfvZoA/ZmQZknWWg+hKh34cEWJ6kWSd5QlQFBPVXYLvWFx/NQu4p8HFU83lTbyN/m2rIIzpQmXUomBKlGwcEbJ8wLrAp75plxumvUbjtXJTa3sAUQzRUr43zy0VzlR/Cn3/8q9bYWt6HoTwhMolMjUyxIBsD+1Y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831524; c=relaxed/simple;
	bh=ZC1GF1MNZePh9HLLuuog9KO9//houAM+fAU1BrOZPdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sgcSxAHbxU9VapGPToaFi7foIUqnI4HHwCY8o4yo6qSwsEZr8BzPkLw67g3vQMiQzJnhPJw08ukw2fqnaZ42b84xM0+FzCGBK7jTUemR+gDofdftd8OdlOpOFgPLfZ3TtWjOwMh0zuM5b9rBwxr9aA7kI37x7NAoStmVk0m+jIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdpy4aOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdpy4aOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD181F000E9;
	Thu, 23 Jul 2026 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784831518;
	bh=gyDSgT+6hZ3IABio99o7X+r2PvEh8UgvnWY8feAe5FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fdpy4aOD0hc4e8QAZNOZ7Zp8J7iFf7fQHEvqwJSyo5mSCc987xV2v22wj0+rJ1OpE
	 VUftxcQ6Lv1w0sFIBfBwFgH2Csea2fC6EtZTPfenOFu2E8R339egDMVNUo0Z2DA+O2
	 VUsvaefIK2KgP0VSBHDF/Y3OgSDq4q8O4+AN3eMiGsLYWRAIMTGukP50EUUypMaviR
	 iOvIXOWTXMh7lBQUGgg6w6q2IY7jTzJYVMrvxqp+kl91zWCrS55HIE+/TQlhShomCR
	 tUUqcZ0woWqQzAoPoGmk4WHqLX6ZsXxEch7vp4arKCrlJn981YFWMhWnQpqH0TOp2E
	 YNQoigNiy1OpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-2-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:31:58 +0000
Message-Id: <20260723183158.7FD181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded mutual recursion in channel program parsing leads to=
 host kernel stack overflow.
- [High] Out-of-bounds read in `ccwchain_calc_length` due to an off-by-one =
error.
--

--- Patch [1]: [PATCH v3 1/8] s390/vfio_ccw: free all memory if cp_init() f=
ails ---
commit e7fe5fe9c1f027187ba27b2948379cc2bd88397e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

The routine cp_free() is called to unpin/free any memory once an I/O
is completed successfully, or if cp_prefetch() fails. But if cp_init()
fails, and cp->initialized is not enabled, the same routine cannot be
used to free all the memory. This patch performs the cleanup outside of
the recursive ccwchain_handle_ccw()/ccwchain_loop_tic() logic.

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
This is a pre-existing issue, but does this mutual recursion between
ccwchain_handle_ccw() and ccwchain_loop_tic() have a depth limit?

If a guest VM constructs a channel program with a long sequence of
transfer in channel commands that each jump to a distinct guest physical
address, tic_target_chain_exists() will return false.

This causes ccwchain_loop_tic() to recursively call ccwchain_handle_ccw():

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_loop_tic() {
        ...
        if (tic_target_chain_exists(tic, cp))
                continue;

        ret =3D ccwchain_handle_ccw(tic->cda, cp);
        ...
}

Since there doesn't appear to be a limit on the recursion depth here,
could this exhaust the host kernel stack?

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

[ ... ]

[Severity: High]
This is also a pre-existing issue, but is there a potential out-of-bounds
read in ccwchain_calc_length() due to an off-by-one error?

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
        ...
        do {
                cnt++;
                if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, c=
nt))
                        break;
                ccw++;
        } while (cnt < CCWCHAIN_LEN_MAX + 1);
        ...
}

Since cp->guest_cp is allocated with exactly CCWCHAIN_LEN_MAX elements,
if a guest provides a channel program where all 256 items have the
command-chaining flag enabled, the loop executes 256 times.

On the 257th iteration, cnt is 257 and ccw points to cp->guest_cp[256],
which is past the end of the allocation. The loop condition evaluates
to true (256 < 257), allowing ccw_is_chain(ccw) to dereference the
out-of-bounds pointer.

Could this read hit an unmapped guard page and crash the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723174751.1180=
334-1-farman@linux.ibm.com?part=3D1
