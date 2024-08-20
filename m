Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B32BAEB;
	Tue, 20 Aug 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158887; cv=none; b=gAgOfOS0eSFMsWTE2X9+HrhhMueQrM3HjLR5w1XAaDMfAkSyKo+NlFhqZCOcONcXGBvV1u5QouwoeF3XQi0Dt66uF+5tdnDg6aph492NT+mzOTKVPZy0y0ICvHmiZO5VPkxOF4FFhiENc6QIMZz3Kendd00P/wyLJzE0K5PZK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158887; c=relaxed/simple;
	bh=ZzYV8R7oLNooWuBF+41kJ1zL7ccQfq+wmFXy2bObT5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urFmd8rRyfIoHemvfr1/yp34MSDhFWso8EPc+T3HoEprq/+8EZ44prdvXL3pU5yuIMcXEl1FvAYkiaaX477xA07Wt7OF5/FqZrVtGfvikcWgmGWnIcAbSY3uvUiV0hZIGBxaGp9o0jO1O61egkeLGjU5e8MKC1uL5qkWhZpApzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJXTlzYp; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJXTlzYp"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso27112916d6.0;
        Tue, 20 Aug 2024 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724158885; x=1724763685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzrfdMM7ZdY4mCivAH1uqZtZFRpJQqic8ZQayP8T1MA=;
        b=bJXTlzYp2+u44Q5rGhP/0HZSb2BchiaAKKKFRDjlcBmJw093DRNPyUAFesG/cT5AOw
         MLPV4aR5vnqeZdGk1LDqe/W5IVTZs5naC9X36Kxc3gLlgknO0y79HaStyH2CysZJw+mu
         axpjkUwk32v6ooUkCNM4FhfBqbdjY4Bn93O/+9IrVJ1ue1zPensAHYTVO5toLyTX/LYB
         7W+/5Wz5uOlzZ8YIS2NRr2UoDMUhkNn+KdHPxeBsRTXRL4wiuibZb4wCV/bycU0PDFU0
         5B1BD6cStrB44aVV6s9pQMOKyvFrS6dBbJnenQJCv1cbQBnVcSSq/IbcmeoalqGdyEzJ
         3f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158885; x=1724763685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzrfdMM7ZdY4mCivAH1uqZtZFRpJQqic8ZQayP8T1MA=;
        b=iHks3n5nihWTk7X9kWhKyCBhsMPHbW+gewVO3AHLhnFIRBPfHGWbLWodAq9/wnP3Su
         LJ0WiuNofEviimBtKyCqETRoGpceYHlb7fJNm6n3S3puZtvV3+/Jipgpgb9fq4+gNhAl
         P+f6zmzX5LEuii9ZFIGXEd/FV2VaeKcpKPVSx1OgE9WwqHCubbmjiDk1bSKdmd55MmC5
         xZqRxZX3B43GypiHI2qCrQLKcEgaGXhDaX0rcWORnGSPH4levk5cHCdds7zL8SFZxb9y
         Wd7XPoq3JXDMzbpLebFY2U/BACkhAk8pIcXPehXOIamD95MfNEEEUlg394Emsy6R47Co
         +Opw==
X-Forwarded-Encrypted: i=1; AJvYcCUHBLwPJhI2mGziN+qhvK33mopKjqn+znz5h86j/kHff+jorv5oBLSEeJgN0OUKp8oppoUIt0i40k5o+IJWX4WP5EHIpfdl57gf5zvW5EJy49b/hY7eukZjz6EIc3uO0aeb5Deo9eBt0utJW1jW5cohAkm6amNf7f0XxmDRte0lcg==
X-Gm-Message-State: AOJu0YxDs1cJvR1r/eKKZcnr+9c9HbWE45kIqKn78bd2yO8D/CkYdU3o
	umx2NgnBwnxs83qbJ13crXAQj1iei9qzT+b0n2rDVVNBRMEpudC0r9SZ4unK16GQU8uGNY9ORlr
	ayaGf302RQ8Dap8r6dd5uNPnQk5w=
X-Google-Smtp-Source: AGHT+IHu1R21Ij4m0PIa1a51kH4IMrN30SRA67hu1vg5+f5lv8vLg6Vzi0dyh6/vbeiQjsKNdbTSqdMHYbbpciASF8M=
X-Received: by 2002:a05:6214:4286:b0:6bf:6e7d:81ab with SMTP id
 6a1803df08f44-6bf7cd79088mr174747606d6.1.1724158884593; Tue, 20 Aug 2024
 06:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820121312.380126-1-aha310510@gmail.com> <20240820121526.380245-1-aha310510@gmail.com>
 <CANn89iJrPpmHvidEdd7G7oPrm1+VWsdprvrzQiN4OwTKjU3KsQ@mail.gmail.com>
In-Reply-To: <CANn89iJrPpmHvidEdd7G7oPrm1+VWsdprvrzQiN4OwTKjU3KsQ@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 20 Aug 2024 22:01:11 +0900
Message-ID: <CAO9qdTFiCEoDnckBq7tQDxtZ2LonC6+rMC5rq8H9UnOHL-iqUg@mail.gmail.com>
Subject: Re: [PATCH net,v6,1/2] net/smc: modify smc_sock structure
To: Eric Dumazet <edumazet@google.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, utz.bacher@de.ibm.com, 
	dust.li@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
>
> On Tue, Aug 20, 2024 at 2:15=E2=80=AFPM Jeongjun Park <aha310510@gmail.co=
m> wrote:
> >
> > Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> > point to the same address, when smc_create_clcsk() stores the newly
> > created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupte=
d
> > into clcsock. This causes NULL pointer dereference and various other
> > memory corruptions.
> >
> > To solve this, we need to modify the smc_sock structure.
> >
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Fixes: ac7138746e14 ("smc: establish new socket family")
>
> Are you sure this Fixes: tag is correct ?
>
> Hint : This commit is from 2017, but IPPROTO_SMC was added in 2024.
>

After listening, I realized that the Fixes tag was wrong.

When sending the v7 patch, you only need to use the Fixes tag for the
d25a92ccae6b commit, so we will send it by combining the existing patches.

>
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  net/smc/smc.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 34b781e463c4..f23f76e94a66 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -283,7 +283,10 @@ struct smc_connection {
> >  };
> >
> >  struct smc_sock {                              /* smc sock container *=
/
> > -       struct sock             sk;
> > +       union {
> > +               struct sock             sk;     /* for AF_SMC */
> > +               struct inet_sock        inet;   /* for IPPROTO_SMC */
> > +       };
> >         struct socket           *clcsock;       /* internal tcp socket =
*/
> >         void                    (*clcsk_state_change)(struct sock *sk);
> >                                                 /* original stat_change=
 fct. */
> > --
