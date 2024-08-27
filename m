Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62918AE4;
	Tue, 27 Aug 2024 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730617; cv=none; b=WsbAgKX6aTUYWWytdfrRHYvM7HNY4gY3y/FZBw0CXm1yABAbGnq5ujiOxdzyOmNekok6U1bx3xOnLLQiIlAhFS+TsAQGPurzNoWhxLVJ8Yz6+xpouGCk7z0yuBbjK6J3Wt1mpdyPpulmEQVHOzs2dIjJvUjzp+KxmZeyor+ZVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730617; c=relaxed/simple;
	bh=ct237ptWjdB4jDzLrNttZ6cueJsfldCuq2oozNM2LgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rgp11eHm4IYEXJFAYxs/7rMikNoZoB4eC9pjFax7g/XEgSiGbHg8Hb5A9ziMK3+PysUyh4wSIdnB8Fc1yexRs2fA2YAzlGtFP6L7fibPAB15OQLLL3J+Mb6ZPS64AFW48SVkQb8ZUO8eZBaidg2AD9wZQk+MQAzyiJ4LEYVm7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0eiuPho; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0eiuPho"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39b0826298cso17982545ab.2;
        Mon, 26 Aug 2024 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724730614; x=1725335414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAXUgwXZ/Qq7vVTFEv6JHc8ifGQco39iwYhxaM2uIf4=;
        b=g0eiuPhoCUBKA2CV/4B02U3XxQdO5BBKoYojfxdv6hL/mptd+LKLXk09EbEJBoVNV2
         +QqHNXs2DsBOezYaUx+mjWsANoZFTwPZk+RKpw2ZTAy8VO0MoGRxntANPHQQh1RgaJR/
         SZLwCkkzV+ybGzB9ylRuxS+90B9Ct+JJygbpNbNTbnToX+cjWVe4lToyOyx+nOw43KQz
         zvG/bZA4OERsjl/XaZL88Fns3x/FQiJkoNXbqsdKJXWCurDGh+W3nE3pOdW2f6TTXdrP
         iB2Is/QgR3+HTV7YmyifgXw5x29/dURs/ZoAIP+IhcbJH3Uy+C2xHURRvrZsS4d9tzdD
         dwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724730614; x=1725335414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAXUgwXZ/Qq7vVTFEv6JHc8ifGQco39iwYhxaM2uIf4=;
        b=fK+LFLBpiGI+brz1PzNzhQPsihmGpot98L+zsd60pDh7f4SVu4cERljH+CRgZbGU+H
         6YBrMzHO//S7inQv3m4fnV1G4JpwZ8imTiuMBwZ/PN8DlQun9RPVSMp5jLWFtGlT7rwm
         E3Fdd/LmLZyV4I7ss9P3y0z/bqSTqvrT6WVK5hBaAoegmKkjcFT4mW5kh0hRP0WEo2Bl
         z1l9uZl80G6w9VNN4jxYussZ3lgnnbaArPS8FexZ4uxJuSbbtYzxSNTZ+KahiU0u0IcP
         6pmTGYl5QRB6d0CZ+FeK5tN+tELKL0PoARI3aErVbQNn0Jsl4jpjebMN+YggxOQ4NsZT
         i8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWLocHjzvzuYjDJgPcyDTDrFeuTNl5znjRA5HHSIiEfU+s+B1PENs/QEB0cDSpt6Ux8of9L3V+J@vger.kernel.org, AJvYcCXRJo4/Dut0eLxzumQRgDli7kbeb08rzwkp+eFl6I9HdaIOGYAkcvmT6eFBPM0ADO6yyGngJw6ALOOQsw==@vger.kernel.org, AJvYcCXpC+jFVvEr9HyryypNaD970kDRlvQEL0LzUSpbnZ16KAHUXaZZAvnFK/2ZrfFUd1ATRNOmpaOXIViPDDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybsbsW+TjS7XUr1L5KGg/LBMMtdYiDlshzZ1eESqrWC9l+2+up
	htjO1rJDkf2XY89AhshZBsqyTgioiZ97b1KrV2c7kBW0eKLw/jJF
X-Google-Smtp-Source: AGHT+IFWnGZMFhalb255sfHb5fPwt66w1/5HjEqmfHapuEVndVH1nQsCjqVYY/Edle6+Rr8adv3wsA==
X-Received: by 2002:a05:6e02:1c09:b0:39d:46f6:b92e with SMTP id e9e14a558f8ab-39e3c982e21mr127514795ab.11.1724730614369;
        Mon, 26 Aug 2024 20:50:14 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422eab8sm7670247b3a.41.2024.08.26.20.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:50:13 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jaka@linux.ibm.com
