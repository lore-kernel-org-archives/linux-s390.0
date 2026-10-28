Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201991;
	b=t9yr/onjavCpKGUZboYdAxs5kGieX7BFVeHWb2nbpmtm3+3ImhnSwCpVft53xmtkMm/d
	 6Cuw9pxRROM17R51oTO5/ssXf5hUHdSY4FC8VIFxuwfIJApMFkEK9Rvxf9oExR2vX35QR
	 ZNx1G0Zc9mKl+eVu/3RT4A5MabOJme7LT4P4LsQoKR7LXYgBwOw9BGecluUf8bloD2kwL
	 YIgojpZM4+Ck+fOFCJJ5+QWlbm16rogPGhPLdBJJ9SbqyV6sn5IVt4a+0hYQNjWLhOsfJ
	 /BBj5pyajT407mWCP71mjxK0IORAkpDYtmHpkjehcM6PsPTrVQcgz6Z0gxbk25CD7cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201991;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v/GrfVBE9REqGlviMjMV9KYA8baC9D3Z4PFL9rDyJNI=;
	b=Lgqqbc16mJlnnsqkdBecEosuIgIQtFMUnFx0kDZOyiHVydggyDpHUpKvYZcYC5FKFQtb
	 xapXXMp1oDMyZXZA9XVcp2UplrBNk6gQRG7rM29cUo0w8PYRiYad03AH0uh9Wp1MrB5l6
	 Bll9aRmN7Tn02gvn4j2gIl64zQK0W++z2Wib1Tw2C5M8AA7ZknS7X79oqHz0Hqxi9SqR3
	 5gR3gkA/TAUyjXWkR8QemR1Odtc5jwFEgXRjH2oMdH1Q14PbLUFjilbs44pSQvqfaJNB2
	 pAsmcfTf7C5zLyoUoaGpXShB78RVvNM/ZAnWve3YsUkbFFM66YtJMSfzBI+vRnsE0dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VHtM/wzi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6B606A32C
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHtM/wzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C039F1F031F6
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201990;
	bh=v/GrfVBE9REqGlviMjMV9KYA8baC9D3Z4PFL9rDyJNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VHtM/wzid4Vjpi1ahtkrCTunBXdpMk588+yxAl/Zt7jPzQ9CgDIh+PYPt+lW+RHtD
	 XBF1ITpY/oCCREN/r3GxTTiasnxkbYCm2mrSb3zmMn23c5zknBvNx/dV5SfeyYM827
	 m45G9IzvrUp2GsXITO1BPz91FS4SrBTRct5fIYPvHF7/uja6GCRbMQHJlEDtcLZFBR
	 bBqsTOILPojBkbqP9c5uFYFLXwvDa2XYT2SFUMxRTuB6ZQzLNkssif/6urHzHO00fk
	 Skgn+ptvjMSTS3VMBezq8yREZJPVwbZdc9I441ADP3crdeclpWj7HnR60MZ9kaBb89
	 e8j26jTotaK2A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab39af88aeso10357311fa.2
        for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 08:39:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYFV4nK9YTjuUTduIzLs/V+gyDb2MgyKYd6p/9YQXrPAdIpKGQDtZpH9+3kIV8rkIvOc/z12Ov481I@vger.kernel.org
X-Gm-Message-State: AFq9FYKV2uKb+etvJ+1h14CX5Od6H18bcjZz21HmwdQICWgmMxoHCqZG
	gSHM3qSLuZ3v7YckrNv8Vd7BYelaKzKcfL4d0pyVzy8hOY2sPhKhvVEjei61Aa7ivgNsBuIiBr1
	tJz5ay2Nq/Fimnd9HB74NmfU5Nav39+Y=
X-Received: by 2002:a05:6512:33cb:b0:5bf:ba43:f2f1 with SMTP id
 2adb3069b0e04-5bfcad8c081mr1232361e87.34.1793201988873; Wed, 28 Oct 2026
 08:39:48 -0700 (PDT)
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
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com> <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
In-Reply-To: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 16:39:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Gm-Features: AclHuK-jtq7opXKWd_89haXf76RntnjsmSewB7PcsqPK44QRbhInXeBo-GT0LQw
Message-ID: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: Ian Rogers <irogers@google.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
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

