Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794878;
	b=AnuwfSPv3pKaHLcrab0BFNFAZMOx/c9TWmqP/ZirbB20MufrHRERUMhGkPzanVDOR8vT
	 T57VTcYgA+q99JvZw77ErkJvrCwiVV36e7N6RSfb3JeNB1/mkVQOd8UmS/JrtaIZHE9Di
	 DU+wY3M+a15R/JQOXRQo5NMZKxo2fEn1/WIwjBXmQrCPyJ83jZbXSGL2vHzXJ7E9Eg3XI
	 Bl9bZIS/TAu4LK49VZiAcBsZK5W4jn+Dj9R6L2BPbQut1C4+2dOJPLAgJgtsaenlQt4BK
	 BGA5C6BvVD+cO98XXbSJotlwahq2KhMB0bsBbpKxrddur1B3Zt+AOUxsf4ymZ9xwi+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794878;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qT2SmpKT42/60ZCfaDo5yzFJNJBXnuaeiR7un/Ksq+A=;
	b=PKATDjZDFkYtwAnehrGeMFjTelpLgU4F7wgU8D9bg+MY8dmMv42l1xMOkwoZUVY+5aeb
	 ITAPFkkiSDBRpzGmFjXV5HFZa1K5BM7wVKBckX2mFcrkRHNwKileBfyQIEPKy2iM7/xuK
	 U3TxLih4Eo+i46kYN8UShZJk11Ar1u1kJkIFQb8IdpeNOyymplspCC34sKKVT12jLksf+
	 gmzwOEclspRDMg4qpAcZAriy9FcjPDak2E8WDm7Se63D3BYmNmXDOt/IMOjvx2/ln1cfu
	 qGXh/S8WM8p6eqOJXXJBvmVfkKB6rM0tYtB0CVJNEDHYYpLGCDpvDi/9TETcHd75QhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5ZJTfSG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAF606A321;
	Fri, 27 Nov 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5ZJTfSG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436F61F00935;
	Fri, 27 Nov 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794877;
	bh=qT2SmpKT42/60ZCfaDo5yzFJNJBXnuaeiR7un/Ksq+A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J5ZJTfSGwyx7YP//jUdN0TD8TP+nVbpyO3+54YaVPHZoVlgYeQL7XshMdgm9nkZ7U
	 MvaBjId+eZjehUOUGY9mLJ7DEmj9YpVyJDnKtTZ5DhR838Z39vjDlrzqsSbo/WcdX+
	 /UyXE9Q+yGZ8flHpV7tkCQsd0kOr0jraNL+CnCTik9uJ+PMcPOjopRqFG9g+qYGkC+
	 zVg4sMXLrWgEhOsXEnbNqY4RKJFztkt7qFfpMk7UqYKiUa63HtJ76BdAep6/pxP5KA
	 UnCnh0s8wxbavMjIaNIXtAZsCJWRxiuIXGJpCPlH09t+P5yDq+1OBgGhWt4Xw+fUyG
	 8VTAfjwyIMjrw==
Subject: Re: [PATCH net v4] net/smc: bound the DMB-nocopy send-buffer credit
 by what was sent
From: netdev-bot+sashiko@kernel.org
To: piyus@iiitd.ac.in
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kapil@presceralabs.ai, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 15:54:35 +0000
Message-ID: <179579487576.3135.5925577471148632436@kernel.org>
In-Reply-To: <20261126150617.2113159-1-piyus@iiitd.ac.in>
References: <20261126150617.2113159-1-piyus@iiitd.ac.in>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 (1) · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new clamp makes the sndbuf_space credit depend on the
  tasklet seeing a tx_curs_sent at least as new as every prod the peer…
- [Low] The commit message treats the DMB-nocopy consumer cursor as
  untrusted remote input that "nothing bounds", and the Fixes: tag sends…
- [Low] The new comment in smc_cdc_msg_recv_action()
  (net/smc/smc_cdc.c:392-393) says the bound preserves "the fin <= sent…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the
  producer cursor (prod) from the same CDC message, handled in the same…

--

net/smc: bound the DMB-nocopy send-buffer credit by what was sent

