Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA927D760;
	Fri, 11 Apr 2025 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355558; cv=none; b=ADjacDwh1eeNNrkrRU6jEVbZHxT1PI09Qn5om2cadJ8b6l5bM/b2ZJzkTkmHeCNvOmDjwJdkrlqYC4nY7XCCMfGBif9EiZooo7S05JAY2nv4mJxrLKTfZDZnlKUyJASRd4zCaBPG4D3dc5GC57PfTE/e6Vi8NNMWk/BL0CUhCwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355558; c=relaxed/simple;
	bh=mZ5yZ/RRH5jPH/YqF59ciQA4yPAyUYG2Z7W2fOiCoww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XLhcK6tN/RtQ6oWf3Vr3qkeC87rFcS25SBZZ/htThiz3f54ZwBES8nTtzqS17r4B/2fnlxMbOAjc19yiY05rnfw8T/XKVs+fmbEogW1IVkXTTQdDvLzC+be1N6FPTcCkPtP8M++Sxk+4YsaKwawX3uqPTzInjHREn7MQ59JRIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTW0m84Z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTW0m84Z"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1472838a12.2;
        Fri, 11 Apr 2025 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744355555; x=1744960355; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzShCwppEme7OMOnT5z5FD+rJw9aaKOfx1ISsPkjuh4=;
        b=GTW0m84ZCjUe97nVIDfVEFewCEv/JL9SfDQXndJoTQfYt5h0PQNGAjsLTvQwH1sMfC
         /9Ed3iPQFio3xY8t2gxEFxhlgc099oepFFTYSkTpLFJNvRA2pmiqtHJeBGGGM4XWHWYW
         OsVdGo3Aqo/fWnjnB6BbBvUI2GksOcfNrhXtVZBhduK3x/OxgD7Y7bEuKtDEKDfqr0zI
         wOc0FIgrUlul2Nejy4hYi70jFoDaNovyjZhusQPaplXOfX0Ki7LaQLZZuBkvpuochkjo
         poKjs+661eFXfJK9YfDmNHvI/Img3YSvVvnMui+lkroHH23EnZ+BLPkLoauDkT8B4JLK
         XdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744355555; x=1744960355;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzShCwppEme7OMOnT5z5FD+rJw9aaKOfx1ISsPkjuh4=;
        b=oesXQ/Zo0ocHJUFXHCnGih2yHNkp7OCLCkDIb5US6cyc+sXxnvXjM5bRzXBVad97/D
         NUCITSwylTvusPMGI6jC2gXf5OWVN7wtuffBXtlhT67ZPLFhUF0lhvaj2ue8oLnXUsKg
         MDP3NoqI926IV5dMOOPSczmaBFQ+AhIxgSdNgy/lzguvayYbBVlDXq+QddOyrUX3vX9B
         QU5KivGPoUTNbFodpq+98zb1ukkw0+Tph8ggLm/NQPMbkhNSYPCUWj9kGst3G4F0+yp7
         eRaeYpf0z0UuPdNijxTznMuyOD1FyGFPfr+9lAza5llWOiQDSBnssWVxxmDeoimb8QxE
         r6sw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kLmmMo/iugTBda3rExPVhWoFMIkGeyyYU2awBdKrWzdXK2EXy5OcJZg81mtpd6sbTGOHHdR7xvm7fg==@vger.kernel.org, AJvYcCWNU3LJ1TAWr1zTt3aCojcu8o1LMBGP0FfV6hOaxgAbi8zys3jmRENhlvOz2u51QCEzE3pYEaVitv3Xd/s=@vger.kernel.org, AJvYcCXnP2eBT2dnoAfvdyc9JzAjhZYMR2b1pKrgT5q/RXZOF0Uh5DTeTvJ85kWOh6sJAtrKmvFMCjMEO1EbVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKM7XqkUSfSfVlP04WAu4Hj50cGxtTFCH2khK6jxWkvRm392A
	d4CZxFxICxI5emXFQt+fa6oaESyxHRzUtfYPZ0YclkI77hboGO22
X-Gm-Gg: ASbGnctlYEferU/hFw1OUAgpN1t6CMN4v69xWkKTww/DJe7IHHPKTUzAmbl/iqW6iae
	BdBpKEj3CiXJdU4Np9MTzXQ+r2sk3K6F5mVzlfKHy+k6d5WQEpmulSvOm+UKn8uN9o2LSFH0mAR
	hqe6GsfMu8WxePqYXv7OXwZZ4a1Ww0jeJq58+39FewyQDrGGDprHU4CqqXRBVz5KPn6XRak3he6
	kMJhLc6ikP2Vj1t6SSYjC55dm02vANml8G3+ejAMxb0gOus9RS5snPYA82e3Ey1miNPpu3oSfzc
	oNohYoUm1yWbn2Z/S/T5lQVeYrzZwiZoZw==
X-Google-Smtp-Source: AGHT+IHpSOk8rGIiMZXty/hbuCSKlXyveZLgB4pNTJ04Shha/BPkKtAvaM61qadHeDDYt8o+ld2JZA==
X-Received: by 2002:a17:90b:5245:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-3082377c271mr2980340a91.11.1744355555591;
        Fri, 11 Apr 2025 00:12:35 -0700 (PDT)
