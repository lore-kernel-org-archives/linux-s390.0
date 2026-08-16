Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6034250E
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786888519; cv=none; b=Y+832/q+DpVzywsB7ZAAN0ZbHTu2dG3lFowIPVEcZgUIKRPujRmJXzIxtA3ZzjOxL89mcsppbl60qt0eRPwMVvTRXUOiipvPXI99g1mIpC4WO4dvoUhuYjZFt5oenm33mouzC4Y1Z37u9tbEUssZrEHT861hbNywfmS51Hzw7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786888519; c=relaxed/simple;
	bh=XQAEhA1c5F16fnM9McgpPO9psGvleFpXRX3BQJKUlGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Twoxy4iLy6C652qEefhSC8gO6x+hNiSd9KbsBsZ52zU0i48WkCS5W610gdERAhKa3E43kS61KMRyY8wtkb+v1i7o+RmAtEMrp/ti6yUIvVpkY+zvRJZMZeIQTlKUIgzwkIEOFR2IRiNBStVyFers9yEhV3JKJHUMXgomKa1QOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPe3XP6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPe3XP6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816271F000E9;
	Sun, 16 Aug 2026 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786888517;
	bh=HpN6PKFDSdqIsAHT59DxQF7uLed67spzKThjd03fT1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPe3XP6HA11bVp89hwgGLajZCf3QWmWxHc/ubyU7YPGlUslJu8ltaN31RCImcVi8t
	 8jbbWeGoC/6qV1tN2SeYa+/HRdatsuFIpoZ7uXgnRAoFRRODQWAfEQkuFR47OWDmA3
	 YgM74ans19SnzBLKaLV5dv4uHuZLptugn9ALqpa1OivNauJjGxeNMjL+FYcfsVLnUh
	 aVlV6Ggdf7PD58B2M9+wdK2IOuGeL5GfeB3IoCpoMhOQDNARNgkz0Wcb8wxGwnSGbF
	 AEPlx+dxafwxHj94Eqx86HfDXdxD8bBrPiEVhZMRzvMellU8z0FlKpuMFCm/bOUTeU
	 YuYA6QgGamcyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/iucv: descend into net/iucv independently of
 IUCV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260815135456.53684-1-pengpeng@iscas.ac.cn>
References: <20260815135456.53684-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 13:55:17 +0000
Message-Id: <20260816135517.816271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional descent into net/iucv/ causes a vmlinux linker error=
 when CONFIG_AFIUCV=3Dy and CONFIG_IUCV=3Dm.

Pre-existing issues:
- [High] Packet handler modifies and queues shared SKBs without ensuring ex=
clusive ownership, causing list corruption and data corruption.
--

--- Patch [1]: [PATCH net v2] net/iucv: descend into net/iucv independently=
 of IUCV ---
commit e7b1f87fb6bb063631fc940969ffda9c69434171
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

net/iucv: descend into net/iucv independently of IUCV

AFIUCV can be enabled as either built-in or a module through QETH_L3 even
when IUCV is disabled. The top-level net Makefile currently descends into
net/iucv/ only under CONFIG_IUCV, so the valid configurations
CONFIG_AFIUCV=3Dy/m with CONFIG_IUCV=3Dn never consider af_iucv.o.

> diff --git a/net/Makefile b/net/Makefile
> index 5b2dd7f07a85e..c0da946b281e1 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -45,7 +45,7 @@ obj-$(CONFIG_WIRELESS)		+=3D wireless/
>  obj-$(CONFIG_MAC80211)		+=3D mac80211/
>  obj-$(CONFIG_TIPC)		+=3D tipc/
>  obj-$(CONFIG_NETLABEL)		+=3D netlabel/
> -obj-$(CONFIG_IUCV)		+=3D iucv/
> +obj-y				+=3D iucv/

[Severity: High]
Does unconditionally descending into iucv/ cause a vmlinux linker error when
CONFIG_AFIUCV=3Dy and CONFIG_IUCV=3Dm?

Before this patch, Kbuild descended into net/iucv/ as a module (obj-m),
compiling af_iucv.o as a module. With this change, af_iucv.o is compiled
into vmlinux when CONFIG_AFIUCV=3Dy.

However, af_iucv.c contains:

net/iucv/af_iucv.c:afiucv_init() {
    ...
    if (machine_is_vm() && IS_ENABLED(CONFIG_IUCV)) {
        cpcmd("QUERY USERID", iucv_userid, sizeof(iucv_userid), &err);
        ...
        pr_iucv =3D &iucv_if;
    }

Because IS_ENABLED(CONFIG_IUCV) evaluates to 1 when CONFIG_IUCV=3Dm, the
built-in afiucv_init() will emit an external reference to iucv_if (which
resides in the iucv.ko module), leading to an undefined reference linker
error.

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the IUCV
code, I noticed a pre-existing issue in the AF_IUCV packet handlers.

Could the packet handler corrupt memory by modifying and queuing shared SKBs
without ensuring exclusive ownership?

When a HiperSockets AF_IUCV packet is received by afiucv_hs_rcv() while a
packet socket like tcpdump is concurrently active on the same interface,
the network core passes a shared or cloned SKB to the handlers.

afiucv_hs_rcv() and its callbacks modify the packet data in-place without
calling skb_share_check() or skb_unshare():

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    ...
    EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
    EBCASC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));
    ...
}

The same happens in the callbacks before transmission:

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    ...
    skb_push(skb, ETH_HLEN);
    memset(skb->data, 0, ETH_HLEN);
    ...
}

Furthermore, it enqueues the shared SKB directly into the backlog:

net/iucv/af_iucv.c:afiucv_hs_callback_rx() {
    ...
    skb_queue_tail(&iucv->backlog_skb_q, skb);
    ...
}

If the packet socket also enqueues the SKB, the SKB's next and prev
pointers are concurrently overwritten, which can lead to list corruption
and a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815135456.5368=
4-1-pengpeng@iscas.ac.cn?part=3D1
