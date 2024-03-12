Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F4B673
	for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212195; cv=none; b=HraRvLCAtX6CJdiBHAsplvVSU7CCALT0LO0Oq7C4vLPeZXM6Bp/qhYARbQH2ECFBAkXeHXMOQjYlPU5KBepUhnf11B39WU92dIvOwgTdy9BoEs9q7/R9UMKoxF0vtwzsrGAgNFs4sKdOl2/vurhXipHHm8Rgy4QrAd7jSH5xaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212195; c=relaxed/simple;
	bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HagPZUrwZOCzDoPRxuK8qtlqBDVdU2yyfqIjL7URJVjz2lHrQ8jP57j+79S6rWJhGo4rfjq1qAf5VUwgSeO61W7pqESy+MT9PGjUbpkKX9hZ4DXQf0NCtk4guahbU8q4KTl9E2/cdnU0c8XEeVFa3sLS33LK+r2UIZLpEEdES94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d2Ova4t3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d2Ova4t3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29bf998872fso1081553a91.3
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710212192; x=1710816992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
        b=d2Ova4t3LH8K/YV1te1DCzhVl3PLbvJaG/iY2pzTDJkcosWx6A/MdUZ/mM4MW9sfUR
         GQ5sY5+buMi0xl8pZAl6oybDues4UiLqfZLkGdHy7hPxqm0DSdeog5UKj7At1YM1DJbF
         l6UuGZe+F+ck+GPIQFyxK9ZWsB8KHcJnj8TP5e3nSaFDsrIcxIZjimixhc84Rouc2Ru1
         jU20/9p6MyfoCzVO+QitGrjhtK31dySWPAfyxG2PMVfo2ka/f/+TxRDVMZ2SEVhhX4tC
         +C70CU73YnvAnGtEokTXbWYERGIAFzRa+RhVapWsKkGeZhM3DUaa0u5ykhQUncKB7WlF
         EL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710212192; x=1710816992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8duYlw7yiLaMQiEjvPs64/nXpWh4xT1l7do/uy0Ifvk=;
        b=XyWtZ3SRiTQ9bJbfYdapceQbI5OJ4AoTimCM4KhorVT2AvBRoaqYVK3fRnGNNlFiNi
         56jYi+pNUOhSCdDDP5vylZRtrRKmDX1NvpQlmCuitZQwl4Vzp7BMICrBdwY7zP+hU5uK
         2uFNnUwcr06Ik6C5WBQOdv33pyVuqJ3+s2NOBvRzdXVMk/Y4269LZI6fbz5O+I8/J3xO
         lVXSohCkXBQm4W4fKgibb/zUfBQZCYWQ9Z//dsvlS6qiHRIxvgnmGmu+vjHUDRADxRty
         Fd4Ba6h/65bB9EcWCKp4MV/sfXIf0Yx2FXk5lOtsaLKret5dd7FNt6oLMVFbXp/e0nm2
         i7iA==
X-Forwarded-Encrypted: i=1; AJvYcCXK0Peytv+ELUa+7le6b2WZlLM90Fx/cj0N30p+maQurI5QUaVEKO8eS2QIVbuwxwoqkUiA85MkhQEL0PBsywXVH46zwMudi7fdPQ==
X-Gm-Message-State: AOJu0Yxl8iOdiX3UTPrtp/xWzg7zgS4j8Q5+Rpz5EpU9M9HHZTSFVvSW
	Rkhl3czwdoQbKggDXdlNsHGW0cTfT2yi/slgEzLOJOS7DAO/eV8myuxCOpR5QqK9ftZRLPGgbYV
	xa3cpj/GIxaZlgSuZKSuwO2pGYn5TOvuZYhZTlA==
X-Google-Smtp-Source: AGHT+IEEbNdZpfvWrZfgFQVH2ecv7uQ4oHjBsb6d+e9PBZQkR1FkO3HlcgN1IPWibJVLKEs+f74flvYnRRAAWujNw0M=
X-Received: by 2002:a17:90a:f305:b0:299:63fe:3a27 with SMTP id
 ca5-20020a17090af30500b0029963fe3a27mr5454778pjb.19.1710212192599; Mon, 11
 Mar 2024 19:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-8-dongmenglong.8@bytedance.com> <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
 <CALz3k9iabeOwHSrPb9mkfCuOebanh3+bAfi7xh3kBBN0DzHC3A@mail.gmail.com> <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
In-Reply-To: <CAADnVQKsrLB-2bD53R4ZdzUVdx1aqkgom1rzGCGKK0M3Uc+csQ@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:56:21 +0800
Message-ID: <CALz3k9jJtxVRmgGM4F-33m1wp=aCShnqdaX+7pZ9UmHwntFgXw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 7/9] libbpf: don't free btf if
 program of multi-link tracing existing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:05=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > > >
> > > > +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> > > > +
> > >
> > > It shouldn't be exported.
> > > libbpf should clean it up when bpf_object is freed.
> >
> > Yes, libbpf will clean up the btfs when bpf_object is freed in
> > this commit. And I'm trying to offer a way to early free the btfs
> > by the users manual to reduce the memory usage. Or, the
> > btfs that we opened will keep existing until we close the
> > bpf_object.
> >
> > This is optional, I can remove it if you prefer.
>
> Let's not extend libbpf api unless we really need to.
> bpf_program__attach_trace_multi_opts() and
> *skel*__attach() can probably free them.

That's a good idea! Should we add a "bool free_btf" field
to struct bpf_trace_multi_opts? bpf_program__attach_trace_multi_opts()
can be called multi times for a bpf_object, which has multi bpf
program of type tracing multi-link. Or, can we free the btfs
automatically if we found all tracing multi-link programs are attached?

Thanks!
Menglong Dong

> I don't see a use case where you'd want to keep them afterwards.
