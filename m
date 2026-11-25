Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629794;
	b=dTG3scSTW9+8xGgFhZRAoZNEu0tuwQyexNpANLmjaOAPNzkB7o1W+RRNserhitHC9FaI
	 J8R1b3bn6O0uDNOFSoSwkoWeQ0Kxd670leq0lcpcJC3lD4z4CjDJfv0KfN3H61Urftrh3
	 wIJfPi5d8OnC+AuHHIvxmGXNjxuoQ90hk3tTz2ulP1IcZBRF5cc2FRtRuK1SGFOIWZTFm
	 MgDwioRib3GYNgJ57uulo43m5SSbXGGnVzjyfrPLEUDuf/fPd+5Wm0xYV+lV7HHcByLw1
	 pO3Lx0VdwbmhlYlbcr32OtCYqlZK9FxbIoCuWOBo3Ckg0ouZM0QRWVjJLhiMNZBByFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1GU2PBrjyppiRE0ZxMrZDSbgl/5EnFV4Q0YV+IpsZeg=;
	b=Ql1wub3X4yrEfxWpf9Gr+Jm06ydAJtEe22mBp8v4YFPGJdVoEXa/N+2eW+8HOFYWNWCe
	 OB9tFng5M5tO3PoLocF2e1uIFAtEsqmpbp0escdK0+5Ae4TJg4J1Pyw0ARtKGEO6vZ6GO
	 OiK1Cp6ui9WuUS8+oIHeOv+yW/Tmu7KOUlVMNenx4+bxSmfjsJaratKORpRfSifMN64We
	 tJx7eQwAxAtoV+A/HimExZECirokCRg6dWk7sEeEE8f24yJENUQmj6d0Fopqr2y8fF7dR
	 zQNmuyOqyAqeEo3WC2fSiB+2paWr0c/d+Od1a5DqJtvF2GHebQi4igwZsSoLo1t6duA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sm7jPhHX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E3606A31E
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sm7jPhHX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA7E1F000C4;
	Wed, 25 Nov 2026 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629794;
	bh=1GU2PBrjyppiRE0ZxMrZDSbgl/5EnFV4Q0YV+IpsZeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sm7jPhHXAsjgrlrBhSQ4fzPWVBaKJJNKvL2jckppW2nlhJk/hf/OjFpYzATNX8mGU
	 Ng2bLxttS2rDnxZOvgw9F/YFFKs4NU3XmjLpUYDOj/hWw4mU2hVB2ID0yu87QI+Fv1
	 gAcTKQKRXMlpM4zsQ7kn764aRamV4n0t1Bgc6yGzsAKiFTrbOBuJFqW+Oa7lRDbC+l
	 vwwmyaE1nDZzdfLRg6jazsiWPUTkLqjL5hciuwluMoSTuV+aA7oBynt4xlLlz/lE6S
	 jYl41JnOy2VZWmgbnCK/AEToEnhAOpDzEX1Pi6nvps+nKDIstEzTC/a3CrzMrU2b3p
	 +KIkoczzIgu0w==
Message-ID: <sashiko-outbox-233892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/smc: bound the DMB-nocopy send-buffer credit
 by what was sent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piyus Kedia" <piyus@iiitd.ac.in>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261124180257.622064-1-piyus@iiitd.ac.in>
References: <20261124180257.622064-1-piyus@iiitd.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:03:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net/smc: torn cursor read and non-atomic update in
  smc_cdc_msg_recv_action()
--

commit 133d80c5be599b5dfed59704241a6f51344fbb12
Author: Piyus Kedia <piyus@iiitd.ac.in>

net/smc: bound the DMB-nocopy send-buffer credit by what was sent

This commit bounds the send-buffer credit on the SMC-D DMB-nocopy receive
path by the unconfirmed sent bytes between tx_curs_fin and tx_curs_sent,
and advances tx_curs_fin by the bounded difference with smc_curs_add().

