Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 10:30:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
Return-Path: <borntraeger@de.ibm.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org, catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net, deller@gmx.de, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org, rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

You are now include a <linux/*.h> from several asm files
(
 arch/arm64/include/asm/stat.h   
 arch/s390/include/asm/elf.h     
 arch/x86/include/asm/ftrace.h   
 arch/x86/include/asm/sys_ia32.h 
)
It works, and it is done in many places, but it looks somewhat weird.
Would it make sense to have an asm-generic/compate-time.h instead? Asking for
opinions here.

> 
> The patch also requires an operation similar to:
> 
> git grep "asm/compat\.h" | cut -d ":" -f 1 |  xargs -n 1 sed -i -e "s%asm/compat.h%linux/compat.h%g"

some comments from the s390 perspective:

> --- a/arch/s390/hypfs/hypfs_sprp.c
> +++ b/arch/s390/hypfs/hypfs_sprp.c
ok.
[...]
> --- a/arch/s390/include/asm/elf.h
> +++ b/arch/s390/include/asm/elf.h
> @@ -126,7 +126,7 @@
>   */
> 
>  #include <asm/ptrace.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/syscall.h>
>  #include <asm/user.h>

see above.
[...]
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
ok
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
ok
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
ok 
> --- a/drivers/s390/char/fs3270.c
> +++ b/drivers/s390/char/fs3270.c
ok
> --- a/drivers/s390/char/sclp_ctl.c
> +++ b/drivers/s390/char/sclp_ctl.c
ok
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
ok
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
ok

> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -32,7 +32,7 @@
>  #include <asm/chpid.h>
>  #include <asm/io.h>
>  #include <asm/sysinfo.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/diag.h>
>  #include <asm/cio.h>
>  #include <asm/ccwdev.h>

Can you move that into the other includes (where all the other <linux/*> includes are.
