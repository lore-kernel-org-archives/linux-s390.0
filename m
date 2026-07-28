Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E676380FF3;
	Tue, 28 Jul 2026 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211386; cv=none; b=QXrhbsjsN2HHk9Vzik35g2VGPzWIaJajcKQHd8FpO+mBBoX/KGzo13FfefVhhroeE6GqVxVhaT6vwwH5nfckNP3euSpMnXzNfCcypja/oJphYS5/MbwNTndpfWqv5MeHXIiWlAijkC7xx7bmR7IQtKq5fjK93T1NtgnVTG+eR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211386; c=relaxed/simple;
	bh=H3GlkhC2Rh4qXS8tMrF60qc0VPY8lOy7mbDfLPxDJ9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I37kZ0+/lpMR73YdnHG9uXR4fAbsGWa0VsV789ixOhPV0JMi0bDBEp1oVoTpoBJzts5pPDbR1KVyq8Cj5uhlWU+yY5PmXYdoDPyJ4w2ZW2wxITdDpJ79zZy7gfDq0d0XoNOPunaQgk+sENC3P6htEs6sHOURjnFjzO/5op/SGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7rocucW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7rocucW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7E91F000E9;
	Tue, 28 Jul 2026 04:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211384;
	bh=hlfFBDbdcVpo3UpYNkO1zLi5WrTgIbVgzB1MenyuH9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7rocucWZITcjYYpKk5wp76RK9EiuGdKE1weTiv4USYl3I+quWGZqPImcrh2/xjGs
	 BD9uq84FA39OI2twMSL3kLXOY/sZvKKC7bxRQzZ3A5HP3JWg2RzHjT5SF097EHOTrm
	 IxZPQ/jQ/vpgkdXDf7AonlXMtZLcmmnSVJbKVKDdGwT0aWyR0JTz5vHVWZBLPPZHeE
	 Evj6gRTubFxDSg1AFg6Sykn2/IyPKgMtWv46TbBuskpjOYLmAm9swXneek8XuecVDX
	 e+ImOUYpZ33w0uF3WZZRV4gkUhADJY/GCZxgu1xlGkbjiD+WHtnEjgpkAywxSEMT0X
	 d+G8Y4FXTVSIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/10] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260728033022.2658232-2-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:03:04 +0000
Message-Id: <20260728040304.9C7E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded mutual recursion in `ccwchain_handle_ccw` and `ccwch=
ain_loop_tic` allows a malicious guest to trigger a host kernel stack overf=
low or kernel memory exhaustion via a long linear chain of TICs.
--

--- Patch [1]: [PATCH v9 01/10] s390/vfio_ccw: free all memory if cp_init()=
 fails ---
commit 0328e77fed7449f2970377374db30134792fce5b
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

The routine cp_free() cannot be used to free memory if cp_init() fails
before initialization completes. This patch moves cleanup outside the
recursive loop to properly free all segments created by a Transfer in
Channel (TIC) if an error occurs.

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
This is a pre-existing issue, but does this mutually recursive call chain
between ccwchain_handle_ccw() and ccwchain_loop_tic() allow a malicious
guest to trigger a host kernel stack overflow?

If a guest constructs a channel program with a long linear sequence of
Transfer In Channel (TIC) commands, each pointing to a distinct guest
physical address, the host processes it by recursively entering:

ccwchain_handle_ccw()
  ccwchain_loop_tic()
    ccwchain_handle_ccw()

Could this unbounded recursion exhaust the host kernel stack and cause a
denial of service?

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D1
