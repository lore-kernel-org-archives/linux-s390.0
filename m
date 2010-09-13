From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [-next Sept 13] s390 build break [nclude/linux/interrupt.h:local_softirq_pending()]
Date: Mon, 13 Sep 2010 15:05:25 -0700
Message-ID: <AANLkTi=5g_pTOhSqjMxcCvx868kt1xR67eN9FsKPQqrc@mail.gmail.com>
References: <4C8E04C4.4060508@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C8E04C4.4060508@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, laijs@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Sep 13, 2010 at 4:02 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Today's next build failed on a s390 box with following
> include/linux/interrupt.h: In function '__raise_softirq_irqoff':
> include/linux/interrupt.h:429: error: implicit declaration of function
> 'local_softirq_pending'
> include/linux/interrupt.h:429: error: lvalue required as left operand of
> assignment
> In file included from /tmp/build/linux/arch/s390/include/asm/hardirq.h:18,

Same problem on ia64.  The problem seem to be the conversion of
__raise_softirq_irqoff() from #define macro to static function. This means
the compiler looks more closely at the:
     or_softirq_pending(1UL << nr);
line ... which expands to
     (local_softirq_pending() |= (1UL << nr);
on every architecture where __ARCH_SET_SOFTIRQ_PENDING is not
set (everything except x86).  It seems that s390 and ia64 don't have an
in scope #define for local_softirq_pending() at this point, hence the "lvalue
required" error message.

I think we need <asm/hardirq.h> to provide this ... but the dependencies here
are a bit messy.

-Tony
