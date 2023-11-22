Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446222F0D;
	Wed, 22 Nov 2023 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D8C433C8;
	Wed, 22 Nov 2023 23:31:44 +0000 (UTC)
Date: Wed, 22 Nov 2023 18:32:00 -0500
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
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
Message-ID: <20231122183200.409e982b@gandalf.local.home>
In-Reply-To: <20231121220155.1217090-2-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
	<20231121220155.1217090-2-iii@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 23:00:55 +0100
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Architectures use assembly code to initialize ftrace_regs and call
> ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> KMSAN warnings when running the ftrace testsuite.
> 
> Fix by trusting the architecture-specific assembly code and always
> unpoisoning ftrace_regs in ftrace_ops_list_func.

You must be very trusting to trust architecture-specific assembly code ;-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..dfb8b26966aa 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7399,6 +7399,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  			       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> +	kmsan_unpoison_memory(fregs, sizeof(*fregs));
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
>  }
>  #else

