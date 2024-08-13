Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031417C7CC;
	Tue, 13 Aug 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541516; cv=none; b=aQ7qzLG8ejmCB7BCXB14wJcO3bbLXTlgVP1QKS3MjRQk+Yk+Xl5vdv/7Pu++eyH6E4LfNJPxGDCsBTLncjQ144zD57/IB+kcVJFcRgBFFmmIF0jkZAIjjbCdfiUOcz9oV6whJzqkYuNIF4BtqMMXf86rQmXN2BdQYVoFsaELOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541516; c=relaxed/simple;
	bh=OJtM7QuA+FTUJm2AUnYIgvlJxFP7SRKBskfsRzvpuQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwFtTY412HTylmssytSKt8/TKQb86nPwWZ0mBZsLsq65jEF4boHP5c032H68+azwfv9lg9FfVFI45eyOceFDuUrDPcad2L8CHcqKGI09TH9GD8qVI2bU+U58G77JznrYZDL1SZwPQRG7UajFA4rP0aaIdokLG6ANzhpzLGIZs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHlzNg10; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHlzNg10"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd9e70b592so39547085ad.3;
        Tue, 13 Aug 2024 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723541514; x=1724146314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35gPZlKK15jUEgTaWSZkIPQe/ceudO5mMDu9MAQSfWQ=;
        b=HHlzNg10OQ7TfZ6lViElTVMAtTrDHcRWMyCrnnfKj+VXTqOyMdjgxMlKjFUD3HE2R+
         SFPpo4elVxbK1IQOOvrqGQ4B/3RPiSIGHdftJC7j0AdarrAS7cr2vZd9w6zY2RnE2MsH
         S5e/ehiIoNOuV2FfhDZl9NeVyVdBNoBd78HfIl0RFASvD6Fz1ecr2/yi0FxBvKsnif39
         vTwvZdpgnx0lCh8CLv3t/CXEEwtD/LwsWEtR0WX683JCuBD4xcIilUU4yvXaANLN4rZU
         w9Utc+8tGFoZCdSU0g4HKbzzdnscASHQdkb7+uf2oL5iGChyHunyysHV6Na+1SXCs8/L
         ULrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541514; x=1724146314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35gPZlKK15jUEgTaWSZkIPQe/ceudO5mMDu9MAQSfWQ=;
        b=adiv4MRkBfDTGo61tpZXLieLoo6WW/m15pq+wRPK+A7+unR8KbqQJiPnj17EahtRJb
         jnBol7skOuAD4xf1Akqy3hpZXwpWtfhD7DcEYtU86AWr3SJqZXFBPkGJYJPjxuCiqtQn
         EIu8vzCiRWMgg4Szfj3hEfMRlHMGgFL3Mc+WdPc5uUSIRxt5OiyoaHe69HwwuGaB98g4
         ldZX2CDsTL/yt6u2Eer8q+HYmzeiY8awOtMTE9hMw0WxQ0hBP9lHxftGlxTdq+gS1qxu
         5FhH2XlO33DZC6jWVkl9GF05wMZrexkWeHk7noyN1M3jy9KprY1Mj3lzOW3SdBeEzaq3
         9Eaw==
X-Forwarded-Encrypted: i=1; AJvYcCX/cUs9JeM6gWMlCehpe0kpNvPdGud6fVWtof6O8acXu6MCqt7FWKv4cEQ2QcZ70TwU3RMT7yUohY1/5dcl4rzacOC0uLMwbJaYsZHW/Y7EIFkIHprapj8zuEKpYkZnmidXHAQzQSwP8YCElPpJ+Gvo9v5eG0lEuVaMNRpyjqtRYg==
X-Gm-Message-State: AOJu0Ywz8Ysa4rUhkUTBZpGWlMvW8OtnhGgin2RlN41w+sVhMImb9ytw
	Skh/51CzCHEwziFI4Zz7dfouDoAgHmsbUvz0JwdtQ0Ko7DMGFsPJ
X-Google-Smtp-Source: AGHT+IGgdJRnPNtIKrI3UOQ8wFxysKdGOtOO8vdWkSDuDxaJQhAUIsF0G70EOs1HhHSWjq93ibQosw==
X-Received: by 2002:a17:903:18a:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-201ca1ca1d6mr40370655ad.48.1723541513614;
        Tue, 13 Aug 2024 02:31:53 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cfe91sm9549405ad.291.2024.08.13.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 02:31:53 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: alibuda@linux.alibaba.com
Cc: aha310510@gmail.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	gbayer@linux.ibm.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH net] net/smc: prevent NULL pointer dereference in txopt_get
Date: Tue, 13 Aug 2024 18:31:47 +0900
Message-Id: <20240813093147.175682-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4ccf34a0-3db2-4cbf-a9b2-cf585af8c63a@linux.alibaba.com>
References: <4ccf34a0-3db2-4cbf-a9b2-cf585af8c63a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

