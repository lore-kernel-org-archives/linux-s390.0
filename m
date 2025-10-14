Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A42F2617
	for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454702; cv=none; b=EGjNEbLhRR6kymR7oqKZx0DyACbgfHeUfTu+8MvdUX2SPFWfXlFH6xRyPV1GV3YDjmH+y2P3tof8WUhfsZPhp7dSaOAYWh++/FpzTUSGg9TUSHXCoFOXi3YoGM3+N8MuH0PCPYwaCcwgxDNiQWt139/Uug90KzEwaWZjvUe/GXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454702; c=relaxed/simple;
	bh=ldtXdhDcD5noXeIiZQgZJBdMoBquMUFmAjt6sfVA5AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHISELQeZsHhuQjIexj/gCzlz0qsCUdxbmir0jiPI/DCMWsA1Xiq3DAbiOsATKAxonCR+d33M7eoprxV7B4GgSkW/d0ZGKnum7bc2EhYsY7ufxnYtbYu+6dk5wvnUoaQ2xa89JoQTIMLXLeVdyATpwYrSWYxG3HUWiTpfm+7hU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7ea50f94045so80152436d6.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 08:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454700; x=1761059500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ckaUVvDg5E1Kv0tRjD3tkk4SrmpuBncmnCZzWhCIjg=;
        b=n5j5d5E4Ao62tN4eNboorO+1XpsM0ODE67FzxonI+O9F3/cr0oz7Hs3Wwj5f3yGrEY
         yfnAFYbjky2ConCGzfs1H6RCdesi4PwacU5qd8Bmao1henYy8RWlQvj2tzcGCIqthI3k
         FQNcLEVAX+kqI+gz6IAJaCnMXK3KZzJGUU39oPX2/oSTTON7i/QHlRsXiRAREbf/SPSP
         r1rjU2Vbszv1C0lO2UAais/lFMgW/ZaJG0aqFjmTfm6938+RKflL4fI4r6GyuoEaGrN6
         46yPwhMjWOWzjkPKsQbgPH02dv+4tJ/wcW1NPhQ7lTkD7Cm2/i8vjL5BPuVKYDanZdE6
         hohQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqLkVHpYAv5CdEnV3DwGyOU+blP+A8jiU/Msg+oE6I1rIuLjJsPePLDAg9NMqX4y8otbWoKTY1u5ok@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7//BY3yvNZcDXP5DYc0ltcFm/MSH5hLYFszdfNH+7UlIgUgo
	zzKMfaTlw44MRFd7JcCt8PFEq6V18xL7LqyYOKeHvNVI9wmiNtzWFtcIqR6UnXPn
X-Gm-Gg: ASbGnctmnOvDHap78h6DDjX16Xl0YYrht7tjqJTZeawNRhMC/bIxRDLA7xay5gleI+c
	lYJktbCmwuuQQifWBANfY1J9jPH3CmnSlJQi5BxThPu3XW4svD0mz13z58V+tq4QCrt15yqK1C2
	+1+QtvVj25lYB57ghDYDZszMRnYeUmAL2WRqqCPtFefjc6ERBWJR3MkSKXAD1EerbucsP57ftGs
	rVMRoPLot3bKZQLNym0ZzPEdzksHqiiPOqPSUAUVQA1rXcjXS+Y+KUUtjt1OfAjutBNNj7kKiGR
	cHJNZtZ1PteU2T88EppNr9pHxATYmc0PzYCiRw2x1UO8K/m/I0MNfVPKhYkiFczYDFnCtg45G24
	fkXNtLBm8DzJ9lRuh4jCzjuj9IScBNH9jC/M/3eOPUFBAhMwp/85LV6UMhwr+V0jBALqIYtvyx+
	ZLd4tnQUXZ5zg=
X-Google-Smtp-Source: AGHT+IE5WtCsvZRAnM80PSHf0Hl6l3Mytvi542xIFXvhpa81iLUyBT5XVilor/NEYeSmcNk+66UJYw==
X-Received: by 2002:a05:6214:c81:b0:78e:e882:ac8b with SMTP id 6a1803df08f44-87a052a8426mr440594956d6.28.1760454699620;
        Tue, 14 Oct 2025 08:11:39 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0122d19asm316956d6.29.2025.10.14.08.11.39
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:11:39 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85d02580a07so629954485a.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 08:11:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5W/wSaG1rVnMHTUelG/P577z5Qp6/lfVWPx3qLAYS9IofzcggLdsRbdH14owyjy7lbKdYQfUCmT8F@vger.kernel.org
X-Received: by 2002:a05:690c:6a04:b0:781:556:b7ee with SMTP id
 00721157ae682-7810556c4f0mr161656307b3.7.1760454307894; Tue, 14 Oct 2025
 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041319.1284-1-kprateek.nayak@amd.com> <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu> <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
 <20251014094210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdUD8RZqPL5ZYyJrwJB+XL_Tkn-rsLx7WvUmn6y5M_tAtw@mail.gmail.com> <20251014141730.GZ3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251014141730.GZ3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 17:04:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpFdjDJrMbK8+6aO=O8c8p68RUGe0o1Mo4PMmFLufc9w@mail.gmail.com>
X-Gm-Features: AS18NWCARfLQt44MvWjqR1ybmDP5uvpIwul8XKi8euGj-rQtyjldCOHWrbLZbQg
Message-ID: <CAMuHMdXpFdjDJrMbK8+6aO=O8c8p68RUGe0o1Mo4PMmFLufc9w@mail.gmail.com>
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

Hi Peter,

On Tue, 14 Oct 2025 at 16:18, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Oct 14, 2025 at 02:37:11PM +0200, Geert Uytterhoeven wrote:
> > > > > +       help
> > > > > +         Improves the CPU scheduler's decision making when dealing with
> > > > > +         MultiThreading at a cost of slightly increased overhead in some
> > > > > +         places. If unsure say N here.
> > > >
> > > > So it should default to n?
> > >
> > > That's just help text that got carried around. Many of the architectures
> > > that had default y still had this text on. I suppose we can change it if
> > > someone cares.
> >
> > Please do so.
>
> How about we remove the recommendation like so? There are many help
> things that do not have a recommendation. Mostly these options add a
> little code and the most expensive bits tend to be gated by
> static_branch() so it really shouldn't be that bit of a burden.
>
> CONFIG_SMP was the big one for the scheduler, and Ingo recently removed
> that (he did an effective unifdef CONFIG_SMP=y on the scheduler code).
>
> ---
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ebe08b9186ad..3d8e2025a4ac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -57,7 +57,7 @@ config SCHED_SMT
>         help
>           Improves the CPU scheduler's decision making when dealing with
>           MultiThreading at a cost of slightly increased overhead in some
> -         places. If unsure say N here.
> +         places.
>
>  config SCHED_CLUSTER
>         bool "Cluster scheduler support"
> @@ -77,7 +77,7 @@ config SCHED_MC
>         help
>           Multi-core scheduler support improves the CPU scheduler's decision
>           making when dealing with multi-core CPU chips at a cost of slightly
> -         increased overhead in some places. If unsure say N here.
> +         increased overhead in some places.
>
>  # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
>  config HOTPLUG_CORE_SYNC

Thanks, LGTM!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
