From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 1/5] arm64: Fix vDSO clock_getres()
Date: Tue, 16 Apr 2019 13:42:58 +0100
Message-ID: <efaafc72-79da-b25a-78b7-36424d9350ad@arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
 <20190401115152.32751-2-vincenzo.frascino@arm.com>
 <20190415173521.GA901@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190415173521.GA901@arrakis.emea.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

Hi Catalin,

On 15/04/2019 18:35, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:51:48PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 2d419006ad43..47ba72345739 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
>>  		vdso_data->cs_shift		= tk->tkr_mono.shift;
>>  	}
>>  
>> +	vdso_data->hrtimer_res			= hrtimer_resolution;
>> +
>>  	smp_wmb();
>>  	++vdso_data->tb_seq_count;
>>  }
>> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
>> index c39872a7b03c..7a2cd2f8e13a 100644
>> --- a/arch/arm64/kernel/vdso/gettimeofday.S
>> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
>> @@ -296,32 +296,35 @@ ENDPROC(__kernel_clock_gettime)
>>  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
>>  ENTRY(__kernel_clock_getres)
>>  	.cfi_startproc
>> +	adr	vdso_data, _vdso_data
>>  	cmp	w0, #CLOCK_REALTIME
>>  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
>>  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
>> -	b.ne	1f
>> +	b.ne	2f
>>  
>> -	ldr	x2, 5f
>> -	b	2f
>> -1:
>> +1:	/* Get hrtimer_res */
>> +	seqcnt_acquire
>> +	syscall_check fail=5f
>> +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
>> +	seqcnt_check fail=1b
>> +	b	3f
>> +2:
> 
> We talked briefly but I'm still confused why we need the fallback to the
> syscall here if archdata.vdso_direct is false. Is it because if the
> timer driver code sets vdso_direct to false, we don't don't support
> highres timers? If my understanding is correct, you may want to move the
> hrtimer_res setting in update_vsyscall() to the !use_syscall block.
> 

Ok, so let me try to provide more details on what I mentioned yesterday:
- clock_getres syscall follows the rules of what defined in posix-timers.c
- based on the clock_id that, for this purpose, can be separated in coarse and
non-coarse calls either posix_get_coarse_res() or posix_get_hrtimer_res().
- if clock id is set to a coarse clock and posix_get_coarse_res() is invoked,
happens what follows:

static int posix_get_coarse_res(const clockid_t which_clock,
				struct timespec64 *tp)
{
	*tp = ktime_to_timespec64(KTIME_LOW_RES);
	return 0;
}

Note that since CONFIG_1HZ seems not supported (jiffies.h) by the kernel in this
case we do not need rounding in our vDSO implementation.

- if clock id is set to non-coarse and posix_get_hrtimer_res() is invoked,
happens the following:

static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
{
	tp->tv_sec = 0;
	tp->tv_nsec = hrtimer_resolution;
	return 0;
}

hrtimer_resolution can be high res or low res depending on the call of
hrtimer_switch_to_hres(). For us the only way to preserve the correct value is
to keep it in the vdso data page.

- The assembly code mimics exactly the same behaviour detailed above, with one
difference: the one related to the use_syscall parameter which is specific to arm64.
The use_syscall parameter is set by arm_arch_timer and consumed by
update_vsyscall(). To mirror what update_vsyscall does in update_vsyscall() I
check "syscall_check fail=5f" in clock_getres vdso function.

Said that, even if functionally it is the same thing, I think it is logically
more correct to have hrtimer_res setting inside the !use_syscall block, hence I
am going to change it in the next iteration.

Please let me know your thoughts.

-- 
Regards,
Vincenzo
