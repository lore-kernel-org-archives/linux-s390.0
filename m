Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6043BFE2D
	for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511823; cv=none; b=dP4Ztx4R5FOKcs2XnEpHXTqgnnJIcH1DXkqe+SXYF0t9asv5Gb5g9lSiKGFmDxrp+X+OAmMgAGm/h3yJQBsh7XLF4PQJdiV79lSQnh6V+2oUSBgpWpyyzHpOWQGMdbHhct/SLCa5kTf9DBEpR5CQeU22oLcAfZl5pdfrfnBnltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511823; c=relaxed/simple;
	bh=jNTG2XUtfKQMJ20/U5Q/HHa+ch4PjKqGprKSQ1ScWLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ojiamapaGewYdF1RRzABcgcihWJWgdzrWq+MwXkwCDsmRU2V82eqT1a048lOzZ6rtqKKm+Jtn5nop35g3PhB9sGEOL3Z5woe5aRAnRcRsJ46UVFJQLUtgPuSoAsSDqQI7DR5wqLuW7p99jvG1tE0a4Y3whC1LqLIRUXpOBHWMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e95Y9R9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e95Y9R9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08081F00A3A;
	Mon, 15 Jun 2026 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781511822;
	bh=oj7aSwOKzL8/K35h/9Q6Dte/4qK0ha7mVm6Haorj0eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e95Y9R9elR3LgA0vUlm+pVtz4U59mUnLzUm8NCB+TTOJuqXHALrL6oJFVSqjs5cLd
	 O2q6VdhcBdefNYE70Ct/XbMyC3Hm/mE9Bq2kdAn7EBZ/Tae4bHQNzdDcHUUCm7Wxvm
	 ilK7sBgpguoQ6QArm4aj9Exq51lpNNodmE77IyhfUHqZsNCeCZoBn3FzvGULEnelkE
	 /FQj0ThMhECpXR7eq2zoVbF1Ov8h3FbO5qqmKYmXwOJrGWxrmhHuyBQdLmn83rqYun
	 GeOzSXsE+qheaI8Y8V50pn1YkjNbzEAD9CIbaeLMnBFhPinWJxaONe8YS8Tcop/cX1
	 rDJVVjSOHeRVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] net/smc: bound the receive length to the RMB in
 smc_rx_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me>
References: <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:23:41 +0000
Message-Id: <20260615082341.D08081F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Clamping a negative `bytes_to_rcv` to a positive length causes per=
sistent phantom data delivery and infinite loops.

Pre-existing issues:
- [Critical] Unbounded `peeked_bytes` accumulation bypasses cursor wrap log=
ic, leading to massive out-of-bounds read and kernel memory disclosure.
--

commit 7335ccb72e218a6f34e62494f13d66e4b8827bb3
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the receive length to the RMB in smc_rx_recvmsg()

The patch clamps the readable bytes calculation in smc_rx_recvmsg() to the =
RMB
length. This aims to prevent out-of-bounds reads if a forged producer cursor
drives bytes_to_rcv past the RMB size or into negative values.

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index c1d9b923938da..f461cf10b0855 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
> @@ -442,6 +442,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msgh=
dr *msg,
>  		/* initialize variables for 1st iteration of subsequent loop */
>  		/* could be just 1 byte, even after waiting on data above */
>  		readable =3D smc_rx_data_available(conn, peeked_bytes);
> +		/* bytes_to_rcv is accumulated from the peer's wire-controlled
> +		 * producer cursor; a forged cursor can drive it past the RMB,
> +		 * or overflow the signed accumulator to a negative value across
> +		 * many CDC messages (which a plain "> len" check would miss
> +		 * before the size_t cast below turns it huge).  Bound it to the
> +		 * RMB in either case so the wrap-around copy cannot run past
> +		 * rmb_desc->len.  This enforces the documented
> +		 * 0 <=3D bytes_to_rcv <=3D rmb_desc->len invariant at the consumer,
> +		 * race-free against the producer update in the receive tasklet.
> +		 */
> +		if (readable < 0 || readable > conn->rmb_desc->len)
> +			readable =3D conn->rmb_desc->len;

[Severity: Critical]
This isn't a bug introduced by this patch, but does unbounded peeked_bytes
accumulation bypass the cursor wrap logic?

If bytes_to_rcv is negative, subtracting peeked_bytes in smc_rx_data_availa=
ble()
guarantees readable is negative. Clamping this negative value to a positive
buffer length (conn->rmb_desc->len) allows the loop to iterate indefinitely,
growing peeked_bytes unboundedly.

When peeked_bytes exceeds 2 * conn->rmb_desc->len, is it correctly wrapped
when applied to the cursor?

net/smc/smc_cdc.h:smc_curs_add() {
    curs->count +=3D value;
    if (curs->count >=3D size) {
        curs->wrap++;
        curs->count -=3D size;
    }
}

Since smc_curs_add() only subtracts size once, cons.count will remain >=3D =
size
if value is massive.

This out-of-bounds cursor would then cause an underflow in the chunk length
calculation:

net/smc/smc_rx.c:smc_rx_recvmsg() {
        ...
		/* determine chunks where to read from rcvbuf */
		/* either unwrapped case, or 1st chunk of wrapped case */
		chunk_len =3D min_t(size_t, copylen, conn->rmb_desc->len -
				  cons.count);
        ...
}

Could this underflow result in a massive chunk_len and a subsequent
out-of-bounds kernel memory read?

[Severity: High]
Will clamping a negative bytes_to_rcv to a positive length cause an infinite
stream of phantom data?

If readable is clamped to a positive value when bytes_to_rcv is negative, t=
he
function will authorize the phantom read and copy rmb_desc->len bytes of
stale data.

At the end of the loop:

net/smc/smc_rx.c:smc_rx_recvmsg() {
        ...
		/* update cursors */
		if (!(flags & MSG_PEEK)) {
			/* increased in recv tasklet smc_cdc_msg_rcv() */
			smp_mb__before_atomic();
			atomic_sub(copylen, &conn->bytes_to_rcv);
        ...
}

When atomic_sub() executes, subtracting copylen from the already negative
bytes_to_rcv makes it even more negative.

Since bytes_to_rcv is never zeroed or corrected, will the next recvmsg()
call see a negative value, clamp it to rmb_desc->len again, and deliver ano=
ther
chunk of phantom data indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-disp-ed=
d64be9-v3-0-551fa514257e@proton.me?part=3D2
