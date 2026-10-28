Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201766;
	b=zEezwpboB+gHB5pRKIqtJNUCjo5APM2QKqhXYPiyJ+ZooZCMh1yGC+Q3AggBpYwPZPch
	 nXtgvbqxOz7GghDgVlOEQhVoVFxQ8cHgE3SEOh5PBNpdF8moCDsvnH/kVLbH2vWuME0sQ
	 KpNzB17VzJmvO23/q34FTDosy51Op/68cWqEwx+2bwSvGWoAGYeHMJ0uVuaYRPBpu3bTv
	 cIa03WslehQ2XS29Msdlfvs13HbeHYQC7qFBdUT2Uy3quAWC7W3BHomPQKe55XYDBGvFG
	 I/yKu9oFkLwq2C8pjyZDVTmS2KLCN1gQEIXJRsWsKed5jgXuCoyB2nW66vATfkCaFJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	b=SVe6q7SaL/13s0+uIK32MWM2xb+pyiK0cbpGnMSAniwZlZMTlhDmcwW3U+gJcASqvV4i
	 AUyi1/taUWbiejF89iGhVdYzEoGhmtiKiKnr0uXYQjpT9SjrY7GuzSNThNEgFL8bZOOQJ
	 1X/S/SM0hPA/ukV07WjPcrIfahlHD0FQ1gb3A/rW2coKHFXEAwHTw1ef/rOs7QGRJWD49
	 iUzpT8OtF/Y9W5oHIwwArlvQMRZxOtj9wzZ27cfxJLhjPXFwr/Ecz4cSqRGDhcSP2Vqzy
	 GXP5QL9Yew58rnDTTxzUWaqK4/6S+6naL1667HBFrc+zY/h3hSdXBiHKQKSjxBGpoAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nek8Nqx7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CA606A32F
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A18CA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nek8Nqx7
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-535f598d126so291881cf.1
        for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 08:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201765; cv=none;
        d=google.com; s=arc-20260327;
        b=g5QIARdn+xgjrvoAC/6Zen1gWKkc40+kuurDkXeq6lz+ulXOPUdmlxTvWuLYReNsce
         3OZn20LBnL459ZMqmS0qye4DbxcNlnc1QeWwuS41iEI162+udeBZi5XCJp4/E9DMxkMj
         ywpAOdxk9V/Xtq7sU+GUWQtzM2dB6PvN7Qeu9GAZlShYEVV/lV1Z7qdg3kZEomlRJClQ
         qHkYhY1qQxIUIy3rEGo46gD5NqSF0WhPMxmaL2LQ+Ao2pSPVYsdymrMeVCcjGPPGAHxE
         lPZ8xniv5Nall+ggt6rT/JjPyaRxuphoZKkNrqnD8hg2Owr48hciINQWyA2Z5jUEianj
         M8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=waaFnterUbEe9+EPKkwO25E0gASBzMomdg1oMzMpxeM=;
        b=XAvcOisTz0rhqH/cdWf+f+1riCW1EDCxA3cdD22iplXnxFWja6iVHOmauYHbjYFSuS
         L4bK9MHgeQ6yNO+e+dAw59nKdXInd2XVJkfc9G1egcz3rOAceZR7+p0fRWyPRrK9xfwa
         l1DEQn1SgrNJtQKzuYOfkXnOarUeEV4UdCn2NZ/THfZq91sn1wi/VIhmLRPDY2qNza0k
         i1qlO7tP0m+SLeO8A7v7btXIvr5KxNrSHyLY8ZeiO+ujr5CcRt2c+44sTnkRS+pUdEeH
         9N/uXmPVG1Phio89C8X82PQDqAnuNqlqXGPR+loeeAtjmd6HU5lts8wHDrEXSOH1R8i7
         z/zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201765; x=1793806565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=nek8Nqx7d91OXZD7qWDvJpTMT7lowI69bPRP4zceMjAHm41xVpEzL1BgH5vON4e36j
         5cupyHhbLDw6ON8nWoBBJZRqDZ3S005GTvmgG3G0PtukPozM+2/LQ6a2MbkxzKZS39DP
         bzt/9gF0lI0l85/qa7WC7RdZ4Q0VkZkptogZtDuCXlakBdrYLGSggMJHiY7LR3KsJOtq
         1Gs4DN3Qtb9EZhFCO/4J0qmcKYuf+7C8fYPhDx+V95CDLxirmdfGb4XEO5yTc9zBxZGZ
         yh6Zudv8FzVB3adSvO7fw4oKhhxqCMD/35RpDFJe+zEhfhlT3Ry+hqRJH1ZgZUluJuF9
         /m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201765; x=1793806565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=SPX/j3SdnwwnUsBdhzEHG1P9l04W6W6ACUYCuDjKxxQEw5sHqU8gnzGV/iOy4QkQ71
         4AUDrxSVGi0Z7YrVtqIGMF+44yKu0TJ3BCGO2xgyWd8BGdhgTFIuFdF4LgZV5QFA/Osk
         3gLwqd5diTb1TPUCI1DOONabBw4oH784yLGiIjWNTxynJ2dNQzOYL3+NVMRRdZASLS0z
         J5LKzFYGDjnKZbXPzk6vMEZnSeG2V8zQTdrgGSUyyV5LKeT+LJ8EL5+ntPp7ch+xtWb7
         KKKILu7OvyPlrKQ+St/30X1DYdc6/hiJn7v34ZR7qQyGRxmi424nJY3osLnOdtLcQKjr
         owiQ==
X-Forwarded-Encrypted: i=1; AKwUvByo3J8KETwYjVVqYfaU2WzO3Yh2UjLloz+m6IeRSaKYT4gknTZnFyjyV6fPrOULgsInIa4jb+L/QJjH@vger.kernel.org
X-Gm-Message-State: AFq9FYIwEfRK2kUL6jYxPxe0O+26+d2UapWYxpDBzpI+viEjReARBDrg
	4UTI2UUXeeVzHGTRfXGUifzooWiEPTmQEt4IRBMtvp7XGU5YhbMO5BEUWgkGOCqZ/qAkQQgIuGC
	EEsgK0v8lFhW7mHM4GpEYkDzFjbd23Yi8H5z2Fpht
X-Gm-Gg: AYBFou0kmLv7T0K3Seb1nnAIKroqiGFJz1ISWnp1Hwsn9A5a0kSibrpeZCQ9oZgLQbo
	K6myeylpEUIBAW38wMww5cU7jKdQLSIkmQY90U3EyYSC3VcMwEAG1k0vod8tZA0ycQ3dkoGYyMa
	IkLSmuHo0yn7wOIl6XEnBge7vb9hlEOpgKVBz4+GAq6X6YMzK802Zm980mWoR4bsc04DrUmQAD8
	rvrSH0QiLK47ywka+ejyVlS/odU4P5TjegfEOKCh+2BwCYndryMwjsTMjoV9UkFa3kidJOAV99a
	70c+m8/6Omd3Zu0ZlwdW/C1K/xbrmUftUDS3s6KBivgmIpxwtGGfKlaKk29iuF5m15uq4up/NH9
	fly7m1EhUfhpYO0qcITRRBGx0nb0lybNL8iQt+Z3+jXNAvogfqPsXkLlO1VI=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
