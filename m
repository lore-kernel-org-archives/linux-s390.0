From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes and improvements for 4.16
Date: Wed, 14 Feb 2018 17:19:12 +0100
Message-ID: <b23c7ff2-0458-2505-1076-a37580527f19@redhat.com>
References: <20180214155636.60405-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180214155636.60405-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 14/02/2018 16:56, Christian Borntraeger wrote:
> Paolo, Radim,
> 
> some fixes and improvements for 4.16. (via kvm/master).
> Either for features new in 4.16 or to improve the speculative
> execution handling.

Pulled, thanks.  Should make it into rc2.

Paolo

> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.16-1
> 
> for you to fetch changes up to baabee67f4135e3de87bc874929ac50637aacb0d:
> 
>   KVM: s390: use switch vs jump table in interrupt.c (2018-02-14 13:53:43 +0000)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes and improvements for 4.16
> 
> - optimization for the exitless interrupt support that was merged
>   in 4.16-rc1
> - improve the branch prediction blocking for nested KVM
> - replace some jump tables with switch statements to improve
>   expoline performance
> 
> ----------------------------------------------------------------
> Christian Borntraeger (5):
>       KVM: s390: optimize wakeup for exitless interrupts
>       KVM: s390: do not set intervention requests for GISA interrupts
>       KVM: s390: force bp isolation for VSIE
>       KVM: s390: use switch vs jump table in priv.c
>       KVM: s390: use switch vs jump table in intercept.c
> 
> David Hildenbrand (1):
>       KVM: s390: use switch vs jump table in interrupt.c
> 
>  arch/s390/kvm/intercept.c |  51 +++++++------
>  arch/s390/kvm/interrupt.c |  98 +++++++++++++++----------
>  arch/s390/kvm/kvm-s390.h  |   2 -
>  arch/s390/kvm/priv.c      | 183 +++++++++++++++++++++++-----------------------
>  arch/s390/kvm/vsie.c      |  20 +++++
>  5 files changed, 200 insertions(+), 154 deletions(-)
> 
