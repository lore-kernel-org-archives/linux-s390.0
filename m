Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20354478865
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028448; cv=pass; b=i2EOELrvIewWEnl11LFM7WBr/9q9Hb0CjRHP/etkDjEpDT//3ZyMajSkNl4aP/eNV46TSQVi/s6Ta8qX8JLec54E4W1iQ9EBFg9lymuYl7DQRxMTye8Qf8n1kX+pw2AJscpUzU4McXL170KzZiDDF5nWObtk7A1Y4bpZQfBlEaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028448; c=relaxed/simple;
	bh=xHWfrtbUKzJn60DpMzTvrgdZeVM3KtRHSI8GmZl6zPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9pX7daqRZxvi0nhcKg6wQ2+Jm3ZyHlsi19OHq3RSF8xJZZhyTfub+EQ8LBf9aOwKUKOSl5tAt/wcyLjoY82gSzWjE1Eh9QDveSt7AizCuJUDObEu9J+CFc+I203U67+79s1Kv3xAg3GWBmnf1BNieB/sV4LeVHhd2hzYNmoROs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKSxu1Ra; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKSxu1Ra"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49954b88fffso7868295e9.0
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 08:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028433; cv=none;
        d=google.com; s=arc-20260327;
        b=LvISlvp+TOHsKJpjFLfq5N9q4uCVW7qw3QtjoQEu3tvI4WVJyeTZqvTR0SrA/9DKKO
         PxPTBJx8QQeF4hFWv5BCFmMQhaBF5WF1lQ/jfTTdyNJSLABQGgDMyhrgzhyfvWQCTW99
         zNPY37Xu9Rc6WD3iQQu/daWk7oZey0nAeFr8S8+UXUNW7xUhz0X+XSVNbG2Ec1M8Jkqz
         N7FCt5HN3Dz/TewkSZ/x1aS+Iwk+G61Gos9tBp2RjwS8y5/SfDG9SEbsP0riumXmx8sF
         8SiBNCoLg+TBrLYUW2vca9X/FC7gbrIseq7RXKX3CSIhS0fmnWckWbwws28riHM7Kw3I
         aoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        fh=e3rZkCYOr+HQnzl4Hre9l5CaYsHwAvI0Aci5KbiBdww=;
        b=NGQRZMTakLYIC1amMjcT3AFu4KIalp6UwX38kqOcRQXEucx0XBDHxNxixHUbgRPsT/
         +2myYo7tIGFIRz8hhm0JmIZinFq4J0x9u2cXKTuxmOwqHlvDnT7fgDiNIh41OZU5UXNm
         G/KIJd2xnblUInAQsEQE/6WocCniqjr+DbDohBZJGqMsNkSqbmRlGtU1cbOO0SHf/UAC
         LtwmA19FkGO6IZIOUQNniacJWAbNCgF9xcFOY4+LCsc1ctsGH+tSpCOgsnOJxHISewzj
         tK+3d+OcLYd9kgjVVUWkvdOhniihJ7LebpXnGNeW/HFCSA0HrgKZrtjl+Z3hKZg53S4S
         ewkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028433; x=1786633233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        b=BKSxu1Raq6JT3Ik0gqq5iBH5cROw+YPM2+EG5MwCXqCZ2JpqHTJyqFznlT9ikO6dZN
         +d6pDajoVcRTZ5sDWVeZxBRgNaIAieqhHV/yzu4lP+bidE+ORLMqgvrWHhxFcfRF94S9
         +EtudeYin7bNjC2etIxahk/Jx57p6j6g3Wl74oh87FioCifGvjLqxQj1BC3phTOCap1h
         BblC2Qq2UzLABLvhtIzrGkhrxiNdVns9ehxCmfWqiNROy4NS/e0rTfey0Cm2zNxUDlLv
         j2TFzagrmemJ71oo4NRoT/yUweoOCc1b/edb7NuFzXqBC07Ce3Je5RMl3/JLgWa5Gt6l
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028433; x=1786633233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        b=Cr1IhUPS15mbfsNSHaCXrGkJXG1NTAGBAI/1NEuv9XZe+yoMjMU9QkDlU40hKHawX2
         YEIxdE/9pf2fEFJIig9YZw35kTyUjO+hIdagrBolgk+75fYnYVh4deLKdoNnGAyJ1vGp
         T0XLEWolBXQSKj/qk0racCKoKT2fX3RkLFoneSS8QFgdrghLKP/3zLey1KdA8LYiSKnX
         KFHV4BnyWOw09jm/YVeJiqe5IIJcF54PROtuAD6mWLMdP/VzyvSiDGjm7VvKEWLOqIkq
         c5Zgybr93WeYQYeoPRta/8rWNxk/tEIai9nOCe6wdcPAM3x8c8Jxc9EAVSXRryz/vMQd
         zgpw==
