Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248309;
	b=wPKLKemWQ/F5VEEo7Ek/tvaQBG1s8IM8ytMaJ7wUaFufkKakn5iSHaPAABmqjvKKOob6
	 WxCymy+MK8/xE9wNejp18D396/sZu4AU9bZ3shE6CU5qOjgrOGuz2TJnEIeBj+11ENIJB
	 fAPQcp4QFiZjeBYl3TN7ihbu9oaFDD64TsFCFxOHy1SPrdZcBD5jPV/WCCF7e4Pxsu7d6
	 RYNUs43BZx4xIdKDOSD9n8fq52HO4eBmsIp0MO9FNMKsrije/OvFqY7G/sYKyoYAyyaZg
	 iiB6KecBdUdCTp69P7N9ZESi0iUeZKQ1eOwgo9kAxm/PKEk0XSX+qBzVbCWFKPimTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248309;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RnJha7VVVsZJcHCtg/jczwllaW0KJ4wm5ZbAUagO4eA=;
	b=ah2Hk4rM0fn+kmOjTcH06xL5YtgSK7njy2b+Xtb2evs8QldbzcOjeji/BA5oFvQS4y1c
	 tC8wevJ2oKM73B6nvY2UEbEPODYBZmwFz+NGRl/74cDxLk0+V0MwGq3VhIiC1xK8+ayc5
	 azdq4IM3GjPnU5hOK9JGBQvB69mvnXr8EC2guHMjk7Fg0pYWC/yzTk+XEEWe/EvDwK/g+
	 0Ee4rkd0Gosa/RorioBayI3+JQ0enEnYE42z/3a0HZazKMQMRoYfywgfNvdHmj31jAJEd
	 ZfVY4OZQxKINOA4joy86dlRwdUcCchebgjxsC83H+kfrLGWhqoz2yryCc43GBHzeIUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=XFTrW0ak;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A051606A31A;
	Thu, 29 Oct 2026 04:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A051606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=XFTrW0ak
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793248305; x=1793507505;
	bh=RnJha7VVVsZJcHCtg/jczwllaW0KJ4wm5ZbAUagO4eA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XFTrW0akXxqUibMgoe0BQbfYr+eRRYNNl4VXmtuunSQVWxm6bwmvyb8OcIFgAbK7b
	 ARm/w0RlTptQLp1fcZAVxZNQ7AoaEzMZuI7ooO2FDP+LGossEzq6nocYCnRBlDSAGB
	 lDSaUJjVWsoJgWRcb6Oq7tLUiyA9JyaIhPihGB44PviU6BOhwLeG9wRNKsRzw0EU0K
	 Y2b1tXUMbqa4qFQ7piX718pLcfgypkKpRhRlX1CuGWtS8dcef4/eJ2+UPi9gok+88s
	 nDgg0EBm/LBbW/GdKbrhSRN7pDt4YRxjX3oGdZsl3LQZanRyNE7LRSGGwhd4+tp+lc
	 h4jylYx2c1LMg==
Date: Thu, 29 Oct 2026 04:31:41 +0000
To: Paolo Abeni <pabeni@redhat.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Ursula Braun <ursula.braun@de.ibm.com>, Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/iucv: take a private, writable frame before rewriting it in place
Message-ID: <20261029043134.432738-1-hexlabsecurity@proton.me>
In-Reply-To: <eb32ba07-0a4c-4bc6-acda-36e6b95af89b@redhat.com>
References: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me> <eb32ba07-0a4c-4bc6-acda-36e6b95af89b@redhat.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: b0f95197546e081200a2ba0e10761147fe33e3ba
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

On Tue, 13 Oct 2026 15:05:54 +0200, Paolo Abeni wrote:
> > +=09if (skb_cow_head(skb, ETH_HLEN)) {
>
> Sashiko (nipa) noted the above is the wrong helper:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-b4-disp-bf46=
f1ba-v2-1-46ff1ea9c40b@proton.me
>
> you should use skb_ensure_writable() or skb_cow()

Agreed, and sorry for the slow answer. The rewrite is in the data, not
the headroom, and skb_cow_head() only tests skb_header_cloned(), which
leaves the data shared with a nohdr holder. No af_iucv frame has one
today (nohdr is set only on the TCP, SCTP and GRO frag_list paths), so
the two cases in the commit message still get their copy; it's still
the wrong contract for a data rewrite.

v3 uses skb_cow(skb, ETH_HLEN): skb_cloned() for the rewrite, the same
ETH_HLEN headroom for the push in afiucv_swap_src_dest(). Same s390x
QEMU A/B as v2, re-run on v3: eight boots, the tap and the
ETH_P_AF_IUCV socket read every frame as sent, and each of the two
calls is still needed.

Thanks,
Bryam

pw-bot: cr

