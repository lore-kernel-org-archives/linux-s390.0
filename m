From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: KVM-S390: Less function calls in kvm_s390_import_bp_data() after
 error detection
Date: Sat, 27 Aug 2016 18:12:33 +0200
Message-ID: <05fa56cb-843e-39bd-847d-1b31b5a726b5@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
 <f9f50675-b283-4c03-8764-c7c570647fe4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9f50675-b283-4c03-8764-c7c570647fe4@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

>> @@ -273,10 +273,12 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>>  	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
>>  	vcpu->arch.guestdbg.hw_wp_info = wp_info;
>>  	return 0;
>> -error:
>> -	kfree(bp_data);
>> -	kfree(wp_info);
>> +free_bp_info:
>>  	kfree(bp_info);
>> +free_wp_info:
>> +	kfree(wp_info);
>> +free_bp_data:
>> +	kfree(bp_data);
>>  	return ret;
>>  }
> 
> I agree with Cornelia,

This is generally fine.


> while it seems correct from a technical point of view,

Thanks for another bit of acknowledgement.


> it will make the code harder to maintain.

I agree that there some efforts and challenges involved.


> For example if we ever add a new malloc and remove another one

Do you see any changes coming from this direction?


> over time we would need to reshuffle the labels

This can occasionally happen, can't it?


> and this did went wrong several times in the past.

Would you like to add any corresponding software development experiences
to discussions around a topic like "CodingStyle: add some more error
handling guidelines"?

https://www.spinics.net/lists/linux-doc/msg39307.html
http://marc.info/?l=linux-doc&m=147187538413914

Regards,
Markus
