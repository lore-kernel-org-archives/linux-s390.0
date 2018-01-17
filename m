From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/6] s390: improve speculative execution handling
Date: Wed, 17 Jan 2018 13:00:38 +0100
Message-ID: <20180117130038.4830f89b.cohuck@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018 10:48:33 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> This patch series implements multiple mitigations for the speculative
> execution findings:
> 1. The definition of the gmb() barrier as currently used by the
>    distributions, we may have to find a better name for it
> 2. The architecture code for the nospec interfaces, the macros for
>    nospec_ptr and nospec_load just use the gmb() barrier
> 3. The enablement for firmware features to switch between different
>    branch prediction modes. It comes with a config option
>    CONFIG_KERNEL_NOBP, two new kernel parameters "nobp=[0|1]" and
>    "nospec", and a new system call s390_modify_bp.
>    With CONFIG_KERNEL_NOBP=y the new branch prediction mode is active
>    for the kernel code by default and can be switched off with "nospec"
>    or "nobp=0". With CONFIG_KERNEL_NOBP=n the new mode is inactive for
>    kernel code unless "nobp=1" is specified.
>    User space code can use the trapdoor system call s390_modify_bp to
>    set the new TIF_NOBP bit. This switches to the new branch prediction
>    mode for the lifetime of the task, any children of the task will
>    inherit this attribute.
>    The vCPU of a KVM guest will run with the new branch prediction
>    mode if either the associated qemu task has TIF_NOBP set or if the
>    KVM kernel code sets TIF_NOBP_GUEST. The later will require a small
>    update to KVM backend.

How does this interact with the facility bits? Bit 81 seems to indicate
function code f (gmb), while bit 82 seems to indicate function codes
c/d (branch prediction modes). Both seem to be in the range of bits
transparently passed through for kvm (although this still needs a qemu
update to the cpu models so the bits are not masked out as unknown.)

What happens if a certain branch prediction mode is set prior to
execution of SIE and the guest kernel is issuing PPA c/d itself?

> 4. Transport channel reduction by clearing registers on interrupts,
>    system calls and KVM guest exits.
> 
> We are working on an equivalent for retpoline, stay tuned.
> 
> @Greg: I have started with the backports for the stable kernel releases,
> but unless the interface for gmp/nospec_ptr/nospec_load is cast in stone
> does it make sense to send them?
> 
> Christian Borntraeger (1):
>   KVM: s390: wire up seb feature
> 
> Martin Schwidefsky (5):
>   s390/alternative: use a copy of the facility bit mask
>   s390: implement nospec_[load|ptr]
>   s390: add options to change branch prediction behaviour for the kernel
>   s390: add system call to run tasks with modified branch prediction
>   s390: scrub registers on kernel entry and KVM exit
> 
>  arch/s390/Kconfig                   |  17 +++++
>  arch/s390/include/asm/barrier.h     |  38 ++++++++++
>  arch/s390/include/asm/facility.h    |  18 +++++
>  arch/s390/include/asm/kvm_host.h    |   3 +-
>  arch/s390/include/asm/lowcore.h     |   3 +-
>  arch/s390/include/asm/processor.h   |   1 +
>  arch/s390/include/asm/thread_info.h |   4 ++
>  arch/s390/include/uapi/asm/kvm.h    |   4 +-
>  arch/s390/include/uapi/asm/unistd.h |   3 +-
>  arch/s390/kernel/alternative.c      |  33 ++++++++-
>  arch/s390/kernel/early.c            |   5 ++
>  arch/s390/kernel/entry.S            | 134 +++++++++++++++++++++++++++++++++++-
>  arch/s390/kernel/ipl.c              |   1 +
>  arch/s390/kernel/setup.c            |   4 +-
>  arch/s390/kernel/smp.c              |   6 +-
>  arch/s390/kernel/sys_s390.c         |   8 +++
>  arch/s390/kernel/syscalls.S         |   1 +
>  arch/s390/kvm/kvm-s390.c            |  11 +++
>  arch/s390/kvm/vsie.c                |   8 +++
>  include/uapi/linux/kvm.h            |   1 +
>  20 files changed, 294 insertions(+), 9 deletions(-)
> 

Something under Documentation/ to document the new knobs would be nice.
