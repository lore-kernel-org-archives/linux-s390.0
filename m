From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/4] KVM: s390: Fixes for kvm/next (3.19) and stable
Date: Fri, 07 Nov 2014 13:07:28 +0100
Message-ID: <545CB600.2050900@redhat.com>
References: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1415360716-9670-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 07/11/2014 12:45, Christian Borntraeger wrote:
> Paolo,
> 
> here are some fixes for KVM on s390 for kvm/next. The first two patches
> have a stable tag and could also go via kvm/master - if you like.
> 
> The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:
> 
>   Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20141107
> 
> for you to fetch changes up to 365dc1633521a32d55d839f56b41bb9a531d957a:
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for kvm/next (3.19) and stable
> 
> 1. We should flush TLBs for load control instruction emulation (stable)
> 2. A workaround for a compiler bug that renders ACCESS_ONCE broken (stable)
> 3. Fix program check handling for load control
> 4. Documentation Fix
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>       KVM: s390: Fix ipte locking
>       KVM: s390: flush CPU on load control
> 
> Dominik Dingel (1):
>       KVM: fix vm device attribute documentation
> 
> Heiko Carstens (1):
>       KVM: s390: fix handling of lctl[g]/stctl[g]
> 
>  Documentation/virtual/kvm/devices/vm.txt | 10 ++---
>  arch/s390/kvm/gaccess.c                  | 20 ++++++---
>  arch/s390/kvm/priv.c                     | 72 +++++++++++++++-----------------
>  3 files changed, 53 insertions(+), 49 deletions(-)
> 

Pulled to kvm/next (at least locally, I have tests running and will push
to kernel.org next Monday).

Paolo
