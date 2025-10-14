Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC098312802
	for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445448; cv=none; b=nOhbVUVMQw7d7sUlVfXs0R+nrCHukBO6XIAWt1wmoCbfsrF4CKSUQTKT2tpRj2i1wFksat70ORXrqJy1ODKCNBXteSUa0dBwLr9K9Pda0XCMghDk46sR1G0PtzgAFOgdJiUkAWuKpogYr/qgRkN/M6np6fy4JBIlvCcpeHwJlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445448; c=relaxed/simple;
	bh=RIfWvbV5qR2Jc9YKaUmr9BCFgP/FhvLoQholBe4TpL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTj8AlueALaC7ymKPvXs+1idfH3XoWv+jVVvrQA6e26M4FZjAL1BELsIPCJ6dbYizAHwRFTtPmHEmgnwFAM7R4H+5DFsTj0/ds/jJL5aBeS5z4eWOmSnspCe8vRvlGD1c2S0lOOSZhFgEzvB8FMolujeQCsJi0zGP4IlvxyJDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8e936be1359so3154426241.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 05:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445444; x=1761050244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNxEU7KyfBYhfmf3Lx2LLvPMpGLQ7HkB7d0pkrjoK9E=;
        b=nn5IUX4cuS6RcMtdxbnAN4vpgGQ2+7aD4VPqhzkdSCEOu+lvW6g56MI5s6Kd22UwtF
         7SNfO0nbM2mLS46MhcCd7cV7i47TH3FyTzxLK7a4Xd0RrLXneI5HjzxYsJrI1C1yy8uX
         IRUVPqM7GgXOTglfVzA9Ujc9QHj3VLyzNJ4ptgv3uoAXHTiZ2O0FzzprORiVpKyGXJDI
         5+0zNbgdoloEQNPDz1I5WsXAkK5dNhSlGhFsW6Q8bWt6GEvXOecveBnzYG0Y4gFf3YaO
         wUY1olgmyLiGNNPUVIaTcXzy/JRu3Ihx/2FYMKKJbEyc/xBgK/uvU4THIm5y0iW+BQnD
         0NKw==
X-Forwarded-Encrypted: i=1; AJvYcCU+rkC0nB9U+xD1mKrCDgQenyMdl6LDmSwyXYfGZ3o2vNwpA05kEYaJZoCH3N/9kNG5hX5KL1NjXhkG@vger.kernel.org
X-Gm-Message-State: AOJu0YxgVvTUa89mOMcD+NtzF3+m1sVPVZeSZ+3rUsKpXNR4XnXrM6oQ
	4nVTCFRWCFCSt0iVsgThSl7C5eWRrOvcySTxyNZPOGFMRyn6e0zht3XwapVA9i+K
X-Gm-Gg: ASbGncvMmOe731sI9CsSmICC9EwHNQkLEWvXFt2gL+jBaRf3PX2FlhiARE3YE7rXNtm
	LBheCfZWF/EdOC1GQrgYLOM6kLgK2fCQVM2hrz+eA3SLHCsRYx2cUrhzea9uac0x1ch/Kcm7VLi
	0+4PwdbQCrqyHkET8KmBKd4aplI5p1qo03HykweYDLDY9dP1cNiI2iQhH00d7FzGjfoYhDpV9wH
	ndS/g8aKsCRMgav1JHv44SpQ6cgGWZPAdX9QEH+ajB5kbte3PRYv4Cw4FZjX1WnxKayo4iFF7K8
	ndqqIRE52T7cX2LAQYg0ZgE/WdDkz5EamZBegFn0Ry20HSP53QQFR6XaIks3JzMM/oO4u+pXAxd
	4c6y84h26fI6pdGYOx7Rb0r/pppSA5t294WYE6f+lET+uFaZa6qDBCKDBBg+Q2GNpJa6rMF3NRG
	cXVu3w/7U=
