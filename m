From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Thu, 12 May 2016 11:45:53 +0800
Message-ID: <5733FC71.8070101@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <573305A8.50406@huawei.com> <5733149C.4030903@huawei.com>
 <5250356.myv9GIZ34h@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5250356.myv9GIZ34h@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi, Arnd

On 2016/5/11 22:50, Arnd Bergmann wrote:
> On Wednesday 11 May 2016 19:16:44 Zhangjian wrote:
>> Hi,
>>
>> On 2016/5/11 18:12, Zhangjian (Bamvor) wrote:
>>> Hi, Arnd
>>>
>>> On 2016/5/11 16:09, Arnd Bergmann wrote:
>>>   > On Wednesday 11 May 2016 10:04:16 Zhangjian wrote:
>>>   >>> I don't remember. It's probably not important whether we have the shift
>>>   >>> in there, as long as it's independent of the actual kernel page size and
>>>   >>> user space and kernel agree on the calling conventions.
>>>   >> Well. I am ok with where to shift the pages size because we get the same
>>>   >> result. I was just thinking if we should get rid of the name of mmap2 in our
>>>   >> ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
>>>   >> if they do not know the implementations.
>>>   >
>>>   > That is a good point: If the implementation matches the mmap() behavior rather than
>>>   > mmap2(), we should rename the macro by doing
>>>   >
>>>   > #undef __NR_mmap2
>>>   > #define __NR_mmap 222
>>>   >
>>>   > in the uapi/asm/unistd.h file for ilp32 mode.
>>> Do you mean define the following things in kernel:
>>> ```
>>> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
>>> index 1caadc2..3f79640 100644
>>> --- a/arch/arm64/include/uapi/asm/unistd.h
>>> +++ b/arch/arm64/include/uapi/asm/unistd.h
>>> @@ -14,3 +14,9 @@
>>>     * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>>     */
>>>    #include <asm-generic/unistd.h>
>>> +
>>> +#ifdef __ILP32__
>>> +#undef __NR_mmap2
>>> +#define __NR_mmap 222
>>> +#endif /* #ifdef __ILP32__ */
>>> +
>>> ```
>>> Then glibc could call mmap instead of mmap2.
>>> I could not try it now. Because after change off_t to 64bit in glibc, stat
>>> is fail. I may need to revert the stat relative patch.
>> After revert stat relative patch in glibc, mmap01-mmap14 success. But mmap16
>> success with segfault. I will investigate it later.
>>
>> There is pointer and size_t in mmap, so, IIUC, we need to clear the top halves
>> of register by using COMPAT_SYSCALL_WRAP6.
>
> Correct, good catch!
>
>> And after check the function in
>> arch/s390/kernel/compat_linux.c, I feel that we need to do the same thing for
>> pread64 and pwrite64.
>>
>
>> But I got following error when I try to add
>> COMPAT_SYSCALL_WRAP4(pread64, unsigned int, fd, char __user *, buf,
>> size_t, count, loff_t, pos);
>> COMPAT_SYSCALL_WRAP4(pwrite64, unsigned int, fd, const char __user *, buf,
>> size_t, count, loff_t, pos);
>>
>
> Hmm, that is indeed tricky. I think COMPAT_SYSCALL_WRAP4 rightfully
> refuses the loff_t argument here, as the common case is that this is
> not possible.
It works if I apply the following patch, I defined the wrong `__TYPE_IS_xxx`
yesterday. Should we merge this into ILP32 series or send the compat.h
and syscalls.h individually? The current series of ILP32 is a little bit
long and hard to review.
diff --git a/include/linux/compat.h b/include/linux/compat.h
index ba6ebe0..22a9565 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -747,7 +747,8 @@ asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
  #ifndef __SC_COMPAT_CAST
  #define __SC_COMPAT_CAST(t, a) ({                                      \
         BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&              \
-                    !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));            \
+                    !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&           \
+                    !__TYPE_IS_LOFFT(t));                              \
         ((t) ((t)(-1) < 0 ? (s64)(s32)(a) : (u64)(u32)(a)));            \
  })
  #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 6e57d9c..66eb85d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -47,6 +47,7 @@
  #define __TYPE_IS_L(t) (__same_type((t)0, 0L))
  #define __TYPE_IS_UL(t)        (__same_type((t)0, 0UL))
  #define __TYPE_IS_LL(t) (__same_type((t)0, 0LL) || __same_type((t)0, 0ULL))
+#define __TYPE_IS_LOFFT(t)     (__same_type((t)0, (loff_t)0))
  #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
  #define __SC_CAST(t, a)        (t) a
  #define __SC_ARGS(t, a)        a
diff --git a/kernel/compat_wrapper.c b/kernel/compat_wrapper.c
index 98b68b8..28f02d0 100644
--- a/kernel/compat_wrapper.c
+++ b/kernel/compat_wrapper.c
@@ -304,3 +304,7 @@ COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
  COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len,
                      unsigned int, flags, struct sockaddr __user *, addr,
                      int, addr_len);
+COMPAT_SYSCALL_WRAP4(pread64, unsigned int, fd, char __user *, buf,
+                       size_t, count, loff_t, pos);
+COMPAT_SYSCALL_WRAP4(pwrite64, unsigned int, fd, const char __user *, buf,
+                        size_t, count, loff_t, pos);
 >
 > Can you open-code this using a COMPAT_SYSCALL4 definition similar to what
 > arch/tile has, but without the merging of the two halves of the argument?
I am lost here. Tile do not use the wrapper, and it do not use the loff_t
either:
COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
                        size_t, count, u32, dummy, u32, low, u32, high)

Regards

Bamvor
> 	Arnd
>
