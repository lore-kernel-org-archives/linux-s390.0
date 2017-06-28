From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Jun 2017 13:45:14 +0000
Subject: Re: [GIT PULL 0/2] s390,kvm: provide plumbing for machines checks when running guests
Message-Id: <337f8bea-25ee-35d5-fb6b-a0ac684429ca@de.ibm.com>
In-Reply-To: <bc040dd4-0f9d-c92e-66bc-27eba404bbc8@redhat.com>
References: <bc040dd4-0f9d-c92e-66bc-27eba404bbc8@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/28/2017 02:48 PM, Paolo Bonzini wrote:
> 
> 
> On 28/06/2017 13:53, Christian Borntraeger wrote:
>> This is probably more a question for Martin or Heiko, but our initial machine
>> check handling seems to be older than the hwpoison infrastructure (older than
>> the 2.6 git history). Historically we have killed processes with SIGSEGV on 
>> fatal errors and never included the BUS_MCEERR things so we still kill processes
>> on errors. From an architectural point of view we can get the failing address, 
>> so maybe we should consider the BUS_MCEERR things for memory errors.
> 
> Also because other architectures use SIGBUS, and QEMU uses SIGBUS too.
> 
>> On the other hand since z196 (2010) the memory is protected with RAIM (in addition
>> to ECC) and I am not aware of any field incidence where HW was not able to recover
>> since the introduction of RAIM the pressure to do that is pretty small.
>>
>> If we decide to do that, this would require additional changes for KVM - we would then
>> need to translate the host address into a guest address or as V1 unset the valid
>> bit for the failing address information.
> 
> That's fine.  Does s390 also do background scrubbing of memory?  That

Yes, the hardware does.