Received: from localhost ([220.253.99.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171942sm4948139a91.33.2025.04.11.00.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 00:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 17:12:28 +1000
Message-Id: <D93MFO5IGN4M.2FWKFWQ9G807P@gmail.com>
Cc: "Hugh Dickins" <hughd@google.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Juergen Gross" <jgross@suse.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <kasan-dev@googlegroups.com>, <sparclinux@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] mm: Fix apply_to_pte_range() vs lazy MMU mode
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
X-Mailer: aerc 0.19.0
References: <cover.1744037648.git.agordeev@linux.ibm.com>
In-Reply-To: <cover.1744037648.git.agordeev@linux.ibm.com>

On Tue Apr 8, 2025 at 1:11 AM AEST, Alexander Gordeev wrote:
> Hi All,
>
> This series is an attempt to fix the violation of lazy MMU mode context
> requirement as described for arch_enter_lazy_mmu_mode():
>
>     This mode can only be entered and left under the protection of
>     the page table locks for all page tables which may be modified.
>
> On s390 if I make arch_enter_lazy_mmu_mode() -> preempt_enable() and
> arch_leave_lazy_mmu_mode() -> preempt_disable() I am getting this:
>
>     [  553.332108] preempt_count: 1, expected: 0
>     [  553.332117] no locks held by multipathd/2116.
>     [  553.332128] CPU: 24 PID: 2116 Comm: multipathd Kdump: loaded Taint=
ed:
>     [  553.332139] Hardware name: IBM 3931 A01 701 (LPAR)
>     [  553.332146] Call Trace:
>     [  553.332152]  [<00000000158de23a>] dump_stack_lvl+0xfa/0x150
>     [  553.332167]  [<0000000013e10d12>] __might_resched+0x57a/0x5e8
>     [  553.332178]  [<00000000144eb6c2>] __alloc_pages+0x2ba/0x7c0
>     [  553.332189]  [<00000000144d5cdc>] __get_free_pages+0x2c/0x88
>     [  553.332198]  [<00000000145663f6>] kasan_populate_vmalloc_pte+0x4e/=
0x110
>     [  553.332207]  [<000000001447625c>] apply_to_pte_range+0x164/0x3c8
>     [  553.332218]  [<000000001448125a>] apply_to_pmd_range+0xda/0x318
>     [  553.332226]  [<000000001448181c>] __apply_to_page_range+0x384/0x76=
8
>     [  553.332233]  [<0000000014481c28>] apply_to_page_range+0x28/0x38
>     [  553.332241]  [<00000000145665da>] kasan_populate_vmalloc+0x82/0x98
>     [  553.332249]  [<00000000144c88d0>] alloc_vmap_area+0x590/0x1c90
>     [  553.332257]  [<00000000144ca108>] __get_vm_area_node.constprop.0+0=
x138/0x260
>     [  553.332265]  [<00000000144d17fc>] __vmalloc_node_range+0x134/0x360
>     [  553.332274]  [<0000000013d5dbf2>] alloc_thread_stack_node+0x112/0x=
378
>     [  553.332284]  [<0000000013d62726>] dup_task_struct+0x66/0x430
>     [  553.332293]  [<0000000013d63962>] copy_process+0x432/0x4b80
>     [  553.332302]  [<0000000013d68300>] kernel_clone+0xf0/0x7d0
>     [  553.332311]  [<0000000013d68bd6>] __do_sys_clone+0xae/0xc8
>     [  553.332400]  [<0000000013d68dee>] __s390x_sys_clone+0xd6/0x118
>     [  553.332410]  [<0000000013c9d34c>] do_syscall+0x22c/0x328
>     [  553.332419]  [<00000000158e7366>] __do_syscall+0xce/0xf0
>     [  553.332428]  [<0000000015913260>] system_call+0x70/0x98
>
> This exposes a KASAN issue fixed with patch 1 and apply_to_pte_range()
> issue fixed with patches 2-3. Patch 4 is a debug improvement on top,
> that could have helped to notice the issue.
>
> Commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash lazy mmu
> mode") looks like powerpc-only fix, yet not entirely conforming to the
> above provided requirement (page tables itself are still not protected).
> If I am not mistaken, xen and sparc are alike.

Huh. powerpc actually has some crazy code in __switch_to() that is
supposed to handle preemption while in lazy mmu mode. So we probably
don't even need to disable preemption, just use the raw per-cpu
accessors (or keep disabling preemption and remove the now dead code
from context switch).

IIRC all this got built up over a long time with some TLB flush
rules changing at the same time, we could probably stay in lazy mmu
mode for a longer time until it was discovered we really need to
flush before dropping the PTL.

ppc64 and sparc I think don't even need lazy mmu mode for kasan (TLBs
do not require flushing) and will function just fine if not in lazy
mode (they just flush one TLB at a time), not sure about xen. We could
actually go the other way and require that archs operate properly when
not in lazy mode (at least for kernel page tables) and avoid it for
apply_to_page_range()?

Thanks,
Nick
