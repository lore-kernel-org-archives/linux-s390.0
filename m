From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 15:32:38 +0100
Message-ID: <7624195c-6933-ec70-11c5-328b247f21b8@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-7-borntraeger@de.ibm.com>
 <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2018 03:20 PM, David Hildenbrand wrote:

>> +void kvm_s390_gisa_init(struct kvm *kvm)
>> +{
>> +	if (1 || !css_general_characteristics.aiv)
>> +		kvm->arch.gisa = NULL;
> 
> 1 || ... ? This will always trigger. -> gisa never active with this patch

See patch 10. 
