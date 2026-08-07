Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8E233943
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090623; cv=none; b=VsDvlUby2cvOIG/XbWyuh3srsagHi7ymSf8We7QcvTHkQjfDwN5vumGm1oBDy3Sqg+LSvD8yK5O3kOWS6SM8xPDnQBkZpvlPtYcinzVptHw3zp5eJgOq/CKq93LHaKkfMW9AlMHnqm76NgWBGUJYt/T/lKErxksbqbi9aKbrcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090623; c=relaxed/simple;
	bh=mVkRYgjgjNtNfvTPbSzfmnffvd7ct5AB6ZcED2G1s9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bo7cGagYjLvSm8wFsqakpAvTNJ3nudaLRVnKwJAInt4yVXifLKqtBICg3OOLD5vW4fGA1VDAsF1+TyF5P4SubqXJEkZbgHTbrtX1pxvEnrALStNgaa/NwVmv5YGzODQT4QTt+FUuZP1O6MiifKxjofdNz/3NLUWfzggiFW8IdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JItFrPOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JItFrPOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBB61F000E9;
	Fri,  7 Aug 2026 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786090620;
	bh=6P5Ul0fOnwijiqB2xF+gW1IMXp8wDWIJSgxrQkuxnBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JItFrPOwUks29EMbyXHBKlRb268wgrQQrk9QiGK/630Wqs4TxUfOx64FnHzZYmk0r
	 dM/MnxHNnI9AX2p/sonzdEJ+GXEkrJpEiGL/DWc6wzGqQb+g7/v2B+uL08zEL/uAmn
	 CAOOfarmjv7gZPp2Dys07HmXnU8aNOIWFPBk1DacwPKZqISwKPEhWTCMEozaEBabmI
	 7tn2A2SpZo9VbwemxP46OeBfRItD9w5YdJbCjE7up2JWHAiPlREXAetiUkKWHIzAv0
	 BN+elYzIP2L6xJOwSupTEL6qi90FuQS0HV2gtrD6uSOgpMnJ4EHlachjmE9Grv7D3M
	 GB1NC8W2pj6Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: drop the abort_work reference when the
 work is cancelled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806081549.595001-1-hidayath@linux.ibm.com>
References: <20260806081549.595001-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:16:58 +0000
Message-Id: <20260807081700.7FBB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AB-BA deadlock between `smc_conn_free()` and `smc_conn_abort_work(=
)` caused by calling `cancel_work_sync()` while holding the socket lock.
--

--- Patch [1]: [PATCH net] net/smc: drop the abort_work reference when the =
work is cancelled ---
commit 1b6cdab59cd811b97297f9b5597cac1aa3e420d9
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: drop the abort_work reference when the work is cancelled

This commit fixes a socket reference leak that occurs when an abort_work
item is cancelled before it runs. It drops the socket reference if
cancel_work_sync() returns true, ensuring the socket can be properly
destroyed.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index b4208cb186c5e..3d4a86d99dd6b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
[ ... ]
> @@ -1275,8 +1276,13 @@ void smc_conn_free(struct smc_connection *conn)
>  		tasklet_kill(&conn->rx_tsklet);
>  	} else {
>  		smc_cdc_wait_pend_tx_wr(conn);
> -		if (current_work() !=3D &conn->abort_work)
> -			cancel_work_sync(&conn->abort_work);
> +		/* If the work was pending (cancel returns true) it never ran,
> +		 * so the sock_hold taken by its scheduler was never released.
> +		 */
> +		if (current_work() !=3D &conn->abort_work) {
> +			if (cancel_work_sync(&conn->abort_work))
> +				sock_put(&smc->sk);

[Severity: High]
This isn't a bug introduced by this patch, but can calling cancel_work_sync=
()
here cause an AB-BA deadlock with the workqueue thread?

If a thread initiates a socket close, such as via smc_release() or
smc_close_passive_work(), it acquires the socket lock:

smc_release()
  lock_sock(&smc->sk);
  ...
  smc_conn_free()
    cancel_work_sync(&conn->abort_work);

If a remote peer concurrently sends an out-of-order CDC message, abort_work
is queued. The workqueue thread starts executing smc_conn_abort_work() and
attempts to acquire the same socket lock:

smc_conn_abort_work()
  lock_sock(&smc->sk);
  smc_conn_kill(conn, true);
  release_sock(&smc->sk);

Could this result in the workqueue thread blocking on the socket lock, while
the socket release thread blocks indefinitely in cancel_work_sync() waiting
for the workqueue thread to finish?

> +		}
>  	}
>  	if (!list_empty(&lgr->list)) {
>  		smc_buf_unuse(conn, lgr); /* allow buffer reuse */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806081549.5950=
01-1-hidayath@linux.ibm.com?part=3D1