This patch changes the SMC-D DMB-nocopy path in smc_cdc_msg_recv_action().
The sndbuf_space credit is now bounded by the bytes between tx_curs_fin and
tx_curs_sent, and tx_curs_fin is advanced by that bounded amount instead of
being assigned the consumer cursor the peer reported. Both cursors are
snapshotted with smc_curs_copy() before use.

Link: https://lore.kernel.org/all/179552966151.3135.8162716126718648323@kernel.org/

> The peer writes that cursor into the DMB itself, so under DMB-nocopy the
> value is remote input and nothing bounds it.  A cursor reporting more
> consumed than this side ever sent raises sndbuf_space past
> sndbuf_desc->len, and the assignment moves tx_curs_fin past tx_curs_sent,
> breaking the fin <= sent <= prep order the three cursors are documented
> with.

[Severity: Low]
Does "remote input" describe where this cursor comes from accurately?

smc_ism_support_dmb_nocopy() is only true when the dibs device implements
ops->support_mmapped_rdmb:

net/smc/smc_ism.c:smc_ism_support_dmb_nocopy() {
	/* for now only loopback-ism supports
	 * merging sndbuf with peer DMB to avoid
	 * data copies between them.
	 */
	return (smcd->dibs->ops->support_mmapped_rdmb &&
		smcd->dibs->ops->support_mmapped_rdmb(smcd->dibs));
}

The only in-tree provider is in drivers/dibs/dibs_loopback.c:

	.support_mmapped_rdmb = dibs_lo_support_dmb_nocopy,

So the peer that writes the cursor is the same kernel's SMC stack. It goes
through smcd_cdc_msg_send()->smcd_tx_ism_write()->dibs_lo_move_data().

The CDC header sits at offset 0 of the DMB. smcd_buf_attach() places the
ghost sndbuf after sizeof(struct smcd_cdc_msg), so user data written through
sendmsg cannot overwrite the header.

The peer only advances cons through recvmsg. recvmsg is limited by
bytes_to_rcv, which comes from the prod the peer received, and that prod is
at or behind our tx_curs_sent.

As a result, diff_tx <= unconfirmed always holds and the new min_t() never
clamps. smc_curs_add(fin, diff_tx) gives the same tx_curs_fin as the old
assignment from local_rx_ctrl.cons. Producing the forged CDC stream
mentioned in the notes would need kernel-level injection.

Could the changelog say that this path is only reachable with loopback-ism,
and call the change hardening? If so, is the Fixes: tag still appropriate,
since it sends this to stable as a bug fix?

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..8f4351e1d4adc 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -333,6 +333,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>  	union smc_host_cursor cons_old, prod_old;
>  	struct smc_connection *conn = &smc->conn;
>  	int diff_cons, diff_prod, diff_tx;
> +	union smc_host_cursor fin, sent;
> +	int unconfirmed;
>  
>  	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
>  	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);

[Severity: Critical]
This isn't a bug introduced by this patch, but the producer cursor from the
same CDC message is never range-checked. It is handled a few lines further
down in smc_cdc_msg_recv_action(). Can a remote peer use it to read past
the end of the RMB?

smcd_cdc_msg_to_host() copies peer->prod.wrap and count straight from the
DMB. On SMC-R, smc_cdc_cursor_to_host() is reached from
smc_cdc_rx_handler(), and it only rejects backward moves:

	if ((old.wrap > temp.wrap) && temp.wrap)
		return;
	if ((old.wrap == temp.wrap) &&
	    (old.count > temp.count))
		return;
	smc_curs_copy(local, &temp, conn);

Any forward prod is accepted, for example the same wrap with
count = 0x70000000. diff_prod then approaches INT_MAX and is added to
bytes_to_rcv without a check, even though the comment says:

	atomic_add(diff_prod, &conn->bytes_to_rcv);
	/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */

If the peer also sets prod_flags.urg_data_present,
smc_cdc_handle_urg_data_arrival() does this:

	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
	if (conn->urg_curs.count)
		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);

urg_curs.count is never compared against rmb_desc->len. The read happens in
softirq context and can land up to about 2 GiB past the RMB. It either oopses
or leaks one byte to user space through recv(MSG_OOB) in smc_rx_recv_urg().

