From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/4] KVM: s390 features and fixes for 4.5 (kvm/next)
Date: Wed, 16 Dec 2015 18:49:35 +0100
Message-ID: <5671A42F.4070408@redhat.com>
References: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>



On 15/12/2015 20:23, Christian Borntraeger wrote:
> Paolo,
> 
> here is the 2nd part of the s390 queue for 4.5
> 
> The following changes since commit 460146348518a1c4e810d01baf81847f8c6a1c73:
> 
>   Merge tag 'kvm-s390-next-4.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2015-12-02 13:50:04 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.5-2
> 
> for you to fetch changes up to 32e6b236d26946eb076d1450bfb8f9978f15d6b9:
> 
>   KVM: s390: consider system MHA for guest storage (2015-12-15 17:08:22 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390 features and fixes for 4.5 (kvm/next)
> 
> Some small cleanups
> - use assignment instead of memcpy
> - use %pK for kernel pointers
> 
> Changes regarding guest memory size
> - Fix an off-by-one error in our guest memory interface (we might
> use unnecessarily big page tables, e.g. 3 levels for a 2GB guest
> instead of 2 levels)
> - We now ask the machine about the max. supported guest address
>   and limit accordingly.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>       KVM: s390: use assignment instead of memcpy
>       KVM: s390: obey kptr_restrict in traces
> 
> Dominik Dingel (1):
>       KVM: s390: fix mismatch between user and in-kernel guest limit
> 
> Guenther Hutzl (1):
>       KVM: s390: consider system MHA for guest storage
> 
>  Documentation/virtual/kvm/devices/vm.txt |  3 ++-
>  arch/s390/include/asm/kvm_host.h         |  1 +
>  arch/s390/include/uapi/asm/kvm.h         |  2 ++
>  arch/s390/kvm/kvm-s390.c                 | 44 ++++++++++++++++++++++++--------
>  arch/s390/kvm/trace-s390.h               |  6 ++---
>  arch/s390/mm/pgtable.c                   |  4 +--
>  drivers/s390/char/sclp_early.c           |  8 +++++-
>  7 files changed, 50 insertions(+), 18 deletions(-)
> 

Pulled (but not pushed yet), thanks.

Paolo
