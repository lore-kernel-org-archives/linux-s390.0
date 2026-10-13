Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DE4FECC3
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896762; cv=none; b=g7cP9lP3PPpZ10Qrp7JqRDYK0kuwqyKEZzCluGrlOad/ZmapOkViZfIbVwK+GxZnW74DhFi6t0fjSHIqu8LeSYBokrx+t3n96EQ/a8T97gXWjlXrIOTvOawSY30GUZnNC41IRnRQxIdoF+7vccMjq5ZDdUNCZJ8rc28ZIBNKJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896762; c=relaxed/simple;
	bh=KsD1LVlw+1Kr1B587KDn1/9Ew+g5GADS5l3OjuXK7ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAhr77x2deB4dJHrgfWTXl8WZlDTxiN56/b+bjqKUFYue+2JqX+FQGGwNsRNrunj987mgHPsrd1tepNgjUdGq56ZnilMN0zv/O1gfMxei+S0C5oCbnLWyHkh7+XvqWxT9NfXAQWePbRdoiWtUArLZiarhvPEowNhT7KoqKJGbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I87Id51I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOLkC7q3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I87Id51I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOLkC7q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791896760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdqiLExlH2Tq6MbaQcUrlE9HuVHbfGn9a51KFwL/x4o=;
	b=I87Id51IG20miEiQV/cPLb+NOILYA8fBf2e/YmG/YxDvdYdJBKYRG2uUtkhk4tTPDvjxAp
	UkYe0euhRaA9NY12QVXkjslkJOnVYh1rI4eGfJgSWC7PXlMBaEDfz4Qb9umMHIaynN44C7
	5vGtH7Mac1gJlJycKGIoR1G3APvPEnc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jlq9auSePWOjPIVYgIDnvg-1; Tue, 13 Oct 2026 13:05:58 +0000
X-MC-Unique: jlq9auSePWOjPIVYgIDnvg-1
X-Mimecast-MFC-AGG-ID: jlq9auSePWOjPIVYgIDnvg_1791896757
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c31952e5afaso270544966b.0
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791896757; x=1792501557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdqiLExlH2Tq6MbaQcUrlE9HuVHbfGn9a51KFwL/x4o=;
        b=NOLkC7q3UbXll/teOj7+3Ab/cedrWqyI9CYFPosKe2IWUsGYlAw4S+2QbR5mQJ1eTz
         MRrjnvuoYI3B30wuRZjONCPgQ0yNpv9eKblRtk5cFOBp617E3t+wIxa0/1aKYDikLYhO
         uGxvm557/q7m5yQ5cTfG7WQKo6PcGB6dVu1+w6xRta067MKN5sHaAM5Z0FToUp6iYFbl
         jC6KH9bdP6oOxTGgcYM0+lRZXx3Os9LgPc50ksvSTGBV2PZTWXpJ4+p0xFJzDbA8WJ4/
         TrCyLZFNo5vBt6hdh2JDKXhF27/+QH0jHxTFZ+jGkWVu2sHR+XyATu56ZYOh4mJVw5ry
         l0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896757; x=1792501557;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WdqiLExlH2Tq6MbaQcUrlE9HuVHbfGn9a51KFwL/x4o=;
        b=vnzkwtkxK21ltxfodZtBS3dcOe7W3+HWMfyuUv9ObUFbqBC/X0exGll7c1sz+1RdXU
         c9/Kdv6fAFsv43ZSuiQGTrmsXx3IR5Wp/aGluT41qZbUXdG/N/XtiU0sG/MpqClwSx0O
         LpZQR35Nfx3WuDSlYBhtSrhtNghjvnTf4bTOeltIF9Dt78I4NI0e0r7DGpLVc+oPAwYd
         3tRFCzUbsI2k3TxrabN78RU3ZNtvmIJ7xZYZKwQxhHmhY/F6c5j3f/riRvLkbqb16hQX
         JrjM1guLsgj+FNWzA79yIHVDR3d6XnC5UpCjNBTZz9TCnZF3/TwzJJ/p2ywxdJyng3WJ
         Dnhw==
X-Gm-Message-State: AFq9FYJSvbn3U9F7NG6e/3ew9Bgsegh0AIcdEWet7fmMEEKGNlv3Ay+i
	K1tuUSV6eKn9Of4k95MjzZzVNaBrV48i0xBL/jtINfBvJ16Cxy0SVfgJKvn6FMrbDbG8MSaipf2
	4WYNu8XUQy8ueQvPZ9wwEmngLQzsszZM+Feru4mXUThuLtI60BoIx4VaBZUUBb28=