There is a second path in smc_rx_recvmsg(). There, copylen is bounded only
by the inflated bytes_to_rcv. When copylen > rmb_desc->len, the second
chunk is:

	chunk_len = copylen - chunk_len; /* remainder */
	chunk_len_sum += chunk_len;
	chunk_off = 0; /* modulo offset in recv ring buffer */

memcpy_to_msg() or smc_rx_splice() copies it from the start of the RMB, and
the copy runs past the end of the buffer.

Should prod be checked against rmb_desc->len, and diff_prod against the
free space in the RMB, before either is used here?

> @@ -358,16 +360,55 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>  			/* Calculate consumed data and
>  			 * increment free send buffer space.
>  			 */

[ ... ]

> +			smc_curs_copy(&fin, &conn->tx_curs_fin, conn);
> +			smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
>  			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
> -						&conn->tx_curs_fin,
> +						&fin,
>  						&conn->local_rx_ctrl.cons);
> +			/* This difference comes from the cursor the peer

[ ... ]

> +			 * would move tx_curs_fin past tx_curs_sent and break
> +			 * the fin <= sent <= prep order the three cursors are
> +			 * documented with.
> +			 */

[Severity: Low]
Where is the fin <= sent <= prep ordering documented? Under net/smc/, this
new comment is the only place the phrase appears.

The field comments in struct smc_connection in net/smc/smc.h only give loose
TCP analogies and state no invariant:

	union smc_host_cursor	tx_curs_prep;	/* tx - prepared data
						 * snd_max..wmem_alloc
						 */
	union smc_host_cursor	tx_curs_sent;	/* tx - sent data
						 * snd_nxt ?
						 */
	union smc_host_cursor	tx_curs_fin;	/* tx - confirmed by peer
						 * snd-wnd-begin ?
						 */

Could the invariant be written down next to these fields? Otherwise, could
this comment and the matching sentence in the changelog be reworded so they
don't say it is documented?

> +			unconfirmed = smc_curs_diff(conn->sndbuf_desc->len,
> +						    &fin, &sent);
> +			diff_tx = min_t(int, diff_tx, unconfirmed);

[Severity: Medium]
Can this clamp drop a legitimate credit when the sent snapshot is stale?

The bound assumes this tasklet sees a tx_curs_sent at least as new as any
prod the peer has seen. On the writer side, nothing orders those two
stores:

smcd_tx_sndbuf_nonempty()        /* holds conn->send_lock */
  smc_tx_rdma_writes()
    smc_curs_copy(&conn->tx_curs_sent, &sent, conn);
      /* relaxed atomic64_set() on 64-bit */
  smcd_cdc_msg_send()
    smcd_tx_ism_write()
      dibs_lo_move_data()
        read_lock_bh(&ldev->dmb_ht_lock);    /* acquire only */
        memcpy((char *)rmb_node->cpu_addr + offset, data, size);
          /* publishes prod into the peer DMB */

On weakly ordered architectures such as arm64, ppc and riscv, the prod store
can become visible before the tx_curs_sent store.

Suppose the peer's rx tasklet is already running on another CPU. It reads
the new prod in smcd_cdc_rx_tsklet(), consumes the data and reports cons
back, all before the tx_curs_sent store has propagated. The sent snapshot is
then behind, so unconfirmed < diff_tx and min_t() drops part of the credit.

local_rx_ctrl.cons has already moved, and this block only runs when
diff_cons is non-zero. The dropped part is only credited when the peer moves
cons again.

Take a sender that fills the whole sndbuf (sndbuf_space == 0), sends it in
one smc_tx_rdma_writes() call and blocks in smc_tx_wait(). If the snapshot
is a full write behind, unconfirmed is 0 and nothing is credited. The peer
has nothing more to consume, so it sends no further cons update. Does the
sender then stall for good?

The old code assigned cons directly and never read tx_curs_sent here. The
changelog covers tearing but not the order in which other CPUs see the
stores. The timing is very tight and this hasn't been shown on real
hardware, but LKMM allows it.

Is an smp_wmb() or a store-release needed between the tx_curs_sent update
and publishing the CDC? Alternatively, could the bound avoid depending on
tx_curs_sent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126150617.2113159-1-piyus%40iiitd.ac.in
