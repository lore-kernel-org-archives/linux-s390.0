From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
Date: Tue, 3 May 2016 19:07:12 +0800
Message-ID: <57288660.9030607@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1554541.oDP7Ro5zB2@wuerfel>
 <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
 <3846428.6xx69KGEja@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3846428.6xx69KGEja@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>, joseph@codesourcery.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com, Hanjun Guo <guohanjun@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>



On 2016/5/3 17:05, Arnd Bergmann wrote:
> On Tuesday 03 May 2016 10:00:45 Catalin Marinas wrote:
>> On Fri, Apr 29, 2016 at 07:30:19PM +0200, Arnd Bergmann wrote:
>>> On Friday 29 April 2016 17:01:55 Catalin Marinas wrote:
>>>> On Wed, Apr 06, 2016 at 01:08:46AM +0300, Yury Norov wrote:
>>>>> ILP32 VDSO exports next symbols:
>>>>>   __kernel_rt_sigreturn;
>>>>>   __kernel_gettimeofday;
>>>>>   __kernel_clock_gettime;
>>>>>   __kernel_clock_getres;
>>>>
>>>> [...]
>>>>
>>>>> +$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
>>>>> + $(call if_changed_dep,vdso-ilp32as)
>>>>
>>>> Are struct timeval and timespec the same between ILP32 and LP64? For
>>>> example, __kernel_gettimeofday() assumes TVAL_TV_SEC offset defined in
>>>> asm-offsets.c based on the LP64 timeval.
>>>
>>> No, ilp32 uses the generic 32-bit data structures, which have a 32-bit
>>> time_t. I guess that means it can work for little-endian but not
>>> big-endian, right?
>>
>> I don't think it works for little-endian either. The LP64 struct timeval
>> is 16 bytes while the ILP32 one is 8 bytes. The VDSO gettimeofday is
>> storing 16 bytes (stp x10, x11, [x0, #TVAL_TV_SEC])
>
> You are right. Yury asked pointed out the same thing on IRC as well.
> Using the 64-bit gettimeofday() will put the right number in the
> .tv_sec member on little-endian, but will write zeroes to tv_nsec
> and corrupt the memory following it.
>
> Yury also tried it out and noticed that for a (so far) unknown reason,
> the vdso gets never used by his glibc build, so it has not triggered
> any test case failures.
We found this issue too. And it is because the version is different from
the glibc wanted. We define 2.6.39 for lp64 but 2.6 for ilp32 in vdso
in kernel:
+VERSION
+{
+	LINUX_2.6 {
+	global:
+		__kernel_rt_sigreturn;
+		__kernel_gettimeofday;
+		__kernel_clock_gettime;
+		__kernel_clock_getres;
+	local: *;
+	};
+}
If I change 2.6 to 2.6.39, the ilp32 application will call vdso instead
of syscall. But the result is wrong as Catalin mentioned before.

Should we set this version to 4.6 or higher version? We will need to update
the version in "sysdeps/unix/sysv/linux/aarch64/init-first.c" too:
static inline void
_libc_vdso_platform_setup (void)
{
   PREPARE_VERSION (linux2639, "LINUX_2.6.39", 123718537);

   void *p = _dl_vdso_vsym ("__kernel_gettimeofday", &linux2639);
   PTR_MANGLE (p);
   VDSO_SYMBOL(gettimeofday) = p;

   p = _dl_vdso_vsym ("__kernel_clock_gettime", &linux2639);
   PTR_MANGLE (p);
   VDSO_SYMBOL(clock_gettime) = p;

   p = _dl_vdso_vsym ("__kernel_clock_getres", &linux2639);
   PTR_MANGLE (p);
   VDSO_SYMBOL(clock_getres) = p;
}

Regards

Bamvor

>
> 	Arnd
>