X-Gm-Gg: AYBFou0RwGENXjKuGND4Vo7vq+bG2D8u5aibNF354dhriFoRXBSPxlhEjOBV9La9yU4
	eHEvV/WhUIulMV84fpTj5tCYcCRui5xzF3EwuUa+OsTohJUNQC6UVgEscwBCeQZZZMxReGWU+ar
	gR7NmnmaIZPWuqD6aCDUgccbXBnNMTdiR9JteOHuj0ewsDiMT5Xgbmb664DpqWMFBB3lXur4YVb
	wKPz7LoAFPGGbSyM/GJqRPTYFs05+jyusaTKottEiAO3m+GjPLiwxMf/YYc/bHDuwzRsqYRE5cT
	73IQutl8hVaKsFaBGv5ecKVNLQwL5FiuuNdpkPGF7N1VLBWy5QXb8G5wFSUkRn97mwb8SUnvcRe
	rkqpCxWxdHVlL4Cfx6EnKPzdhU/AGPhj+0ynCflpIiVWOcbbQ+YHnVIis3XQs9CzJXrVuLqpNKg
	==
X-Received: by 2002:a17:907:7f94:b0:c2e:34b7:8899 with SMTP id a640c23a62f3a-c31aa0790f5mr1285599766b.30.1791896756652;
        Tue, 13 Oct 2026 06:05:56 -0700 (PDT)
X-Received: by 2002:a17:907:7f94:b0:c2e:34b7:8899 with SMTP id a640c23a62f3a-c31aa0790f5mr1285592866b.30.1791896756079;
        Tue, 13 Oct 2026 06:05:56 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c353033b3a4sm218681366b.57.2026.10.13.06.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:05:55 -0700 (PDT)
Message-ID: <eb32ba07-0a4c-4bc6-acda-36e6b95af89b@redhat.com>
Date: Tue, 13 Oct 2026 15:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/iucv: take a private, writable frame before
 rewriting it in place
To: hexlabsecurity@proton.me, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Hidayath Khan <hidayath@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 11:21, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> afiucv_hs_rcv() rewrites the frame in place -- EBCASC() on four name
> fields, then afiucv_swap_src_dest() swaps them and pushes an Ethernet
> header -- and can hand the same skb to dev_queue_xmit(), without making
> it private first, so a packet socket that also gets the frame reads the
> rewritten names. An ETH_P_ALL tap runs first and leaves af_iucv a
> cloned skb; a socket opened for ETH_P_AF_IUCV sits on a ptype_specific
> list, walked after ptype_base[], so deliver_skb() takes a reference and
> af_iucv runs on an skb that is shared but not cloned.
> 
> Unshare, then cow the head, in that order: skb_cow_head() can reach
> pskb_expand_head(), which has BUG_ON(skb_shared()). Asking for ETH_HLEN
> also covers the unchecked push in afiucv_swap_src_dest(); on the ordinary
> path eth_type_trans() has already pulled that much, so it only compares.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me?part=1
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
> Sorry for the long silence since August: a major earthquake hit where I
> live, and I was finishing a postgrad program. Back now.
> 
> v2: the old 2/2 alone. 1/2 is dropped; Alexandra's 80230a18c164
>      ("net/iucv: filter frames in afiucv_hs_rcv() by ingress device")
>      replaced it and is in mainline. Rebased on net, no code change,
>      carries Alexandra's R-b. Kept on net; Alexandra agreed on v1 to
>      treat it as a fix. The commit message now covers both cases: v1
>      described the ETH_P_ALL tap, where af_iucv gets a cloned skb, and
>      the v1 thread added the ETH_P_AF_IUCV socket, where it gets a shared
>      one. My reply there said v1 had the delivery order backwards. It
>      didn't; both cases are real, and the A/B below shows each call is
>      needed.
> 
> v1: https://lore.kernel.org/all/20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me/
> 
> Tested on s390x under QEMU TCG, KASAN and lockdep on. No z/VM there, so
> af_iucv gets its frames from lo (80230a18c164 filters after the
> EBCASC(), so lo frames still hit the rewrite), and a packet socket
> reads each one back. Unpatched, the tap and the ETH_P_AF_IUCV socket
> both get the 48 name bytes already in ASCII, and a SYN with no listener
> never reaches that socket as a 0xfbfb frame. Patched, every frame
> arrives as sent. Drop skb_share_check() and the ETH_P_AF_IUCV socket is
> broken again; drop skb_cow_head() and both are. FWIW no splat in any
> boot, patched or not -- on lo the damage is in what the other receivers
> read. Builds clean for s390 with W=1. Repro and logs on request.
> ---
>   net/iucv/af_iucv.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af..493dc156e9f5 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2072,11 +2072,20 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>   	int err = NET_RX_SUCCESS;
>   	char nullstring[8];
>   
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		return NET_RX_SUCCESS;
> +
>   	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
>   		kfree_skb(skb);
>   		return NET_RX_SUCCESS;
>   	}
>   
> +	if (skb_cow_head(skb, ETH_HLEN)) {

Sashiko (nipa) noted the above is the wrong helper:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me

you should use skb_ensure_writable() or skb_cow()

/P

