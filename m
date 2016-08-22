From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 3/4] KVM-S390: Less function calls in
 kvm_s390_import_bp_data() after error detection
Date: Mon, 22 Aug 2016 23:17:26 +0200
Message-ID: <5da7978a-922b-8ccc-fce4-2bffffca888f@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
 <20160822150048.309a3e10.cornelia.huck@de.ibm.com>
 <cff92477-f426-a4c7-fffb-f8bbc378afe7@users.sourceforge.net>
 <20160822213736.62f1ae29.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822213736.62f1ae29.cornelia.huck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

>>>> @@ -273,10 +273,12 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>>>>  	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
>>>>  	vcpu->arch.guestdbg.hw_wp_info = wp_info;
>>>>  	return 0;
>>>> -error:
>>>> -	kfree(bp_data);
>>>> -	kfree(wp_info);
>>>> +free_bp_info:
>>>>  	kfree(bp_info);
>>>> +free_wp_info:
>>>> +	kfree(wp_info);
>>>> +free_bp_data:
>>>> +	kfree(bp_data);
>>>>  	return ret;
>>>>  }
>>>>
>>>
>>> This replaces a perfectly fine fallthrough
>>
>> The usage of a single goto label like "error" seems to be convenient.
>> But how do these habits fit to the current Linux coding style convention?
>>
>>
>>> with some horrible labels.
>>
>> Do they explain better which processing steps should be performed
>> for an efficient exception handling in this function implementation?
> 
> *sigh*
> 
> It's _exception handling_. It does not need to be "efficient",

I imagine that run time situations could evolve where software efficiency
will also matter for this purpose.


> it needs to be easily parsable by humans.

I guess that we have got different preferences for this detail.


> If in doubt, the compiler will be _much_ better at optimizing
> that kind of stuff anyway.

Which compiler (or optimizer) implementation is capable to restructure
the jump targets for you automatically in the way I propose here?

Regards,
Markus
