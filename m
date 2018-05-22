From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Date: Tue, 22 May 2018 17:10:44 +0200
Message-ID: <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180522145208.310143ea.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On 22/05/2018 14:52, Cornelia Huck wrote:
> On Wed, 16 May 2018 15:32:48 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>> On Fri, 11 May 2018 11:33:35 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>   
>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>>>>>     
>>>>>     	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>>>>>     
>>>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>>>>> +	/*
>>>>> +	 * Start processing with the clear function, then halt, then start.
>>>>> +	 * We may still be start pending when the caller wants to clean
>>>>> +	 * up things via halt/clear.
>>>>> +	 */
>>>> hum. The scsw here does not reflect the hardware state but the
>>>> command passed from the user interface.
>>>> Can we and should we authorize multiple commands in one call?
>>>>
>>>> If not, the comment is not appropriate and a switch on cmd.fctl
>>>> would be a clearer.
>>> There may be multiple functions specified, but we need to process them
>>> in precedence order (and clear wins over the others, so to speak).
>>> Would adding a sentence like "we always process just one function" help?
>> Why should we allow multiple commands in a single call ?
>> It brings no added value.
>> Is there a use case?
>> Currently QEMU does not do this and since we only have the SCSH there
>> is no difference having the bit set alone or not alone.
> I found this to be a very easy way to implement halt/clear. This still
> holds true if we switch to some kind of capabilities for this (did not
> have time to look at this further, though).
>
> As we have the fctl field anyway, I'm in favour of processing this all
> in one function.
>

Sorry, I do not understand if we agree or not.

I agree we have the fctl field and we must continue to use it
for backward compatibility.

I do not understand the "processing all in one function".

Since yo already have 3 function to process these three instructions.

Do you mean the if .. else if .. else if ?

Then I come back to what you said earlier on the precedence of the clear 
instruction:

1) do we have a use case to have more than one bit set in the fctl field?

- if no, there is no need for precedence

- if yes, why should clear have precedence ?
   How do QEMU set more than one bit in fctl?
   why should we alter the order of the instructions given by the guest?
   How can we know this order if there are multiple instructions at once?


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
