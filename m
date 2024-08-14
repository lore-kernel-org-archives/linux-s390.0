Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3B1AE030;
	Wed, 14 Aug 2024 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631855; cv=none; b=B0oTCgG6plVuClLsTzWbPlL80VqhykUO18dZsHkr223a88EWtouEHEuYrRPS1c+fpPUKq8O7i40RRWolhXGB7kHKUybMFriQq2rzmp//yNJtiqkGUXMHny0D4+S/ChIz7DuPc4zUYgZvG4D4O0073B8RhF8cs1MB+juxXLahnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631855; c=relaxed/simple;
	bh=lIDZfIJCwS9kOpHOYSU0fUk1LBYFw3wNKq7zRpsW9ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSo5A9bGxobEJ58Pt1OzZ5n67gSuzG/huKTQBgoK0sYcpOt3kQi0Nzomc931TKwwcIrkJO+UVQS9rH+E0m399THx262EGQwJnjhl2wfGdr4UAWqvbGQRZQUtdHtqgenzdj9/DnpXZamkQT6R/yb6l20XrVCjPZLik1396erBV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Sm+F81; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Sm+F81"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so497396a12.0;
        Wed, 14 Aug 2024 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631853; x=1724236653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuYo2+Zx6hAIj6J/3osNO/3OPdKH5IIxqLSLHJJmTBI=;
        b=J2Sm+F81rpZIjNHrG68kyKuLtnA2/JjZcqrnV6tIZHHZJS1bs0v1NJPsZgmMldK7hj
         HipzlYjvMqBKtlO4MTU4IG/iSY0kKa+3RX4YqIOf73BEz2u6/00xer44Moym3+6/AxOt
         E321awv/ToB+BzhkhId2GuDyiIMeNK7hLk0gE9XCxDUKNPq2dGMIpTaYQy+hp9ocfF89
         WzdtNrR55yEPgANv0I0Pu5W8KuCZ3x47w4Ak05BGWvyDHn6LsXu557BQp7PtyxOD5zHH
         NYnrqgx/OBqWVPfKNe6nv9F63Bt6GEBFPYwCr5dDtHARi97WtrjrZTu9j/9bdSxWCek8
         pObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631853; x=1724236653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuYo2+Zx6hAIj6J/3osNO/3OPdKH5IIxqLSLHJJmTBI=;
        b=b5WS5gUjPVGqqYa8eLCO9uT96BtHKf/mhlzxhlZrr7H/QL/EbeYS1C/tjrWCzbfhgr
         Eo5AoEHA4ug3PJ4yQ2bnWCNQSBNP/phqphjc1K04kvgsMb5eAxoM4vfZb5loPlArquF7
         QCEheMs9Y5vjuRKuLx3OCDweDZQVnEEpjF8rxBXf9c18/hD2PvI4qTfxMh0DlN7ndi3j
         nVipbW2U3Bg7PWmUXGC6a1bivCUTlxXwOXX8JHbA3kMfjdccP5NnobSiJzdjumZ4i7Uz
         uw+m0k/SiYm58XfXE9Ye8vfOFsAXpVt2L319G+VyXkh/j+zAoS7hU47tqaB+Wfd/YUU7
         Pa8A==
X-Forwarded-Encrypted: i=1; AJvYcCVf46YvJbefBCNOnlAuyrfSYHS5LsqunK9DdLnVHJw+WlvpFiHGonYSuWpy1Zd6uZUuGo3DNnDGrocbLxFWhzZXBONrBnxkRdQyoOZbXuFrbiyxPIM+nq0h6m2vuUpVoEGRUc9XSWANd90rhnT0amNHwCPFlmy6+jTl/wigokOgNw==
X-Gm-Message-State: AOJu0YxZpakjTQLLQgfSEKCMZcMbJImXZqcQSfr2Se05DgcgQMazADaV
	GxALx/hsOpEmq70AhFn1dYFp6gaaVH1tqkdNA7s7YhB3c6GYhSYGYDR74c4Jrqs55mncIJW8xyn
	+b4G+1y2Mtd187BjKHYFZDfO+meE=
