From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Tue, 10 May 2016 15:55:23 +0800
Message-ID: <573193EB.8040709@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <572C8B30.7000005@huawei.com> <20160506123731.GA11959@yury-N73SV>
 <573190CF.6030408@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <573190CF.6030408@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, Andrew Pinski <apinski@cavium.com>, schwab@suse.de, schwidefsky@de.ibm.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, "jijun (D)" <jijun2@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

Sorry I forget to paste my test code:

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>

#define TEMPFILE "mmapfile"

int main(int argc, char *argv[])
{
	int fd;
	void *addr;
	unsigned long offset;
	unsigned long size;

	if (argc == 3) {
		if (argv[1][0] == '0' && argv[1][1] == 'x')
			offset = strtoll(&argv[1][2], NULL, 16);
		else
			offset = atoi(argv[1]);

		if (argv[2][0] == '0' && argv[2][1] == 'x')
			size = strtoll(&argv[2][2], NULL, 16);
		else
			size = atoi(argv[2]);
	} else {
		exit(2);
	}

	printf("page size<0x%x>, offset is <0x%x>\n", size, offset);
//	if ((fd = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
//		fprintf(stderr, "opening %s failed\n", TEMPFILE);
//		exit(2);
//	}
	fd = open("/dev/mem", O_RDWR | O_SYNC);
	if (-1 == fd)
	{
		printf( "open /dev/mem fail!\n" );
		return 1;
	}

	//addr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, offset);
	addr = mmap(0, size, PROT_READ, MAP_FILE | MAP_SHARED, fd, offset);
	if(addr == MAP_FAILED) {
		fprintf(stderr, "mmap of %s failed\n", TEMPFILE);
		exit(2);
	}
	printf("addr: <0x%x>\n", addr);

	return 0;
}

Regards

Bamvor