On Wed, Oct 28, 2026 at 4:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Export cpufreq_dbs_data_release() and set .kobj_type.release statical=
ly
> > > in the ondemand and conservative governors so their gov_attr_set
> > > kobjects have a valid release callback statically initialized, matchi=
ng
> > > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > > cpufreq_dbs_governor_init().
> > >
> > > This prepares for annotating struct kobj_type::release with
> > > __must_init.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Do you want stuff to be picked up by maintainers, or do you want to
> > route it yourself?
>
> Hi Rafael,
>
> Just a quick note: I agree with Zhongqiu's feedback and the commit
> message needs a fix.
>
> Regarding merging the patches, the issue with maintainers picking up
> fixes is that the series will break the clang/llvm build without them.
> So the maintainers need to either merge the patches (and the series be
> rebased on top of them) or merge the series as a unit. Perhaps since
> the patches align, merge conflicts won't happen, so maintainers
> merging and landing the series is okay. I don't have the experience to
> know.

I'd expect the driver core to pick up the series as a whole then, so
please feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

to the next version of this patch.

Thanks!

> > > ---
> > >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> > >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> > >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> > >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> > >  4 files changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq=
/cpufreq_conservative.c
> > > index 02bfd46543e9..146a2353b1a2 100644
> > > --- a/drivers/cpufreq/cpufreq_conservative.c
> > > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *pol=
icy)
> > >
> > >  static struct dbs_governor cs_governor =3D {
> > >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > > +       .kobj_type =3D {
> > > +               .release =3D cpufreq_dbs_data_release,
> > > +               .default_groups =3D cs_groups,
> > > +       },
> > >         .gov_dbs_update =3D cs_dbs_update,
> > >         .alloc =3D cs_alloc,
> > >         .free =3D cs_free,
> > > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpu=
freq_governor.c
> > > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > > --- a/drivers/cpufreq/cpufreq_governor.c
> > > +++ b/drivers/cpufreq/cpufreq_governor.c
> > > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_db=
s_info *policy_dbs,
> > >         gov->free(policy_dbs);
> > >  }
> > >
> > > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > > +void cpufreq_dbs_data_release(struct kobject *kobj)
> > >  {
> > >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kob=
j));
> > >         struct dbs_governor *gov =3D dbs_data->gov;
> > > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobje=
ct *kobj)
> > >         gov->exit(dbs_data);
> > >         kfree(dbs_data);
> > >  }
> > > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> > >
> > >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> > >  {
> > > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_poli=
cy *policy)
> > >         policy->governor_data =3D policy_dbs;
> > >
> > >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> > >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->=
kobj_type,
> > >                                    get_governor_parent_kobj(policy),
> > >                                    "%s", gov->gov.name);
> > > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpu=
freq_governor.h
> > > index 806d8fb4dff1..1026712bb79b 100644
> > > --- a/drivers/cpufreq/cpufreq_governor.h
> > > +++ b/drivers/cpufreq/cpufreq_governor.h
> > > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_o=
f(struct cpufreq_policy *policy
> > >  }
> > >
> > >  /* Governor callback routines */
> > > +void cpufreq_dbs_data_release(struct kobject *kobj);
> > >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> > >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> > >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpu=
freq_ondemand.c
> > > index 9942dbb38dae..7386d043c665 100644
> > > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> > >
> > >  static struct dbs_governor od_dbs_gov =3D {
> > >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > > -       .kobj_type =3D { .default_groups =3D od_groups },
> > > +       .kobj_type =3D {
> > > +               .release =3D cpufreq_dbs_data_release,
> > > +               .default_groups =3D od_groups,
> > > +       },
> > >         .gov_dbs_update =3D od_dbs_update,
> > >         .alloc =3D od_alloc,
> > >         .free =3D od_free,
> > > --
> > > 2.56.0.313.g2479322e68-goog
> > >
> > >
>
