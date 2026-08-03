Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364B34A79D;
	Mon,  3 Aug 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774509; cv=none; b=mikHxiXtDILgVIwtcIFnGBVSZAX+8uMdGHXcl8arjkHY+/JQnz3McnZ+SV7cTnVBFrWhHD7Nhb9myhYZmF0pLrUWRVj419Tts0uU0S2ZYrpwHovVwy02ZkDYnqxSm2QJLrSoErYO62rJFxAAlkesTXlWYVrdJZAUp+PvYlWaX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774509; c=relaxed/simple;
	bh=ZEXUmAfjknJqnNcHm3ua3v8AIseudkrKS4YlFiHUZ0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KcKiJaukpPrATprzf0FzvAuKwZHzO/O7RqIGnb6RXaMcZ7+BWisuJLhsuyvnL5/8m1K6N/cs8/FZ6Qcvs2PkrinBV0CbGg665h2KN7dMoN/S0JFfVGJ531CBzz2QsflwYXRs690B5xDK8APVCKeNq9QqPqP9ILgJhCnbUO3vdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3K3oNfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3K3oNfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719B81F000E9;
	Mon,  3 Aug 2026 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774507;
	bh=YS4ysVsSyyhrGCz1ANTN9ok+nZ05pXsSgfc5L4CiTk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3K3oNfDkaY06J/LaNu2iP/wtoQYGbsmsfEYGp2a2x975sQlgOQBM/aZygutftt5i
	 R1IuGsUt9OO5nK3bHFvYuM1mwYWPE9P2r07pOXL7MK+ptNeD++4XYEBQXCGMrEDcAj
	 M0XAj8EtoCWTGRJi4O8yKmkpkHcXtGV+T2gmb1EJJxERMpDXk0vAcV7kO1CosZp7RW
	 pFo0rloje03fd6FQdKNFrW7H/V25LhsJFjLOT8uchv8iVr3zKTOonFQu+mGc8Ztsga
	 4AqpSKLNYg0JyFTJ5j8pPk5WZEPMHab5/RuGzDdzDZgm8UGlj5iwME+kHKM4cE04BX
	 xJHgOvWtpczCQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 01/23] s390/vfio_ccw: Free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803160924.236807-2-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:28:26 +0000
Message-Id: <20260803162827.719B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious guest can trigger unbounded kernel stack recursion and=
 host panic by providing a long chain of non-looping Transfer in Channel (T=
IC) CCWs.
--

--- Patch [1]: [GIT PULL v1 01/23] s390/vfio_ccw: Free all memory if cp_ini=
t() fails ---
commit 2ed68383152f2b2060167f3fc63cdb973d979950
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Free all memory if cp_init() fails

This commit moves the ccwchain cleanup out of the recursive
ccwchain_handle_ccw() and ccwchain_loop_tic() logic into a new wrapper
function ccwchain_build_ccws(). This ensures that all segments allocated for
a channel program are freed if initialization fails.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 7561aa7d3e017..086d1b54bdb05 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
[ ... ]
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct ch=
annel_program *cp)
>  	/* Loop for tics on this new chain. */
>  	ret =3D ccwchain_loop_tic(chain, cp);
> =20

[Severity: High]
This is a pre-existing issue, but can this recursive call chain lead to
unbounded kernel stack consumption?

Looking at ccwchain_handle_ccw() and ccwchain_loop_tic(), they recursively
call each other:

ccwchain_handle_ccw()
   ccwchain_loop_tic()
      ccwchain_handle_ccw()

If a guest constructs a channel program with a long sequence of Transfer
in Channel (TIC) CCWs, where each points to a distinct guest physical
address, tic_target_chain_exists() will return false.

Does this allow an unprivileged guest to trigger unbounded recursion and
overflow the host kernel stack, resulting in a host panic?

> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D1
