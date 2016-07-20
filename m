From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Is THREAD_INFO_IN_TASK appropriate for -mm for 4.8?
Date: Wed, 20 Jul 2016 09:44:51 +0200
Message-ID: <20160720074451.GB28606@gmail.com>
References: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86 <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>


* Andy Lutomirski <luto@kernel.org> wrote:

> Cons: It's a bit odd to merge code that can't be enabled as-is.  OTOH
> x86 could plausibly enable it for 4.8 if Ingo is okay with applying
> "x86/dumpstack: Pin the target stack in save_stack_trace_tsk()" and
> "x86: Move thread_info into task_struct" during the merge window after
> the -mm patchbomb lands.

There's quite a few risky stuff piled up already so I'd prefer if we delayed these 
core bits and the enablement to v4.9.

We can carry these core bits in -tip as well, can create a tip:sched/thread_info 
tree for it and such. I'd prefer that because this way we have natural proximity 
between patch application, testing and eventual fixes.

Then we can expose -next to all these changes as a single, bisectable group of 
commits and, should anything overly catastrophic happen, remove it and regroup our 
forces.

This would really be the best approach I think, since I'd like to default-enable 
all this on x86 from the very beginning.

Thanks,

	Ingo
