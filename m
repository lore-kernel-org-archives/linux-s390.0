From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/9] KVM: s390: fixes and features for 4.13 (via
 kvm/next)
Date: Wed, 28 Jun 2017 22:39:58 +0200
Message-ID: <0572000e-6315-32d4-d3ac-31fcd3b1ae2a@redhat.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 28/06/2017 19:30, Christian Borntraeger wrote:
> Paolo, Radim,
> 
> the first chunk of 4.13 related changes for s390.
> 
> There are two conflicts
> 1. wit the kvm-arm tree due to 2387149eade2 ("KVM: improve arch vcpu
> request defining") which will be resolved in the kvm tree, I assume
> 2. with the s390 tree due to the s390-wide cleanup  a75259825401
> ("s390: rename struct psw_bits members"). This is trivial. I guess
> this must be resolved by Linus.
> 
> It also contains a merge of a topic branch for machine check handling.
> This branch is also merged in the s390 tree.
> 
> The following changes since commit 865279c53ca9d88718d974bb014b2c6ce259ac75:
> 
>   tools/kvm_stat: display guest list in pid/guest selection screens (2017-06-08 18:24:49 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.13-1
> 
> for you to fetch changes up to d52cd2076eb2ace9fe95dbf795f6d93587453914:
> 
>   KVM: s390: Inject machine check into the nested guest (2017-06-28 12:42:33 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: fixes and features for 4.13
> 
> - initial machine check forwarding
> - migration support for the CMMA page hinting information
> - cleanups
> - fixes
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>       KVM: s390: implement instruction execution protection for emulated     ifetch
>       Merge tag 'nmiforkvm' of git://git.kernel.org/.../kvms390/linux into kernelorgnext
> 
> Claudio Imbrenda (2):
>       KVM: s390: CMMA tracking, ESSA emulation, migration mode
>       KVM: s390: ioctls to get and set guest storage attributes
> 
> Martin Schwidefsky (1):
>       KVM: s390: avoid packed attribute
> 
> QingFeng Hao (4):
>       s390/nmi: s390: New low level handling for machine check happening in guest
>       KVM: s390: Backup the guest's machine check info
>       KVM: s390: Inject machine check into the guest
>       KVM: s390: Inject machine check into the nested guest
> 
> Yi Min Zhao (1):
>       KVM: S390: add new group for flic
> 
>  Documentation/virtual/kvm/api.txt               | 135 +++++++++
>  Documentation/virtual/kvm/devices/s390_flic.txt |  15 +
>  Documentation/virtual/kvm/devices/vm.txt        |  33 +++
>  arch/s390/include/asm/ctl_reg.h                 |   4 +-
>  arch/s390/include/asm/kvm_host.h                |  44 ++-
>  arch/s390/include/asm/nmi.h                     |  13 +
>  arch/s390/include/asm/processor.h               |   2 +
>  arch/s390/include/uapi/asm/kvm.h                |  12 +
>  arch/s390/kernel/asm-offsets.c                  |   3 +
>  arch/s390/kernel/entry.S                        |  13 +-
>  arch/s390/kernel/nmi.c                          |  84 +++++-
>  arch/s390/kvm/gaccess.c                         |  43 ++-
>  arch/s390/kvm/interrupt.c                       |  91 +++++-
>  arch/s390/kvm/kvm-s390.c                        | 372 +++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h                        |   2 +
>  arch/s390/kvm/priv.c                            | 103 ++++++-
>  arch/s390/kvm/vsie.c                            |  25 +-
>  include/uapi/linux/kvm.h                        |  33 +++
>  18 files changed, 981 insertions(+), 46 deletions(-)
> 

Pulled, thanks (and thanks David for the reviews!).

Paolo
