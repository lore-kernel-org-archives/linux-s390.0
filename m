From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 13/23] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
Date: Sun, 12 Jun 2016 21:08:28 +0800
Message-ID: <575D5ECC.4030000@huawei.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-14-git-send-email-ynorov@caviumnetworks.com>
 <575D53B0.5020408@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <libc-alpha-return-70530-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <575D53B0.5020408@huawei.com>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>



On 2016/6/12 20:21, Zhangjian (Bamvor) wrote:
> Hi, Yury
>
> On 2016/5/24 8:04, Yury Norov wrote:
>> Based on patch of Andrew Pinski.
>>
>> This patch introduces is_a32_compat_task and is_a32_thread so it is
>> easier to say this is a a32 specific thread or a generic compat thread/task.
>> Corresponding functions are located in <asm/is_compat.h> to avoid mess in
>> headers.
>>
>> Some files include both <linux/compat.h> and <asm/compat.h>,
>> and this is wrong because <linux/compat.h> has <asm/compat.h> already
>> included. It was fixed too.
>>
>> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
>> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>   arch/arm64/include/asm/compat.h      | 19 ++----------
>>   arch/arm64/include/asm/elf.h         | 10 +++----
>>   arch/arm64/include/asm/ftrace.h      |  2 +-
>>   arch/arm64/include/asm/is_compat.h   | 58 ++++++++++++++++++++++++++++++++++++
>>   arch/arm64/include/asm/memory.h      |  3 +-
>>   arch/arm64/include/asm/processor.h   |  5 ++--
>>   arch/arm64/include/asm/syscall.h     |  2 +-
>>   arch/arm64/include/asm/thread_info.h |  2 +-
>>   arch/arm64/kernel/hw_breakpoint.c    | 10 +++----
>>   arch/arm64/kernel/perf_regs.c        |  2 +-
>>   arch/arm64/kernel/process.c          |  7 ++---
>>   arch/arm64/kernel/ptrace.c           | 11 ++++---
>>   arch/arm64/kernel/signal.c           |  4 +--
>>   arch/arm64/kernel/traps.c            |  3 +-
>>   14 files changed, 91 insertions(+), 47 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/is_compat.h
>>
> [...]
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 12f8a00..a66a0f7 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -26,6 +26,7 @@
>>   #include <linux/types.h>
>>   #include <asm/bug.h>
>>   #include <asm/sizes.h>
>> +#include <asm/is_compat.h>
>>
>>   /*
>>    * Allow for constants defined here to be used from assembly code
>> @@ -61,7 +62,7 @@
>>
>>   #ifdef CONFIG_COMPAT
>>   #define TASK_SIZE_32        UL(0x100000000)
>> -#define TASK_SIZE        (test_thread_flag(TIF_32BIT) ? \
>> +#define TASK_SIZE        (is_compat_task() ?        \
>>                   TASK_SIZE_32 : TASK_SIZE_64)
>>   #define TASK_SIZE_OF(tsk)    (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
>>                   TASK_SIZE_32 : TASK_SIZE_64)
> Should we update or delete this macro?
>   #define TASK_SIZE_OF(tsk) (is_compat_task() ? \
> TASK_SIZE_32 : TASK_SIZE_64)
Sorry it should be:
#define TASK_SIZE_OF(tsk)       ((is_a32_compat_thread(task_thread_info(tsk)) \
                                   || is_ilp32_compat_thread(task_thread_info(tsk))) ? \
                                 TASK_SIZE_32 : TASK_SIZE_64)

> x86, sparc, mips, ppc, parisc, s390 define its own version. But
> "include/linux/sched.h" will define it if
> TASK_SIZE_OF does not exist:
> #ifndef TASK_SIZE_OF
> #define TASK_SIZE_OF(tsk)       TASK_SIZE
> #endif
>
>
> Regards
>
> Bamvor
>
