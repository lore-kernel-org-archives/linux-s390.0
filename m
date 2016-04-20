From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 10/11] x86, rwsem: provide __down_write_killable
Date: Wed, 20 Apr 2016 22:45:01 +0200
Message-ID: <20160420204501.GA6815@pd.tnic>
References: <1460041951-22347-1-git-send-email-mhocko@kernel.org>
 <1460041951-22347-11-git-send-email-mhocko@kernel.org>
 <20160413090829.GB29579@gmail.com>
 <20160413091625.GF14351@dhcp22.suse.cz>
 <20160413091943.GA17858@gmail.com>
 <20160413102731.GA29896@gmail.com>
 <20160413124943.GH14351@dhcp22.suse.cz>
 <20160420134019.GX3448@twins.programming.kicks-ass.net>
 <91A11395-ACAA-4043-B770-2DF6CBAED54C@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <91A11395-ACAA-4043-B770-2DF6CBAED54C@zytor.com>
Sender: linux-alpha-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 20, 2016 at 11:04:05AM -0700, H. Peter Anvin wrote:
> The reason it breaks is because the same register can't be an
> input-output register and a separate input. However, the input side of
> the input-output is probably undefined, and so gcc may not notice.

So Michal and I talked about this a while ago. Why do we need the '"a"
(sem)' input dependency if '"+a" (ret)' already supplies the same thing?

There's also that "=d" (tmp) thing which we don't really need as an
output, right?

I.e., can we simplify like this?

---
#define ____down_write(sem, slow_path)                  \
({                                                      \
        long tmp = RWSEM_ACTIVE_WRITE_BIAS;             \
	struct rw_semaphore* ret = sem;			\
                                                        \
        asm volatile("# beginning down_write\n\t"       \
                     LOCK_PREFIX "  xadd      %[tmp],(%[ret])\n\t"      \
                     /* adds 0xffff0001, returns the old value */ \
                     "  test " __ASM_SEL(%w[tmp],%k[tmp]) "," __ASM_SEL(%w[tmp],%k[tmp]) "\n\t" \
                     /* was the active mask 0 before? */\
                     "  jz        1f\n"                 \
                     "  call " slow_path "\n"           \
                     "1:\n"                             \
                     "# ending down_write"              \
                     : "+m" (sem->count), [ret] "+a" (ret) \
                     : [tmp] "d" (tmp)                  \
                     : "memory", "cc");                 \
        ret;                                            \
})

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
