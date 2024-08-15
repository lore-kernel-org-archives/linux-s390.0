Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608F6FC3;
	Thu, 15 Aug 2024 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691727; cv=none; b=fMy61FaruFTpy4+7p9sTZ35IeEWsmRJEolF1u/bgl/Xe5Oq9KKVXvgBc5UOQmhrjuSyO0Td/pdZizeqV5MmcWhivvffl4sTBcvAMzl1SIOrT87VY+hVQp2XWBdCQxPUjgrCFPapoGHH+Ir9HL6OXo3eX+Td8BRu+i+YxmnxNQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691727; c=relaxed/simple;
	bh=+8pEvT4Kr+975J7uHniAljyXE+nSa1o1trJ3UZzOjfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q567axAipoAxDX1Cahc2gWNo225tzzupt6e34cJ7Ke8kCjGUuN2I9haz8NitMyyKhtmdgMqj2ruPMJVkO/T6dLNg9pdcFtRBs33NamNBebfNh24AymwFNNwrIUeLuLnwvYFYoopcwwK9sTib2Hl6RWJh19I48VtCTIFyWCpvxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcSPsOf9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcSPsOf9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3b5f2f621so369234a91.1;
        Wed, 14 Aug 2024 20:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723691726; x=1724296526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtPf+04gKObZUgi4bIGxCdJ2e58CFxBSSmwvE0nQa2Y=;
        b=IcSPsOf9QCgi3ekcuyQ4GFnvdO0LAnUUVLSHl51+IDS1Tu8luDT1ALQA+jnaIwUNgc
         QCfKkUuGA2zMmbQ4E9eSZynyCtQIYbPZ9o4xWUz92IwclJwoMARjxhFaaYnCQO/0KipX
         JLY8oO5F9CQbCIl6cwoFYZnlfYziE/HWbss4bvEydO2/whoTm+aBZdTT/8hC/w4CiS9O
         8o5ZGrBFg0+JdkjlZkaZTi/d9DSHPYAUpEf5C8/rSpEqzN3IqZzf9XLtw3j8P+naWDjg
         aRLTTe3dCL4l8l0Bzcc2BvOeOJuccT783jnjhA3PvxBPdhc4EckntZ21S4PB+j55PHeu
         U+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723691726; x=1724296526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtPf+04gKObZUgi4bIGxCdJ2e58CFxBSSmwvE0nQa2Y=;
        b=AgaPMmqmNs7/Uzg+lEax6WvrDj5S0/vFcl0OIMYab/C5pZGgBdCiEWLnxh7KCDY5aO
         AGDrfGtngsJGyRbev7J9e/SMwNWLG6qvwXON2+aotclgIySVKkE9V47M6U4/urT+F49e
         XMXcxwpGIqJOsN+BlJrVoY27Rca8vMmJIcPZu6WF/SalrLUoCgXp5YGGUi4AzWKKcyVy
         Zxl6Knjuea0ZtN6jSVrblNW6phY0oVTnUQbx1SQRrbywsqlI6o0+5HoY5baET/LdClPt
         5KMN7RnI5vNYoAkLqFRP4Qz9VS1Ugpo0m2Kk2A0JsTUBhg+pPkY5hwGGvTVlGEcHdHjT
         Aorg==
X-Forwarded-Encrypted: i=1; AJvYcCWLJ9VPSvW7hXq/aPKZ51LKr6Mv3DRIXlQdOtdI8ViBOEq0e+xERuyLE+UgrAG9Hf5FnDEm2k5JahS01MzABa03Gq277bdLjlv3jSJLxWtaNQEjz9Vgq25ZJ3k4e5D/x7XGXrb7GvRKYxlUoCQewqFSBM2P7yPsJWJ1iI43OBkz8Q==
X-Gm-Message-State: AOJu0Ywn1QxkFNH1aL5B00dmfIc4iRQRTwmZHHfzDP/1MOqief7MNUtv
	53HxcY7yYxw7u2BIV02C6G68h75QmBzns5DCJdrDv+F86tA8FeQkjNffY+W+vbfd3PTJGBCivk9
	4gFPrf9KKesHWovyrBvtA+QwTpF0=
