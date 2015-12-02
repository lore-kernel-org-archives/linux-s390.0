From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 00/23] KVM: s390 features, kvm_get_vcpu_by_id and stat
 for 4.5
Date: Wed, 2 Dec 2015 13:50:31 +0100
Message-ID: <565EE917.4050803@redhat.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>



On 02/12/2015 12:06, Christian Borntraeger wrote:
> Paolo,
> 
> here is the first s390 pull request for 4.5. It also contains the
> remaining vcpu lookup changes and an improved cleanup of the kvm_stat
> exit path.
> I have deferred the kvm_stat per VM patches.
> 
> The s390 changes are:
> - ESCA support (up to 248 CPUs)
> - detection if KVM works (e.g. for nested virtualization)
> - cleanups
> 
> The following changes since commit bb11c6c96544737aede6a2eb92e5c6bc8b46534b:
> 
>   KVM: x86: MMU: Remove unused parameter parent_pte from kvm_mmu_get_page() (2015-11-26 15:31:36 +0100)
> 
> are available in the git reposi at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.5-1
> 
> for you to fetch changes up to 2f8a43d45d14ad62b105ed99151b453c12df7149:
> 
>   KVM: s390: remove redudant assigment of error code (2015-11-30 12:47:13 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390 features, kvm_get_vcpu_by_id and stat
> 
> Several features for s390
> 1. ESCA support (up to 248 vCPUs)
> 2. KVM detection: we  can now detect if we support KVM (e.g. does KVM
>    under KVM work?)
> 
> kvm_stat:
> 1. cleanup
> 
> kvm_get_vcpu_by_id:
> 1. Use kvm_get_vcpu_by_id where appropriate
> 2. Apply a heuristic to optimize for ID VCPU == No. VCPU
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: remove redudant assigment of error code
> 
> David Hildenbrand (12):
>       KVM: Use common function for VCPU lookup by id
>       KVM: use heuristic for fast VCPU lookup by id
>       KVM: s390: rewrite vcpu_post_run and drop out early
>       KVM: s390: fast path for sca_ext_call_pending
>       KVM: s390: we always have a SCA
>       KVM: s390: fix SCA related races and double use
>       KVM: s390: always set/clear the SCA sda field
>       KVM: s390: cleanup sca_add_vcpu
>       KVM: s390: don't switch to ESCA for ucontrol
>       s390/sclp: introduce check for SIE
>       s390: show virtualization support in /proc/cpuinfo
>       KVM: s390: don't load kvm without virtualization support
> 
> Eugene (jno) Dvurechenski (8):
>       s390/sclp: introduce checks for ESCA and HVS
>       KVM: s390: Generalize access to IPTE controls
>       KVM: s390: Generalize access to SIGP controls
>       KVM: s390: Provide SCA-aware helpers for VCPU add/del
>       KVM: s390: Introduce new structures
>       KVM: s390: Make provisions for ESCA utilization
>       KVM: s390: Introduce switching code
>       KVM: s390: Enable up to 248 VCPUs per VM
> 
> Heiko Carstens (1):
>       KVM: s390: remove pointless test_facility(2) check
> 
> Janosch Frank (1):
>       KVM: Remove unnecessary debugfs dentry references
> 
>  arch/powerpc/kvm/book3s_hv.c     |  10 +-
>  arch/s390/include/asm/elf.h      |   7 ++
>  arch/s390/include/asm/kvm_host.h |  49 +++++++-
>  arch/s390/include/asm/sclp.h     |   8 +-
>  arch/s390/kernel/processor.c     |   6 +
>  arch/s390/kernel/setup.c         |   9 ++
>  arch/s390/kvm/diag.c             |  11 +-
>  arch/s390/kvm/gaccess.c          |  38 +++++--
>  arch/s390/kvm/intercept.c        |   7 +-
>  arch/s390/kvm/interrupt.c        | 133 +++++++++++++++++-----
>  arch/s390/kvm/kvm-s390.c         | 237 +++++++++++++++++++++++++++------------
>  arch/s390/kvm/kvm-s390.h         |   7 ++
>  drivers/s390/char/sclp_early.c   |   8 +-
>  include/linux/kvm_host.h         |   6 +-
>  virt/kvm/kvm_main.c              |  30 ++---
>  15 files changed, 407 insertions(+), 159 deletions(-)
> 

Pulled, thanks.

Paolo
