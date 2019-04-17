Return-Path: <SRS0=rjjQ=ST=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: s390: Fix potential spectre warnings
References: <20190417005414.47801-1-farman@linux.ibm.com>
 <6b8a6436-2ca9-a939-b373-ba1820baa667@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Apr 2019 15:10:38 +0200
MIME-Version: 1.0
In-Reply-To: <6b8a6436-2ca9-a939-b373-ba1820baa667@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f0384b36-0ae6-601d-8748-8510342f0a3b@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 17.04.19 15:09, Paolo Bonzini wrote:
> On 17/04/19 02:54, Eric Farman wrote:
>> Fix some warnings from smatch:
>>
>> arch/s390/kvm/interrupt.c:2310 get_io_adapter() warn: potential spectre issue 'kvm->arch.adapters' [r] (local cap)
>> arch/s390/kvm/interrupt.c:2341 register_io_adapter() warn: potential spectre issue 'dev->kvm->arch.adapters' [w]
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>> A recent patch from Paolo [1] acted as a reminder (thanks, Christian!)
>> that I had one for the s390 KVM code after some code reviews [2].
>> Let's clean that up.
> 
> Spectrev1 is a gift that keeps on giving... I suppose Christian will
> queue this one and I don't have anything to do here.

Yes, will just wait until the review has settled.
