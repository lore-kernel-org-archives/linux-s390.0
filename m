Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287C489873
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391029; cv=none; b=KgyT6olT+9t2gtnsHAJ2j+RRrCySGG59i3whopF8tV/Nh5tewK6t184+8h1Ys0kIGLUhMyqXdOxvp5CY4SGxUxMLl7jGTH+QL1sKjxlqO7RDIljTcEKVDSfy+j4nWgS/wejjbuDAmo9WnWdV/ge3nDRHO1mq23/r/FCJ35HEgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391029; c=relaxed/simple;
	bh=2pLoukYahHb7S8TYUggI5uaqxMqr5qTBtTS3rmyESvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LstaBr/U677m9hQ8ZyPWyfkpJbPwp5GQgpatDLLJxeuA/p2ZEEutd9hQdph09HuupqSRgJiVLYg6Fx6R57o2ztcJ0WhBWm0e8MnayWzp8gwJZ/M84+7VfI2AOUfHrpkfVaRYRkJ0cvzH1fHd9vA1lP35tAJ07Xw3qxhnCIyp9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFkhIvg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFkhIvg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6631F000E9;
	Thu, 30 Jul 2026 05:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785391027;
	bh=L1tziJydEOpW4204JZuQx79ZMV6H7mtb0ZD4AVJb7EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFkhIvg54w5ZOdc8C9EUJaK44YlFE1LH1twFXHvjN0aSJ3NK8R0P/kLc599m8UymS
	 5DlIQCDYFpg1qOSw12xrU2ayvJcDgKSU26Nat51Q6KjspGU/VejtvuF3v4J2euRqHJ
	 63pw+AnH1Qa3menVAXMcwDu2Cs4EdcLv2H6v0b4t7xgOjTxsFWeB03G1+JU05I+/Eb
	 FkbMkwE89ws5H0gb90N90EKMKs0p0Fs5ykVtqjl0NuVQJ52iAxy3F7chiptJHCwU9U
	 6mr7AgMGwQBuH+JOBoMlSNH9ugrNWRnD6sG3V5o1zEpUtw0CxrW3DwCqu3HwTcSFfb
	 kaeocsoBCx9Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] s390/crypto: Replace cond_resched() with
 msleep(1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730052907.2607026-2-hca@linux.ibm.com>
References: <20260730052907.2607026-1-hca@linux.ibm.com>
 <20260730052907.2607026-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:57:07 +0000
Message-Id: <20260730055707.8D6631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free / Incorrect Backlog Handling due to improper `-EBUS=
Y` check
- [High] Double completion of crypto requests on error paths leading to Use=
-After-Free
- [Medium] Unreachable error handling logic for `-EKEYEXPIRED` in `phmac_do=
_one_request`
--

--- Patch [1]: [PATCH v3 1/4] s390/crypto: Replace cond_resched() with msle=
ep(1) ---
commit b1e4ce79023817dc16f19a077b044e708fcff721
Author: Heiko Carstens <hca@linux.ibm.com>

s390/crypto: Replace cond_resched() with msleep(1)

This patch replaces cond_resched calls in the s390 crypto code with msleep(=
1).
This ensures that the current task is scheduled away as originally intended,
since cond_resched is compiled away to a no-op under newer scheduling
preemption modes.

Link: commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 8cfe6166c193c..511cb6105436f 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c

[Severity: High]
This is a pre-existing issue, but does the crypto request entry function
ecb_paes_crypt() properly handle backlogged requests?

When a caller submits a request with CRYPTO_TFM_REQ_MAY_BACKLOG and the
crypto engine queue is full, crypto_enqueue_request() successfully enqueues
the request to the backlog and returns -EBUSY.

However, ecb_paes_crypt() appears to treat -EBUSY as an error because it
only checks for rc !=3D -EINPROGRESS:

ecb_paes_crypt() {
    rc =3D crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, r=
eq);
    if (rc !=3D -EINPROGRESS)
        atomic_dec(&ctx->via_engine_ctr);
    ...
    if (rc !=3D -EINPROGRESS)
        skcipher_walk_done(walk, rc);
}

This prematurely tears down the request state while the request remains
queued in the engine. When the engine eventually processes this request,
could it execute with freed or zeroed structures and corrupt memory?

> @@ -555,7 +555,7 @@ static int ecb_paes_do_one_request(struct crypto_engi=
ne *engine, void *areq)
>  		 * To avoid immediately re-invocation of this callback,
>  		 * tell the scheduler to voluntarily give up the CPU here.
>  		 */
> -		cond_resched();
> +		msleep(1);
>  		pr_debug("rescheduling request\n");
>  		return -ENOSPC;
>  	} else if (rc) {

[Severity: High]
This is a pre-existing issue, but does ecb_paes_do_one_request() accidental=
ly
trigger a double completion on error paths?

If ecb_paes_do_crypt() fails and returns a negative error code like -EINVAL,
the code falls through and calls crypto_finalize_skcipher_request(), which
completes the request.

ecb_paes_do_one_request() then returns that same negative error code back to
crypto_pump_requests() in the crypto engine. When crypto_pump_requests() se=
es
a negative return code that is not -ENOSPC, it branches to its error path
and calls crypto_request_complete() a second time on the exact same request.

Could this lead to a use-after-free if the user completion callback
already freed the request context during the first invocation?

[ ... ]

> diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
> index 03ca33ffe6ccf..da76c7beb1847 100644
> --- a/arch/s390/crypto/phmac_s390.c
> +++ b/arch/s390/crypto/phmac_s390.c

[Severity: High]
This is a pre-existing issue, but does phmac_update() share the same
backlog handling regression as ecb_paes_crypt()?

It also checks only for rc !=3D -EINPROGRESS and wrongly cleans up the
request via hwh_advance() on -EBUSY, even though the request was successful=
ly
enqueued to the backlog.

> @@ -895,7 +895,7 @@ static int phmac_do_one_request(struct crypto_engine =
*engine, void *areq)
>  			 * tell scheduler to voluntarily give up the CPU here.
>  			 */
>  			pr_debug("rescheduling request\n");
> -			cond_resched();
> +			msleep(1);

[Severity: Medium]
This is a pre-existing issue, but is this error handling block for
-EKEYEXPIRED ever actually reachable?

When phmac_kmac_update() and phmac_kmac_final() are called with maysleep
set to true, they do not seem to proactively check tfm_ctx->pk_state to
return -EKEYEXPIRED.

Instead, if the key is expired, they synchronously call phmac_convert_key()
and retry the operation.

Because they handle conversions synchronously in this path, they never
return -EKEYEXPIRED, which would make this entire error handling block
dead code. Is there another path where -EKEYEXPIRED could be returned
here?

>  			return -ENOSPC;
>  		} else if (rc) {
>  			hwh_advance(hwh, rc);

[Severity: High]
This is a pre-existing issue, but just like ecb_paes_do_one_request(), does
this hash error path also cause a double completion?

If rc is a negative error code like -EINVAL, crypto_finalize_hash_request()
is called in phmac_do_one_request(), and then crypto_request_complete()
is called again in the crypto engine error path.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730052907.2607=
026-1-hca@linux.ibm.com?part=3D1
