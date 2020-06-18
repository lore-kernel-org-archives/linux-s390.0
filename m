Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:55438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730376AbgFRNth (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jun 2020 09:49:37 -0400
Subject: Re: [PATCH] s390: fix build error for sys_call_table_emu
References: <20200618110320.104013-1-nixiaoming@huawei.com>
 <20200618112702.GB4231@osiris>
From: Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <a7e79943-0858-f1eb-5d06-3c7339c592d3@huawei.com>
Date: Thu, 18 Jun 2020 21:49:21 +0800
MIME-Version: 1.0
In-Reply-To: <20200618112702.GB4231@osiris>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, arnd@arndb.de, borntraeger@de.ibm.com, catalin.marinas@arm.com, christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com, fenghua.yu@intel.com, geert@linux-m68k.org, gor@linux.ibm.com, ink@jurassic.park.msu.ru, jolsa@redhat.com, linux@armlinux.org.uk, lkp@intel.com, mark.rutland@arm.com, mattst88@gmail.com, minchan@kernel.org, mingo@redhat.com, monstr@monstr.eu, namhyung@kernel.org, peterz@infradead.org, rth@twiddle.net, sargun@sargun.me, sfr@canb.auug.org.au, tony.luck@intel.com, will@kernel.org, akpm@linux-foundation.org, alex.huangjianhui@huawei.com, zhongjubin@huawei.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, clang-built-linux@googlegroups.com, kbuild-all@lists.01.org, linux-mm@kvack.org

On 2020/6/18 19:27, Heiko Carstens wrote:
> On Thu, Jun 18, 2020 at 07:03:20PM +0800, Xiaoming Ni wrote:
>> Build error on s390:
>> 	arch/s390/kernel/entry.o: in function `sys_call_table_emu':
>> 	>> (.rodata+0x1288): undefined reference to `__s390_'
>>
>> In commit ("All arch: remove system call sys_sysctl")
>>   148  common	fdatasync		sys_fdatasync			sys_fdatasync
>> -149  common	_sysctl			sys_sysctl			compat_sys_sysctl
>> +149  common	_sysctl			sys_ni_syscall
>>   150  common	mlock			sys_mlock			sys_mlock
>>
>> After the patch is integrated, there is a format error in the generated
>> arch/s390/include/generated/asm/syscall_table.h:
>> 	SYSCALL(sys_fdatasync, sys_fdatasync)
>> 	SYSCALL(sys_ni_syscall,) /* cause build error */
>> 	SYSCALL(sys_mlock,sys_mlock)
>>
>> There are holes in the system call number in
>>   arch/s390/kernel/syscalls/syscall.tbl. When generating syscall_table.h,
>> these hole numbers will be automatically filled with "NI_SYSCALL".
>> Therefore, delete the number 149 to fix the current compilation failure.
>>   Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.
>>
>> Fixes: ("All arch: remove system call sys_sysctl")
>> Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> ---
>>   arch/s390/kernel/syscalls/syscall.tbl           | 1 -
>>   tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
>> index f17aaf6fe5de..bcaf93994e3c 100644
>> --- a/arch/s390/kernel/syscalls/syscall.tbl
>> +++ b/arch/s390/kernel/syscalls/syscall.tbl
>> @@ -138,7 +138,6 @@
>>   146  common	writev			sys_writev			compat_sys_writev
>>   147  common	getsid			sys_getsid			sys_getsid
>>   148  common	fdatasync		sys_fdatasync			sys_fdatasync
>> -149  common	_sysctl			sys_ni_syscall
> 
> This is not correct. It should be changed to:
> 
>     149  common	_sysctl			-				-
> 
thanks for your guidance

> Otherwise the generated __NR__sysctl define will be lost from
> unistd.h, which should not happen. Looking at the link above it
> _looks_ like a similar mistake was done for arm64.
> 
Using holes will cause the definition of __NR__sysctl to be missing in 
include/asm/unistd_32.h and include/asm/unistd_64.h

For arm64, I observed that "sys_afs_syscall", "sys_get_kernel_syms" and 
other commented out syscalls have no corresponding definition _NR_XXX in 
unistd.h, is it not a problem on arm64?

                         /* 127 was sys_create_module */
__SYSCALL(127, sys_ni_syscall)

                         /* 130 was sys_get_kernel_syms */
__SYSCALL(130, sys_ni_syscall)

                         /* 137 was sys_afs_syscall */
__SYSCALL(137, sys_ni_syscall)


Thanks
Xiaoming Ni
