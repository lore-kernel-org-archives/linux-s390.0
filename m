From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: add proper locking for CMMA migration bitmap
Date: Fri, 22 Dec 2017 14:38:02 +0100
Message-ID: <8a3e9dae-42da-5750-0575-b4b04d3c90a2@de.ibm.com>
References: <20171222112145.80485-1-borntraeger@de.ibm.com>
 <20171222143536.0aee4d5b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171222143536.0aee4d5b.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 12/22/2017 02:35 PM, Cornelia Huck wrote:
> On Fri, 22 Dec 2017 12:21:45 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Some parts of the cmma migration bitmap is already protected
>> with the kvm->lock (e.g. the migration start). On the other
>> hand the read of the cmma bits is not protected against a
>> concurrent free, neither is the emulation of the ESSA instruction.
>> Let's extend the locking to all related ioctls by using
>> the slots lock and wait for the freeing until all unlocked
>> users have finished (those hold kvm->srcu for read).
>>
>> Reported-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: stable@vger.kernel.org # 4.13+
>> Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
>> ---
>>  arch/s390/kvm/kvm-s390.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> I'm way too confused by the locking rules to give this a good review
> before Christmas... do we have a general writeup somewhere?

The hiararchy is documented (Documentation/virtual/locking) but not the purpose
and what is locked by what. the slots_lock basically protects the memory slots
as it is used for memslot changes (normally you would use rcu but the mutex is
the big hammer to prevent concurrent memslot changes).


Lets defer this to after christmas. I will do a pull request for the other
2 patches.
