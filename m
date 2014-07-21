From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Let user space control the cpu states
Date: Mon, 21 Jul 2014 09:47:47 +0200
Message-ID: <53CCC5A3.4000107@de.ibm.com>
References: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com> <53C933EB.9020707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53C933EB.9020707@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 18/07/14 16:49, Paolo Bonzini wrote:
> Il 15/07/2014 15:27, Christian Borntraeger ha scritto:
>> Paolo,
>>
>> The following changes since commit 9f6226a762c7ae02f6a23a3d4fc552dafa57ea23:
>>
>>   arch: x86: kvm: x86.c: Cleaning up variable is set more than once (2014-06-30 16:52:04 +0200)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140715
>>
>> for you to fetch changes up to 6352e4d2dd9a349024a41356148eced553e1dce4:
>>
>>   KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control (2014-07-10 14:11:17 +0200)
>>
>> ----------------------------------------------------------------
>> This series enables the "KVM_(S|G)ET_MP_STATE" ioctls on s390 to make
>> the cpu state settable by user space.
>>
>> This is necessary to avoid races in s390 SIGP/reset handling which
>> happen because some SIGPs are handled in QEMU, while others are
>> handled in the kernel. Together with the busy conditions as return
>> value of SIGP races happen especially in areas like starting and
>> stopping of CPUs. (For example, there is a program 'cpuplugd', that
>> runs on several s390 distros which does automatic onlining and
>> offlining on cpus.)
>>
>> As soon as the MPSTATE interface is used, user space takes complete
>> control of the cpu states. Otherwise the kernel will use the old way.
>>
>> Therefore, the new kernel continues to work fine with old QEMUs.
>>
>> ----------------------------------------------------------------
>> David Hildenbrand (5):
>>       KVM: s390: allow only one SIGP STOP (AND STORE STATUS) at a time
>>       KVM: s390: move finalization of SIGP STOP orders to kvm_s390_vcpu_stop
>>       KVM: s390: remove __cpu_is_stopped and expose is_vcpu_stopped
>>       KVM: prepare for KVM_(S|G)ET_MP_STATE on other architectures
>>       KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control
>>
>>  Documentation/virtual/kvm/api.txt | 31 ++++++++++++++---------
>>  arch/s390/include/asm/kvm_host.h  |  1 +
>>  arch/s390/kvm/diag.c              |  3 ++-
>>  arch/s390/kvm/intercept.c         | 32 ++++++++++--------------
>>  arch/s390/kvm/kvm-s390.c          | 52 +++++++++++++++++++++++++++++++--------
>>  arch/s390/kvm/kvm-s390.h          | 10 ++++++--
>>  arch/s390/kvm/sigp.c              |  7 +++++-
>>  include/uapi/linux/kvm.h          |  7 +++++-
>>  8 files changed, 98 insertions(+), 45 deletions(-)
>>
> 
> Alex, wdyt about this patch series?  Does it make sense to use
> KVM_GET/SET_MP_STATE or should the one-reg interface be a better match?
> 
> It's a bit weird that running and halted map to the same mp_state on
> s390.  I would be more confident that KVM_GET/SET_MP_STATE is the right
> choice if it had at least the KVM_MP_STATE_RUNNABLE and
> KVM_MP_STATE_HALTED.  Christian, where is the halted state stored, is it
> in the PSW?

Yes, there is a bit in the PSW called wait. It is pretty much similar to 
the HLT instruction: The CPU does not continue the execution, but it will
accept all interrupts that are not fenced via control registers or PSW. 
Its mostly used for cpu_idle. KVM on s390 is always doing the wait in the
kernel (IOW, we always have something like halt_in_kernel), except for the
disabled wait which boils down to no execution and all interrupts off. This is
used for error states of the OS and a special case (we set the guest in the
panic state).

So having such a state wont buy us much. It would be even wrong, because
we want our MP_STATE defines to be a 1:1 match of the states that are defined
in the architecture as proper CPU states. Some of the SIGP calls will return the
state of the target CPU and that depends on the CPU state as defined in the
architecture. The wait bit does not have an influence on the return value.


So instead of modelling as x86, we actually want to model the mp_states as 
defined for the architecture. What I can see from the x86 defines, its somewhat
similar: it matches the x86 architecture and not the QEMU model.


ONEREG would work as well (you can make it work with almost every interface),
but mp_state looks like a better fit to me, because its is an interface to define
CPU states that are not directly tied to runtime registers.
Furthermore, the bits in PSW and registers are only considered by the HW if
the CPU is in the operating state. By using ONEREG, we would have a "register"
that does not follow that rule.

Christian

PS: See SA22-7832 chapter 4-1 (http://publibfi.boulder.ibm.com/epubs/pdf/dz9zr009.pdf !! its big)
---snip---
The stopped, operating, load, and check-stop states
are four mutually exclusive states of the CPU. When
the CPU is in the stopped state, instructions and
interruptions, other than the restart interruption, are
not executed. In the operating state, the CPU exe-
cutes instructions and takes interruptions, subject to
the control of the program-status word (PSW) and
control registers, and in the manner specified by the
setting of the operator-facility rate control. The CPU
is in the load state during the initial-program-loading
operation of ESA/390. The CPU enters the check-
stop state only as the result of machine malfunctions.
---snip---