Cc: aha310510@gmail.com,
	alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	ubraun@linux.vnet.ibm.com,
	utz.bacher@de.ibm.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
Date: Tue, 27 Aug 2024 12:50:05 +0900
Message-Id: <20240827035005.159504-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <edfc4840-48ef-4d91-b1f8-b65b3aa4e633@linux.ibm.com>
References: <edfc4840-48ef-4d91-b1f8-b65b3aa4e633@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Jan Karcher wrote:
>
>
> On 26/08/2024 04:56, D. Wythe wrote:
> >
> >
> > On 8/22/24 3:19 PM, Jan Karcher wrote:
> >>
> >>
> >> On 21/08/2024 13:06, Jeongjun Park wrote:
> >>> Jan Karcher wrote:
> >>>>
> >>>>
> >>
> >> [...]
> >>
> >>>>
> >>>> If so would you mind adding a helper for this check as Paolo suggested
> >>>> and send it?
> >>>> This way we see which change is better for the future.
> >>>
> >>> This is the patch I tested. Except for smc.h and smc_inet.c, the rest is
> >>> just a patch that changes smc->sk to smc->inet.sk. When I tested using
> >>> this patch and c repro, the vulnerability was not triggered.
> >>>
> >>> Regards,
> >>> Jeongjun Park
> >>
> >> Thank you for providing your changes. TBH, I do like only having the
> >> inet socket in our structure.
> >> I did not review it completley since there are, obviously, a lot of
> >> changes.
> >> Testing looks good so far but needs some more time.
> >>
> >> @D. Wythe are there any concerns from your side regarding this solution?
> >>
> >> Thanks,
> >> Jan
> >>
> >
> > Well, I really don't think this is a good idea. As we've mentioned, for
> > AF_SMC, smc_sock should not be treated as inet_sock.
> > While in terms of actual running logic, this approach yields the same
> > result as using a union, but the use of a union clearly indicates
> > that it includes two distinct types of socks.
>
> Fair. I understand both sides here and i do not have a strong opinion.
> One is kinda implicit, the other defines fields we do not use...
> Of course there would be a compromise to define another struct something
> like this:
>
> struct smc_sock_types {
>         struct sock             sk;
>         #if IS_ENABLED(CONFIG_IPV6)
>                 struct ipv6_pinfo       *pinet6;
>         #endif
> };
>
> struct smc_sock {                               /* smc sock container */
>         struct smc_sock_types   socks;
> [...]

If absolutely must use the sock structure in smc_sock, I think it would 
be okay to modify it like the patch below to avoid a lot of code m
odifications.

---
 net/smc/smc.h      | 3 +++
 net/smc/smc_inet.c | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..ad77d6b6b8d3 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -284,6 +284,9 @@ struct smc_connection {
 
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct ipv6_pinfo	*pinet6;
+#endif
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..a5b2041600f9 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -60,6 +60,11 @@ static struct inet_protosw smc_inet_protosw = {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+struct smc6_sock {
+	struct smc_sock		smc;
+	struct ipv6_pinfo	inet6;
+};
+
 static struct proto smc_inet6_prot = {
 	.name		= "INET6_SMC",
 	.owner		= THIS_MODULE,
@@ -67,9 +72,10 @@ static struct proto smc_inet6_prot = {
 	.hash		= smc_hash_sk,
 	.unhash		= smc_unhash_sk,
 	.release_cb	= smc_release_cb,
-	.obj_size	= sizeof(struct smc_sock),
+	.obj_size	= sizeof(struct smc6_sock),
 	.h.smc_hash	= &smc_v6_hashinfo,
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--

Regards,
Jeongjun Park

>
> That said, don't know if i like this either.
>
> Thanks
> - Jan
>
> >
> > Also, if you have to make this change, perhaps you can give it a try
> >
> > #define smc->sk smc->inet.sk
> >
> > This will save lots of modifications.
> >
> > Thanks,
> > D. Wythe
> >
> >>>
> >>>>
> >>>> The statement that SMC would be more aligned with other AFs is
> >>>> already a
> >>>>    big win in my book.
> >>>>
> >>>> Thanks
> >>>> - Jan
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Paolo
> >>>>>
> >>>
