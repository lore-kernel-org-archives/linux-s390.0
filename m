Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247497;
	b=rYU/9bN78ch1IJXleWzAN0YSOR1Gz/XCKfHa/Cm2gTIPdOu+bhTMKFpVdpUskgbfVbOd
	 OrFaNbpscFj6+SB+btEJCNwV+TMw2/7QsZ5h0TkcUmh5ovcyJaLMxY0zBgbpNljP4jZvp
	 7uKodhHF91Q2bVI62iPbOAJsRZmUKVME1V+EC2quDOXu+jcRVe6bYgb2HQbR8iV/m7gc/
	 FqWVcPcAZVqs042hiQO9lXB08quc11Lkaws++EwniqBJa+BRTpNDBlCcBhtn6Uo0WwA4X
	 nflLng4uTOgB+3Tcm4gVNgF27mctp35XcXPS77lgc8P83YGXQQjRinPLmi9srTjAr8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247497;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4V1QY5rnLtUFHVy7j/lGfFmVKAOrcLlyIp4tAu9on10=;
	b=cbdMugp8i3voMnsgNy23nYIGuqRohcKWOGf6e+Z6z9YZoh9jVyhJAt5kRaQaXx6ejbb4
	 Jvngme29X/ki9W6XekAb+UthC0DmLlJ+lAGMj3A8RdQzLtm7eWdM5P3ArVjUKHo1KmN6u
	 DA5SbdwXVKmZJ5OPPcubzg2dWWBqS14uw12WXjz2irOWpAiL7aDSVzCxUZBTxOgKGk7lM
	 VtKcak6yQpL8RunflYJQrVfvXcDQWy822wAHb4WxWKFxKfNtLVut/kyusEodCDG40lZkN
	 OntOQNEjTGE2g7CZsT5WVDoeMWqg5ZDdG4A7mUjsFOlA/+zVbdoC4ncbN7CKURyBzAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=fHRp8W2g;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE4606A321
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 04:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EE4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=fHRp8W2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793247494; x=1793506694;
	bh=4V1QY5rnLtUFHVy7j/lGfFmVKAOrcLlyIp4tAu9on10=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fHRp8W2gJD0gY0Fo5rTfRNWS7qxDo2ppPVVSc62ChZObnOe3b5vwCQy/NOsQtYEWq
	 VHDNQU/8RS70HsOooNpvhfSuLjwQ+sfzz4i31Drzp4/2PRtfPCLFaOLesJfh7fg4gV
	 FISGAtcmL05utbMMn7IecyJupEJrit2550Fl9sg7nTRbcLRMnopbY9xHmqZ67D0e9H
	 llpk1REyDaMdis86iAo2aN05NVwmmGVhQcmrIEUZny0M4STGdQea+4CcOXpaEJUopm
	 PJVq4bndCvif/YfDDMNj/R8Wzm48jIvOtsc07sW6IcDYX0bdLdDioOQ/GVS8SZE6Ce
	 Mkhih7RqKvEZg==
Date: Thu, 29 Oct 2026 04:18:08 +0000
To: netdev-bot+sashiko@kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Simon Horman <horms@kernel.org>, Hidayath Khan <hidayath@linux.ibm.com>, Nagamani PV <nagamani@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/iucv: do not count the SHT frame against the receive window
Message-ID: <20261029041801.406712-1-hexlabsecurity@proton.me>
In-Reply-To: <179306942509.3134.1109951482403010755@kernel.org>
References: <20261022-b4-disp-b35a9153-v1-2-d74645876195@proton.me> <179306942509.3134.1109951482403010755@kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 18184e39b0757656a9ad30fcbcf0ef6c97309a0d
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

On Tue, 27 Oct 2026 02:50:25 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Can an empty frame read after the over-window close reach
> iucv_send_ctrl() while iucv->hs_dev is NULL?

Yes. The close purges backlog_skb_q, not sk_receive_queue, msg_recv
stays over the limit, and with the length test an empty frame read
after it skips the -EFAULT branch and lands in the window update. Repro
on the emulated s390x setup with SO_MSGLIMIT 2: the peer sends twice
(the window), then from a tap on its interface one data frame over the
window, its SHUT_WR for the SHT, and 16 more data frames behind it, so
backlog_skb_q is not empty and no read sends a window update before
the close (a Linux peer blocks at the window; the overrun is injected).
Six reads: 1, 1, -EFAULT (the close), -ECONNRESET, 0 (the SHT),
-EFAULT (a data frame behind the SHT closes again). On v1 the fifth
read enters iucv_send_ctrl() once, with nothing leaving the adapter.
The reads are the same with and without the bug: on a default boot the
NULL read lands in the lowcore and afiucv_hs_send() fails with -ENODEV,
as you say, so nothing shows from user space. v2 sends the update only
while the socket is connected; the same run then shows no attempt
after the close.

> [Severity: Medium]
> This is a pre-existing issue, but does a zero-length data frame always
> arrive at the receiver as an empty data frame?

No. With a credit piggybacked it is a window update to afiucv_hs_rcv()
and never reaches recvmsg(). v2 narrows the sentence to "a zero-length
data frame that reaches recvmsg()". The slot the sender loses there is
the tx side's own accounting, not this patch's.

> [Severity: Medium]
> This is a pre-existing issue, but the classic IUCV transport still has a
> WARN that a peer can trigger, of the same kind as the one removed here.

Same kind, agreed, and iucv_process_message_q() retries the oversize
message on every read. That is the z/VM transport, not this path; out
of scope here.

> [Severity: High]
> This isn't a bug introduced by this patch, but this read-time check is
> the only window enforcement on the receive side. Can a peer that ignores
> its window grow iucv->backlog_skb_q without limit?

Today it can: nothing on arrival counts against the window, and
backlog_skb_q is neither bounded nor charged. This patch takes a WARN
off that check and does not move the enforcement; the bound belongs on
the rx side at arrival and is not this patch's.

> [Severity: Medium]
> This is a pre-existing issue, but can a conforming peer still reach this
> close?

Yes, by lowering SO_MSGLIMIT in IUCV_BOUND below the window the SYN
advertised; that is the case in the notes below the patch. Not in the
commit message or the comment: 2/2 only stops counting the SHT and
takes the WARN off, and the socket enforcing a window other than the
one it advertised is the series' fix. The locking series keeps the
advertised window in its own field, so the budget, this check and the
update threshold read the same number.

> [Severity: Low]
> Two unsynchronized writes to sk->sk_shutdown can lose RCV_SHUTDOWN.

Pre-existing; the series puts both writes under the same lock.

Thanks,
Bryam

pw-bot: cr