X-Google-Smtp-Source: AGHT+IGBFWuLGzL/ikc1kuuvu59ml2SiwwutFZWQ8BtuzM8bfmR90/zyu1Z/RvYcLeWY3ZlW3o3X4Fv5CiPOiw2MhDA=
X-Received: by 2002:a17:90b:4b12:b0:2cb:5fe6:8a1d with SMTP id
 98e67ed59e1d1-2d39424d4edmr8982969a91.9.1723631852956; Wed, 14 Aug 2024
 03:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56255393-cae8-4cdf-9c91-b8ddf0bd2de2@linux.alibaba.com>
 <20240814035812.220388-1-aha310510@gmail.com> <4eeb32b7-d750-4c39-87df-43fd8365f163@linux.alibaba.com>
In-Reply-To: <4eeb32b7-d750-4c39-87df-43fd8365f163@linux.alibaba.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 14 Aug 2024 19:37:20 +0900
Message-ID: <CAO9qdTG=aspVkmB9zSh1x-5QLc-FBkxsnPfVErPVmCR3saCe9A@mail.gmail.com>
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in txopt_get
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com, 
	gbayer@linux.ibm.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 8=EC=9B=94 14=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:00, D=
. Wythe <alibuda@linux.alibaba.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> On 8/14/24 11:58 AM, Jeongjun Park wrote:
> > Because clcsk_*, like clcsock, is initialized during the smc init proce=
ss,
> > the code was moved to prevent clcsk_* from having an address like
> > inet_sk(sk)->pinet6, thereby preventing the previously initialized valu=
es
> > from being tampered with.
>
> I don't agree with your approach, but I finally got the problem you
> described. In fact, the issue here is that smc_sock should also be an
> inet_sock, whereas currently it's just a sock. Therefore, the best
> solution would be to embed an inet_sock within smc_sock rather than
> performing this movement as you suggested.
>
> struct smc_sock {               /* smc sock container */
>      union {
>          struct sock         sk;
>          struct inet_sock    inet;
>      };
>
>      ...
>
> Thanks.
> D. Wythe
>

I tested it myself and it doesn't trigger the existing issue, so
I'll write a v4 patch with this code and send it to you.

Regards,
Jeongjun Park

>
> >
> > Additionally, if you don't need alignment in smc_inet6_prot , I'll modi=
fy
> > the patch to only add the necessary code without alignment.
> >
> > Regards,
> > Jeongjun Park
>
>
> >>
> >>> Also, regarding alignment, it's okay for me whether it's aligned or
> >>> not=EF=BC=8CBut I checked the styles of other types of
> >>> structures and did not strictly require alignment, so I now feel that
> >>> there is no need to
> >>> modify so much to do alignment.
> >>>
> >>> D. Wythe
> >>
> >>
> >>>>>> +
> >>>>>>     static struct proto smc_inet6_prot =3D {
> >>>>>> -     .name           =3D "INET6_SMC",
> >>>>>> -     .owner          =3D THIS_MODULE,
> >>>>>> -     .init           =3D smc_inet_init_sock,
> >>>>>> -     .hash           =3D smc_hash_sk,
> >>>>>> -     .unhash         =3D smc_unhash_sk,
> >>>>>> -     .release_cb     =3D smc_release_cb,
> >>>>>> -     .obj_size       =3D sizeof(struct smc_sock),
> >>>>>> -     .h.smc_hash     =3D &smc_v6_hashinfo,
> >>>>>> -     .slab_flags     =3D SLAB_TYPESAFE_BY_RCU,
> >>>>>> +     .name                           =3D "INET6_SMC",
> >>>>>> +     .owner                          =3D THIS_MODULE,
> >>>>>> +     .init                           =3D smc_inet_init_sock,
> >>>>>> +     .hash                           =3D smc_hash_sk,
> >>>>>> +     .unhash                         =3D smc_unhash_sk,
> >>>>>> +     .release_cb                     =3D smc_release_cb,
> >>>>>> +     .obj_size                       =3D sizeof(struct smc6_sock)=
,
> >>>>>> +     .h.smc_hash                     =3D &smc_v6_hashinfo,
> >>>>>> +     .slab_flags                     =3D SLAB_TYPESAFE_BY_RCU,
> >>>>>> +     .ipv6_pinfo_offset              =3D offsetof(struct smc6_soc=
k,
> >>>>>> np),
> >>>>>>     };
> >>>>>>
> >>>>>>     static const struct proto_ops smc_inet6_stream_ops =3D {
> >>>>>> --
>
