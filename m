Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbhADQJs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jan 2021 11:09:48 -0500
Subject: Re: [PATCH v1 4/4] s390/kvm: VSIE: correctly handle MVPG when in VSIE
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
 <20201218141811.310267-5-imbrenda@linux.ibm.com>
 <6836573a-a49d-9d9f-49e0-96b5aa479c52@redhat.com>
 <20210104162231.4e56ab47@ibm-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3376268b-7fd7-9fbe-b483-fe7471038a18@redhat.com>
Date: Mon, 4 Jan 2021 17:08:15 +0100
MIME-Version: 1.0
In-Reply-To: <20210104162231.4e56ab47@ibm-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

On 04.01.21 16:22, Claudio Imbrenda wrote:
> On Sun, 20 Dec 2020 11:13:57 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.12.20 15:18, Claudio Imbrenda wrote:
>>> Correctly handle the MVPG instruction when issued by a VSIE guest.
>>>   
>>
>> I remember that MVPG SIE documentation was completely crazy and full
>> of corner cases. :)
> 
> you remember correctly
> 
>> Looking at arch/s390/kvm/intercept.c:handle_mvpg_pei(), I can spot
>> that
>>
>> 1. "This interception can only happen for guests with DAT disabled
>> ..." 2. KVM does not make use of any mvpg state inside the SCB.
>>
>> Can this be observed with Linux guests?
> 
> a Linux guest will typically not run with DAT disabled
> 
>> Can I get some information on what information is stored at [0xc0,
>> 0xd) inside the SCB? I assume it's:
>>
>> 0xc0: guest physical address of source PTE
>> 0xc8: guest physical address of target PTE
> 
> yes (plus 3 flags in the lower bits of each)

Thanks! Do the flags tell us what the deal with the PTE was? If yes,
what's the meaning of the separate flags?

I assume something like "invalid, proteced, ??"

I'm asking because I think we can handle this a little easier.

> 
>> [...]
>>>  /*
>>>   * Run the vsie on a shadow scb and a shadow gmap, without any
>>> further
>>>   * sanity checks, handling SIE faults.
>>> @@ -1063,6 +1132,10 @@ static int do_vsie_run(struct kvm_vcpu
>>> *vcpu, struct vsie_page *vsie_page) if ((scb_s->ipa & 0xf000) !=
>>> 0xf000) scb_s->ipa += 0x1000;
>>>  		break;
>>> +	case ICPT_PARTEXEC:
>>> +		if (scb_s->ipa == 0xb254)  
>>
>> Old code hat "/* MVPG only */" - why is this condition now necessary?
> 
> old code was wrong ;)


arch/s390/kvm/intercept.c:handle_partial_execution() we only seem to handle

1. MVPG
2. SIGP PEI

The latter is only relevant for external calls. IIRC, this is only active
with sigp interpretation - which is never active under vsie (ECA_SIGPI).



-- 
Thanks,

David / dhildenb
