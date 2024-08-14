Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4BEA4;
	Wed, 14 Aug 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620617; cv=none; b=e2fHUVT2pyZ3BSZ5EEPBJqOINiHIXFKJg1rqwv1P8qFgtP8G65OKOUDelyR3AIEbXAGfU34+pQWLgJJHfomU5/r2KFAVQRdMwLeZn4VSRwWA6EHGctvC4AJl3+yqVf25/cn3yO1pwXkN05DlG++5BaqxOnF4tzzHUDAo13cJHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620617; c=relaxed/simple;
	bh=m3S7JU+HCylBG7tym+JkEbCTnGOtEt9vkuHrFlnGleA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=kVe+f4VTh8MRrnkCVuxUmJw9DKB4+pdCeCj6eOoVLntkJIzzll1gKtlIvAhbaoG2MRxV9557nsXLlwxx6Jvkx/CWiyzz6udHlIM295pcTcGogAIg2HpKEyMBwy9LyeHtmu+aYpyNI/npxGiCRaA7n8+v8flhmRPWChjpKvYpu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlItA6OR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlItA6OR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd66cddd4dso60873045ad.2;
        Wed, 14 Aug 2024 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723620615; x=1724225415; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZjg8zveGCIUd8Xm20UvhZjkI4TEvCstRkn7S7YAXGA=;
        b=GlItA6OResk2DIJQMDFuVxSMKoPwtmhuWWmOLFfzVkNjw+HxCzJFDVnpls1p+DJyw4
         XGMd7dMH/E3CPJ4CKGTC67wY7BKSubjqIUBQOZSqx9XDFVID0Vdc5Ya99FH8wLTC1T2k
         02nHAx3qRqWfxlUTmiKYx2KttE8B8pg9LGlXYHBTaihIxZ4z3lxdrxwXvyUUVCGSdnbY
         7wtHEX38W/ZulwOCV8p12UqyfvwpA3zMjasN09H2Bb+GINk7o7ElxgfyzLIKevwMqtgt
         SY4B9XTWOUSglNHKGIbntcYbboTns9I+RzA+iEkjCE/IThSvVRa2FzCPrxtlTGtW1ST7
         SFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620615; x=1724225415;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZjg8zveGCIUd8Xm20UvhZjkI4TEvCstRkn7S7YAXGA=;
        b=LzaynaOWqvew7AA6RgOVrBSsMIsuhvf7j/uQ/AkGx4TD2S67i9UiZJAgYIJXTyrlmE
         l7rmYW3X/y22+EZKimFz3r1hwVWrpd3OfZFP+MTdYXD/puzZFp8r99VjF6nqbHk1ZuFV
         C0gN3CqdV4TU/1hwsAfjwRPP5bZg8WRUwxjyZgNSo68QBa+kUCjJzuKbQZonWxnTT4+b
         U7KhGt92n2A/8fiiH7q+IAAG8SmoC6sL/6QWC2rgveUQRK7WcOp/oDsJNQP46CJ/12tM
         4iR9U6OsYDqRDIfmnwfbJxQx7H65Smbuw4/jOyJGW8o8b70dTRXdhDcFC0R8WD6CyC0V
         O8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKZFOPToJhdVK23rXCPaO1WsXyKxXtXVuNrpACTzWGo0gkJgLcecs1F9JpQZTOhJTuB9jnZxhQX+84H4ZB2/FEYkg0UByVkqXH2nRBHV5JxImGKKd+ulvJUQ7+8MfroxS9jWH0RQfaEgGC7en8uHqeUlCWkXq+kmnAbNo3dmojSA==
X-Gm-Message-State: AOJu0Yy4yvdhn2rZ8liHfeWJgqIz7fszgwsCISyvCc2A3FNNH90acqDf
	p6FnNQbcbuduZxz8LoGSdqM1s/+X3dwVuvsIXg+HDJFISpyxyf8I
X-Google-Smtp-Source: AGHT+IF9vetZEBq79rLwnfC3eNHkEvNAwOlqnrjH9+Gl+rQcBXi7+FTtVhF9PCJKqZ3PQov6/++wHw==
X-Received: by 2002:a17:902:f687:b0:1f8:6bae:28f with SMTP id d9443c01a7336-201d638cec6mr29496275ad.9.1723620615271;
        Wed, 14 Aug 2024 00:30:15 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a406:4828:124:7d18:f674:4bb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a94b1sm24050485ad.122.2024.08.14.00.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:30:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in txopt_get
