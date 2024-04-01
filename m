Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AB17FD
	for <linux-s390@vger.kernel.org>; Mon,  1 Apr 2024 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938511; cv=none; b=lPGeJ1bwfxHX87YzFs5tydSezGqOXPVH3nTYpBAKHVCo1j/WxaiIFDJ85bPOrsx95d51PN18Cr0IH8o9/Fr3VVIT5SSt2TJ4iLX6VbiIS1UGSjueglCNbFoJF1B+5tqrLT4d6Ve5LlMU14+ilm8imtWOhTajWbXSPfvSuvCVrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938511; c=relaxed/simple;
	bh=lKYTnWKj8aFybgNfcmvkcPZSxsoRl/ozkQQU3rEQW/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xznt+sXoiEs5xVdFGUUUkAPA089fmBKUsWAybdva2yStRkf0l5u6wZWKUGBF1sMPjYbwCnsr+hhsDarTTStlviEt7+jlUK/VhWo5GpqiU8uG1KWRLSGaetB3j0U+/SJle/CW2Yq8WvWwwd2LqRPivMjVycR75dtO5VnGKHsK6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P9LU1I5j; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P9LU1I5j"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso3468368b3a.3
        for <linux-s390@vger.kernel.org>; Sun, 31 Mar 2024 19:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711938509; x=1712543309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXMeLoImPZ33R4zJ3SWpn56WCPhsxXC6Los6ajh1i8M=;
        b=P9LU1I5jukjBMKO1LqMu6jlbfGHWLyHQxqQEbnkNnlfzzWygJn8dddUXQxUiTYGYJk
         pIU80nb/2WZVl3/N78k9aRjLZDKKH6J8167B9QXy68cqQHfQubEORLoFjlDhJVM7VM3B
         6Na+rY+eTZa0JSAL6z3h7R/HVgj9AeTdTOE8/TY6IYzAzKStiN8pUlJs4+N6Qa/6A3ya
         7EDlKJEIHYKWInZL5oH0u5OH7XiI1OuKJWLwWhynNDiDm4rNYpwWeBGxtyJngpicWEL+
         88rxTY76vW1XtH7NDjlmMxvBnSri98lhy/GpFpqlgYW5itg2Oxs+cqcpgtblJ2t/vYuY
         YDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711938509; x=1712543309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXMeLoImPZ33R4zJ3SWpn56WCPhsxXC6Los6ajh1i8M=;
        b=IjnLOSMBdLSZkNV9FxL0/dkn3BCiikO4zLsODlkgsEOmM/0Emfsqqd0jXojJFYejds
         0eovD1kx2MHAuJ2QxTDme6RP2cC/8O5B++tkDoz6RFYB0fhVSBn66zMDNJCzdqpHz+pZ
         Gm3sPa2wDQqyhpz35TxB+P2b7ZlHM2CV8ZyjELtdcedO0834QPMWwfZr6VVpsj+E5qhx
         fO1lQlVo06A3l1Oct775DU9WZ5kH0792gZvqY7W4Y/tC7mSFqwozXfImKl6Zz9M00aJp
         KxT8OqESmixrK0oAYYugKm7u2FadXH6GDRyj1fq8UL9UCvmNSiMyOGs/A5qrNOb5Jgl5
         kNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvLslnQE2hIIPwXlRC58AXWh+xefU/LMrBgtcxU0xcQJLPenxtfe1Nufm6M4lrEkE7UMOg5zWq9MtGAW78y9n0Jf/ZiY+xsEokbQ==
X-Gm-Message-State: AOJu0Yx4KGtWJfapLeBwCQernlLbBgHdi4CvAaRbGbkXLNTbw98gBVhv
	6sNYpr1amkBFyeTinHaiFAxrFLW15olCb1gCQKXQi21Vi6XIp+eyQFPmaAv8Ns9nvsZJ0eSH6KQ
	aPjn85jOFsUkT8ZIxuG98k5MvBTU1iD70iPv/MQ==
X-Google-Smtp-Source: AGHT+IGzGQQaneP5xALvw57pZKTHGiCwen67uykrwqg6rWGJrnO4HP/K70Vm6Xhliw5Ne2x0YoSn10U7kH5Lflzm9D8=
X-Received: by 2002:a05:6a20:550a:b0:1a3:6a74:2e6a with SMTP id
 ko10-20020a056a20550a00b001a36a742e6amr8586402pzb.14.1711938508724; Sun, 31
 Mar 2024 19:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home> <CALz3k9idLX10+Gh18xWepwtgvp4VZ3zQfY4aoNXn0gCh8Fs_fA@mail.gmail.com>
 <20240330153722.65104301@gandalf.local.home>
In-Reply-To: <20240330153722.65104301@gandalf.local.home>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Mon, 1 Apr 2024 10:28:17 +0800
Message-ID: <CALz3k9j_RGqSMdN+GvbHEjRqMWYe4R9VNZRANG7jbfL_jVpoVg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 3:34=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sat, 30 Mar 2024 11:18:29 +0800
> =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
>
> > > If you really want to have thousands of functions, why not just regis=
ter it
> > > with ftrace itself. It will give you the arguments via the ftrace_reg=
s
> > > structure. Can't you just register a program as the callback?
> > >
> >
> > Ennn...I don't understand. The main purpose for
> > me to use TRACING is:
> >
> > 1. we can directly access the memory, which is more
> >    efficient.
>
> I'm not sure what you mean by the above. Access what memory?
>

We need to use the helper of bpf_probe_read_kernel
when we read "skb->sk" in kprobe, and the "skb" is the
1st arg in ip_rcv(). And we can directly read "skb->sk"
in tracing, which is more efficient. Isn't it?

> > 2. we can obtain the function args in FEXIT, which
> >     kretprobe can't do it. And this is the main reason.
>
> I didn't mention kretprobe. If you need access to the exit of the functio=
n,
> you can use Masami's fgraph update.
>
>  fentry -> ftrace_trampoline -> your_code
>
> For fgraph:
>
>  fentry -> ftrace_trampoline -> fgraph [sets up return call] -> your_entr=
y_code
>
>  function ret -> fgraph_ret_handler -> your_exit_code
>
> And you will be able to pass data from the entry to the exit code,
> including parameters.

Yeah, the fgraph sounds like a nice solution to my problem.
I'll have a try on it.

Thanks!
Menglong Dong

>
> -- Steve
>
>
