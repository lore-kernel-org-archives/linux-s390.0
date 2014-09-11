From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/7] KVM: s390: Fixes and features for next (3.18)
Date: Thu, 11 Sep 2014 11:09:45 +0200
Message-ID: <541166D9.8050509@redhat.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 10/09/2014 15:53, Christian Borntraeger ha scritto:
> Paolo,
> 
> please have a look at the next bunch of s390 patches and consider to apply:
> 
> The following changes since commit fd2752352bbc98850d83b5448a288d8991590317:
> 
>   KVM: x86: use guest maxphyaddr to check MTRR values (2014-08-29 18:56:24 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20140910
> 
> for you to fetch changes up to bfac1f59a1afb13a3cf225bffd04be99a49c51a6:
> 
>   KVM: s390/interrupt: remove double assignment (2014-09-10 12:19:45 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes and features for next (3.18)
> 
> 1. Crypto/CPACF support: To enable the MSA4 instructions we have to
>    provide a common control structure for each SIE control block
> 2. Two cleanups found by a static code checker: one redundant assignment
>    and one useless if
> 3. Fix the page handling of the diag10 ballooning interface. If the
>    guest freed the pages at absolute 0 some checks and frees were
>    incorrect
> 4. Limit guests to 16TB
> 5. Add __must_check to interrupt injection code
> 
> ----------------------------------------------------------------
> Christian Borntraeger (6):
>       KVM: s390: add __must_check to interrupt deliver functions
>       KVM: s390: Limit guest size to 16TB
>       KVM: s390: unintended fallthrough for external call
>       KVM: s390: get rid of constant condition in ipte_unlock_simple
>       KVM: s390/cmm: Fix prefix handling for diag 10 balloon
>       KVM: s390/interrupt: remove double assignment
> 
> Tony Krowiak (1):
>       KVM: CPACF: Enable MSA4 instructions for kvm guest
> 
>  arch/s390/include/asm/kvm_host.h | 14 +++++++++++++-
>  arch/s390/kvm/diag.c             | 26 ++++++++++++++++++--------
>  arch/s390/kvm/gaccess.c          |  3 +--
>  arch/s390/kvm/interrupt.c        | 14 +++++++-------
>  arch/s390/kvm/kvm-s390.c         | 35 ++++++++++++++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h         |  2 +-
>  6 files changed, 74 insertions(+), 20 deletions(-)
> 

Thanks, applying to kvm/queue.

Paolo
