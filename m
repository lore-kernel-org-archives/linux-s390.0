From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Thu, 12 May 2016 20:49:24 +0800
Message-ID: <57347BD4.8010105@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <4989778.Fs81NJurjH@wuerfel>
 <20160512091758.GB11226@e104818-lin.cambridge.arm.com>
 <2733875.IzutTZKHMc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2733875.IzutTZKHMc@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 2016/5/12 17:21, Arnd Bergmann wrote:
> On Thursday 12 May 2016 10:17:58 Catalin Marinas wrote:
>> On Wed, May 11, 2016 at 09:30:07PM +0200, Arnd Bergmann wrote:
>>> On Wednesday 11 May 2016 17:59:01 Catalin Marinas wrote:
>>>
>>> I don't think the shifts are a problem, the main downside would be
>>> the limit to 44 bits of file offsets (16TB files), but it's also
>>> unclear if that is a practical problem at all. If it is, we run
>>> into the same problem on all other 32-bit architectures too.
>>
>> I hope people are seriously thinking of moving to an LP64 ABI if they
>> have such large file offset needs.
>
> Good point. 44 bits of file size is certainly enough for mmap()
> on a 32-bit task: you would only be able to map a very small fraction
> of the file anyway, and if you want to map larger files, and should
> move to 64-bit tasks long before this becomes a limitation.
Hi,

I apply the following patch in order to make use of the REAL mmmap2. LTP
test pass in litle endian. mmap16 successful with segfault in big endian.

BTW, I saw the similar code in tile, mips, microblaze and s390 compat. Should
we merge these code into a common syscall wrapper?

kernel:
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index d85fe94..2cd72eb 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -41,7 +41,16 @@
  #define compat_sys_sync_file_range     sys_sync_file_range
  #define compat_sys_truncate64          sys_truncate
  #define sys_llseek                     sys_lseek
-#define sys_mmap2                     sys_mmap
+
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+       unsigned long, prot, unsigned long, flags, unsigned long, fd,
+       unsigned long, pgoff)
+{
+       if (pgoff & (~PAGE_MASK >> 12))
+               return -EINVAL;
+
+       return sys_mmap_pgoff(addr, len, prot, flags, fd, pgoff >> (PAGE_SHIFT-12));
+}

  asmlinkage long ilp32_sys_rt_sigreturn_wrapper(void);
  #define compat_sys_rt_sigreturn        ilp32_sys_rt_sigreturn_wrapper

glibc:
diff --git a/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap.c b/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap.c
index e69de29..f75e251 100644
--- a/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap.c
+++ b/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap.c
@@ -0,0 +1,2 @@
+#include <sysdeps/unix/sysv/linux/generic/wordsize-32/mmap.c>
+
diff --git a/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c b/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c
index c6c7f1d..6f1a141 100644
--- a/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c
+++ b/sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c
@@ -1,29 +1 @@
-#include <errno.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <string.h>
-
-#include <sysdep.h>
-#include <sys/syscall.h>
-
-/* mmap is provided by mmap as they are the same. */
-void *__mmap (void *__addr, size_t __len, int __prot,
-                    int __flags, int __fd, __off_t __offset)
-{
-   void *result;
-   result = (void *) INLINE_SYSCALL (mmap2, 6, __addr, __len, __prot, __flags,
-   return result;
-}
-/* mmap64 is provided by mmap as they are the same. */
-void *__mmap64 (void *__addr, size_t __len, int __prot,
-                    int __flags, int __fd, __off64_t __offset)
-{
-   void *result;
-   result = (void *)
-     INLINE_SYSCALL (mmap2, 6, __addr,
-                     __len, __prot, __flags, __fd, __offset);
-   return result;
-}
-weak_alias (__mmap, mmap)
-weak_alias (__mmap64, mmap64)
+#include <sysdeps/unix/sysv/linux/mmap64.c>

Regards

Bamvor
> 	Arnd
>