Link: https://lore.kernel.org/all/179552966151.3135.8162716126718648323@ker=
nel.org/

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..ecac93023d327 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -333,6 +333,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *=
smc,
>  	union smc_host_cursor cons_old, prod_old;
>  	struct smc_connection *conn =3D &smc->conn;
>  	int diff_cons, diff_prod, diff_tx;
> +	int unconfirmed;
> =20
>  	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
>  	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
> @@ -361,13 +362,34 @@ static void smc_cdc_msg_recv_action(struct smc_sock=
 *smc,
>  			diff_tx =3D smc_curs_diff(conn->sndbuf_desc->len,
>  						&conn->tx_curs_fin,
>  						&conn->local_rx_ctrl.cons);
> +			/* This difference comes from the cursor the peer
> +			 * reported, which is taken as it arrives.  The peer
> +			 * can only have consumed what this side actually
> +			 * sent - smc_tx_rdma_writes() advances tx_curs_sent
> +			 * together with the producer cursor the peer sees -
> +			 * so bound it by that and advance tx_curs_fin by the
> +			 * bounded amount rather than assigning the reported
> +			 * cursor.  The invariant below then holds by
> +			 * construction, tx_curs_fin stays inside the send
> +			 * buffer, and it stays at or behind tx_curs_sent:
> +			 * bounding by sndbuf_desc->len - sndbuf_space would
> +			 * also admit bytes that are only PREPARED, which
> +			 * would move tx_curs_fin past tx_curs_sent and break
> +			 * the fin <=3D sent <=3D prep order the three cursors are
> +			 * documented with.
> +			 */
> +			unconfirmed =3D smc_curs_diff(conn->sndbuf_desc->len,
> +						    &conn->tx_curs_fin,
> +						    &conn->tx_curs_sent);
> +			diff_tx =3D min_t(int, diff_tx, unconfirmed);
> +
>  			/* increase local sndbuf space and fin_curs */
>  			smp_mb__before_atomic();
>  			atomic_add(diff_tx, &conn->sndbuf_space);
>  			/* guarantee 0 <=3D sndbuf_space <=3D sndbuf_desc->len */
>  			smp_mb__after_atomic();
> -			smc_curs_copy(&conn->tx_curs_fin,
> -				      &conn->local_rx_ctrl.cons, conn);
> +			smc_curs_add(conn->sndbuf_desc->len,
> +				     &conn->tx_curs_fin, diff_tx);
> =20
>  			smc_tx_sndbuf_nonfull(smc);
>  		}

[Severity: Medium]
Can passing &conn->tx_curs_sent directly to smc_curs_diff() tear across its
wrap and count fields while smc_tx_rdma_writes() updates conn->tx_curs_sent?

smc_cdc_msg_recv() runs in tasklet context under bh_lock_sock(&smc->sk)
without conn->send_lock, while process-context smc_tx_sendmsg() or
smc_tx_work() holds lock_sock(&smc->sk) (which releases sk_lock.slock) and
conn->send_lock when advancing conn->tx_curs_sent via smc_curs_copy():

CPU0 (process)                    CPU1 (tasklet)
smc_tx_sendmsg()                  smcd_cdc_rx_tsklet()
  lock_sock(&smc->sk)               ...
  ...                               bh_lock_sock(&smc->sk)
  smc_tx_rdma_writes()              smc_cdc_msg_recv_action()
                                      smc_curs_diff(..., &conn->tx_curs_sen=
t)
                                        reads tx_curs_sent.wrap (old W)
    smc_curs_add(len, &sent, ...)
      /* wraps: wrap =3D W + 1,
       * count =3D C_new < fin.count
       */
    smc_curs_copy(&conn->tx_curs_sent,
                  &sent, conn)
                                        reads tx_curs_sent.count (C_new)
                                        /* old->wrap =3D=3D new->wrap,
                                         * C_new < fin.count -> returns 0
                                         */  <-- torn read

If smc_curs_diff() observes the pre-wrap wrap counter with the post-wrap
count, unconfirmed evaluates to 0 and clamps diff_tx to 0.  Because
conn->local_rx_ctrl.cons has already been updated to the new consumer
cursor, the credit is lost andconn->tx_curs_fin is not advanced, which can
stall a sender waiting for send-buffer space if no further consumer updates
arrive.  Conversely, if the plain loads are reordered (or on
!KERNEL_HAS_ATOMIC64 systems where conn->acurs_lock is bypassed) so that
the post-wrap wrap counter is paired with the pre-wrap count, unconfirmed
exceeds conn->sndbuf_desc->len and defeats the credit bound.

In addition, replacing smc_curs_copy() on conn->tx_curs_fin with in-place
smc_curs_add() updates tx_curs_fin.count and tx_curs_fin.wrap with
non-atomic stores (transiently writing count >=3D sndbuf_desc->len before
wrapping) rather than an atomic 64-bit cursor write.

Other unlocked readers such as smc_tx_prepared_sends() snapshot the cursor
into a local union smc_host_cursor via smc_curs_copy() before calling
smc_curs_diff(), and advancing a local copy of tx_curs_fin before writing
it back with smc_curs_copy() would keep the update atomic as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124180257.6220=
64-1-piyus@iiitd.ac.in?part=3D1
