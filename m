From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Tue, 10 May 2016 17:47:26 +0800
Message-ID: <5731AE2E.2050403@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160506123731.GA11959@yury-N73SV> <573190CF.6030408@huawei.com>
 <9651510.pg5Vmm8vKS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <9651510.pg5Vmm8vKS@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, "bamvor >> Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi, Arnd

On 2016/5/10 16:36, Arnd Bergmann wrote:
> On Tuesday 10 May 2016 15:42:07 Zhangjian wrote:
>> On 2016/5/6 20:37, Yury Norov wrote:
>>> On Fri, May 06, 2016 at 08:16:48PM +0800, Zhangjian (Bamvor) wrote:
>>>
>>> AFAIR, here we don't shift offset, as it's 64-bit both in user-
>>> and kernel-space,
>> In your ilp32-2.22 branch, you wrapper mmap to mmap2 in which type of
>> offset is off_t. And off_t is 32bit in ilp32, correct?
>> "sysdeps/unix/sysv/linux/aarch64/ilp32/mmap64.c"
>> /* mmap is provided by mmap as they are the same. */
>> void *__mmap (void *__addr, size_t __len, int __prot,
>>                        int __flags, int __fd, __off_t __offset)
>> {
>>      void *result;
>>      result = (void *)
>>        INLINE_SYSCALL (mmap2, 6, __addr,
>>                        __len, __prot, __flags, __fd, __offset);
>>      return result;
>> }
>
> __off_t should be 'long long' on new architectures, and map
> to __kernel_loff_t.
>
> Can you see how it is defined?
For kernel part, in "include/uapi/asm-generic/posix_types.h":
     #ifndef __kernel_long_t
     typedef long            __kernel_long_t;
     typedef unsigned long   __kernel_ulong_t;
     #endif
     typedef __kernel_long_t __kernel_off_t;
in "include/linux/types.h":
     typedef __kernel_off_t          off_t;

"include/uapi/asm-generic/posix_types.h" is uapi, we could not check
"ARCH_32BIT_OFF_T" here. Besides, the `__kernel_long_t` is long which
mean it is 32bit in ILP32. should we define something like x32?
     ```
     diff --git a/arch/arm64/include/uapi/asm/posix_types.h b/arch/arm64/include/uapi/asm/posix_types.h
     index 7985ff6..9baa8d3 100644
     --- a/arch/arm64/include/uapi/asm/posix_types.h
     +++ b/arch/arm64/include/uapi/asm/posix_types.h
     @@ -5,6 +5,9 @@ typedef unsigned short __kernel_old_uid_t;
      typedef unsigned short __kernel_old_gid_t;
       #define __kernel_old_uid_t __kernel_old_uid_t

      +typedef long long __kernel_long_t;
      +typedef unsigned long long __kernel_ulong_t;
      +
       #include <asm-generic/posix_types.h>

       #endif /*  __ASM_POSIX_TYPES_H */u
     ```
After this definition, the following kernel types is 64bit in ILP32:
     typedef __kernel_long_t         __kernel_suseconds_t;
     typedef __kernel_long_t __kernel_ssize_t;
     typedef __kernel_long_t __kernel_ptrdiff_t;
     typedef __kernel_long_t __kernel_off_t;
     typedef __kernel_long_t __kernel_time_t;
     typedef __kernel_long_t __kernel_clock_t;
     typedef __kernel_ulong_t __kernel_ino_t;
     typedef __kernel_ulong_t __kernel_size_t;

But it is not a generic way to define off_t to 64bit if
ARCH_32BIT_OFF_T is not defined. How about this one? We need to
define `__kernel_off_t` on all the old 32bit architecture like
arm:
```
diff --git a/arch/arm/include/uapi/asm/posix_types.h b/arch/arm/include/uapi/asm/posix_types.h
index d2de9cb..f9d065c 100644
--- a/arch/arm/include/uapi/asm/posix_types.h
+++ b/arch/arm/include/uapi/asm/posix_types.h
@@ -32,6 +32,9 @@ typedef unsigned short                __kernel_gid_t;
  typedef unsigned short         __kernel_old_dev_t;
  #define __kernel_old_dev_t __kernel_old_dev_t

+typedef __kernel_long_t        __kernel_off_t;
+#define __kernel_off_t
+
  #include <asm-generic/posix_types.h>

  #endif
```
And We could change the generic posix_types.h a little bit:
```
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index fe74fcc..7bbaf04 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -80,10 +80,13 @@ typedef struct {
  } __kernel_fsid_t;
  #endif

+#ifndef __kernel_off_t
+typedef long long __kernel_off_t;
+#endif
+
  /*
   * anything below here should be completely generic
   */
-typedef __kernel_long_t        __kernel_off_t;
  typedef long long      __kernel_loff_t;
  typedef __kernel_long_t        __kernel_time_t;
  typedef __kernel_long_t        __kernel_clock_t;
```

On the other hand, glibc define it own off_t in "bits/types.h":
     __STD_TYPE __OFF_T_TYPE __off_t;        /* Type of file sizes and offsets.  */
     __STD_TYPE __OFF64_T_TYPE __off64_t;    /* Type of file sizes and offsets (LFS).  */

in "sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h":
     #define __OFF_T_TYPE            __SLONGWORD_TYPE
     #define __OFF64_T_TYPE          __SQUAD_TYPE

If we define off_t as 64bit in glibc:
     #define __OFF_T_TYPE           __SQUAD_TYPE

Should We need to align all the off_t syscall to 64bit syscall in
kernel?

Regards

Bamvor


> 	Arnd
>
