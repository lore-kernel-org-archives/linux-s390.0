From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes and features for 4.16
Date: Tue, 16 Jan 2018 16:14:03 +0100
Message-ID: <69c45e6a-9ad6-ecb5-c7e2-1660ef35ffff@de.ibm.com>
References: <20180116150314.201352-1-borntraeger@de.ibm.com>
 <a35355a6-26f9-ab7d-d9cd-80edd9181866@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <a35355a6-26f9-ab7d-d9cd-80edd9181866@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/16/2018 04:09 PM, Paolo Bonzini wrote:
> On 16/01/2018 16:03, Christian Borntraeger wrote:
>> Paolo, Radim,
>>
>> the first chunk (of already reviewed) patches for 4.16 via kvm/next.
>>
>>
>> The following changes since commit ccff53fd86ee54022e3d841f3db9280b1deb22e4:
>>
>>   KVM: x86: avoid unnecessary XSETBV on guest entry (2017-12-18 13:10:25 +0100)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.16-1
>>
>> for you to fetch changes up to 715e0427049606f499ea6b485c997f93f0778c77:
>>
>>   KVM: s390: cleanup struct kvm_s390_float_interrupt (2018-01-16 15:53:09 +0100)
>>
>> ----------------------------------------------------------------
>> KVM: s390: Fixes and features for 4.16
>>
>> - add the virtio-ccw transport for kvmconfig
>> - more debug tracing for cpu model
>> - cleanups and fixes
>>
>> ----------------------------------------------------------------
>> Christian Borntraeger (3):
>>       KVM: s390: use created_vcpus in more places
>>       KVM: s390: add debug tracing for cpu features of CPU model
>>       kvm_config: add CONFIG_S390_GUEST
>>
>> David Hildenbrand (2):
>>       s390x/mm: cleanup gmap_pte_op_walk()
>>       KVM: s390: cleanup struct kvm_s390_float_interrupt
>>
>> Michael Mueller (1):
>>       KVM: s390: drop use of spin lock in __floating_irq_kick
>>
>>  arch/s390/include/asm/kvm_host.h |  3 ---
>>  arch/s390/kvm/interrupt.c        | 27 +++++++++++----------------
>>  arch/s390/kvm/kvm-s390.c         | 29 +++++++++++++++++++----------
>>  arch/s390/kvm/kvm-s390.h         |  2 +-
>>  arch/s390/kvm/sigp.c             | 12 ++++--------
>>  arch/s390/mm/gmap.c              | 23 ++++++++---------------
>>  kernel/configs/kvm_guest.config  |  1 +
>>  7 files changed, 44 insertions(+), 53 deletions(-)
>>
> 
> We probably will have to rebase kvm/next, sorry, to remove a series that
> had problems and (worse) complaints from the arch/x86 maintainers. :(
> Can you rebase on top of 5cb0944c0c66004c0d9006a7f0fba5782ae38

Can you (when doing that) rebase on something newer? rc3 is broken in many ways
and only works on some of my test systems (those without multipath).

I will rebase on 4.15-rc3 to give you all the freedom you need. 
