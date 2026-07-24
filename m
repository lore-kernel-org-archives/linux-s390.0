Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EC418A54;
	Fri, 24 Jul 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885606; cv=none; b=TQHuRB5WxFlZta061Of7xxBe4PVOjGTDFGcsAcKjAb6uPZpyxv9fzeBmeoHBlFAWz7DDAzWladOAgFO8m7ShV0UwzDyWhy/Bux0Z2D3rgV5Zt9et1BRU7el6W8aKuwKiPvm08ynsQoQNlfFQuH8rHEoElr4itmWW3luA8h5CBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885606; c=relaxed/simple;
	bh=c5lHZUA21LX18YnAh07iCzCv6SAMbuYHV8/QWeREYc8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AE810IJ4PcWzXiAxjLpgRKWVR8sYo1RFKkgaT1orVtvb2GlzMbzsN9dH2n8+9jCucEiHlltbiwUyWjXuHmFfX9vu8b81KxS0bOVxajGjziXK5z23LrXAiWJAebwywyCH7p1LsxgNx1FVs2PMucRzDr6u7v8J+yaokg8OpW45xeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nNOZfci3; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nNOZfci3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vgrsfkybijhorgnwrdckjf4224.protonmail; t=1784885597; x=1785144797;
	bh=DSxSsiBb5thoJgkAuJOTNi6IZ2JahwLUEA6iDcnQm/w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nNOZfci3TJf9YViKWHIW9D4P9x941+UXtoUeaykMhBLV2p2Jek6RFPWfXH4V/T3Kg
	 QxJfiiY5FsTXhy23ruFFkZ/4QI/Fca/BiMPg2G8ZU4n+KuzlIBFRZClVoZKWSSVIGr
	 Fx+RhF6JWSH+rCTq3p7BGxxNKUqPu1vYithQ574EL/Fk8kQ5XyJa+8mAh7zx0XAdxA
	 X2U0l3Ql65dGmq1zUghnVAjTid8g5hY1vkorl2NravE+BcjZiA0qywBIWTPFFZ47vq
	 PxAmJ0LX8BuFUhARqZb7DwzdhcGP7jsbw+fLUeT+cfsIwtL27EhBgXmVYQqdsQknuT
	 f+O+UoHOPBc4w==
Date: Fri, 24 Jul 2026 09:33:11 +0000
To: Alexandra Winter <wintera@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/iucv: fix use-after-free of a severed iucv_path
Message-ID: <20260724093301.9627-1-hexlabsecurity@proton.me>
In-Reply-To: <3da353b3-a159-46ea-83fb-807a2a242e49@linux.ibm.com>
References: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me> <178461900540.131537.16161978052316384549.git-patchwork-notify@kernel.org> <3da353b3-a159-46ea-83fb-807a2a242e49@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 8d4d7d6505d069c715f2074a7dc553a201861908
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To:  Alexandra Winter <wintera@linux.ibm.com>
Cc:  Thorsten Winkler <twinkler@linux.ibm.com>,
     Hidayath Khan <hidayath@linux.ibm.com>,
     Heiko Carstens <hca@linux.ibm.com>,
     Vasily Gorbik <gor@linux.ibm.com>,
     Alexander Gordeev <agordeev@linux.ibm.com>,
     Paolo Abeni <pabeni@redhat.com>,
     "David S. Miller" <davem@davemloft.net>,
     Eric Dumazet <edumazet@google.com>,
     Jakub Kicinski <kuba@kernel.org>,
     linux-s390@vger.kernel.org,
     netdev@vger.kernel.org,
     linux-kernel@vger.kernel.org

Alexandra,

> After iucv_sever_path it should not be possible to call
> iucv_process_message_q() anymore.

For the close path, yes -- iucv_sock_close() ends at IUCV_CLOSED/SOCK_ZAPPE=
D
and recvmsg() is out, so message_q just leaks. The peer-sever path is
different: iucv_callback_connrej() severs and then sets IUCV_DISCONN, leavi=
ng
the socket open. recvmsg()'s early return needs message_q.list empty; with =
a
saved entry it falls through, and if a datagram is still on sk_receive_queu=
e it
reaches iucv_process_message_q() and hands the freed path to message_receiv=
e()
-- pathid is the read.

It isn't a tight free-vs-use race. The core tasklet runs message_pending th=
en
path_severed in arrival order under iucv_table_lock, so the entry is saved =
with
the path live and the sever frees it in the same pass; neither connrej nor =
close
drains message_q or purges sk_receive_queue. The stale entry then sits in
message_q.list until the next qualifying recvmsg -- deferred use, not a
nanosecond window. A peer that floods past rcvbuf (which is exactly what sp=
ills
into message_q) and then severs before the slow reader catches up owns the
ordering; and where a gap did need stretching, it's a lock-free interval a
blocked reader holds open, so I wouldn't read "narrow on HW" as a bound.

> I agree that it is a message leak [...] not freed anywhere.

Right, same missing drain. On close it's a leak; on connrej the socket stay=
s
readable, so it's a use-after-free on the next recvmsg(). So: a leak from y=
our
side, a reachable UAF from mine, gated to s390/z-VM and its timing. I verif=
ied
the pointer lifetime with KASAN (mocked transport) and CBMC, not on z/VM
hardware -- the measured HW trigger is yours to confirm, I'm not claiming i=
t.

> I would have preferred to do that in iucv_sock_close() [...] but this sho=
uld
> work as well.

Draining at sever covers both callers in one spot; close-side for symmetry =
with
iucv_sock_alloc() is fine too, no objection to moving it.

I'll fold the reachability point into the receive-path locking rework and s=
end
that RFC to netdev and linux-s390, as you asked.

Thanks,
Bryam

