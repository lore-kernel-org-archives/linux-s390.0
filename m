Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385046F4A7
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312548; cv=none; b=J1HUGSWa/eGi9sEK4Y4p9Ws6isQgXWkT4t7rrGckOJTYFJ4K6T0Z/4FA2NCgxemqJW7m5rw46SsXLXOkqVT2sYcqB+DqXvTv3G8zvgIdwc31kYjuof7G+iqONVW+KB4sop3lHrdSN/f2WqvlKeavmw20JcT8GCd0YsuKUPWyGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312548; c=relaxed/simple;
	bh=t6spRM5ARh3PqgiSyOH7ty3+/8rnZwWx7PPHGCZaKJU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obdqzkuBka+KFjCfCilN5UHcd42gwPggP3+vFDL2u8H0PaWvoVD/UuL5i97m8iPCsCeO1ExxsaHUCNzbQCuBxrODyVxUIqbhNd3mkAyPRkcIZzBvufMaPckKiADVlBJUXozyvOXkLwXfzrwkxUhMp4MhFxJiPJcIiNfZO9Lr6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZkIQ3pV5; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZkIQ3pV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787312534; x=1787571734;
	bh=t6spRM5ARh3PqgiSyOH7ty3+/8rnZwWx7PPHGCZaKJU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZkIQ3pV5v9waFSm7wSIuLHFuJFJU7eDYDWbv+zaJWidRBf+6GbTfuoaHTPgEP2Y+f
	 jmlJEwfmXVm5uaNQ7uroHCoDqbTmd5QlClkcHiHnEnOIJtgZwjss7nhYZXYON1hKhP
	 nnzYJFQhEfUo3LAycspt4PI61RPhzvKyrThRtID2naeNhEY8SLvHLcbuBd15a64uL7
	 +QvDa8lL9fWXRFvgqQKJldfo7pjzlI2QjURve0CpDvdHkD5JSClO6Lhd/oeHmunkaP
	 8ZTIT2bkitk4scs52Ia3tBa/U+WanH8jDXeUPOSCHG6kcewl6M1H+A/yJ2dyn5WvKU
	 2EQm0NdpOLR/w==
Date: Fri, 21 Aug 2026 11:42:07 +0000
To: Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ursula.braun@de.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/iucv: take a private, writable frame before rewriting it in place
Message-ID: <20260821114155.430473-1-hexlabsecurity@proton.me>
In-Reply-To: <5f368349-a417-42b9-9ee3-d9996a949bb2@linux.ibm.com>
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me> <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me> <5f368349-a417-42b9-9ee3-d9996a949bb2@linux.ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 85ab4f0a2e45dc681bcdb0f2ce15c5d1355724b0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandra,

> Excuse my ignorance, if it is obvious to other readers, but is the worst
> thing that the output of tcpdump is not correct?

Not obvious, and my description is why: it led with tcpdump, which is the
mildest end of this.

The order is the other way round. __netif_receive_skb_core() walks
ptype_base[] at net/core/dev.c:6160, before net->ptype_specific (:6169)
and orig_dev->ptype_specific (:6173). iucv_packet_type sets no .dev and no
.af_packet_net, so it sits in ptype_base[] while a packet socket for
ETH_P_AF_IUCV lands in one of the later lists. af_iucv runs first, and the
AF_PACKET reader gets the frame after EBCASC() has rewritten the four name
fields. The capture is wrong, but it was already wrong before the reader
was reached.

That isn't what I'd defend the patch on. Because af_iucv isn't the last
matching handler in that configuration, deliver_ptype_list_skb() hands it
over through deliver_skb(), which does refcount_inc(&skb->users) before
calling us (dev.c:2492, :2507). We run with users =3D=3D 2, and on that skb=
 we
rewrite the header in place, skb_push() 14 bytes in afiucv_swap_src_dest()
and pass the same skb to dev_queue_xmit() (af_iucv.c:1876, :1888, :1914) --
including for a frame that matched no socket (:1872).

What hides it in review is a guard asymmetry. deliver_skb() leaves
users =3D=3D 2 with skb->cloned =3D=3D 0, so skb_shared() is true while
skb_cloned() is false, and the copy-on-write guards all test skb_cloned()
-- __pskb_pull_tail() at skbuff.c:2886 among them -- so they read the skb
as already writable. The one that does test it is BUG_ON(skb_shared(skb))
at the top of pskb_expand_head() (skbuff.c:2305); skb_expand_head() carries
"/* pskb_expand_head() might crash, if skb is shared. */" (:2456) for the
same reason.

What I don't have is a panic. On the qeth geometry the first
pskb_may_pull() finds enough tailroom in the napi_get_frags() head and
copies out of the frags without expanding, so it doesn't reach
pskb_expand_head that way. By inspection; not reproduced.

> Is this really a problem fix then? Or should it go to net-next?

If the bar is a failure I can show you, net-next is right. I sent it to net
because a handler that writes a shared skb and then gives it to the
transmit path is a rule violation with a BUG_ON behind it, not because I
can fire that BUG_ON. Your call either way, and net-next is fine by me.

Worth having in the record: reaching the shared state costs one syscall --
socket(AF_PACKET, SOCK_RAW, htons(0xFBFB)), no bind, no ETH_P_ALL -- since
ptype_base[] is walked before the per-namespace list.

If Hidayath's version is further along, take his. I'd rather the check land
than land mine.

Thanks,
Bryam

