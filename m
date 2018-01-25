From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 17:50:23 +0100
Message-ID: <fe7d07ee-1ce2-6293-6b2a-fb2c3659a05f@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-7-borntraeger@de.ibm.com>
 <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
 <b7fb3580-0eae-ee29-cae6-d58bc8a4e350@de.ibm.com>
 <be0022df-be6d-3b03-f5f5-c61e09c08da7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <be0022df-be6d-3b03-f5f5-c61e09c08da7@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/25/2018 05:47 PM, David Hildenbrand wrote:
> On 25.01.2018 17:32, Christian Borntraeger wrote:
>>
>>
>> On 01/25/2018 03:20 PM, David Hildenbrand wrote:
>> [...]
>>>> @@ -918,18 +919,38 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
>>>>  	return rc ? -EFAULT : 0;
>>>>  }
>>>>  
>>>> +static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
>>>> +{
>>>> +	int rc;
>>>> +
>>>> +	rc  = put_guest_lc(vcpu, io->subchannel_id, (u16 *)__LC_SUBCHANNEL_ID);
>>>> +	rc |= put_guest_lc(vcpu, io->subchannel_nr, (u16 *)__LC_SUBCHANNEL_NR);
>>>> +	rc |= put_guest_lc(vcpu, io->io_int_parm, (u32 *)__LC_IO_INT_PARM);
>>>> +	rc |= put_guest_lc(vcpu, io->io_int_word, (u32 *)__LC_IO_INT_WORD);
>>>> +	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
>>>> +			     &vcpu->arch.sie_block->gpsw,
>>>> +			     sizeof(psw_t));
>>>> +	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
>>>> +			    &vcpu->arch.sie_block->gpsw,
>>>> +			    sizeof(psw_t));
>>>
>>> These should now it into less lines.
>>
>> The last two lines are way beyond 80. 
>>
> 
> Huh? At least in my world, I can reduce 3 to 2 lines (for both).

Yes, but if I have to break the line, then I prefer to have one parameter per line. (all or
nothing)
