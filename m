From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Fri, 13 May 2016 16:11:23 +0800
Message-ID: <57358C2B.1010106@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
 <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
 <20160512134431.GB30205@yury-N73SV>
 <20160512140734.GG11226@e104818-lin.cambridge.arm.com>
 <20160512142457.GC30205@yury-N73SV>
 <20160512152805.GJ11226@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160512152805.GJ11226@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, schwab@suse.de, schwidefsky@de.ibm.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 2016/5/12 23:28, Catalin Marinas wrote:
> On Thu, May 12, 2016 at 05:24:57PM +0300, Yury Norov wrote:
>> On Thu, May 12, 2016 at 03:07:35PM +0100, Catalin Marinas wrote:
>>> On Thu, May 12, 2016 at 04:44:31PM +0300, Yury Norov wrote:
>>>> On Thu, May 12, 2016 at 02:35:34PM +0100, Catalin Marinas wrote:
>>>>> On Thu, May 12, 2016 at 03:20:00AM +0300, Yury Norov wrote:
>>>>>> I debugged preadv02 and pwritev02 failures and found very weird bug.
>>>>>> Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
>>>>>> of vector, and kernel reports successful read/write.
>>>>>>
>>>>>> There are 2 problems:
>>>>>> 1. How kernel allows such address to be passed to fs subsystem;
>>>>>> 2. How fs successes to read/write at non-mapped, and in fact non-user
>>>>>> address.
>>>>>>
>>>>>> I don't know the answer on 2'nd question, and it might be something
>>>>>> generic. But I investigated first problem.
>>>>>>
>>>>>> The problem is that compat_rw_copy_check_uvector() uses access_ok() to
>>>>>> validate user address, and on arm64 it ends up with checking buffer
>>>>>> end against current_thread_info()->addr_limit.
>>>>>>
>>>>>> current_thread_info()->addr_limit for ilp32, and most probably for
>>>>>> aarch32 is equal to aarch64 one, and so adress_ok() doesn't fail.
>>>>>> It happens because on thread creation we call flush_old_exec() to set
>>>>>> addr_limit, and completely ignore compat mode there.
>>>
>>> [...]
>>>
>>>>>> --- a/arch/arm64/kernel/binfmt_elf32.c
>>>>>> +++ b/arch/arm64/kernel/binfmt_elf32.c
>>>>>> @@ -12,6 +12,7 @@
>>>>>>   do {						\
>>>>>>   	clear_thread_flag(TIF_32BIT_AARCH64);	\
>>>>>>   	set_thread_flag(TIF_32BIT);		\
>>>>>> +	set_fs(TASK_SIZE_32);			\
>>>>>>   } while (0)
>>>>>>
>>>>>>   #define COMPAT_ARCH_DLINFO
>>>>>> diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
>>>>>> index a934fd4..a8599c6 100644
>>>>>> --- a/arch/arm64/kernel/binfmt_ilp32.c
>>>>>> +++ b/arch/arm64/kernel/binfmt_ilp32.c
>>>>>> @@ -59,6 +59,7 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
>>>>>>   do {									\
>>>>>>   	set_thread_flag(TIF_32BIT_AARCH64);				\
>>>>>>   	clear_thread_flag(TIF_32BIT);					\
>>>>>> +	set_fs(TASK_SIZE_32);						\
>>>>>>   } while (0)
>>>>>
>>>>> I don't think we need these two. AFAICT, flush_old_exec() takes care of
>>>>> setting the USER_DS for the new thread.
>>>>
>>>> That's true, but USER_DS depends on personality which is not set yet
>>>> for new thread, as I wrote above. In fact, I tried correct USER_DS
>>>> only, and it doesn't work
>>>
>>> Ah, it looks like load_elf_binary() sets the personality after
>>> flush_old_exec(). Looking at powerpc and x86, they set USER_DS to the
>>> maximum 64-bit task value, so they should have a similar issue with
>>> native 32-bit vs compat behaviour.
>>
>> Hmmm. If so, it means we'd introduce generic fix. It would be removing
>> set_fs() from flush_old_exec() and appending it to load_elf_binary()
>> after SET_PERSONALITY(). But I think it should be agreed with other
>> arches developers.
>
> The set_fs() in flush_old_exec() is probably fine, it may be meant to
> re-set the USER_DS for the old thread.
>
> It appears that at least powerpc and x86 don't have different USER_DS
> setting for native and compat, so moving the set_fs() call further down
> would not make any difference for them, nor will it fix the preadv02 LTP
> test (if it fails for them, I haven't checked).
>
>> I've sent standalone patch for aarch64 (you in CC) so let's move
>> discussion there.
>
> I've seen the patch but we would lose some discussion history here. I
> think we should continue this thread and just summarise the conclusion
> in reply to the other patch. This thread is also available on
> linux-arch, in case other architecture maintainers follow it.
>
>>> So what exactly is LTP complaining about? Is different error (like
>>> EFAULT vs EINVAL) or not getting an error at all.
>>
>> It should be EINVAL, but it succeed. The other problem is that
>> following fs routines does not complain on wrong address.
>
> I see. The test asks the kernel to write a single byte (out of maximum
> 64) to the user address 0xffffffff.
What address We should set for this limitation, TASK_SIZE or STACK_TOP?
It is same for 64bit application. But STACK_TOP(0xffff0000) is below
TASK_SIZE in 32bit application. The address above STACK_TOP is preserved
for 32bit application.

Regards

Bamvor

 > In the absence of the access_ok()
> check, this operation succeeds. If the preadv syscall gets 2 bytes as
> the count, then it would fail with EFAULT.
>
> While it's not really a bug, I agree that for matching the native 32-bit
> behavior (basically for other syscalls like those involving vfs_read()),
> the simplest fix would be to have a dynamic USER_DS.



>
