Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299109;
	b=3s6jT2x6i2QAc1lOmWTGqYtC9mM0cPoWZos3JXqPzA394UPuX7g//NFiPBJ0xhBJNMZs
	 jAtRYE0CLrYKX2F23Y/m1/g32VZ+EWekJH8x6G88VjnEEfyDZaOEF83k6dGkU1g0Fv3uT
	 cvoSiFErzYuMiunA2rHQxLAJH2s74Pn5jf5O6nBYczMWb0wgfr7kP+9Ft2OR9qRCVRRKk
	 9zInBgaOeVunEA/xf9EDvC5Ks0TVDm8nYXBSjQi2Lan0KVLmezlsVe2Ac2Paq6VoXkZVn
	 S+w5ddo0Xenxz5G9pvo19x2VOhlyoo/uvYHxxYh1QYDTg2w3tvyTppu+LA+g9uFYUXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299109;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=aQUQ22arzOsDcdQH8iQ6HuUgomjVmoeil3/Gy5LRfZY=;
	b=GGH7vRCaRpdJDrSHXtmbE2plyrjBJ0ReTy5ohmI0N7vtgNpvFZNEpL/zuUBLUE+MEEXr
	 BmFUpR2s45YYaSFmnREqBLC9tMHdAd4+CYtnvMp5+FdhhK0lr0DHvD6msK0n8FtlbGWa+
	 lehbxvb/XrtKYisRgIEJrh4HVrDs21n7Ed8iKyTEEc4O8V4avX10HWejRNHgdwj8nUINF
	 0ORSHEGPudIwztah5exqtqM91OgdT9aEZjVLdvNxxQvnaMbS0mcIKv1XpwBncTlymRDOy
	 ypIRegOjSdckswWrkacn8wkI0AVngy8NKGKfUXwTbvLDZjYT6uwU9XtKf7QG309jjKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=XeNuHzvj;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040E606A31C;
	Thu, 29 Oct 2026 18:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8040E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=XeNuHzvj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793299106; x=1793558306;
	bh=aQUQ22arzOsDcdQH8iQ6HuUgomjVmoeil3/Gy5LRfZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XeNuHzvjhhmFjKb4/hfEKc/nvRgxii4YWMR8vS1fTAohcL/YSkiTLisc353Q60J0c
	 eNnq6tVFfjObP3YW0MboWDasYYF8TplFW3tE6h5lyaBj6dBKsfC41sbpcicM52NW4S
	 E7wBXLEvSqunjbdkf43Q7a1oJySSzlquaAPxMKm6lLCrP8hEY7u4wAtn7ggitv5sC7
	 A88qpkcuPQms3BZ0sXqrKIMtbTwVDY8EuT3RA2aFDhWfBByZ94886clnPMWPl4sLz/
	 jAcXokcuJEoWodV3KaP4N/aD0VdJJ3iWB/4m0qos7mHC0bPdE/elCCYLq1CehW/8pj
	 0aXMYd5c89eAQ==
Date: Thu, 29 Oct 2026 18:38:20 +0000
To: netdev-bot+sashiko@kernel.org, "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>, Guangguan Wang <guangguan.wang@linux.alibaba.com>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 4/4] net/smc: bound the link failover cursor advance to the send buffer
Message-ID: <20261029183812.1762144-1-hexlabsecurity@proton.me>
In-Reply-To: <179209532452.434549.6588379141939967966@kernel.org>
References: <20261013-b4-disp-f345196c-v7-4-ef3dddfbfa68@proton.me> <179209532452.434549.6588379141939967966@kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 463b6ff5123c872ec9a8ab535f5c76a5d686f2bc
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 20:15:24 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Does this fully close the destination side of the overrun that the commit
> message describes? The new cons.count check only decides whether the
> catch-up branch runs. The forged cursor is not rejected and stays in
> conn->local_rx_ctrl.cons.

No, and v8's message no longer claims it. 4/4 bounds our side, the
source cursors and sndbuf_space; smc_write_space() still sizes the
window from the peer's cursor, so a forged one can take the next write
past the peer's own RMB, where its HCA refuses it and the link goes
down. Measured on rxe: with the consumer cursor forged two wraps ahead
at the peer's RMB + 4096, the first write after the switch, from
prod.count 1 with a whole-RMB window, ends one byte past the peer's RMB
and is refused; a cursor one wrap ahead gets the send's own write
refused the same way with or without the patch, no failover needed. The
write targets the forger's own memory in both cases. Bounding cons at
import, as you suggest, is a different change: cons indexes the peer's
RMB (1/4's reason for leaving it alone), and a forged one harms only
that RMB.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the two users of the wire
> consumer cursor now handle it differently. smc_switch_cursor() bounds its
> use of local_rx_ctrl.cons. smc_cdc_msg_recv_action() in net/smc/smc_cdc.c
> still credits the window without a limit:

They do. The second chunk can run past the peer's RMB, same answer as
above: the forger's own memory, and its HCA refuses the write; the
receive-path credit is pre-existing and not this series.

> [Severity: Medium]
> This is a pre-existing issue, but smc_curs_comp() in net/smc/smc_cdc.h
> compares the u16 wrap fields as plain numbers:

Yes: at the 65535 -> 0 rollover a cursor ahead reads as behind, the
catch-up is skipped and smc_write_space() goes negative; nothing more is
sent, so, with nothing left for the peer to consume, no cons update
reopens the window and the connection stalls until it is closed. One
window per 65536 wraps of the peer's RMB, before and after this patch.

> [Severity: Low]
> Two cases leave local_tx_ctrl.prod behind local_rx_ctrl.cons: the prep
> term of this min() wins, or the branch is skipped because
> cons.count >=3D peer_rmbe_size. The comment above still says the catch-up
> fixes prod < cons.

Intended: neither case happens with a conforming peer; a forging one
stalls its own connection, or has its next write refused as above.
v8's comment says why the catch-up is bounded.

> [Severity: High]
> This isn't a bug introduced by this patch, but the RDMA write takes its
> offsets from these cursors. Is the source side of smcr_tx_rdma_writes() i=
n
> net/smc/smc_tx.c bounded for the second destination chunk?

By inspection it is not; reachable only once the receive-path credit
above has pushed peer_rmbe_space past the peer's RMB. Not reproduced;
pre-existing, SMC-R only, not this series.

> [Severity: High]
> This is a pre-existing issue, but smc_switch_cursor() reads and updates
> tx_curs_fin, local_tx_ctrl_fin and sndbuf_space while holding only
> conn->send_lock. smc_switch_conns() takes that lock:

Yes to both: the interleaving credits the handler's bytes a second time,
the race from your 3/4 comment (send_lock on one side, bh_lock_sock() on
the other), and after the over-credit the copy stays inside the buffer
but can overwrite data the peer has not received yet. Pre-existing.

