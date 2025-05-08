Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C51367;
	Thu,  8 May 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746662756; cv=none; b=TvkZmZHtoPv+2//Ifita5YxuyrCauIb8q5IJLOU9+5FjhJvlp0HEuQxRR/z2EFwslIerrkhnQfYaO7tvVn0XI5GHe+x/D1J9//crvn5glrPT8Fe8LfpniyBhsU2V0vBMPUzAUIAYlmGmpjihYr1KtsHOm81D2BYw/au0sF21vPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746662756; c=relaxed/simple;
	bh=/CfN2fzHSTtiqT3tfUd7tdwMutcgTvXdnVYD4tdfri0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UlkTFN2kFWVBgauW8YLv5Hm/5Dayvwh7P3mHHt0jZscNkSIULKA4Xgwd2IuLFcxfGXRwk70yVbiykY6211E6XH1RAlS6fa2FsrUGpkiiKMK8FdncHiG84jaY0Oo0f8YR55OZi3WuQ34Zsmw9DW2z/wFIVcJByHT/Pm+uBvk8qKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JkIjJsRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JkIjJsRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DB8C4CEE2;
	Thu,  8 May 2025 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746662755;
	bh=/CfN2fzHSTtiqT3tfUd7tdwMutcgTvXdnVYD4tdfri0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkIjJsRfOUWjpcXtTKOyQRmJVattxIc8eAA843v35EmDENHsSVACMuLgcrASxC+w2
	 NGX6tnUBRw3k4jg8hFDmEdeXZHa38tx3S0Ow1bPnqATzhiBVYTeO9hZmhV5wW9V2o5
	 L0USev11lMIuDnoDnj9H1lsc4HdGp3tVnbqtJyro=
Date: Wed, 7 May 2025 17:05:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Daniel Axtens
 <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-Id: <20250507170554.53a29e42d3edda8a9f072334@linux-foundation.org>
In-Reply-To: <0388739e3a8aacdf9b9f7b11d5522b7934aea196.1746604607.git.agordeev@linux.ibm.com>
References: <cover.1746604607.git.agordeev@linux.ibm.com>
	<0388739e3a8aacdf9b9f7b11d5522b7934aea196.1746604607.git.agordeev@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 May 2025 14:48:03 +0200 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> apply_to_pte_range() enters the lazy MMU mode and then invokes
> kasan_populate_vmalloc_pte() callback on each page table walk
> iteration. However, the callback can go into sleep when trying
> to allocate a single page, e.g. if an architecutre disables
> preemption on lazy MMU mode enter.
> 
> On s390 if make arch_enter_lazy_mmu_mode() -> preempt_enable()
> and arch_leave_lazy_mmu_mode() -> preempt_disable(), such crash
> occurs:
> 
>     [  553.332108] preempt_count: 1, expected: 0
>     [  553.332117] no locks held by multipathd/2116.
>     [  553.332128] CPU: 24 PID: 2116 Comm: multipathd Kdump: loaded Tainted:
>     [  553.332139] Hardware name: IBM 3931 A01 701 (LPAR)
>     [  553.332146] Call Trace:
>     [  553.332152]  [<00000000158de23a>] dump_stack_lvl+0xfa/0x150
>     [  553.332167]  [<0000000013e10d12>] __might_resched+0x57a/0x5e8
>     [  553.332178]  [<00000000144eb6c2>] __alloc_pages+0x2ba/0x7c0
>     [  553.332189]  [<00000000144d5cdc>] __get_free_pages+0x2c/0x88
>     [  553.332198]  [<00000000145663f6>] kasan_populate_vmalloc_pte+0x4e/0x110
>     [  553.332207]  [<000000001447625c>] apply_to_pte_range+0x164/0x3c8
>     [  553.332218]  [<000000001448125a>] apply_to_pmd_range+0xda/0x318
>     [  553.332226]  [<000000001448181c>] __apply_to_page_range+0x384/0x768
>     [  553.332233]  [<0000000014481c28>] apply_to_page_range+0x28/0x38
>     [  553.332241]  [<00000000145665da>] kasan_populate_vmalloc+0x82/0x98
>     [  553.332249]  [<00000000144c88d0>] alloc_vmap_area+0x590/0x1c90
>     [  553.332257]  [<00000000144ca108>] __get_vm_area_node.constprop.0+0x138/0x260
>     [  553.332265]  [<00000000144d17fc>] __vmalloc_node_range+0x134/0x360
>     [  553.332274]  [<0000000013d5dbf2>] alloc_thread_stack_node+0x112/0x378
>     [  553.332284]  [<0000000013d62726>] dup_task_struct+0x66/0x430
>     [  553.332293]  [<0000000013d63962>] copy_process+0x432/0x4b80
>     [  553.332302]  [<0000000013d68300>] kernel_clone+0xf0/0x7d0
>     [  553.332311]  [<0000000013d68bd6>] __do_sys_clone+0xae/0xc8
>     [  553.332400]  [<0000000013d68dee>] __s390x_sys_clone+0xd6/0x118
>     [  553.332410]  [<0000000013c9d34c>] do_syscall+0x22c/0x328
>     [  553.332419]  [<00000000158e7366>] __do_syscall+0xce/0xf0
>     [  553.332428]  [<0000000015913260>] system_call+0x70/0x98

Is this a crash, or a warning?  From the description I suspect it was a
sleep-while-atomic warning?

Can we please have the complete dmesg output?