X-Google-Smtp-Source: AGHT+IEC0PKtw1NhpIVr8m1fp+8dLE7gCISY5L8zu4jZwRr4k1yoTmek0L/sYzOpo4HtoZ8K87RPKA==
X-Received: by 2002:a05:6102:8385:20b0:5d5:f765:f536 with SMTP id ada2fe7eead31-5d5f765f590mr5541582137.1.1760445444270;
        Tue, 14 Oct 2025 05:37:24 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc713dbasm4209621137.4.2025.10.14.05.37.23
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:37:24 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso5883593137.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 05:37:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN1NnP8Ci8lrasb11qxe+7uImz80zVMQsJiOpW8DVkBf+eAhsjPDruCLztzcfn91npZg+CkJyWMu7W@vger.kernel.org
X-Received: by 2002:a05:6102:a51:b0:5d6:3554:2dbb with SMTP id
 ada2fe7eead31-5d635542e5dmr527665137.16.1760445443647; Tue, 14 Oct 2025
 05:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041319.1284-1-kprateek.nayak@amd.com> <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu> <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com> <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 14:37:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com>
X-Gm-Features: AS18NWC3_aMtxy2dnl_M3on8VhWCTedTTMBJW4khUhDoS9xyzcvkRTZ1BETpTHo
Message-ID: <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard MC
 scheduling bits
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, thomas.weissschuh@linutronix.de, 
	Li Chen <chenl311@chinatelecom.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Mete Durlu <meted@linux.ibm.com>, Tobias Huschle <huschle@linux.ibm.com>, 
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andrea Righi <arighi@nvidia.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hoi Peter,

On Tue, 14 Oct 2025 at 11:42, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 14, 2025 at 11:25:53AM +0200, Geert Uytterhoeven wrote:
> > On Thu, 28 Aug 2025 at 14:57, Peter Zijlstra <peterz@infradead.org> wrote:
> > > Now, when I look at unifying those config options (there's a metric ton
> > > of crap that's duplicated in the arch/*/Kconfig), I end up with something
> > > like the below.
> > >
> > > And while that isn't exact, it is the closest I could make it without
> > > making a giant mess of things.
> > >
> > > WDYT?
> >
> > Thanks for your patch, which is now commit 7bd291abe2da09f5 ("sched:
> > Unify the SCHED_{SMT,CLUSTER,MC} Kconfig") in v6.18-rc1.
> >
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -41,6 +41,44 @@ config HOTPLUG_SMT
> > >  config SMT_NUM_THREADS_DYNAMIC
> > >         bool
> > >
> > > +config ARCH_SUPPORTS_SCHED_SMT
> > > +       bool
> > > +
> > > +config ARCH_SUPPORTS_SCHED_CLUSTER
> > > +       bool
> > > +
> > > +config ARCH_SUPPORTS_SCHED_MC
> > > +       bool
> > > +
> > > +config SCHED_SMT
> > > +       bool "SMT (Hyperthreading) scheduler support"
> > > +       depends on ARCH_SUPPORTS_SCHED_SMT
> > > +       default y
> >
> > This is now enabled by default everywhere, while it was disabled by
> > default on most architectures before...
>
> I'm not sure ARCH_SUPPORTS_SCHED_SMT counts as everywhere, but yes.
> A fair deal of the architectures had all this default yes, and I had to
> pick something. Can't make an omelette without breaking an egg and all
> that :/

OK.

> > > +       help
> > > +         Improves the CPU scheduler's decision making when dealing with
> > > +         MultiThreading at a cost of slightly increased overhead in some
> > > +         places. If unsure say N here.
> >
> > So it should default to n?
>
> That's just help text that got carried around. Many of the architectures
> that had default y still had this text on. I suppose we can change it if
> someone cares.

Please do so.

> > If it is really needed on some architectures or platforms, I guess
> > they can still select it explicitly?
>
> There were 4 cases:
>
>  - arch doesn't support SMT
>  - arch supports SMT and lets user pick, default Y
>  - arch supports SMT and lets user pick, default N
>  - arch mandates SMT
>
> Of those 3 are still possible, the one we lost is the default N case.
>
> Old configs that have =N will continue to have N. New configs might end
> up with Y.
>
> Why is this a problem?

While old .config files will see no changes, old defconfig files do
need updates.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
