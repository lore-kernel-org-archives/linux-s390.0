From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 13/23] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
Date: Sun, 12 Jun 2016 20:56:44 +0300
Message-ID: <20160612175644.GA12475@yury-N73SV>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-14-git-send-email-ynorov@caviumnetworks.com>
 <575D53B0.5020408@huawei.com>
 <575D5ECC.4030000@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <libc-alpha-return-70534-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <575D5ECC.4030000@huawei.com>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jun 12, 2016 at 09:08:28PM +0800, Zhangjian (Bamvor) wrote:
> >>  #ifdef CONFIG_COMPAT
> >>  #define TASK_SIZE_32        UL(0x100000000)
> >>-#define TASK_SIZE        (test_thread_flag(TIF_32BIT) ? \
> >>+#define TASK_SIZE        (is_compat_task() ?        \
> >>                  TASK_SIZE_32 : TASK_SIZE_64)
> >>  #define TASK_SIZE_OF(tsk)    (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
> >>                  TASK_SIZE_32 : TASK_SIZE_64)
> >Should we update or delete this macro?
> >  #define TASK_SIZE_OF(tsk) (is_compat_task() ? \
> >TASK_SIZE_32 : TASK_SIZE_64)
> Sorry it should be:
> #define TASK_SIZE_OF(tsk)       ((is_a32_compat_thread(task_thread_info(tsk)) \
>                                   || is_ilp32_compat_thread(task_thread_info(tsk))) ? \
>                                 TASK_SIZE_32 : TASK_SIZE_64)

Thank you. I know about this, but always forget to fix. )
I think we'd introduce is_compat_thread() as well.

> >x86, sparc, mips, ppc, parisc, s390 define its own version. But
> >"include/linux/sched.h" will define it if
> >TASK_SIZE_OF does not exist:
> >#ifndef TASK_SIZE_OF
> >#define TASK_SIZE_OF(tsk)       TASK_SIZE
> >#endif
> >
> >
> >Regards
> >
> >Bamvor
> >
