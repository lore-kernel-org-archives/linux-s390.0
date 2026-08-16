Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845912FF69
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896454; cv=none; b=E/994p/gqwQEG06NBip+vt7uzE1O5fwfP6BWEZCoTC5xLJ5qF0U1OcVzq/4xbi39SfTIzVpr43ffBZKyjPZbcsJBLE/K4FUXIRrO0Ly1MmGA1udvM0CMBLq9XrcFPz20k5WbZIE2Ze38CNI51q+joMfWxxeWRMYDKf7D24tMXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896454; c=relaxed/simple;
	bh=y9apfKBKHuZX2aKnnK4xJ8f7amO8VAVaexY/s1uhizM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Shnvdo76sL7kmdg0u67AyS+pZI49LBU6uz6t376crs7n52tHE/PzoCjC4gAVDa3kRO4pBcCG07QxGq/MGzF43+Yy+bxcZl+6BPCyZWXfmpwmwezdpMKEc2gDWc8AhR4iJvjlcqiyhjI+BXOKBVWGgRX6GkvZjadQDWNkatLSRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfJ8kIC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfJ8kIC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93661F000E9;
	Sun, 16 Aug 2026 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786896453;
	bh=bgyP5Gwux8Jvs8xIiUxw7T3e8FKIh3N5oWFA0SLGgHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VfJ8kIC7bHIgF+FXBGef23uLdVkEEALXsLsEGQb7pSEVBrfPV75A4B02sXIR+SlSa
	 0vtkwtBUkqEzV6h+pB17oEAnyonBAHQ9zABh8mo6m6uxY0gAKbHQmQsWITL8fterot
	 lov+0Q139XnjAYndfAk6z1fcle8+t7rPhv/SXNrg7V1r2BZf26DOFh6wpITbKjrvE/
	 Mp3eEXVOlb01QQMS7sZNCpVJHGAh+hJF/c6VsDGM91G4UY7XEksFIX5OwL1xHC6EvS
	 tm+ZPV/NCHps/TiCCxEEfJlBxjyhGcFajnLqa31F9pMXWkGeDTHE9JYxUHZbMj9qv2
	 RrJzKojp1lo4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net/iucv: take a private, writable frame before
 rewriting it in place
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me>
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
 <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 16:07:32 +0000
Message-Id: <20260816160732.E93661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected socket state modification from softirq context
--

--- Patch [2]: [PATCH net 2/2] net/iucv: take a private, writable frame bef=
ore rewriting it in place ---
commit 656ba922e59efdf102e7aa3950857e3c0061f9b8
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: take a private, writable frame before rewriting it in place

This commit modifies afiucv_hs_rcv() to take a private, writable copy
of the socket buffer before rewriting the frame in place. It unshares
the skb and uses skb_cow_head() to ensure enough headroom.

Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1=
200533e@proton.me?part=3D1

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index e3ec965d96ca7..10cfc5e82f047 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2069,11 +2069,20 @@ static int afiucv_hs_rcv(struct sk_buff *skb, str=
uct net_device *dev,
>  		return NET_RX_SUCCESS;
>  	}
> =20

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing this file I noticed
an unprotected socket state modification:

net/iucv/af_iucv.c:afiucv_hs_callback_txnotify() {
        ...
        if (sk->sk_state =3D=3D IUCV_CONNECTED) {
                sk->sk_state =3D IUCV_DISCONN;
                sk->sk_state_change(sk);
        }
        ...
}

Does this modification risk corrupting the socket state?

When qeth hardware issues TX completions, qeth_notify_skbs() is called from
softirq (NAPI) context and invokes afiucv_hs_callback_txnotify().

This modifies sk->sk_state directly without acquiring the socket lock
or checking sock_owned_by_user().

Could this lead to missed state transitions or concurrent execution with
process-context operations that assume exclusive access under lock_sock()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-b4-disp-dc=
82fde4-v1-0-e83b10b22ce9@proton.me?part=3D2
