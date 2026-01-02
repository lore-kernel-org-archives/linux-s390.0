Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB92BDC3F
	for <linux-s390@vger.kernel.org>; Fri,  2 Jan 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370759; cv=pass; b=ChoBu0OvTjkK6/GLSclsymKkUyS5q8tHGI5aBJA5YNeLoLtYHTaBKplIiZnHdFfqtidcOt+3ahm8EF9CmywJOq4Zr82buwblsAzNchz7mZ8AQ4zShTf95PRRdmHCDWQlbqIWwuOZ8D535XfArUiK6ry315Es7WtiO5IQIwdwZZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370759; c=relaxed/simple;
	bh=3zUPHsmFXLRLRWZxrqxoS8IggoZhxzhMACoAYfeLcu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7PVn9x4mR3Rt8m4aL54KpuQM5DDhMm+ofc7NwsP5jDN3UsZMZsbXMMqpR205wbexGdxrp73OYX9lDgggq0sJK4mcszCgbmumkiQbb1TMJ7U5GsOnPUy58swfQK4tf03mcLUS2dM5cFTQsc1JeEwqHX2+xre5adofc8WexvxAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RC6OrM7O; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RC6OrM7O"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a2bff5f774so29533515ad.2
        for <linux-s390@vger.kernel.org>; Fri, 02 Jan 2026 08:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767370756; cv=none;
        d=google.com; s=arc-20240605;
        b=DJcIiQwImC7msrBQoK+naXibypNqymv4S2uTxPeVFZKeOQOjRKi2YOb3330LxgYnSu
         gzxABlgVlT3zCeq7l4zwEO5Rilw97glj7HUL8ImpfljDN8q06na2XIn1Yks8DJByIgi9
         BY1l2TM4lVBHa2DZAi3F8+Ag1LvvLxglH/C6zVuVMpBAVn1gauu1do3kEOsJ2D207zAS
         mBvbY3l2hLmJvTEd3HdXTWCvuvKXDVJ+3i7lwv0Zog4OZrksQ7C8iKk0geEuHwlUqaoR
         eGPwdH7nAB9yn3HD5g7bpF0befPVrwlGYTUjMXG4av22f7kG5rpMavsL/cFAxYBNEtL3
         3Dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        fh=pC2zVJYOHPJqoax9m02p1QmiGyROf7YMmUK2EinUvcY=;
        b=GzXXSvwxB02TvJfiX1XezWseCOdW3NsSE82qZV0X4ZUvExXD1mqBVZuAG6yrZAfHKu
         boKF9ME1kwiYvnoPU2uir4qq38c5sU0y4hE1CS0RGwOg4P8//M3UQA6FxBrmHOOTddWe
         bgMjb/EQFqtwqfLi6DNs9w00D4JCyOhrQelDEqDnOx3m8CwlDbK/eWEuN2+HsettTXHa
         sd9bOflq1xAG6Nuya6BtZik93ialxTR28dMlQ2LA8/fB1s8RzqHGq86AZ9BFOEEBDzxg
         I7alSlHGBgJyzd8QsH+GsKh4u66N0EDK5ERAtt+bhtD9rVr3H3EbLjcRuHFyajkGz+Hx
         QP9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767370756; x=1767975556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        b=RC6OrM7O0cVMQCXffp7Y+tRu3KxyP//w1wjt29LedET926XUxE99AlK58/Y9l6s5RX
         tfZhN08MGiYvxmwh7ivaAwr/YzDhtnOSkAeNdL4CpRI1iSnUREFY/qCii2U5MhE3U6ru
         8SeY5SpByufn07hJLrwMSgQVqWkL4KElX6wcBt6NKYHHMK06eVR5NTpBfI3TrymzaqIZ
         TX/S3suwPgQqMM8HrEE4oXLab9RgnrKSh2ZavkJY54tlvvtaBTWBqdGLB1zgUMhkQpds
         fDs9neGR/7x+bttUhqouOuP+Jod6O3o+loQQ8FwuaPXetu6Xh6OJ+qnMLLq8RJXzSxy+
         9Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370756; x=1767975556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        b=hV1XsdaWW7KB28mJnxHf1cUlTx5Nt6PJ7rz7VsdciULTyj28ArcvUzHGBTpkUgucEY
         Oez9YF3/5wqqnlCljRBpJz+cHOFdeldm/S5bOh3MGIc3isDN2WO7ckiFIkRUtK65MQ0H
         V30+OC5T6twA0gsyQIn1nNlx6Dc1444DAOYPaw7aXKj8aw8ElQh0+3pwFdc7nE+ravUw
         okP9MdV8XKOKaynmKxRdgrTDrlF07pE4oDEy5J8leN0KIp0f6xw1HxRUYxFCK96N8gsG
         ZCpXtzyQHIMoCo/SCzSa57rTj5ZXP68NsFKe3JwHDSifgy1GKMWgioOytOQpdlSRcRUm
         AgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvFGiJiNiUO4F3bLUbdeWmYGoSTxI7VKqf+BYBbdAaam+gY7jMOuatGJXHyRgmUteZFfeaiiXBXcWW@vger.kernel.org
