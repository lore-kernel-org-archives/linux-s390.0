From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 0/6] KVM: s390: Multiple-epoch facility fixes
Date: Wed, 7 Feb 2018 12:50:29 +0100
Message-ID: <8f9aa451-08b8-fb52-e1f8-cdefe543f7a3@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-1-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07.02.2018 12:46, David Hildenbrand wrote:
> It think I found various BUGs in the recently added Multiple-epoch facility
> support in KVM. Along with it, two cleanups.
> 
> 1. The clock-comparator sign control is not considered. I sent a patch
>    with this previously. This now contains fixes and simplifications.
> 2. SET CLOCK from the guest does not work reliably if the facility is
>    enabled (epoch index not set).
> 3. Hotplugged CPUs don't inherit the epoch index.
> 4. TOD clock syncs don't take care of overflows/underflows in the epoch
>    value and miss to update the epoch index.
> 
> 
> This is RFC as I have basically no machine to test. Hopefully somebody
> can jump in and verify that we now handle the epoch index in all
> scenarios correctly.
> 
> Most importantly, with Multiple-epoch facility, the condition
> 	Guest TOD = Host TOD - 1
> Is represented by both, epoch and epoch_idx containing 0xff. So it is
> treated as a 64+8bit signed number - we have to properly take care
> of over/underflows when modifying the epoch.
> 
> 
> David Hildenbrand (6):
>   KVM: s390: take care of clock-comparator sign control
>   KVM: s390: provide only a single function for setting the tod
>   KVM: s390: consider epoch index on hotplugged CPUs
>   KVM: s390: consider epoch index on TOD clock syncs
>   KVM: s390: no need to inititalize kvm->arch members to 0
>   KVM: s390: generalize kvm_s390_get_tod_clock_ext()
> 
>  arch/s390/kvm/interrupt.c |  25 ++++++++---
>  arch/s390/kvm/kvm-s390.c  | 109 +++++++++++++++++++++++-----------------------
>  arch/s390/kvm/kvm-s390.h  |   5 +--
>  arch/s390/kvm/priv.c      |   9 ++--
>  4 files changed, 80 insertions(+), 68 deletions(-)
> 

CC'ing Collin (sorry missed you)

-- 

Thanks,

David / dhildenb
