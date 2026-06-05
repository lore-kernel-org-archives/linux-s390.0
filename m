Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BF408018;
	Fri,  5 Jun 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641016; cv=none; b=H29GPa3EuaeNeeDaznXVY51QhWXbYLVNJs9NqugHXYSJalVECvY/t5MCUMBYiXgOL3JRA7pvptxidBnV6GpAk/MYHUUhMnUldAGaKDcXtcG5oOvmQ6BA+pSwEmR8v2B0WjfrO2mNSmn8mm0z8MOIBDyaVgkDkgxQ6i/SraxagJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641016; c=relaxed/simple;
	bh=ZcuHm5PmefJp333Pgnlc3IJF2BvWCrLzrezMIRR4Ud8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MSiovY0gjEQk8nYIaS0F/k0IdUtjYQpmLX0xk/NqSpjOgBn9oUirAT8OTyFtPikcPECZM5wRLw9nOr0uyPIoPGZqTISr9ESmm1trzAum951Hb4hu5B5XMve2Zv5KI3D3S93qvrDOcB1P23cs+iSiGShShJbUYIzLv6kfkTbo4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2tMLtor reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2tMLtor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5638E1F00893;
	Fri,  5 Jun 2026 06:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641015;
	bh=1kmJujliLWVq7SOJBW3cWpP8f1QD6kuoKMKtva7T/Sg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F2tMLtorPtM0DziWwetQVWW0dnCeQUud3yhfQuX3SA5AUpl689AFfeDlF8l53B7PP
	 LYVKy6sY81k0KuCLZ+xgwKBXWatB7oJwi/1noaW7889959j9WHRH/w4rJKRgghAbes
	 eMx5yfS4FJQRlyyiOjPMS2FDoMEK8n6Os4PJsPjOjk4ZuaIcYpB0Iz5MeUeOTLO0mh
	 GDHJd7ewIg+u2dwZeeUadLL4HA14oMUPa/uI7nfPwWCUtW00d2wiZ/MihU+RHQ9AYQ
	 Rj5tZC8ajFdrj4Nl+VftW/5+xScZM4xE3PKk4RZTXkPf1llII1ZkudsYKbs3b6f+0U
	 dl5U3IM5yuqTg==
Content-Type: multipart/mixed; boundary="===============7761534993717686254=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d3e91d227b0e1b777a85806e54b03d46581e4460f893e5b45baa9168f5319fbf@mail.kernel.org>
In-Reply-To: <20260605054128.5925-4-boqun@kernel.org>
References: <20260605054128.5925-4-boqun@kernel.org>
Subject: Re: [PATCH v3 03/13] preempt: Introduce __preempt_count_{sub, add}_return()
From: bot+bpf-ci@kernel.org
To: boqun@kernel.org,peterz@infradead.org
Cc: catalin.marinas@arm.com,will@kernel.org,jonas@southpole.se,stefan.kristiansson@saunalahti.fi,shorne@gmail.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com,svens@linux.ibm.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,arnd@arndb.de,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,boqun@kernel.org,longman@redhat.com,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,ojeda@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ruanjinjie@huawei.com,lyude@redhat.com,thuth@redhat.com,sohil.mehta@intel.com,pawan.kumar.
 gupta@linux.intel.com,seanjc@google.com,nikunj@amd.com,xin@zytor.com,joelagnelf@nvidia.com,andriy.shevchenko@linux.intel.com,rdunlap@infradead.org,ynorov@nvidia.com,bigeasy@linutronix.de,linux-kernel@vger.kernel.org,linux-openrisc@vger.kernel.org,linux-s390@vger.kernel.org,linux-arch@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,rust-for-linux@vger.kernel.org,boqun.feng@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 06:30:14 +0000 (UTC)

--===============7761534993717686254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     preempt: Introduce __preempt_count_{sub, add}_return()
>
>     In order to use preempt_count() to tracking the interrupt disable
>     nesting level, __preempt_count_{add,sub}_return() are introduced, as
>     their name suggest, these primitives return the new value of the
>     preempt_count() after changing it. The following example shows the usage
>     of it in local_interrupt_disable():
>
>             // increase the HARDIRQ_DISABLE bit
>             new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);
>
>             // if it's the first-time increment, then disable the interrupt
>             // at hardware level.
>             if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
                                                    ^^

The operator precedence in this example appears incorrect. In C, the equality
operator == has higher precedence than the bitwise AND operator &, so this
evaluates as:

    new_count & (HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET)

Since the mask does not equal the offset, the equality evaluates to 0, making
the entire condition always false.

Should this be written with explicit parentheses to prevent readers from
copying flawed logic into downstream implementations?

    if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {

This was raised by sashiko-bot@kernel.org in v3 review:
https://lore.kernel.org/all/20260605055933.EDF3D1F00898@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26998319662
--===============7761534993717686254==--
