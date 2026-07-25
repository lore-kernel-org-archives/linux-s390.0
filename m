Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077330D40F
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939025; cv=none; b=sF+ClSb4wO5lOpFpaoyu1PTShYyHqThQzcpNpY9zcOt/41K5rvOXkVHEeYizkf8cgM+La70dg6wnOzD5Bf7TiE7GtfUiU+P2JCuv4EViMjMVzXU0Tj1YnYzyr9/H1nEuw921l2KB0cNu2LW+AqzbC1IedMowluj0pEYC1WuqYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939025; c=relaxed/simple;
	bh=WIi0pACbBoWS7I8Yo5vgRVNKExT9fDM9c+F8P2J8P1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QF1O3sa3TrN4/92bRs7debS151e6y/Y/mKbU8hBUnW+ZpnE0FGoib7FTJUu6FqevmvdVGsKNt787ooUIVaxfBS8daC7n4hiopLUJSSJuX03uAL1c4MRIWQ5gbIIAFW+MZ+MjEjDBmnC44HiO07Oo1DM756lig9ojAATnQ+3ej3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0c+Zyaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0c+Zyaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E7C1F00A3A;
	Sat, 25 Jul 2026 00:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939024;
	bh=HrtRbPGIe/IU3r5uppY7K6zNE4fyeV/FhGCVaPWtED4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0c+ZyajjagC/acHepsRg3rXI7FvDG9fsllVcAwtUmg4HTqTCiVZpj8rgyvR3mS+J
	 IPDp2KUYOukpVw4f8VdbTptG8e6CKIkP+YIfnhhTmlR5BUU2qYsxeK6xAMrONjWX4z
	 TWnej1oPChDc85RSbuMCgjIXv4Qhb0Q8D8KLuh6/2HdfO9U757NDZYZhK+NrATrkau
	 kgNj3gJkesIjJJJ2STve+RYv6aCqNpJuOndGps3A5Md/wHj2lWPtxwSilYDxSY65wS
	 WyOGN/G+0bGJuzA/PE17arROUBpmovVpxXEwT9ORJaJ/pOadVva1BxkfCWGUt3D3HH
	 MLLoH4L269U7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/3] net/smc: bound the send length to the send
 buffer in smc_tx_sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723-b4-disp-0d07164f-v5-3-6a9e235dbc4e@proton.me>
References: <20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e@proton.me>
 <20260723-b4-disp-0d07164f-v5-3-6a9e235dbc4e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:23:43 +0000
Message-Id: <20260725002344.40E7C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `memcpy_from_msg` fails during the second chunk of a wrapped co=
py, `smc_tx_sendmsg` returns a positive `send_done` to user space indicatin=
g partial success, but fails to advance the transmit cursors for the succes=
sfully copied first chunk, causing silent data loss.
--

--- Patch [3]: [PATCH net v5 3/3] net/smc: bound the send length to the sen=
d buffer in smc_tx_sendmsg() ---
commit 278a0035d635d6fbcc8028cbd039373266061251
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the send length to the send buffer in smc_tx_sendmsg()

This commit bounds the write space to the send buffer length at the consumer
in the SMC-D DMB-merge path. This prevents a forged cursor from inflating
sndbuf_space past the send buffer or overflowing the signed accumulator to a
negative value.

> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 3144b4b1fe290..5916f02060fb9 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -233,6 +233,19 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msgh=
dr *msg, size_t len)
>  		/* initialize variables for 1st iteration of subsequent loop */
>  		/* could be just 1 byte, even after smc_tx_wait above */
>  		writespace =3D atomic_read(&conn->sndbuf_space);
> +		/* sndbuf_space is advanced from the peer's wire-controlled
> +		 * consumer cursor on the SMC-D DMB-merge path; a forged cursor
> +		 * can inflate it past the send buffer, or overflow the signed
> +		 * accumulator to a negative value across many CDC messages
> +		 * (which a plain "> len" check would miss before the size_t
> +		 * cast below turns it huge).  Bound it to the send buffer in
> +		 * either case so the wrap-around write cannot run past
> +		 * sndbuf_desc->len.  This enforces the documented
> +		 * 0 <=3D sndbuf_space <=3D sndbuf_desc->len invariant at the
> +		 * producer, race-free against the CDC tasklet.
> +		 */
> +		if (writespace < 0 || writespace > conn->sndbuf_desc->len)
> +			writespace =3D conn->sndbuf_desc->len;
>  		/* not more than what user space asked for */
>  		copylen =3D min_t(size_t, send_remaining, writespace);
>  		/* determine start of sndbuf */

[Severity: High]
This is a pre-existing issue, but if memcpy_from_msg() fails during the
second chunk of a wrapped copy, can this return a positive send_done to
user space while skipping the cursor updates for the first chunk?

Looking further down in smc_tx_sendmsg(), the copy is done in two chunks:

		for (chunk =3D 0; chunk < 2; chunk++) {
			rc =3D memcpy_from_msg(sndbuf_base + chunk_off,
					     msg, chunk_len);
			if (rc) {
				smc_sndbuf_sync_sg_for_device(conn);
				if (send_done)
					return send_done;
				goto out_err;
			}
			send_done +=3D chunk_len;
			...

If the first chunk (chunk =3D=3D 0) succeeds, send_done is incremented.
If the second chunk (chunk =3D=3D 1) fails, it hits the if (rc) block and
returns send_done early.

Because it returns early, it skips the cursor and space updates that
normally happen after the loop:

		smc_curs_add(conn->sndbuf_desc->len, &prep, copylen);
		...
		atomic_sub(copylen, &conn->sndbuf_space);

Will this cause the successfully copied first chunk to be overwritten on
the next send operation, leading to silent data loss since user space
believes those bytes were successfully sent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-disp-0d=
07164f-v5-0-6a9e235dbc4e@proton.me?part=3D3
