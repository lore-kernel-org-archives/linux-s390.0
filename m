Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AA2DCF7B
	for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433969; cv=none; b=JAgVK7xEhQ0Eybw2JgmN+XTgQI8T9wL6oChFDTyZ1mjZg0f+6SSNAUoWI8IdsDR3AcWauUTzseV+/YneQbVJzS7RCdtgfnFMyuoLntQFsQY3DUFPvy0QAzffdkWJ+nqHc5BeqvCyZFkDOInV10WznhYkaZyrt0ntsD6g6m1KiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433969; c=relaxed/simple;
	bh=pkxa8puQtgGel9mbOE5DfNSU9jrsaW0tXQm2k4FGibE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrMWTJvLlAgHdkgjLyLcIw9O//4aDVTv1w6P6jKzyNpPsk+0Shpamj1iFTnrdV5jcX9zWlHO7feXhcZDE5sFX6KalT56U8eYqgW7Xco843j0i0QRArwjAcDOqXQyXc5Oy+U/LFK4u0EBvEXymsDnAD0lw361D6JY2XbsFrHY5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso1871863137.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 02:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433965; x=1761038765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpBgoDCD1NZyU8yXWBy8hXEWr5MI7i37aL5+z3xg+Dc=;
        b=GGFPvE/U4BoP6WPtVzCEwI9GaL+6Ma+QC4OGs93CajL3n66dphj5Rv/zr/np8EYYHf
         t+7xjsKA21XU176/RY+TZmuPzQ+IxxOHTX3GfoAWKFB79I4OX9PMhKcphpY0+Y8Deikr
         s/1xNhqsBHPqI5MF0jVa6mdUsbaiw7bpeqrIfj8d1DvRhyepAIZwWLmkK2WQ5V7TBKo8
         7xWQ+KdlwsXG9fFajqWPptP043oB7uNSNonQIEtGEKWPGulXxhQMAf1AFi0f2uhdaKQv
         stypb59ZAmmfN7pDRGFDFI54ZD7xnG7efllxvqEK42fGnrFko8YIrrSGiKMoyoTAuAWj
         CMxg==
X-Forwarded-Encrypted: i=1; AJvYcCVyDTNRHUuYSQCQivbwnDXFSnrX9HZfmctP2n1z96bRmbWA/9+FHjKyGJ8+eq1sOTFh4RuREUfW4FFM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FfmmbqWxtuVG6HdzbvCugFXMtRYd5GjDPrGgj+iUX7DWfoks
	oGB80YGCIe2Q5u+w7G3R1X5iZTlHdHlq/Anguoeqg3peKzUUVmK50trA43/74QKt
X-Gm-Gg: ASbGnctUOsCLkUaS2tzL2hVA1I4kW3fuQ8vkcwBMcn0Krkvdi7EgX7N79en/9sPE1XO
	Qm2JRAgB+8kV9KP4pfOG4sy3Gdk5QikjhOcEtGKLiwHEvXx4yiSZfRlcfIBCsFOSuiXKyexP9cJ
	EZSmq7oqE4kU3AGp3JV8WVKHUn2VI/H3RktEkvvooSkvU7xmvicqiht1CWKDrKiEkMICTEYEdmW
	YhKD1KVDOtDNFEcKf6sp6CNxOMIG9FXHZjLn5Zv58jEBXCPGyRvemBBAI9T+qzb9HKXIMPOEqDD
	jIUTEpw2iL2qT29Fj2oeLhr7eEtWJRhmZxmvZP0kv5uQTTgFO6M/NFUMmJS7pcypJNtHavG74E+
	dAAvSmlcudTFXS/RUTfiZUNW9Jg9xerSzAtjeP+7RMRJJIO2dU0w2EhfRZggighPrKcS1yfWlNp
	RzXqg=
X-Google-Smtp-Source: AGHT+IHs1wMwjSNq8kVUn7HZzRLWf+yJORgk6qlcs7bRZT0kIgzGQoVWb3+4sxRxEFn3gTQN1jzHFw==
X-Received: by 2002:a05:6102:5121:b0:5d6:36fe:2c8c with SMTP id ada2fe7eead31-5d636fe2cabmr131961137.13.1760433965331;
        Tue, 14 Oct 2025 02:26:05 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80aab53sm3890409e0c.15.2025.10.14.02.26.04
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:26:04 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5838680e242so1493184137.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 02:26:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUNovHZXmVUIwujkcGZiMY/GeGFGvIEGiGnW54nO0CXT1weiuZnL7jzTziwwui+JxGQixeLhBVxUbl@vger.kernel.org
X-Received: by 2002:a05:6102:161e:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-5d5e2278aaamr7047842137.12.1760433964277; Tue, 14 Oct 2025
 02:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826041319.1284-1-kprateek.nayak@amd.com> <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu> <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 11:25:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
X-Gm-Features: AS18NWBTuiqEZg-SFYGrxqYZDbYb0o6XrCJ3YERltbZU5Ho7kkUOk_8aIEnP1Zk
Message-ID: <CAMuHMdWMkKFLEZ34j=JV0Ls+o80UfC6s3yD5x-9G2K8ZV-Y-9w@mail.gmail.com>
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

On Thu, 28 Aug 2025 at 14:57, Peter Zijlstra <peterz@infradead.org> wrote:
> Now, when I look at unifying those config options (there's a metric ton
> of crap that's duplicated in the arch/*/Kconfig), I end up with something
> like the below.
>
> And while that isn't exact, it is the closest I could make it without
> making a giant mess of things.
>
> WDYT?

Thanks for your patch, which is now commit 7bd291abe2da09f5 ("sched:
Unify the SCHED_{SMT,CLUSTER,MC} Kconfig") in v6.18-rc1.

> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -41,6 +41,44 @@ config HOTPLUG_SMT
>  config SMT_NUM_THREADS_DYNAMIC
>         bool
>
> +config ARCH_SUPPORTS_SCHED_SMT
> +       bool
> +
> +config ARCH_SUPPORTS_SCHED_CLUSTER
> +       bool
> +
> +config ARCH_SUPPORTS_SCHED_MC
> +       bool
> +
> +config SCHED_SMT
> +       bool "SMT (Hyperthreading) scheduler support"
> +       depends on ARCH_SUPPORTS_SCHED_SMT
> +       default y

This is now enabled by default everywhere, while it was disabled by
default on most architectures before...

> +       help
> +         Improves the CPU scheduler's decision making when dealing with
> +         MultiThreading at a cost of slightly increased overhead in some
> +         places. If unsure say N here.

So it should default to n?
If it is really needed on some architectures or platforms, I guess
they can still select it explicitly?

> +
> +config SCHED_CLUSTER
> +       bool "Cluster scheduler support"
> +       depends on ARCH_SUPPORTS_SCHED_CLUSTER
> +       default y

Likewise.

> +       help
> +         Cluster scheduler support improves the CPU scheduler's decision
> +         making when dealing with machines that have clusters of CPUs.
> +         Cluster usually means a couple of CPUs which are placed closely
> +         by sharing mid-level caches, last-level cache tags or internal
> +         busses.
> +
> +config SCHED_MC
> +       bool "Multi-Core Cache (MC) scheduler support"
> +       depends on ARCH_SUPPORTS_SCHED_MC
> +       default y

Likewise.

> +       help
> +         Multi-core scheduler support improves the CPU scheduler's decision
> +         making when dealing with multi-core CPU chips at a cost of slightly
> +         increased overhead in some places. If unsure say N here.

Likewise.

> +
>  # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
>  config HOTPLUG_CORE_SYNC
>         bool

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
