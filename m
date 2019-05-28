Return-Path: <SRS0=FZpJ=T4=vger.kernel.org=kvm-owner@kernel.org>
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190523164309.13345-9-thuth@redhat.com>
 <1deb73ac-9589-89cb-9a9b-f9957584733e@de.ibm.com>
 <20190528145344.42fe6bc5.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 May 2019 15:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190528145344.42fe6bc5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dc8ad44b-3019-bdb2-7991-2ab9a0f1b149@de.ibm.com>
Subject: Re:  Re: [PATCH 8/9] KVM: s390: Do not report unusabled IDs via
 KVM_CAP_MAX_VCPU_ID
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 28.05.19 14:53, Cornelia Huck wrote:
> On Tue, 28 May 2019 13:00:30 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Paolo, Radim,
>>
>> would you consider this patch (or the full series) as 5.2 material or 5.3 material?
> 
> FWIW, I'd consider this patch 5.2 material, as we're currently relaying
> wrong values to userspace.

Agreed. I will add cc stable and queue for master. What is our opinion about kselftest?
Are we merging testtools changes also only during the merge window?
> 
>>
>>
>> On 23.05.19 18:43, Thomas Huth wrote:
>>> KVM_CAP_MAX_VCPU_ID is currently always reporting KVM_MAX_VCPU_ID on all
>>> architectures. However, on s390x, the amount of usable CPUs is determined
>>> during runtime - it is depending on the features of the machine the code
>>> is running on. Since we are using the vcpu_id as an index into the SCA
>>> structures that are defined by the hardware (see e.g. the sca_add_vcpu()
>>> function), it is not only the amount of CPUs that is limited by the hard-
>>> ware, but also the range of IDs that we can use.
>>> Thus KVM_CAP_MAX_VCPU_ID must be determined during runtime on s390x, too.
>>> So the handling of KVM_CAP_MAX_VCPU_ID has to be moved from the common
>>> code into the architecture specific code, and on s390x we have to return
>>> the same value here as for KVM_CAP_MAX_VCPUS.
>>> This problem has been discovered with the kvm_create_max_vcpus selftest.
>>> With this change applied, the selftest now passes on s390x, too.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  arch/mips/kvm/mips.c       | 3 +++
>>>  arch/powerpc/kvm/powerpc.c | 3 +++
>>>  arch/s390/kvm/kvm-s390.c   | 1 +
>>>  arch/x86/kvm/x86.c         | 3 +++
>>>  virt/kvm/arm/arm.c         | 3 +++
>>>  virt/kvm/kvm_main.c        | 2 --
>>>  6 files changed, 13 insertions(+), 2 deletions(-)
> 
