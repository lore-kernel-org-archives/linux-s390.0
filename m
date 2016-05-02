From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Mon, 2 May 2016 13:50:53 +0200
Message-ID: <57273F1D.1080900@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <20160502134627.71319e1b.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160502134627.71319e1b.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/02/2016 01:46 PM, Cornelia Huck wrote:
> On Mon,  2 May 2016 12:42:33 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> 
>> @@ -2038,14 +2039,16 @@ out:
>>  		if (block_ns <= vcpu->halt_poll_ns)
>>  			;
>>  		/* we had a long block, shrink polling */
>> -		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
>> +		else if (!vcpu_valid_wakeup(vcpu) ||
>> +			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
>>  			shrink_halt_poll_ns(vcpu);
>>  		/* we had a short halt and our poll time is too small */
>>  		else if (vcpu->halt_poll_ns < halt_poll_ns &&
>> -			block_ns < halt_poll_ns)
>> +			block_ns < halt_poll_ns && vcpu_valid_wakeup(vcpu))
> 
> Isn't that vcpu_valid_wakeup() check superflous, as we have collected
> all !vcpu_valid_wakeup() cases in the previous if?

Yes, will fix in v2.


> 
>>  			grow_halt_poll_ns(vcpu);
>>  	} else
>>  		vcpu->halt_poll_ns = 0;
>> +	vcpu_reset_wakeup(vcpu);
>>
>>  	trace_kvm_vcpu_wakeup(block_ns, waited);
>>  }
> 
