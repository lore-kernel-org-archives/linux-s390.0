Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3710F4;
	Tue, 20 Aug 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157035; cv=none; b=Eg+3JqPa6h2Rzqf/hgXfaCo1nRM/IGvYwBlBiLpw/0TDMT4szgwpINv2XREsSMqgt9j/WVroc9oq7X8Y3W8oqmiibTusILjSz/MBvd72TVjJfY/Z6WPTG+bFIep6mhXfFGFlPhvs3b3OwjGTbu9siOJHkY6Cr+gBUqiV7Dn4ORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157035; c=relaxed/simple;
	bh=EPO7sxDfECUl81PRwQ5c2+xh+Wg6Fp82gY7TKAkiFDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPaZ4SMRvo37IWB9UPVKQbCQYszN9BLK9D1ngxFQtpDF2m8u70dWU8zfYs44+rLs4zpVgYMgl/1xnVqb7uEzlx17L43PyJGHKZRQeDPQQ80O6GC9NtW3EctKfuk3IBnfsR87V3KQ73gJ64b/f+3HxI/rzp+07ph/NG5dW52759M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvKM4N/n; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvKM4N/n"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so41474386d6.1;
        Tue, 20 Aug 2024 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724157032; x=1724761832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GUVLT7Lr8a8VUjwmWyFcHbjj2T0BS/10mTwTLlgLpKM=;
        b=UvKM4N/nOacTq1jn0ldItKInbB4+ACy5b+YfDLbwKmdYf3KxhZZ/NFfp814/UtEGzP
         71bjfb1iaaCChZPow/xsA9HAWomPehFfZ3O+LxJnrKgIG4vACV4x4yj33ZVjpubHtPQ0
         lmmyp2Vn0DX1tVYU3+9k6sZ6Ty9o3gmYudypoSAGQGekjHP2PUKttn30l42DD4juov1G
         LxWSL3HU8gYDk4uIjTEMG1Zad9LcDH+771Rn1rQ2C37+8h1vIY7BKPAxdFnwZvmQvP5r
         Mm7a+BvXvZa8pD30QB60HJ/o8jgciPLkdz/vS0A3mVpmG5iQn97v/GTGg5XKOBWD2K2U
         W2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724157032; x=1724761832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUVLT7Lr8a8VUjwmWyFcHbjj2T0BS/10mTwTLlgLpKM=;
        b=jIODz7tiCaWXTW0opDzTkCBIUd7rCP+/YTTsYm9g6sszAJHs0sMsgiLje9dmbyCAQF
         iE/3zOnyPOqcudpUpSWYn/oggzo/cEwEQGfF6bVAbhk86zwE0t3FwP6cKjFJIgcl3bSy
         h7UVU9axou3xC5unvjNMD/vMvDYpH88P3iUjyw8GL0gei7mmeABYKUnQ5hP++1P6vg7i
         q2ytnrqyoGidtm4UikClXE7sj11hwOanoOL2C9/z2uQei0ucJokYn76NR7MubxjLcl0N
         tdyZIEmRBAM9xmQhastRqSBCbkujmZ4LwbGcl6eD1kQspXYUvx+H0hl21m9Ri3C03xQQ
         HHEA==
X-Forwarded-Encrypted: i=1; AJvYcCUT3fx6t+P9ddtt+Cr/0hrRhxEPQJVSBphvWLicT73t8ydL6a0bbMzR1Vk/8v579CgEwZpHJXRPWEG3vA==@vger.kernel.org, AJvYcCVDcKo7Y8C8z4SjTpLc1Kk5/Ft6C32axiUN9NIXIVvMnBRlTDQc0ra1/VgeGhAEmTT8+rOqCmoUo4TDCyM=@vger.kernel.org, AJvYcCXXIbLFulRUXcFl9SBi9CHFIu2v9nCKWS8iikpq76QgJxSS7BzrYaFjd7Z7gZ0lXG7giF66ZKMO@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSiyr4eoLab3nQBdsw+QWT7W7d+kvXC1uoH1yS9w9HFq3eVCY
	l5aw74ZMOMpVIahRh776/3xUKnPOoQIz85w/hwgo3LgMSDecheMjRCv5aFeiiuahAuYkzCIwnbN
	a1HxR3D9n+o+ohhuJUercR4U4CmAW49wSS2o=
X-Google-Smtp-Source: AGHT+IEtdEFUB9cHd4F2rUXhzKykUPBOkRnfVOYYkiqIXNfaZr9MDZ+O2xAv3ufc1v7BgzmziANuPVFZOwTFOQ6k5MI=
X-Received: by 2002:a05:6214:481:b0:6b7:923c:e0b7 with SMTP id
 6a1803df08f44-6bfa8a689ebmr58386916d6.21.1724157032477; Tue, 20 Aug 2024
 05:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820121312.380126-1-aha310510@gmail.com> <20240820121548.380342-1-aha310510@gmail.com>
In-Reply-To: <20240820121548.380342-1-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 20 Aug 2024 21:30:19 +0900
Message-ID: <CAO9qdTHyj_vUEtixmpiO-VPzBUBAggx2VWjvvzjtmgs2qSGbLQ@mail.gmail.com>
Subject: Re: [PATCH net,v6,2/2] net/smc: initialize ipv6_pinfo_offset in
 smc_inet6_prot and add smc6_sock structure
To: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, utz.bacher@de.ibm.com, dust.li@linux.alibaba.com, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park wrote:
>
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
>
> To solve this, you need to create a smc6_sock struct and add code to
> smc_inet6_prot to initialize ipv6_pinfo_offset.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  net/smc/smc_inet.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index bece346dd8e9..26587a1b8c56 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c
> @@ -60,6 +60,11 @@ static struct inet_protosw smc_inet_protosw = {
>  };
>
>  #if IS_ENABLED(CONFIG_IPV6)
> +struct smc6_sock {
> +       struct smc_sock         smc;
> +       struct ipv6_pinfo       inet6;
> +};
> +
>  static struct proto smc_inet6_prot = {
>         .name           = "INET6_SMC",
>         .owner          = THIS_MODULE,
> @@ -67,9 +72,10 @@ static struct proto smc_inet6_prot = {
>         .hash           = smc_hash_sk,
>         .unhash         = smc_unhash_sk,
>         .release_cb     = smc_release_cb,
> -       .obj_size       = sizeof(struct smc_sock),
> +       .obj_size       = sizeof(struct smc6_sock),
>         .h.smc_hash     = &smc_v6_hashinfo,
>         .slab_flags     = SLAB_TYPESAFE_BY_RCU,
> +       .ipv6_pinfo_offset      = offsetof(struct smc6_sock, inet6);
>  };

Oh, I didn't check for typos properly. I'll fix the typos and send you
a new patch tomorrow.

>
>  static const struct proto_ops smc_inet6_stream_ops = {
> --
