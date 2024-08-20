Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1718FC81
	for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158153; cv=none; b=Ie5xNZkiMXnrUOHW/cRSXZRAvz5dSMBv0m62rN7zhHEJsOeOTSZFGFhgOI1/rhQkuqLtjs3FT/UzqMZCXaSgasWT3XoPZ8iRFtBkUEj3scs5gMn3gyGGE5c9rqfntpB4izFOHFnjuR9Vexa/ap7HXJmt3bzg3f/xQt+Mh0J93kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158153; c=relaxed/simple;
	bh=1Sbs6eQl2iCqdSwxfE6pIQkD2Iw+7sq2JAkoE4cztJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmiKckTkh2rqDWembT3POSAq0V0LaKmcaSRM+z0Gv9xAqN4Jt1fA4F/0zaCvLV91pMveBGyNGfQVwuwJvlTr0U4Lp8LAUBTOqPpPNjPVaTAU9NptdxWVFqpRaUkANCLVL24fZW7r//cM027KGjrhKzopZaVE4E8uRaSrIX2cQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SogOe8+b; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SogOe8+b"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so7530124a12.0
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2024 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724158150; x=1724762950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hkcpd9YjkBve1E3v11AvpsRGi8t+U6b6eWmy9I0Lke0=;
        b=SogOe8+bUgDZTYf9BvUKa7KPTiSa+CztO1ubgqTeWKggAI9HcT5HH24Jj6VGa8tfk1
         meE3T0odp8D2A8UsnXOG6npQnK65nOVMERdHYOTLHHHAXQWLPP6Vss7vUeqhwFn5ywYf
         hnOyC0OUmdBVDzEkbm1NgUxSRsiL48o9dAIOLeciZEpyPi+W0uTyGTGTATuEJXTE8Kii
         dpadUT49x/Oj4i2IFMQvOHZ5ccqanfjuuqfDtogqRRnG6r7HSAb4gHfi6k447CeDjnPS
         mggIzUxpr2WSpDi/S/dGYwi5eIkhBXvSzvW0O1+cwFz2OF4XrPU529hI4vUwllol4HRQ
         yEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158150; x=1724762950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkcpd9YjkBve1E3v11AvpsRGi8t+U6b6eWmy9I0Lke0=;
        b=tFsBVh+buGpwGr7L1RqkuNQvLyqXhOC8EcSj7/uUL+C/jqqetntyFN1aTBdvgNblzm
         r19ij+beW1IJI9Jfl0hQVy7qvg/waATiPV64dOQlf7WVpD8VzE9Wj3XNA3S2xNYSj3AJ
         ydYEAhPdiYSV9W7tuNxyeNH5I/qFR88Ye+NJHJwooA9H6EVfRAP/qO2p5KWZ99ZGjjGa
         s+2AABgCQVaynP2BRA/HpxBgBx+MtcNcheWogi7iNeyU2/hdy20GW1UKX+OJ89WITxOV
         DyLt5ov4cSNA2qidzsk1i3qr0PRsAa9DmQ0CI+3RHzjGtijwYhWd6TGa9KH7Nj725lP6
         rSOg==
X-Forwarded-Encrypted: i=1; AJvYcCWkvnQv8Z3LD8crsjdjWUGjHjFR4BCP4qI3aVmgk/jY1DGtYeeUfdgVzz7irZcR+3d036ojYr2jO2KW8eWXjdEuzgkI7eW7ch94ow==
X-Gm-Message-State: AOJu0YzSXmVj6AqwbSf+3STRqHASAdNs/HpCd4L28OqZKIPgA1hWgd16
	+n/58OpV26p4CtEIB6IbMHQTZETLT/PlUZEQAGhbpV1p7BH3XCyo7oRci1fVA5LOJX+mzCbzvkF
	c8HTgShvDiqo+65Flnenbs3I0YSGggPR9pxkm
X-Google-Smtp-Source: AGHT+IEn9KaHhvgLkNx4C288H1MOvSj4VDl4aH4ZGXp6/aFM03ti3t2cri37LJzMl5DrhmRSLeoPKHKdyfVfGRIQBSo=
X-Received: by 2002:a17:907:9285:b0:a7a:8284:c8d6 with SMTP id
 a640c23a62f3a-a8643fd84a0mr361818166b.24.1724158149039; Tue, 20 Aug 2024
 05:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820121312.380126-1-aha310510@gmail.com> <20240820121526.380245-1-aha310510@gmail.com>
In-Reply-To: <20240820121526.380245-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 14:48:58 +0200
Message-ID: <CANn89iJrPpmHvidEdd7G7oPrm1+VWsdprvrzQiN4OwTKjU3KsQ@mail.gmail.com>
Subject: Re: [PATCH net,v6,1/2] net/smc: modify smc_sock structure
To: Jeongjun Park <aha310510@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, utz.bacher@de.ibm.com, 
	dust.li@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:15=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this, we need to modify the smc_sock structure.
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: ac7138746e14 ("smc: establish new socket family")

Are you sure this Fixes: tag is correct ?

Hint : This commit is from 2017, but IPPROTO_SMC was added in 2024.


> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  net/smc/smc.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 34b781e463c4..f23f76e94a66 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -283,7 +283,10 @@ struct smc_connection {
>  };
>
>  struct smc_sock {                              /* smc sock container */
> -       struct sock             sk;
> +       union {
> +               struct sock             sk;     /* for AF_SMC */
> +               struct inet_sock        inet;   /* for IPPROTO_SMC */
> +       };
>         struct socket           *clcsock;       /* internal tcp socket */
>         void                    (*clcsk_state_change)(struct sock *sk);
>                                                 /* original stat_change f=
ct. */
> --