D. Wythe wrote:
> On 8/13/24 4:05 PM, Gerd Bayer wrote:
> > On Sun, 2024-08-11 at 02:22 +0900, Jeongjun Park wrote:
> >> Since smc_inet6_prot does not initialize ipv6_pinfo_offset,
> >> inet6_create() copies an incorrect address value, sk + 0 (offset), to
> >> inet_sk(sk)->pinet6.
> >>
> >> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock
> >> practically point to the same address, when smc_create_clcsk() stores
> >> the newly created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6
> >> is corrupted into clcsock. This causes NULL pointer dereference and
> >> various other memory corruptions.
> >>
> >> To solve this, we need to add a smc6_sock structure for
> >> ipv6_pinfo_offset initialization and modify the smc_sock structure.
> > I can not argue substantially with that... There's very little IPv6
> > testing that I'm aware of. But do you really need to move that much
> > code around and change whitespace for you fix?
> >
> > [--- snip ---]
> >
> >
> >> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >> ---
> >>   net/smc/smc.h      | 19 ++++++++++---------
> >>   net/smc/smc_inet.c | 24 +++++++++++++++---------
> >>   2 files changed, 25 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/net/smc/smc.h b/net/smc/smc.h
> >> index 34b781e463c4..f4d9338b5ed5 100644
> >> --- a/net/smc/smc.h
> >> +++ b/net/smc/smc.h
> >> @@ -284,15 +284,6 @@ struct smc_connection {
> >>   
> >>   struct smc_sock {                          /* smc sock
> >> container */
> >>      struct sock             sk;
> >> -    struct socket           *clcsock;       /* internal tcp
> >> socket */
> >> -    void                    (*clcsk_state_change)(struct sock
> >> *sk);
> >> -                                            /* original
> >> stat_change fct. */
> >> -    void                    (*clcsk_data_ready)(struct sock
> >> *sk);
> >> -                                            /* original
> >> data_ready fct. */
> >> -    void                    (*clcsk_write_space)(struct sock
> >> *sk);
> >> -                                            /* original
> >> write_space fct. */
> >> -    void                    (*clcsk_error_report)(struct sock
> >> *sk);
> >> -                                            /* original
> >> error_report fct. */
> >>      struct smc_connection   conn;           /* smc connection */
> >>      struct smc_sock         *listen_smc;    /* listen
> >> parent */
> >>      struct work_struct      connect_work;   /* handle non-
> >> blocking connect*/
> >> @@ -325,6 +316,16 @@ struct smc_sock {                               /*
> >> smc sock container */
> >>                                              /* protects clcsock
> >> of a listen
> >>                                               * socket
> >>                                               * */
> >> +    struct socket           *clcsock;       /* internal tcp
> >> socket */
> >> +    void                    (*clcsk_state_change)(struct sock
> >> *sk);
> >> +                                            /* original
> >> stat_change fct. */
> >> +    void                    (*clcsk_data_ready)(struct sock
> >> *sk);
> >> +                                            /* original
> >> data_ready fct. */
> >> +    void                    (*clcsk_write_space)(struct sock
> >> *sk);
> >> +                                            /* original
> >> write_space fct. */
> >> +    void                    (*clcsk_error_report)(struct sock
> >> *sk);
> >> +                                            /* original
> >> error_report fct. */
> >> +
> >>   };
>
> Hi Jeongjun,
>
> I have no problem with this fix, thank you for your assistance.
> But, what this here was for ?

Sorry for the confusion. It looks like the tab character was accidentally 
used. We will fix that and send you a v2 patch.

>
>
> >>   
> >>   #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> >> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> >> index bece346dd8e9..3c54faef6042 100644
> >> --- a/net/smc/smc_inet.c
> >> +++ b/net/smc/smc_inet.c
> >> @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
> >>   };
> >>   
> >>   #if IS_ENABLED(CONFIG_IPV6)
> >> +struct smc6_sock {
> >> +    struct smc_sock smc;
> >> +    struct ipv6_pinfo np;
> >> +};
> >> +
> >>   static struct proto smc_inet6_prot = {
> >> -    .name           = "INET6_SMC",
> >> -    .owner          = THIS_MODULE,
> >> -    .init           = smc_inet_init_sock,
> >> -    .hash           = smc_hash_sk,
> >> -    .unhash         = smc_unhash_sk,
> >> -    .release_cb     = smc_release_cb,
> >> -    .obj_size       = sizeof(struct smc_sock),
> >> -    .h.smc_hash     = &smc_v6_hashinfo,
> >> -    .slab_flags     = SLAB_TYPESAFE_BY_RCU,
> >> +    .name                  = "INET6_SMC",
> >> +    .owner                 = THIS_MODULE,
> >> +    .init                  = smc_inet_init_sock,
> >> +    .hash                  = smc_hash_sk,
> >> +    .unhash                = smc_unhash_sk,
> >> +    .release_cb            = smc_release_cb,
> >> +    .obj_size              = sizeof(struct smc6_sock),
> >> +    .h.smc_hash            = &smc_v6_hashinfo,
> >> +    .slab_flags            = SLAB_TYPESAFE_BY_RCU,
> >> +    .ipv6_pinfo_offset = offsetof(struct smc6_sock, np),
>
> Since you have done alignment, why not align the  '='.
>
> > The line above together with the definition of struct smc6_sock seem to
> > be the only changes relevant to fixing the issue, IMHO.
> >
> >>   };
> >>   
> >>   static const struct proto_ops smc_inet6_stream_ops = {
> >> --
> >>
> > Thanks, Gerd

Regards,
Jeongjun Park