On 2016/5/10 15:42, Zhangjian (Bamvor) wrote:
> Hi, Yury
>
> On 2016/5/6 20:37, Yury Norov wrote:
>> On Fri, May 06, 2016 at 08:16:48PM +0800, Zhangjian (Bamvor) wrote:
>>> Hi,
>>>
>>> On 2016/4/6 6:08, Yury Norov wrote:
>>>> From: Andrew Pinski <apinski@cavium.com>
>>>>
>>>> Add a separate syscall-table for ILP32, which dispatches either to native
>>>> LP64 system call implementation or to compat-syscalls, as appropriate.
>>>>
>>>> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
>>>> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>>>> ---
>>>>   arch/arm64/include/asm/unistd.h | 11 ++++++-
>>>>   arch/arm64/kernel/Makefile      |  2 +-
>>>>   arch/arm64/kernel/entry.S       | 12 +++++++-
>>>>   arch/arm64/kernel/sys_ilp32.c   | 65 +++++++++++++++++++++++++++++++++++++++++
>>>>   4 files changed, 87 insertions(+), 3 deletions(-)
>>>>   create mode 100644 arch/arm64/kernel/sys_ilp32.c
>>>>
>>>> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
>>>> index 2971dea..5ea18ef 100644
>>>> --- a/arch/arm64/include/asm/unistd.h
>>>> +++ b/arch/arm64/include/asm/unistd.h
>>>> @@ -13,9 +13,18 @@
>>>>    * You should have received a copy of the GNU General Public License
>>>>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>>    */
>>>> +
>>>> +#ifdef CONFIG_COMPAT
>>>> +#define __ARCH_WANT_COMPAT_STAT64
>>>> +#endif
>>>> +
>>>> +#ifdef CONFIG_ARM64_ILP32
>>>> +#define __ARCH_WANT_COMPAT_SYS_PREADV64
>>>> +#define __ARCH_WANT_COMPAT_SYS_PWRITEV64
>>>> +#endif
>>>> +
>>>>   #ifdef CONFIG_AARCH32_EL0
>>>>   #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
>>>> -#define __ARCH_WANT_COMPAT_STAT64
>>>>   #define __ARCH_WANT_SYS_GETHOSTNAME
>>>>   #define __ARCH_WANT_SYS_PAUSE
>>>>   #define __ARCH_WANT_SYS_GETPGRP
>>>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>>>> index 9dfdf86..7aa65ea 100644
>>>> --- a/arch/arm64/kernel/Makefile
>>>> +++ b/arch/arm64/kernel/Makefile
>>>> @@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>>>>   arm64-obj-$(CONFIG_AARCH32_EL0)        += sys32.o kuser32.o signal32.o     \
>>>>                          sys_compat.o entry32.o        \
>>>>                          ../../arm/kernel/opcodes.o binfmt_elf32.o
>>>> -arm64-obj-$(CONFIG_ARM64_ILP32)        += binfmt_ilp32.o
>>>> +arm64-obj-$(CONFIG_ARM64_ILP32)        += binfmt_ilp32.o sys_ilp32.o
>>>>   arm64-obj-$(CONFIG_FUNCTION_TRACER)    += ftrace.o entry-ftrace.o
>>>>   arm64-obj-$(CONFIG_MODULES)        += arm64ksyms.o module.o
>>>>   arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)    += module-plts.o
>>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>>> index cf4d1ae..1f7a145 100644
>>>> --- a/arch/arm64/kernel/entry.S
>>>> +++ b/arch/arm64/kernel/entry.S
>>>> @@ -715,9 +715,13 @@ ENDPROC(ret_from_fork)
>>>>    */
>>>>       .align    6
>>>>   el0_svc:
>>>> -    adrp    stbl, sys_call_table        // load syscall table pointer
>>>>       uxtw    scno, w8            // syscall number in w8
>>>>       mov    sc_nr, #__NR_syscalls
>>>> +#ifdef CONFIG_ARM64_ILP32
>>>> +    ldr    x16, [tsk, #TI_FLAGS]
>>>> +    tbnz    x16, #TIF_32BIT_AARCH64, el0_ilp32_svc // We are using ILP32
>>>> +#endif
>>>> +    adrp    stbl, sys_call_table        // load syscall table pointer
>>>>   el0_svc_naked:                    // compat entry point
>>>>       stp    x0, scno, [sp, #S_ORIG_X0]    // save the original x0 and syscall number
>>>>       enable_dbg_and_irq
>>>> @@ -737,6 +741,12 @@ ni_sys:
>>>>       b    ret_fast_syscall
>>>>   ENDPROC(el0_svc)
>>>>
>>>> +#ifdef CONFIG_ARM64_ILP32
>>>> +el0_ilp32_svc:
>>>> +    adrp    stbl, sys_call_ilp32_table // load syscall table pointer
>>>> +    b el0_svc_naked
>>>> +#endif
>>>> +
>>>>       /*
>>>>        * This is the really slow path.  We're going to be doing context
>>>>        * switches, and waiting for our parent to respond.
>>>> diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
>>>> new file mode 100644
>>>> index 0000000..0996d8e
>>>> --- /dev/null
>>>> +++ b/arch/arm64/kernel/sys_ilp32.c
>>>> @@ -0,0 +1,65 @@
>>>> +/*
>>>> + * AArch64- ILP32 specific system calls implementation
>>>> + *
>>>> + * Copyright (C) 2016 Cavium Inc.
>>>> + * Author: Andrew Pinski <apinski@cavium.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>> + */
>>>> +
>>>> +#include <linux/compiler.h>
>>>> +#include <linux/errno.h>
>>>> +#include <linux/fs.h>
>>>> +#include <linux/mm.h>
>>>> +#include <linux/msg.h>
>>>> +#include <linux/export.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/syscalls.h>
>>>> +#include <linux/compat.h>
>>>> +#include <asm-generic/syscalls.h>
>>>> +
>>>> +/* Using non-compat syscalls where necessary */
>>>> +#define compat_sys_fadvise64_64        sys_fadvise64_64
>>>> +#define compat_sys_fallocate           sys_fallocate
>>>> +#define compat_sys_ftruncate64         sys_ftruncate
>>>> +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
>>>> +#define compat_sys_pread64             sys_pread64
>>>> +#define compat_sys_pwrite64            sys_pwrite64
>>>> +#define compat_sys_readahead           sys_readahead
>>>> +#define compat_sys_shmat               sys_shmat
>>>> +#define compat_sys_sync_file_range     sys_sync_file_range
>>>> +#define compat_sys_truncate64          sys_truncate
>>>> +#define sys_llseek                     sys_lseek
>>>> +#define sys_mmap2               sys_mmap
>>> I am a little bit confused here. We wrap the mmap to mmap2 in glibc
>>> without shift the 4096 and We map mmap2 to mmap in kernel which
>>> means we shift with the real page size. It works unless the
>>> application want to mmap the offset bigger then 2G. In ILP32 app,
>>> if the offset is bigger than 2G(e.g. 0xfb000000), it is a negative
>>> number and extend to 64bit nagetive number in kernel
>>> (0xfffffff fb000000). I add the "COMPAT_SYSCALL_WRAP6(mmap, ...)" in
>>> kernel/compat_wrapper.c. But it is not works. I am not sure if it is
>>> already sign extended in userspace.
>>>
>>> On the other hand, I read the code of mmap in arm and other
>>> architecture. Usually, they will shift 4096 in userspace and shift
>>> others in kernel if needed. Should we follow the similar ways or we
>>> could call mmap_pgoff in glibc and do the shift according the real
>>> page shift(getpages())?
>>>
>>> Thanks
>>>
>>> Bamvor
>>>
>>>
>>
>> Hi,
>>
>> AFAIR, here we don't shift offset, as it's 64-bit both in user-
>> and kernel-space,
> In your ilp32-2.22 branch, you wrapper mmap to mmap2 in which type of
> offset is off_t. And off_t is 32bit in ilp32, correct?
> "sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c"
> /* mmap is provided by mmap as they are the same. */
> void *__mmap (void *__addr, size_t __len, int __prot,
>                       int __flags, int __fd, __off_t __offset)
> {
>     void *result;
>     result = (void *)
>       INLINE_SYSCALL (mmap2, 6, __addr,
>                       __len, __prot, __flags, __fd, __offset);
>     return result;
> }
>> and just pass it from user to kernel thru glibc
>> with no changes.
>>
>> It definitely works, as there are many mappings made by linker and
>> libc in 2G+ area, and there are no problems with them. This is a
>> typical ILP32 application map:
> Ok, the different is I am talking about the offset in mmap. I am NOT
> talking about the map result.
> If I run my test case with strace:
> "strace -e trace=mmap ./mmap.arm64_ilp32 0xfb000000 0x1000", here is
> the part of log:
>
> 1 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7721000
> 2 mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7557000
> 3 page size<0x1000>, offset is <0xfb000000>
> 4 mmap(NULL, 4096, PROT_READ, MAP_SHARED, 3, 0xfffffffffb000000) = -1 EINVAL (Invalid argument)
> 5 mmap of mmapfile failed
>
> As you said, line 1 and 2 show that mmap could map above 2G. But it
> is NOT what I want to discussion.
> As I said, when I pass the offset above 2G(e.g. 0xfb0000000), we
> could find that the actual offset pass to kernel is
> 0xfffffffffb000000(reference line 4).
> It will fail if I map in /dev/mmem. It will not fail if the fd is
> a normal file. But in both of case the offset is wrong.
>
> Regards
>
> Bamvor
>
>> 00400000-00401000 r-xp 00000000 08:00 130400     /root/mykill
>> 00410000-00411000 rwxp 00000000 08:00 130400     /root/mykill
>> 00527000-00549000 rwxp 00000000 00:00 0          [heap]
>> c6278000-c6298000 rwxp 00000000 00:00 0
>> c6298000-c63d0000 r-xp 00000000 08:00 135293     /root/sys-root/libilp32/libc-2.22.so
>> c63d0000-c63e0000 ---p 00138000 08:00 135293     /root/sys-root/libilp32/libc-2.22.so
>> c63e0000-c63e2000 r-xp 00138000 08:00 135293     /root/sys-root/libilp32/libc-2.22.so
>> c63e2000-c63e3000 rwxp 0013a000 08:00 135293     /root/sys-root/libilp32/libc-2.22.so
>> c63e3000-c63e6000 rwxp 00000000 00:00 0
>> c63e6000-c63fc000 r-xp 00000000 08:00 135313     /root/sys-root/libilp32/libpthread-2.22.so
>> c63fc000-c640b000 ---p 00016000 08:00 135313     /root/sys-root/libilp32/libpthread-2.22.so
>> c640b000-c640c000 r-xp 00015000 08:00 135313     /root/sys-root/libilp32/libpthread-2.22.so
>> c640c000-c640d000 rwxp 00016000 08:00 135313     /root/sys-root/libilp32/libpthread-2.22.so
>> c640d000-c640f000 rwxp 00000000 00:00 0
>> c640f000-c642c000 r-xp 00000000 08:00 135288     /root/sys-root/libilp32/ld-2.22.so
>> c6437000-c6439000 rwxp 00000000 00:00 0
>> c6439000-c643a000 r--p 00000000 00:00 0          [vvar]
>> c643a000-c643b000 r-xp 00000000 00:00 0          [vdso]
>> c643b000-c643c000 r-xp 0001c000 08:00 135288     /root/sys-root/libilp32/ld-2.22.so
>> c643c000-c643d000 rwxp 0001d000 08:00 135288     /root/sys-root/libilp32/ld-2.22.so
>> ffe2d000-ffe4e000 rw-p 00000000 00:00 0          [stack]
>>
>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
