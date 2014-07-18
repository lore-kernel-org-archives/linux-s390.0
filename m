From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/5] KVM: s390: Let user space control the cpu states
Date: Fri, 18 Jul 2014 16:49:15 +0200
Message-ID: <53C933EB.9020707@redhat.com>
References: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 15/07/2014 15:27, Christian Borntraeger ha scritto:
> Paolo,
> 
> The following changes since commit 9f6226a762c7ae02f6a23a3d4fc552dafa57ea23:
> 
>   arch: x86: kvm: x86.c: Cleaning up variable is set more than once (2014-06-30 16:52:04 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140715
> 
> for you to fetch changes up to 6352e4d2dd9a349024a41356148eced553e1dce4:
> 
>   KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control (2014-07-10 14:11:17 +0200)
> 
> ----------------------------------------------------------------
> This series enables the "KVM_(S|G)ET_MP_STATE" ioctls on s390 to make
> the cpu state settable by user space.
> 
> This is necessary to avoid races in s390 SIGP/reset handling which
> happen because some SIGPs are handled in QEMU, while others are
> handled in the kernel. Together with the busy conditions as return
> value of SIGP races happen especially in areas like starting and
> stopping of CPUs. (For example, there is a program 'cpuplugd', that
> runs on several s390 distros which does automatic onlining and
> offlining on cpus.)
> 
> As soon as the MPSTATE interface is used, user space takes complete
> control of the cpu states. Otherwise the kernel will use the old way.
> 
> Therefore, the new kernel continues to work fine with old QEMUs.
> 
> ----------------------------------------------------------------
> David Hildenbrand (5):
>       KVM: s390: allow only one SIGP STOP (AND STORE STATUS) at a time
>       KVM: s390: move finalization of SIGP STOP orders to kvm_s390_vcpu_stop
>       KVM: s390: remove __cpu_is_stopped and expose is_vcpu_stopped
>       KVM: prepare for KVM_(S|G)ET_MP_STATE on other architectures
>       KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control
> 
>  Documentation/virtual/kvm/api.txt | 31 ++++++++++++++---------
>  arch/s390/include/asm/kvm_host.h  |  1 +
>  arch/s390/kvm/diag.c              |  3 ++-
>  arch/s390/kvm/intercept.c         | 32 ++++++++++--------------
>  arch/s390/kvm/kvm-s390.c          | 52 +++++++++++++++++++++++++++++++--------
>  arch/s390/kvm/kvm-s390.h          | 10 ++++++--
>  arch/s390/kvm/sigp.c              |  7 +++++-
>  include/uapi/linux/kvm.h          |  7 +++++-
>  8 files changed, 98 insertions(+), 45 deletions(-)
> 

Alex, wdyt about this patch series?  Does it make sense to use
KVM_GET/SET_MP_STATE or should the one-reg interface be a better match?

It's a bit weird that running and halted map to the same mp_state on
s390.  I would be more confident that KVM_GET/SET_MP_STATE is the right
choice if it had at least the KVM_MP_STATE_RUNNABLE and
KVM_MP_STATE_HALTED.  Christian, where is the halted state stored, is it
in the PSW?

Paolo
