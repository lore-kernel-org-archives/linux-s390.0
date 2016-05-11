From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Wed, 11 May 2016 19:16:44 +0800
Message-ID: <5733149C.4030903@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <4119683.coHZhzaE6c@wuerfel> <57329320.1000500@huawei.com>
 <4876119.A8fbdncu9Z@wuerfel> <573305A8.50406@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <573305A8.50406@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, Yury Norov <ynorov@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>, joseph@codesourcery.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, "jijun (D)" <jijun2@huawei.com>, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de, pinskia@gmail.com, klimov.linux@gmail.com, broonie@kernel.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 2016/5/11 18:12, Zhangjian (Bamvor) wrote:
> Hi, Arnd
>
> On 2016/5/11 16:09, Arnd Bergmann wrote:
>  > On Wednesday 11 May 2016 10:04:16 Zhangjian wrote:
>  >>> I don't remember. It's probably not important whether we have the shift
>  >>> in there, as long as it's independent of the actual kernel page size and
>  >>> user space and kernel agree on the calling conventions.
>  >> Well. I am ok with where to shift the pages size because we get the same
>  >> result. I was just thinking if we should get rid of the name of mmap2 in our
>  >> ILP32 porting. Actually, it is mmap but we name it as mmap2. User may confused
>  >> if they do not know the implementations.
>  >
>  > That is a good point: If the implementation matches the mmap() behavior rather than
>  > mmap2(), we should rename the macro by doing
>  >
>  > #undef __NR_mmap2
>  > #define __NR_mmap 222
>  >
>  > in the uapi/asm/unistd.h file for ilp32 mode.
> Do you mean define the following things in kernel:
> ```
> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> index 1caadc2..3f79640 100644
> --- a/arch/arm64/include/uapi/asm/unistd.h
> +++ b/arch/arm64/include/uapi/asm/unistd.h
> @@ -14,3 +14,9 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   #include <asm-generic/unistd.h>
> +
> +#ifdef __ILP32__
> +#undef __NR_mmap2
> +#define __NR_mmap 222
> +#endif /* #ifdef __ILP32__ */
> +
> ```
> Then glibc could call mmap instead of mmap2.
> I could not try it now. Because after change off_t to 64bit in glibc, stat
> is fail. I may need to revert the stat relative patch.
After revert stat relative patch in glibc, mmap01-mmap14 success. But mmap16
success with segfault. I will investigate it later.

There is pointer and size_t in mmap, so, IIUC, we need to clear the top halves
of register by using COMPAT_SYSCALL_WRAP6. And after check the function in
arch/s390/kernel/compat_linux.c, I feel that we need to do the same thing for
pread64 and pwrite64.

But I got following error when I try to add
COMPAT_SYSCALL_WRAP4(pread64, unsigned int, fd, char __user *, buf,
size_t, count, loff_t, pos);
COMPAT_SYSCALL_WRAP4(pwrite64, unsigned int, fd, const char __user *, buf,
size_t, count, loff_t, pos);

The error message:
kernel/compat_wrapper.c: In function 'compat_SyS_pread64':
include/linux/compiler.h:429:38: error: call to '__compiletime_assert_308' declared with attribute error: BUILD_BUG_ON failed: (sizeof(loff_t) > 4) && !__TYPE_IS_L(loff_t) && !__TYPE_IS_UL(loff_t) && !__TYPE_IS_PTR(loff_t)
_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
^
include/linux/compiler.h:412:4: note: in definition of macro '__compiletime_assert'
prefix ## suffix(); \
^
include/linux/compiler.h:429:2: note: in expansion of macro '_compiletime_assert'
_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
^
include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
^
include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
^
include/linux/compat.h:749:2: note: in expansion of macro 'BUILD_BUG_ON'
BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) && \
^
include/linux/syscalls.h:38:23: note: in expansion of macro '__SC_COMPAT_CAST'
#define __MAP1(m,t,a) m(t,a)
^
include/linux/syscalls.h:39:35: note: in expansion of macro '__MAP1'
#define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
^
include/linux/syscalls.h:40:35: note: in expansion of macro '__MAP2'
#define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
^
include/linux/syscalls.h:41:35: note: in expansion of macro '__MAP3'
#define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
^
include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP4'
#define __MAP(n,...) __MAP##n(__VA_ARGS__)
^
include/linux/compat.h:777:19: note: in expansion of macro '__MAP'
return sys##name(__MAP(x, __SC_COMPAT_CAST, __VA_ARGS__)); \
^
include/linux/compat.h:735:41: note: in expansion of macro 'COMPAT_SYSCALL_WRAPx'
#define COMPAT_SYSCALL_WRAP4(name, ...) COMPAT_SYSCALL_WRAPx(4, _##name,\
^
kernel/compat_wrapper.c:307:1: note: in expansion of macro 'COMPAT_SYSCALL_WRAP4'
COMPAT_SYSCALL_WRAP4(pread64, unsigned int, fd, char __user *, buf,
^

Because the loff_t is not the long, unsigned long or pointer.

Regards

Bamvor
>  > Alternatively we can keep the
>  > __NR_mmap2 definition but then we need to pass the pgoff (value shifted by
>  > 12 bits) argument rather than the size in bytes.
> It means that we could reuse the existing code of mmap2 in kernel and glibc.
> But we need to shift twice when kernel is 64k page.
> It seems that the first method is more clear. Suggestion?
>
> Regards
>
> Bamvor
>  >
>  >   Arnd
>  >
>
