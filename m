Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93F429033;
	Fri, 24 Jul 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906063; cv=none; b=FjsovhAnGPxfspsfN98Owpoo1Qbhnb0gr/H4ulyhb+NFnF0SP/pj8QT6DGYbKuRAb2l3usbdvp15/djGi75JYdLZRjMdV7n+yqctw1em76S8HrqRmg+6L78ioeVstirJfMxgOeJt9aUJkKEPZyTPBh4cwROY4/RejuKLj82XVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906063; c=relaxed/simple;
	bh=fPDvvEvENTiPAqQleadqmiuCWiteAPXK7TuwBGkcTFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y/kLmgXXooIFhKHugup9iv03RJD/gQHUQ79cbFFp1f0qXtsNO4vPy9qEJsly38HVV5phutuPqTU85jupPc9wI5Qu4LYsiraXLzYK3AuVvDDYJfOhAXtUrFE/2QI07mAGuw1zWfWNqojxginF576NoQURE901WviYRS5FZ0fUw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvLcykWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvLcykWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B8D1F00A3A;
	Fri, 24 Jul 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784906060;
	bh=IPx2ZnDIZMin4gMrx0LbwuEBDtzNulgB5hnZWIUeeK0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TvLcykWmR8qvl3CMLV80Q5wNwYfpVZi6+z6kPddj2KLmLPujJbxrJnoaetul970c4
	 K7lzxRwDp6sEJAq/ZbO5Qwyh15k7SYt/y6aMYsGhKT/gU2rZgj+GR4agP5IA56DYbx
	 udhnIGsUxrGA8u5oExb2pqD5huvzT0qp7HiEiGP1Bmi1aj2cJrh7x59Ze/lnyGkHqM
	 0SyF0aupQFIVbEVmjYmynayzc/UeHU5Pz4JP0MvTlIVtQpjyTnPKCViuAp6SqtqT8c
	 zZGvY6XRQs/URZZvJIF6qQti30sK+rhbOXyeYrOTKlTJ9cLQw7SRyi3aK9AHbBCwIZ
	 DFz4khAlHwsQQ==
Content-Type: multipart/mixed; boundary="===============1022902030199237391=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28e3e54dc801c37d10bf85fd0c8a8c169d64afc8622cdc8249d970a590b586fd@mail.kernel.org>
In-Reply-To: <20260724141318.1037434-4-hca@linux.ibm.com>
References: <20260724141318.1037434-4-hca@linux.ibm.com>
Subject: Re: [PATCH 3/6] s390: Add ftrace_stub_graph
From: bot+bpf-ci@kernel.org
To: hca@linux.ibm.com,stefansf@linux.ibm.com,jchrist@linux.ibm.com,iii@linux.ibm.com,dost@de.ibm.com,agordeev@linux.ibm.com,svens@linux.ibm.com,gor@linux.ibm.com,borntraeger@linux.ibm.com,max@linux.ibm.com,jremus@linux.ibm.com,samitolvanen@google.com,kees@kernel.org,nathan@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: llvm@lists.linux.dev,bpf@vger.kernel.org,linux-s390@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Jul 2026 15:14:18 +0000 (UTC)

--===============1022902030199237391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> index 1fec370fecf48..97e9d6bdc0174 100644
> --- a/arch/s390/kernel/mcount.S
> +++ b/arch/s390/kernel/mcount.S
> @@ -4,6 +4,7 @@
>   *
>   */
>
> +#include <linux/cfi_types.h>
>  #include <linux/linkage.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/ftrace.h>

[ ... ]

> @@ -34,10 +35,14 @@
>
>  	.section .kprobes.text, "ax"
>
> -SYM_FUNC_START(ftrace_stub)
> +SYM_TYPED_FUNC_START(ftrace_stub)
>  	BR_EX	%r14
>  SYM_FUNC_END(ftrace_stub)
>
> +SYM_TYPED_FUNC_START(ftrace_stub_graph)
> +	BR_EX	%r14
> +SYM_FUNC_END(ftrace_stub_graph)

Will this link when CONFIG_CFI_CLANG=y and CONFIG_FUNCTION_GRAPH_TRACER=n?

When CFI is enabled, the SYM_TYPED_FUNC_START() macro emits a reference to
__kcfi_typeid_ftrace_stub_graph. However, this symbol is only generated if
ftrace_stub_graph is declared in C code, which only happens when
CONFIG_FUNCTION_GRAPH_TRACER is enabled in kernel/trace/fgraph.c.

Both the RISC-V reference implementation (commit f3a0c23f2539) and the x86
fix (commit aa69f814920d8) wrap ftrace_stub_graph inside:

  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
  SYM_TYPED_FUNC_START(ftrace_stub_graph)
  	BR_EX	%r14
  SYM_FUNC_END(ftrace_stub_graph)
  #endif

From commit aa69f814920d8:

  "When CONFIG_FUNCTION_GRAPH_TRACER is disabled,
  __kcfi_typeid_ftrace_stub_graph is missing, causing a link failure:
  ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
  referenced by arch/x86/kernel/ftrace_64.o:(__cfi_ftrace_stub_graph) in
  archive vmlinux.a"

Should the s390 implementation include the CONFIG_FUNCTION_GRAPH_TRACER
guard?

> +
>  SYM_CODE_START(ftrace_stub_direct_tramp)
>  	lgr	%r1, %r0
>  	BR_EX	%r1

This looks like a bug fix. Should this include:

  Fixes: 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30100858043
--===============1022902030199237391==--