Date: Wed, 14 Aug 2024 16:30:02 +0900
Message-Id: <75AFEC8C-C050-4AC4-AF63-0B798B040502@gmail.com>
References: <4eeb32b7-d750-4c39-87df-43fd8365f163@linux.alibaba.com>
Cc: davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
 gbayer@linux.ibm.com, guwen@linux.alibaba.com, jaka@linux.ibm.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com,
 tonylu@linux.alibaba.com, wenjia@linux.ibm.com
In-Reply-To: <4eeb32b7-d750-4c39-87df-43fd8365f163@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
X-Mailer: iPhone Mail (21F90)



> D. Wythe wrote:
>=20
> =EF=BB=BF
>=20
>> On 8/14/24 11:58 AM, Jeongjun Park wrote:
>> Because clcsk_*, like clcsock, is initialized during the smc init process=
,
>> the code was moved to prevent clcsk_* from having an address like
>> inet_sk(sk)->pinet6, thereby preventing the previously initialized values=

>> =E2=80=8B=E2=80=8Bfrom being tampered with.
>=20
> I don't agree with your approach, but I finally got the problem you descri=
bed. In fact, the issue here is that smc_sock should also be an inet_sock, w=
hereas currently it's just a sock. Therefore, the best solution would be to e=
mbed an inet_sock within smc_sock rather than performing this movement as yo=
u suggested.
>=20
> struct smc_sock {               /* smc sock container */
>     union {
>         struct sock         sk;
>         struct inet_sock    inet;
>     };
>=20
>     ...
>=20
> Thanks.
> D. Wythe
>=20

Wow, I didn't know this could be done this way. I'll test it with that code=20=

and get back to you

Regards,
Jeongjun Park

>=20
>>=20
>> Additionally, if you don't need alignment in smc_inet6_prot , I'll modify=

>> the patch to only add the necessary code without alignment.
>>=20
>> Regards,
>> Jeongjun Park
>=20
>=20
>>>=20
>>>> Also, regarding alignment, it's okay for me whether it's aligned or
>>>> not=EF=BC=8CBut I checked the styles of other types of
>>>> structures and did not strictly require alignment, so I now feel that
>>>> there is no need to
>>>> modify so much to do alignment.
>>>>=20
>>>> D. Wythe
>>>=20
>>>=20
>>>>>>> +
>>>>>>>    static struct proto smc_inet6_prot =3D {
>>>>>>> -     .name           =3D "INET6_SMC",
>>>>>>> -     .owner          =3D THIS_MODULE,
>>>>>>> -     .init           =3D smc_inet_init_sock,
>>>>>>> -     .hash           =3D smc_hash_sk,
>>>>>>> -     .unhash         =3D smc_unhash_sk,
>>>>>>> -     .release_cb     =3D smc_release_cb,
>>>>>>> -     .obj_size       =3D sizeof(struct smc_sock),
>>>>>>> -     .h.smc_hash     =3D &smc_v6_hashinfo,
>>>>>>> -     .slab_flags     =3D SLAB_TYPESAFE_BY_RCU,
>>>>>>> +     .name                           =3D "INET6_SMC",
>>>>>>> +     .owner                          =3D THIS_MODULE,
>>>>>>> +     .init                           =3D smc_inet_init_sock,
>>>>>>> +     .hash                           =3D smc_hash_sk,
>>>>>>> +     .unhash                         =3D smc_unhash_sk,
>>>>>>> +     .release_cb                     =3D smc_release_cb,
>>>>>>> +     .obj_size                       =3D sizeof(struct smc6_sock),
>>>>>>> +     .h.smc_hash                     =3D &smc_v6_hashinfo,
>>>>>>> +     .slab_flags                     =3D SLAB_TYPESAFE_BY_RCU,
>>>>>>> +     .ipv6_pinfo_offset              =3D offsetof(struct smc6_sock,=

>>>>>>> np),
>>>>>>>    };
>>>>>>>=20
>>>>>>>    static const struct proto_ops smc_inet6_stream_ops =3D {
>>>>>>> --
>=20
