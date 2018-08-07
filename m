Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH RFC 0/2] KVM: s390: vsie: support VCPU requests
References: <20180807125131.3606-1-david@redhat.com>
 <65aefa0e-275f-1a30-2237-904aa4c6d63b@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <837b990a-f034-5199-458d-bfbc9efaecbb@redhat.com>
Date: Tue, 7 Aug 2018 19:35:56 +0200
MIME-Version: 1.0
In-Reply-To: <65aefa0e-275f-1a30-2237-904aa4c6d63b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: pmorel@linux.ibm.com, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07.08.2018 19:15, Pierre Morel wrote:
> On 07/08/2018 14:51, David Hildenbrand wrote:
>> While discussing AP changes, we discovered that we will have to force
>> a CPU using the vSIE to regenerate/reload shadow data structures. For now,
>> we have no mechanism for that.
>>
>> E.g. when clearing AP masks later, we could still have a vSIE CPU making
>> use of AP adapters as the masks might not be considered yet in the vSIE
>> data structures. We need a way to block entering the vSIE and regenerate
>> all shadow data structures once done.
>>
>> Looks like we can achieve that by simply simulating an ordinary SIE
>> entry/exit in the VCPU sie control block (while entering the vSIE loop).
>>
>> This way, we can support blocking and also synchronous CPU requests.
>>
>> Only compile tested.
>>
>> David Hildenbrand (2):
>>    KVM: s390: vsie: simulate VCPU SIE entry/exit
>>    KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
>>
>>   arch/s390/include/asm/kvm_host.h |  1 +
>>   arch/s390/kvm/kvm-s390.c         | 16 ++++++++++++++--
>>   arch/s390/kvm/kvm-s390.h         |  1 +
>>   arch/s390/kvm/vsie.c             | 20 ++++++++++++++++++--
>>   4 files changed, 34 insertions(+), 4 deletions(-)
>>
> Thanks David for your patches.
> 
> Following my tests, they work fine for our AP use case.

Perfect, let's wait for some more comments. You can carry them along in
the AP series for now, maybe Christian/Janosch will decide to pick them
up earlier.

If there is some more work to be done due to review comments, I'll jump in.

> 
> Best regards,
> 
> Pierre
> 
> 


-- 

Thanks,

David / dhildenb