X-Forwarded-Encrypted: i=1; AHgh+RrRSQQ/l7gexFphATAw/51auy7FhlqIIS8JHKrOwug9LNPqXwqp50WV1uZyrFt4VTwFnBE0Oq97+cmL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oijMEHXWLmBTiXnMgaGP29latgVyfInSYlVzEPRl1rmwiXmS
	nNBMFXzeTVA4jLj8wWt1oqM5RmSgMRCLZAaIWQ+0GmCmJ3K34z0ygZELHe/HoQiKAVUA4OjeWhy
	DCY9WCmdU9scMdyKyDmDoLRZ70z9ufZI=
X-Gm-Gg: AR+sD112lFZWQ9HdfkJtLqkj/mhsZKZwZ+M5SytbX8D+XTGs8xH3kGVbpB1ofWH0gM9
	QWvulqOy5ZVj9yKaSX6rqfVu3Zy4GnHc6hinPGorRwu0vSCagVhyvemNbnOV+w8vP1HA9RGtQJO
	yXoxBtV2591MInitksTA8EaB2rMh54xnLQ8BxX1RWavhqJCsw1lPPoJ9Vsrekrx7uQOLwb3zzus
	ZzgHt1zqsINKnpSz1qP7qyoUPTVjpvtQ7zHnVFtOpteGls3W4pvoaABF4QacALxYsLskWh9zpQK
	1u5HeU4jaDFHImCDfglePtFALlB6fhdoFz9Ow4N5p2NaEw==
X-Received: by 2002:adf:e005:0:10b0:47f:8b9e:f44e with SMTP id
 ffacd0b85a97d-47fec52828bmr21215134f8f.12.1786028432410; Thu, 06 Aug 2026
 08:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804213917.3413525-1-gyf161023@gmail.com> <905fe2d9-a8c9-4047-82af-6f530d024ba2@linux.ibm.com>
In-Reply-To: <905fe2d9-a8c9-4047-82af-6f530d024ba2@linux.ibm.com>
From: =?UTF-8?B?6auY6YC46aOe?= <gyf161023@gmail.com>
Date: Thu, 6 Aug 2026 11:00:17 -0400
X-Gm-Features: AUfX_myepY0Ow5BHeLBg3UOI6iMPPgT6p_3js1Gm3-IOdv6gZ05ymxdaZ7gYMsQ
Message-ID: <CAB665WCeZ2bTxCduGqKb_xeaoDb1Ty9wJ+vZ2be_jwj5osHYrQ@mail.gmail.com>
Subject: Re: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns()
 error path
To: Hidayathulla Khan I <hidayath@linux.ibm.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Karsten Graul <kgraul@linux.ibm.com>, 
	Ursula Braun <ubraun@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hidayath,

Thanks for the fix =E2=80=94 I see yours covers the same issue and was post=
ed
first. Please disregard my duplicate.


Hidayathulla Khan I <hidayath@linux.ibm.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 02:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yifei,
>
> Thanks for looking into this.
>
> Yes I have submitted a patch for the same issue.
> https://lore.kernel.org/netdev/20260804082800.498672-1-hidayath@linux.ibm=
.com/
>
> Hidayath
>
> On 05/08/26 3:09 am, Yifei Gao wrote:
> > smc_switch_conns() takes a reference on the socket with sock_hold() bef=
ore
> > dropping conns_lock to prefetch a tx slot. On success the reference is
> > released by the sock_put() after smc_switch_cursor(). When
> > smc_cdc_get_free_slot() fails, however, the function jumps straight to
> > err_out without a sock_put(), leaking the reference and leaving the soc=
ket
> > unreclaimable. During SMC-R link failover with an exhausted backup link
> > this leaks one reference per failing connection switch.
> >
> > Release the reference before jumping to err_out. The err_out label is a=
lso
> > reached from the smc_switch_cursor() failure path, which has already do=
ne
> > its own sock_put(), so the put must stay at the get_free_slot failure s=
ite
> > rather than at the label.
> >
> > Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> > ---
> >   net/smc/smc_core.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index cf6b620fef05..04c6ce608ec7 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_lin=
k_group *lgr,
> >               read_unlock_bh(&lgr->conns_lock);
> >               /* pre-fetch buffer outside of send_lock, might sleep */
> >               rc =3D smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL,=
 &pend);
> > -             if (rc)
> > +             if (rc) {
> > +                     sock_put(&smc->sk);
> >                       goto err_out;
> > +             }
> >               /* avoid race with smcr_tx_sndbuf_nonempty() */
> >               spin_lock_bh(&conn->send_lock);
> >               smc_switch_link_and_count(conn, to_lnk);
