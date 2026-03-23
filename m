Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9963B9
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774240188; cv=pass; b=VGjEYSezztLvhAFETDne7EkIov33G/i21GtjMgztC0eTc/22jvzjFotUejUixZo7EGir9811Q7VNcy7zyqga9fz87CLha9jPl8lssjXRkUQNPtx0i3OZsequdocNWzUAnALzEPKpTTeG6LbX/EPA4TR032wd+iFwZ5XEZ8VWiak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774240188; c=relaxed/simple;
	bh=1/rcecgLtux8bTAmuiZ/+rML+Ha5uRoGH+ayUHLvCcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/lh38cxWHQojSxD/D3Q/WhVFZhplZEf6O21Oe7GGyzVbHAE2zsv0Z12+OgLMlyVawzaAcmaUa9/6++gO4A480W0B1vpBDsy2h7sPHBi6jXD3ulohX6Gr7ddYgpancgGf/GV+7SVhUYoOCUvR0WrLmdN2skbv8Jp7rl7tswaQx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVuhJBSI; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVuhJBSI"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5091ed02c54so888011cf.1
        for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 21:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774240186; cv=none;
        d=google.com; s=arc-20240605;
        b=jSCW9xh3IdIJ/nEtOuNFBoIFEGSiYV5l9TxuZ0TPD+5IFJpNIF4bW3RkSwbQlh9I/x
         U7tPklWGw/ZkxP+1cdh+7FyFhuw38XX+zaWexr4d/VqltJbGywnTLzHeMWooBmAsGM8a
         hI5a9rQ6U0jHpjHppOapGVJwVNTE2cuS3ESq2l0/SsvW5fEsQVcdHqauDektdX35alfJ
         VpZb4K21LEPzWJ6MDnGKYwlRXWrz6m9bnhRzWvW5USgZ73lyYR7Fw/a7eAZgmARQilF8
         /xrCbPihAzAVblq8j+cJLuagqjaighStcfrTCVCcYUsHH4gkQ0mRlwe+S3H3YJ0jPOTT
         2C+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        fh=218QTdmkgf295IKwTBOhs35xBdM+v06ZQ9l5ljigf4U=;
        b=YfaiEDrTMsc10tkDRsfWtMseCJO6iU2TZ14Mfb8G0fbn9knN4qRBE/94N3Urk6Fo81
         E12tVhbH8Sqx9sdddGIiHYufvsL3bPPZFPDkE1p44temBGf+T6v0zQxZo9FNa3Oc5F3M
         hBY4YkKxMkwKqfDgkxzDbI/f5nnk5EX9pALCQzK5ttDU9FfX9F7twb9L77kXITn4j21n
         eznjbM/hxJKVaHt0P22gdxqbCxP6p3OUFi6hr41+5iT/RNuRk4CYxiabX5BbqsjRFWw8
         VCpAWLrGpo4yHvAku9mN0enc8qnewd1CjzctajtnVI7jncqWM1sczSTKMc6/kiXQvZ48
         Bn3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774240186; x=1774844986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        b=kVuhJBSIHN6zhN76IpzdiXj1eZtUbDCbzZQYJjXe0/t06/meZCSwC30o4Y2U0RIowK
         9u7J6BPW9L9HadxF1P9Mh/yx3ZAUEoF6asfP53NIZQz516AE2JVbl3wbYves5F2wUPf6
         saIwWusyz9dZiDF3b66l6nvD0pHATJ0RslPlU+A6uKZZzmdF3YD2OPkMmgZTDoQLw1aF
         PrxnKeeEJWXGbh2MT3m2i1k0QE2u/z76O2HcgwVP80rJQamZaxuXyViyrue/Bmq+lANi
         vnU1aWe83Gm3anKQBV/Qzo5Gp8zzeY2IrcE4LT3BY33v6YDHKkHWBEnUcgFGk1/CgUBN
         w6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774240186; x=1774844986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otZTpvGKCcuyL+5ZI08WO9k61dKZ8I5f3HXdDFzO2RU=;
        b=hI/+Lf+0Cw579Y3Lt+XHiwv6wcbJfqP9p4e3a0r9R9azdwOUnhLHvHWSANUKRcsHZ0
         RytiveJvDNxA+X9mpABf+OTNsLDhMBYxFoupGWttlGJT24GGGE+u9CV4JABg5hfTjjyA
         /zjdjtEGQFGdAvxcGGd/82J5xCoFK6PejrpSYfpUHd7savrVlB3FahVfIOlEKxbHogpe
         U/yT5h6fIdy3DSrsFRVgGfXZ26oh+jVpIQO/vcL8dD7aVyyhuS2qMYX48lWor7Lnk1M8
         Q/4HuoYbyilAqeVDdjunBUQqg/f18Ef6C/RYrjEDXdaD6D5vWIHqhO43T82gsP93Rv0Q
         xwRg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9LAAXLxZx0eiP5cvUOmChKPgobYVF6kbeMvGTI2Xkbk2c4FJSd55e3sw9CW9q8MzJH/50Dm0oqlC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywid6LlhfAhc7ucrkJHOTmL6P4sEvVCLHKbWJNMH1X3PbvR2pwI
	u6m0/2DS0tfVBepbZzm9zw8QQ4Pwyhfa/01h5CfjYxj10bkCpOZVUSKppcM0VAUsAZkkmcO73kg
	gJ/iQBzqUkUoy+1yupkzTPxp/jUU8NNXOJQWDJVtj
X-Gm-Gg: ATEYQzwF0/6HTmqr9QokxOd6J6R9imWnIfdNQWZ18gBbGHvMFVnHkZnXi9JafZ9xYk5
	ltxRzlbQouZyMFmiTCbnpGYQ+t2XzXPwWUBsmWUPuzMlb9TdQx6EhYdqrOOd9YCIq25wovI0h5e
	wv2uhjqes+zFKXASO+KNnc8p5gc3qV+p/8BKxNizGeYdprxHfvV467OSF/kTSu2byOYHL1MYX4f
	wmxtzNCY/pLb1tQkt/lbUyLvDulnswmKr0CtTBrcWM+MQhPcNqbo82tlRQyMkUOR9Q1R7n8c1Uz
	WOfLcQ==
X-Received: by 2002:a05:622a:5597:b0:509:123c:f317 with SMTP id
 d75a77b69052e-50b46a6754emr23046811cf.0.1774240185749; Sun, 22 Mar 2026
 21:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
In-Reply-To: <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 22 Mar 2026 21:29:34 -0700
X-Gm-Features: AQROBzBY2-_fJYphsyTdxWc7XCwazEP7y-d_Omc4v7H9yVwU181BEprIAh7MNYs
Message-ID: <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 9:17=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
>
> Thanks.  Sashiko review raised a few possible issues:
>         https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@goo=
gle.com

Thanks! This Sashiko dude is good :)
