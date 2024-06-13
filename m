Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102A1494CB;
	Thu, 13 Jun 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295672; cv=none; b=i3AnjcufR2HHzNAZhtKGkifSThaJzFEySgM1CZmgs2eVTRXTisHkHUAvjTcYk+gNeIG8R/sOSblZ1fSsuPR1hnTDyQhoJE5xPjMzNP7KVsCNuOKV4aslwtqq/ELJWcuvQPe+kJWc3pPMgrnhjFo+ipXRDBSisWeasT0RxuABpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295672; c=relaxed/simple;
	bh=KhG6p1G/vl180lQCXn0UUW5xYEylfaMDqhz/mseFLpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M255Z5ALTJadfFvbZ0AlBHjS9+dbToW/Z2lRlwQbarFZbY+nEDdpCHyEKRZZMDwsHh6a15rOMwRh3SN1dKRn+f9GYgPewpIfVnSMkvItnywU7B8KUK2s/+jK7GSZUfuZuY2GE+K+fuobRLOi/SWS858si/eZEZ3j6z+ubK9Gix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA525C32786;
	Thu, 13 Jun 2024 16:21:08 +0000 (UTC)
Date: Thu, 13 Jun 2024 12:21:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Alexander Potapenko
 <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko
 Carstens <hca@linux.ibm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco
 Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Pekka
 Enberg <penberg@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil
 Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH v4 01/35] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
Message-ID: <20240613122107.6e9299eb@rorschach.local.home>
In-Reply-To: <20240613153924.961511-2-iii@linux.ibm.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
	<20240613153924.961511-2-iii@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:34:03 +0200
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Architectures use assembly code to initialize ftrace_regs and call
> ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> KMSAN warnings when running the ftrace testsuite.
> 
> Fix by trusting the architecture-specific assembly code and always
> unpoisoning ftrace_regs in ftrace_ops_list_func.
> 
> The issue was not encountered on x86_64 so far only by accident:
> assembly-allocated ftrace_regs was overlapping a stale partially
> unpoisoned stack frame. Poisoning stack frames before returns [1]
> makes the issue appear on x86_64 as well.
> 
> [1] https://github.com/iii-i/llvm-project/commits/msan-poison-allocas-before-returning-2024-06-12/
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 65208d3b5ed9..c35ad4362d71 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7407,6 +7407,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  			       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> +	kmsan_unpoison_memory(fregs, sizeof(*fregs));
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
>  }
>  #else