X-Google-Smtp-Source: AGHT+IFiThIhX+9FhLiAcH6DoPTaT9aFpP6Lkgxy9dJF8YKw8N/bmIWpxt9ge0Vce96c5hJyDA6LFSAG2T3kfQpE3Qo=
X-Received: by 2002:a17:90a:bb8f:b0:2c9:5c7c:815d with SMTP id
 98e67ed59e1d1-2d3aaac3e34mr5518852a91.22.1723691725581; Wed, 14 Aug 2024
 20:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
 <20240814150558.46178-1-aha310510@gmail.com> <9db86945-c889-4c0f-adcf-119a9cbeb0cc@linux.alibaba.com>
In-Reply-To: <9db86945-c889-4c0f-adcf-119a9cbeb0cc@linux.alibaba.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 15 Aug 2024 12:15:14 +0900
Message-ID: <CAO9qdTGFGxgD_8RYQKTx9NJbwa0fiFziFyx2FJpnYk3ZvFbUmw@mail.gmail.com>
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in txopt_get
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: wintera@linux.ibm.com, gbayer@linux.ibm.com, guwen@linux.alibaba.com, 
	jaka@linux.ibm.com, tonylu@linux.alibaba.com, wenjia@linux.ibm.com, 
	davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 8=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:51, =
D. Wythe <alibuda@linux.alibaba.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> On 8/14/24 11:05 PM, Jeongjun Park wrote:
> > Alexandra Winter wrote:
> >> On 14.08.24 15:11, D. Wythe wrote:
> >>>      struct smc_sock {                /* smc sock container */
> >>> -    struct sock        sk;
> >>> +    union {
> >>> +        struct sock        sk;
> >>> +        struct inet_sock    inet;
> >>> +    };
> >>
> >> I don't see a path where this breaks, but it looks risky to me.
> >> Is an smc_sock always an inet_sock as well? Then can't you go with smc=
_sock->inet_sock->sk ?
> >> Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an i=
net_sock?
>
>
> There is no smc_sock->inet_sock->sk before. And this part here was to
> make smc_sock also
> be an inet_sock.
>
> For IPPROTO_SMC, smc_sock should be an inet_sock, but it is not before.
> So, the initialization of certain fields
> in smc_sock(for example, clcsk) will overwrite modifications made to the
> inet_sock part in inet(6)_create.
>
> For AF_SMC,  the only problem is that  some space will be wasted. Since
> AF_SMC don't care the inet_sock part.
> However, make the use of sock by AF_SMC and IPPROTO_SMC separately for
> the sake of avoid wasting some space
> is a little bit extreme.
>

Okay. I think using inet_sock instead of sock is also a good idea, but I
understand for now.

However, for some reason this patch status has become Changes Requested
, so we will split the patch into two and resend the v5 patch.

Regards,
Jeongjun Park

>
> > hmm... then how about changing it to something like this?
> >
> > @@ -283,7 +283,7 @@ struct smc_connection {
> >   };
> >
> >   struct smc_sock {                           /* smc sock container */
> > -     struct sock             sk;
> > +     struct inet_sock        inet;
> >       struct socket           *clcsock;       /* internal tcp socket */
> >       void                    (*clcsk_state_change)(struct sock *sk);
>
>
> Don't.
>
> >                                               /* original stat_change f=
ct. */
> > @@ -327,7 +327,7 @@ struct smc_sock {                         /* smc so=
ck container */
> >                                                * */
> >   };
> >
> > -#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> > +#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
> >
> >   static inline void smc_init_saved_callbacks(struct smc_sock *smc)
> >   {
> >
> > It is definitely not normal to make the first member of smc_sock as soc=
k.
> >
> > Therefore, I think it would be appropriate to modify it to use inet_soc=
k
> > as the first member like other protocols (sctp, dccp) and access sk in =
a
> > way like &smc->inet.sk.
> >
> > Although this fix would require more code changes, we tested the bug an=
d
> > confirmed that it was not triggered and the functionality was working
> > normally.
> >
> > What do you think?
> >
> > Regards,
> > Jeongjun Park
>
