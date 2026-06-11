Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B83A59A2
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168999; cv=none; b=a3NWRK3hOYWJq+67zKs9HGFa5IG8b69//AouMsCOgRsQtnHxBJpIjEOQUdT/G9ZfcuF+rxuZq1Vi8HmQDTjc+P+Nz1y3phMJSqzB3jIXfv+Kd1qE028voxcvIrIwo9G5+/uJhSzFyIhvN2qWga2xZvGTwdYHIiqPFCr/qpMCPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168999; c=relaxed/simple;
	bh=0mkx84Y1h/e2jic0+i1OM5gEVBwnV4gJTfvNFhXrOTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cauCQWMtczWhmNFIeGSq/62WizZu8PHuD0IlUHusRXrSG5TZ2kxCPaQQ/hOwCvx2hk+BmGAtuMbwmnopaaCkzR3ya1Z71FwmZDPShKRyi4gMJhBc+1O7rvAzxZ2OT7fx8r2jE87rvBfJ3f+u3GH4ZDy+cIC3/4sUeAX5/HU1+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UybSJIpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UybSJIpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F31F00893;
	Thu, 11 Jun 2026 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781168998;
	bh=CuS/c+gDWvnJa49bDW7B3nPFNhrKVwtRd9FnDXdjqjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UybSJIpclejxT1BKMf/IusojbL9vINFBfVpdUrqAfTqFy7xP8Y10O/8jc33KggYsK
	 AZ72wVwR/T33hNC8f0sZNNzSxDVJndrbfqkcJAGR7ebrxAQuJEKNLCyYmYfgaJPBTp
	 QmnVZD43xgIiIDnUYht8A9WoJz2ddauR1GEQiqFM4zv4e89P6Jlshy1UgfzTQ0lPiY
	 sqYtwa337fi2bdZSn6fqQ260tC1SR+zRaVmNlzwvS0b3a0F4BJSdUrdlhMwukEHOaX
	 2R2pplYC9/fXMWG4l9xpMLiSYAty1ufm+DZw7w/PMk1qvyPM2f4opBUTnDxNDiyFCZ
	 Yp9ttx2QCLlVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net/smc: bound sndbuf_space on the SMC-D DMB-merge
 receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260610090928.192177-1-hexlabsecurity@proton.me>
References: <20260610090928.192177-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 09:09:57 +0000
Message-Id: <20260611090958.2F1F31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] TOCTOU race condition in `sndbuf_space` clamp allows heap out-of-b=
ounds write

Pre-existing issues:
- [Critical] Unchecked `bytes_to_rcv` inflation leading to heap out-of-boun=
ds read
- [Critical] Signed integer overflow bypasses the `sndbuf_space` clamp check
--

commit e92859ab3e83950d546c2c14959ddfecc322ce3e
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound sndbuf_space on the SMC-D DMB-merge receive path

This commit modifies the receive path to clamp sndbuf_space after calculati=
ng
the cursor difference. It uses an atomic_add followed by a conditional
atomic_set to enforce the bounds. The intent is to prevent sndbuf_space from
exceeding the send buffer length.

> Enforce the documented invariant after the cursor-driven atomic_add(), as
> the SMC-D receive path already does for bytes_to_rcv.

[Severity: Critical]
This is a pre-existing issue, but does the receive path actually enforce
invariants for bytes_to_rcv as claimed here?

In smc_cdc_msg_recv_action(), diff_prod is calculated from an unvalidated
peer cursor and atomically added to conn->bytes_to_rcv without any clamping:

net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
    ...
    atomic_add(diff_prod, &conn->bytes_to_rcv);
    /* guarantee 0 <=3D bytes_to_rcv <=3D rmb_desc->len */
    smp_mb__after_atomic();
    ...
}

If the cdc->prod cursor causes an inflated bytes_to_rcv value, and
smc_rx_recvmsg() reads this value:

net/smc/smc_rx.c:smc_rx_recvmsg() {
    ...
    copylen =3D min_t(size_t, read_remaining, readable);
    ...
}

Could the length of the second chunk exceed the buffer size, causing
memcpy_to_msg() or splice_to_pipe() to read memory out of bounds?

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 619b3bab38248..cf8d65407ea5d 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -365,6 +365,10 @@ static void smc_cdc_msg_recv_action(struct smc_sock =
*smc,
>  			smp_mb__before_atomic();
>  			atomic_add(diff_tx, &conn->sndbuf_space);
>  			/* guarantee 0 <=3D sndbuf_space <=3D sndbuf_desc->len */
> +			if (atomic_read(&conn->sndbuf_space) >
> +			    conn->sndbuf_desc->len)
> +				atomic_set(&conn->sndbuf_space,
> +					   conn->sndbuf_desc->len);

[Severity: High]
Can this non-atomic clamping sequence create a race condition?

If smc_tx_sendmsg() runs concurrently in process context, could it lockless=
ly
read the temporarily inflated sndbuf_space between the atomic_add() and
atomic_set() calls?

net/smc/smc_tx.c:smc_tx_sendmsg() {
    ...
    writespace =3D atomic_read(&conn->sndbuf_space);
    ...
}

Using this transiently inflated value, could the second loop iteration in
smc_tx_sendmsg() write memory out of bounds past the send buffer?

[Severity: Critical]
This is a pre-existing issue, but does this signed comparison fail to catch
negative wrapped values caused by signed integer overflow?

If a forged cursor causes smc_curs_diff() to return a very large value,
and this is added via atomic_add(), the 32-bit signed integer could overflow
into a negative value. The check would then compare this negative value
against the positive sndbuf_desc->len, evaluate to false, and bypass the
clamp entirely.

In smc_tx_sendmsg(), if this negative writespace is cast to size_t:

net/smc/smc_tx.c:smc_tx_sendmsg() {
    ...
    copylen =3D min_t(size_t, send_remaining, writespace);
    ...
}

Would this result in an unexpectedly large unsigned value, causing the
second loop iteration to write memory out of bounds?

>  			smp_mb__after_atomic();
>  			smc_curs_copy(&conn->tx_curs_fin,
>  				      &conn->local_rx_ctrl.cons, conn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610090928.1921=
77-1-hexlabsecurity@proton.me?part=3D1
