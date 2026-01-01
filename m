Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D3289E06
	for <linux-s390@vger.kernel.org>; Thu,  1 Jan 2026 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767233454; cv=none; b=BxsgsAeN4N1q+Zb5/cwka6hDwCz5xNvJgzg2V/TB00Upyf0IOgyxPiYvSnLQ6t4rMZxUkdrcEOC0x/olCHa9GfYrReGsdNNEfJ2lRJTump8Ff0gppZaZuSQXJzqPygIi6jcptG5UA5G4nwA6MleiMNhG6QjJPesqHlvP3u2Okss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767233454; c=relaxed/simple;
	bh=qqizFew/kTOzewLvL59xdtHtP4J/gkIe7g4rCO241Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heTxQkxiiFOb0vmBy3+RO/wl6jA16uRoLTu8QXJoBZO6yDtr0JMFFlg+Xj48ShX1pZvQbwBdYWSlO/G6MNzFGJeFySiQhzoha+rvqGmVz3/UjnyOMG4uRipAM4ErZ74TVTcwFGFZ00M/QxOvtl1ktnGKNKSkTQshTZQKu0hbtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/OVexLt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/OVexLt"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso4713375e9.0
        for <linux-s390@vger.kernel.org>; Wed, 31 Dec 2025 18:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767233451; x=1767838251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2EkUzQ6sigBd+WWV5Hcl6Vcy/jBU7DTMqVQsenR/Xo=;
        b=P/OVexLtkAJL/ji/IYpg+cnW6NzdWDUSRp8Pqik1QtPmS/aI9qBe63lt/ZK4hnmsth
         FXIHJi77ybxplKrxGUFKykkq77JbH1CLGWJINYQ+wHQ45kpk2UwoCg3D1CHM4jOrfsBb
         tkgj8W6Kqu8JZYCI8Dgvf/cg5pkF+tDwdIikC6sCJlyvD8VcAqiEqItzGtvZTCuYkYrb
         yFBjPVXMljpbfsi/ZePaHGVG4gsHTS1l4+LCnA0pvQBhbkrYfU7JYIjAgmrNp7jVL+Sg
         nRgdCYJ2nefi+pYDd2aREqonc+kT0rg0ZZInMTa9f9rZrTVxR1aFN89c/eiD13eRC/nD
         wY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767233451; x=1767838251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2EkUzQ6sigBd+WWV5Hcl6Vcy/jBU7DTMqVQsenR/Xo=;
        b=LASDFXgjwPPRtzbxaHo5UqhVNuFyE9mu+hLpV2rlYeV/xgweMbsVu6cwSd+H3tvFEo
         30PO5EfzC3m56GaOmla6gkwG+h7MSMswE5V2IaOD2hA3RItNcnXRXJAsnIo4FajmKo9z
         W6TkPiLXWzu4iLyrXmk2Kh5Zr/5t4FuOJhvPoksar7K2Elwdg6rNQ5cXTGL5eLVrIAT0
         ZVoT1GBjytKBDFKfp54sN4F02S/Yus43l0hbG4qYvPt3T2YGTYFDmCEkGwl+5pC34giD
         NmCwy0qYvDeWwNGGGg0uvae+KeGphbLAIRbKKUaCrCXSJY5frkBMbDQhD6X63m96y88F
         x61A==
X-Forwarded-Encrypted: i=1; AJvYcCVwcSeOGa/vHga20Dd8NfiuAingzwe+C1F8e1x6DUFZBT8k3s+i8kcehoihnz/KewvnNr6CvLFwcbN3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2CNkn/bRkT6o6x07pRSFNdpX9sKmiYIyphlIwygkfGdB4TH5d
	RS40MKb1jqnTbFIkVOLyCGPdmRJqDGOxnRO5Lh1sH+y5hDu57DNKL6p+JL57ULpAdjszv69/Tlp
	ACYyd1COenJWVE5Ol++2fbJ/hAEZIjWA=
X-Gm-Gg: AY/fxX7GMGLdhM3Mcm1BYZTtluqHqaXV/mV5hFKUlfbB4QIZrxafb0i9OrgFHj/B+ft
	8xyxj3SWXtc/QrASER5YP+1qVCgzt2CGW1UHYoMPN+fNWb9oowCCRMsBBqrFXevCAElH6ORn5l9
	gSFnUF7Y7uAydToJiUUkQPesLAhBp1iruDuIwgj5/eV9D+IGSEaT02LMGaIrKKyTaUmFgE9S4kk
	ak7skPuLEV8UbIOOuUl5zMdpV38D1CSx/IzvZSv0XvtpQRJ5l6L6dPVBb/qfklqTpacPoH+1TSD
	FVdj6bwPC0ZwPCRRNvtskTIeEajh
X-Google-Smtp-Source: AGHT+IH5ZrzzFT5UNwTZptN+H56qkFUXA/Ygb+yPt8+WPgM1uThdV3rrZmNHjr6UFJLqBPNEBxHVHfwADBRcBM115zY=
X-Received: by 2002:a05:600c:638d:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-47d4c8f4972mr206282295e9.21.1767233450902; Wed, 31 Dec 2025
 18:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
 <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com> <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com>
In-Reply-To: <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 18:10:39 -0800
X-Gm-Features: AQt7F2qPTzBBxIXi7mSFxblwdWM4pyxfhqUHnmv1AUlo2Ajz8HPFxUtnTVbWXLM
Message-ID: <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Caleb Sander Mateos <csander@purestorage.com>
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

On Wed, Dec 31, 2025 at 4:28=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Dec 31, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrot=
e:
> > > >
> > > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c=
 b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > >
> > > > [ ... ]
> > > >
> > > > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int d=
ummy, struct task_struct *task__ref,
> > > > >       return NULL;
> > > > >  }
> > > > >
> > > > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > >       .test_1 =3D bpf_testmod_test_1,
> > > > >       .test_2 =3D bpf_testmod_test_2,
> > > >
> > > > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_ini=
t(),
> > > > this struct is modified at runtime:
> > > >
> > > >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> > > >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> > > >         *tramp++ =3D bpf_testmod_tramp;
> > > >
> > > > Writing to a const-qualified object is undefined behavior and may c=
ause a
> > > > protection fault when the compiler places this in read-only memory.=
 Would
> > > > the module fail to load on systems where .rodata is actually read-o=
nly?
> > >
> > > Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> > > init time, I'll leave __bpf_testmod_ops as mutable.
> >
> > No. You're missing the point. The whole patch set is no go.
> > The pointer to cfi stub can be updated just as well.
>
> Do you mean the BPF core code would modify the struct pointed to by
> cfi_stubs? Or some BPF struct_ops implementation (like this one in
> bpf_testmod.c) would modify it? If you're talking about the BPF core
> code, could you point out where this happens? I couldn't find it when
> looking through the handful of uses of cfi_stubs (see patch 1/5). Or
> are you talking about some hypothetical future code that would write
> through the cfi_stubs pointer? If you're talking about a struct_ops
> implementation, I certainly agree it could modify the struct pointed
> to by cfi_stubs (before calling register_bpf_struct_ops()). But then
> the struct_ops implementation doesn't have to declare the global
> variable as const. A non-const pointer is allowed anywhere a const
> pointer is expected.

You're saying that void const * cfi_stubs; pointing to non-const
__bpf_testmod_ops is somehow ok? No. This right into undefined behavior.
Not going to allow that.