X-Gm-Message-State: AOJu0Yymoqw+yzcejCCrsCf1of/jU3lh9LWlZVKWvTPvYLfoqvaVUrRG
	8fY2LpfT8YOsH33gff6nFdLiz8uCL9YUIK6H9GZ3qUb0zTRJfQM5cTmb4lvA/ee1kHSsdhYSuf7
	mvm/HCwOFKvTFgzJ9rHIzOtP25W13vbkW0NG3+cOvlg==
X-Gm-Gg: AY/fxX5XIPkAHZlWHhrqN5lS+lsFO4XgOeGlY69oRg8PEz2aaPs4sqkMU+D7AV5OOQl
	3xYQNfijMsylcrBuJ8OgkvnW4AyIYFgKYuHVy6jLEacrsIxs0iwXWkkZ7UOcJMhwBzV+uhJQ+2Q
	wtXitpkz/BYLCpu/sNqvxEfntRV2P2H7HVItNzu41nyWKTPrSnhLTXsb5VJwasluBRZxynJ2Ei+
	hEZXa20iqT1tY4Rh8Qp405mQahzooMYDCDOtbTxIzTS8mXm3TUMXapB5Q4dIQcDN2eaATJV
X-Google-Smtp-Source: AGHT+IF/IKaol6q06drc0jUZGfDObMCMgUc7sJGF0Pzcwx7Y3zyiL6BNsG9paslEQz3RmfOfMLaSPRZ7OEsv3ldvgtU=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr21225084c88.2.1767370755580; Fri, 02 Jan 2026
 08:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
 <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
 <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com> <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
In-Reply-To: <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 2 Jan 2026 11:19:02 -0500
X-Gm-Features: AQt7F2oEXplVk5UGATVc_njCcDbZ0oTjVxxZL8Y_v3dZVS7iVDarJ5ogQAkD16Y
Message-ID: <CADUfDZppy2CQjZ9La=RcBL5XeKY66Eq7Rr1JD6byuip_GPrMEg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, Tony Lu <tonylu@linux.alibaba.com>, guwen@linux.alibaba.com, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 4:28=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
> > > <csander@purestorage.com> wrote:
> > > >
> > > > On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wr=
ote:
> > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod=
.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > > > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int=
 dummy, struct task_struct *task__ref,
> > > > > >       return NULL;
> > > > > >  }
> > > > > >
> > > > > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > >       .test_1 =3D bpf_testmod_test_1,
> > > > > >       .test_2 =3D bpf_testmod_test_2,
> > > > >
> > > > > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_i=
nit(),
> > > > > this struct is modified at runtime:
> > > > >
> > > > >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> > > > >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> > > > >         *tramp++ =3D bpf_testmod_tramp;
> > > > >
> > > > > Writing to a const-qualified object is undefined behavior and may=
 cause a
> > > > > protection fault when the compiler places this in read-only memor=
y. Would
> > > > > the module fail to load on systems where .rodata is actually read=
-only?
> > > >
> > > > Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> > > > init time, I'll leave __bpf_testmod_ops as mutable.
> > >
> > > No. You're missing the point. The whole patch set is no go.
> > > The pointer to cfi stub can be updated just as well.
> >
> > Do you mean the BPF core code would modify the struct pointed to by
> > cfi_stubs? Or some BPF struct_ops implementation (like this one in
> > bpf_testmod.c) would modify it? If you're talking about the BPF core
> > code, could you point out where this happens? I couldn't find it when
> > looking through the handful of uses of cfi_stubs (see patch 1/5). Or
> > are you talking about some hypothetical future code that would write
> > through the cfi_stubs pointer? If you're talking about a struct_ops
> > implementation, I certainly agree it could modify the struct pointed
> > to by cfi_stubs (before calling register_bpf_struct_ops()). But then
> > the struct_ops implementation doesn't have to declare the global
> > variable as const. A non-const pointer is allowed anywhere a const
> > pointer is expected.
>
> You're saying that void const * cfi_stubs; pointing to non-const
> __bpf_testmod_ops is somehow ok? No. This right into undefined behavior.
> Not going to allow that.

How is that undefined behavior? Wouldn't the following be UB by the
same reasoning?

void takes_const(const int *x);

void f(void)
{
        int not_const =3D 123;
        takes_const(&not_const);
}

A const-qualified pointer type just prevents that pointer from being
used to mutate the memory it points to. It doesn't guarantee that the
memory it points to is marked readonly.
