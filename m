Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298358;
	b=TbS9Pn/a5t+1ZZ+ZsMHZXXhbm33DQr4LCWRaGXdbPwlRc6pFszEyd9k9wspIPBNz2bZK
	 BKmG38FDO8DQujDp/vRtmmha95CVpJKHM1qUpnGVGJE2GR45Bv5a8O6ejp6c+sPPg42B9
	 Aorm7yO7N1yiH3PM8RVY6ISjEGLWv0O9Kw97UjfpIaMVQ+PAaasWS5mwEeghHo32odf83
	 U0OTUksP9oaWoJWLy8AskslE0p2UYj4SPQVy2le/pS3wyHu4AOmPMZcU1XlCHjdPXxfKi
	 i95M7vIPORgoR7jJQRxXrzvcvM9YktVJ5DSGCRzuPkyjJ7KdNyls5zhOtd/Hxl3YNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298358;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=GZ24PPCTQ7Ukom2m+ryN0pWtEtnjWNba4bT5xx6ZYow=;
	b=R88XbYanRkRalRn4JxZjaA4b7KTEuSLDNz4Rdyr0D+AQvuiiswvtdIPce7LdJiH/3CKN
	 GGSUt26SluoGlo4BWTY1SjgDvBn0xvqW0h1PF6oEAf/Ymm4aekLJqPl221HYvt/CQ5URY
	 NKx3/j93X6LYVs4W4ROj5m8ZZxzGnDSpKPE0HUOnw0ubrXVzYU28kPHuOvvng4OMJL9Vq
	 9ZcR4hCZci/l6V5US+bDnHx+xFt6OfVWH19ojyin1dBYPHsSx5+wlddkkcztCW49b0SjK
	 O72pNIkfzLqnltEjyaEgreB/SVzwSurTCaCPYAeis5GBmmTuSC6DA5rapUinOC+z/bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Nizaum6V;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A61606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 18:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Nizaum6V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793298350; x=1793557550;
	bh=GZ24PPCTQ7Ukom2m+ryN0pWtEtnjWNba4bT5xx6ZYow=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Nizaum6VZiMQ+8HUpUEuM4Qfo/btAs8SaChdE+YAPcxxrsKDJ6yalc5d6Z1zPHfZ3
	 gX1KL5AL3D5dRBppqXDZ4qtrzjY2UBjjI31FJCFmSCI1V1ORizxSiQoZXiZ2bImZiV
	 Z2sy8kqygRMQf5pvZosgm+N/0nsluoKkuJicO0FsLDx9bAodGy8Sq7sW9v2HjJOAFV
	 bGcn+FxcALgqPvtzZGcOPkJ1hEzTZDhWG+mgc/5wiHIvGTOy47Bw5GK+dPve1OFady
	 +Ap3RrDUtKFAnIpJ6shZPCPCdOVCw3tmf1BXWQ5sZnpV6rgWYaFC/LTrwGi+ZBHgF4
	 qOcamhIrdiURQ==
Date: Thu, 29 Oct 2026 18:25:42 +0000
To: netdev-bot+sashiko@kernel.org, "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>, Guangguan Wang <guangguan.wang@linux.alibaba.com>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 2/4] net/smc: bound the receive length to the RMB
Message-ID: <20261029182533.1726376-1-hexlabsecurity@proton.me>
In-Reply-To: <179209532096.434549.4189685148052558990@kernel.org>
References: <20261013-b4-disp-f345196c-v7-2-ef3dddfbfa68@proton.me> <179209532096.434549.4189685148052558990@kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: a134c1ba6117cd4c114d544b8dfbd61e6f0a167b
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

On Thu, 15 Oct 2026 20:15:20 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Can spliced bytes still be counted twice through the error path in
> smc_rx_recvmsg()? A read that wraps the RMB end is copied in two chunks.

Yes, and this patch doesn't change it. When chunk 1 fails after chunk 0
went into the pipe, the goto out skips the bytes_to_rcv update for chunk
0, so the count stays high by that much while the pipe release moves
cons past it; the next read is off by chunk 0's length. Same before and
after 2/4. The reorder in 2/4 is for the other double count, a reader
that takes the lock between the cursor update and the splice_pending
drop. Hidayath Khan's v2, announced in [1], will account the first chunk
instead of taking that goto, on both the splice and the memcpy paths,
and would close this one.

> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. Does
> smc_rx_recvmsg() handle a short positive return from smc_rx_splice()?

It doesn't. The bytes that didn't reach the pipe stay in the RMB and
the next read returns them first; the count is what goes wrong, low by
the difference for the rest of the connection, so the tail is lost at
EOF. Measured with a vmalloc RMB over SMC-R, the cursor 100 bytes into
a page and a full 65536-byte RMB spliced into a 16-slot pipe: splice()
returns 65536, FIONREAD on the pipe shows 65436. Hidayath's patch [2]
covers it; not this series.

> [Severity: Medium]
> Now that this helper is bounded, should the other readiness checks use it
> too? Several sites still read the raw counter:

They should; v8 does it. (The raw reads left -- the stats in
smc_rx_recvmsg(), the write_blocked tests in smc_tx.c, the unread-data
test in smc_close.c -- size nothing and gate no reader.) With the count
driven negative (forged wrap bumps, 2^31/len of them) v7's poll()
reports POLLIN while recv() gives -EAGAIN, so a level-triggered reader
spins: 1,887,464 wakeups and 1000 ms of CPU in 1 s; SIOCINQ returns the
negative count; a deferred accept returns at once with nothing to read.
With smc_poll(), SIOCINQ and the accept precheck reading through
smc_rx_data_available(), the same run: 0 wakeups, SIOCINQ 0, accept()
waits out its timeout; with the count at 6x the RMB, SIOCINQ returns the
RMB (v7: 6x). Conforming traffic is unchanged: bytes_to_rcv +
splice_pending does not exceed the RMB there (short of the goto-out
double count above), so the min() is a no-op. The two "guarantee 0 <=3D
bytes_to_rcv <=3D rmb_desc->len" comments from your Low item say "can be
out of range" now.

> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. The clamp
> keeps the MSG_PEEK|MSG_WAITALL case inside the RMB, but the peeked data c=
an
> still have a gap in it.

It can: with a peek asleep at 8192 bytes while a second recv() takes
4096, the peek resumes 8192 bytes past the new cursor, so the peek never
shows the 4096 between what it had and that point (by inspection; the
measured run ends with the peek returning the 8192 it had and nothing
more arriving). 2/4 keeps that read inside the RMB, nothing more; a
peek_seq/copied_seq resync like TCP's is outside this series.

> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. Can recv(=
)
> loop in the kernel indefinitely when unread data and unreleased spliced
> bytes coexist?

Yes; that is the spin [3] fixes, which 2/4 doesn't touch.

[1] https://lore.kernel.org/all/7a174d1f-80d8-4294-ae66-829c9dacd662@linux.=
ibm.com/
[2] https://lore.kernel.org/all/20260820085543.967490-1-hidayath@linux.ibm.=
com/
[3] https://lore.kernel.org/all/20261029-b4-disp-da7f8e6a-v2-1-9052904adf72=
@proton.me/

pw-bot: cr

