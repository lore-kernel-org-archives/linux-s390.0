From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 00/11] KVM: s390: features and fixes for 4.9 (via
 kvm/next)
Date: Thu, 8 Sep 2016 15:36:54 +0200
Message-ID: <53f1396a-90f9-ef37-728b-39d5199783f1@redhat.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 08/09/2016 14:00, Christian Borntraeger wrote:
> Paolo, Radim,
> 
> here are the features and fixes for s390 KVM for 4.9.
> It is based on 4.8-rc3 and it contains a merge of 
> topic branch (that is also merged in Martin Schwidefsky
> feature branch) to avoid potential merge conflicts as
> this file touches code outside */kvm/*.
> 
> The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:
> 
>   Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.9-1
> 
> for you to fetch changes up to b0eb91ae630a4f2771790e306bb4df323127a397:
> 
>   Merge remote-tracking branch 'kvms390/s390forkvm' into kvms390next (2016-09-08 13:41:08 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: features and fixes for 4.9
> 
> - lazy enablement of runtime instrumentation
> - up to 255 CPUs for nested guests
> - rework of machine check deliver
> - cleanups/fixes
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       Merge remote-tracking branch 'kvms390/s390forkvm' into kvms390next
> 
> David Hildenbrand (6):
>       KVM: s390: factor out actual delivery of machine checks
>       KVM: s390: split store status and machine check handling
>       KVM: s390: fix delivery of vector regs during machine checks
>       KVM: s390: write external damage code on machine checks
>       KVM: s390: guestdbg: separate defines for per code
>       KVM: s390: allow 255 VCPUs when sca entries aren't used
> 
> Fan Zhang (1):
>       KVM: s390: lazy enable RI
> 
> Heiko Carstens (1):
>       KVM: s390: generate facility mask from readable list
> 
> Janosch Frank (1):
>       KVM: s390: gaccess: simplify translation exception handling
> 
> Markus Elfring (2):
>       KVM: s390: Improve determination of sizes in kvm_s390_import_bp_data()
>       KVM: s390: Use memdup_user() rather than duplicating code
> 
>  arch/s390/include/asm/facilities_src.h | 24 +++++++++
>  arch/s390/include/asm/kvm_host.h       |  2 +-
>  arch/s390/kernel/asm-offsets.c         |  1 +
>  arch/s390/kvm/gaccess.c                | 37 +++++++------
>  arch/s390/kvm/guestdbg.c               | 59 ++++++++++----------
>  arch/s390/kvm/intercept.c              |  1 +
>  arch/s390/kvm/interrupt.c              | 98 ++++++++++++++++++++++++++--------
>  arch/s390/kvm/kvm-s390.c               | 70 +++++++++++-------------
>  arch/s390/kvm/kvm-s390.h               | 14 +++--
>  arch/s390/kvm/priv.c                   | 21 ++++++++
>  10 files changed, 213 insertions(+), 114 deletions(-)
> 

Pulled, thanks.

Paolo
