Return-Path: <SRS0=Y1VI=SY=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
References: <cover.1555449329.git.alifm@linux.ibm.com>
 <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
 <20190417110348.28efc8e3.cohuck@redhat.com>
 <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
 <20190417171311.3478402b@oc2783563651>
 <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
 <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 22 Apr 2019 10:01:46 -0400
MIME-Version: 1.0
In-Reply-To: <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8bd8ec0b-8b0c-3e74-1b14-7fad7470679e@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/19/2019 04:12 PM, Halil Pasic wrote:
> On Wed, 17 Apr 2019 11:18:19 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>>
>>
>> On 04/17/2019 11:13 AM, Halil Pasic wrote:
>>>>> Otherwise, looks good to me. Will queue when I get some ack/r-b.
>>>>>
>>>> I like it, but I feel weird giving an r-b to something I suggested:
>>>>
>>>> Acked-by: Eric Farman<farman@linux.ibm.com>
>>>>
>>> I think r-b is fine. You did verify both the design and the
>>> implementation I guess. So I don't see why not.
>>>
>>> How urgent is this. I could give this some love till the end of the
>>> week. Should I @Connie,@Farhan?
>>
>> Having more people review it is always a good thing :)
>>
> 
> Hi Farhan,
> 
> I was starring at this code for about an hour if not more and could not
> figure out the intentions/ideas behind it. That is not a fault of your
> patch, but I can't say that I understand neither the before nor the
> after.
> 
> What understand this patch basically does is make us call
> cio_disable_subchannel() more often. That is what you point out in your
> commit message as well. But I fail to see how does this achieve what the
> summary line promises:  'Prevent quiesce function going into an infinite
> loop'.
> 

The main problem with the previous way, was we were calling 
cio_cancel_halt_clear and then waiting and then calling it again.

So if cio_cancel_halt_clear returned EBUSY we would always be stuck in 
the first loop. Now a problem can occur when cancel subchannel returns 
EINVAL (cc 2) and so we try to do halt subchannel. cio_cancel_halt_clear 
will return EBUSY for a successful halt subchannel as well. And so back 
in the quiesce function we will wait and if the halt succeeds, the 
channel subsystem will clear the halt pending bit in the activity 
control field of SCSW. This means the next time we try 
cio_cancel_halt_clear we will again start by calling cancel subchannel, 
which could again return EINVAL....

We would be stuck in an infinite loop. One way to prevent this is to 
call cio_disable_subchannel right after calling cio_cancel_halt_clear,
if we can successfully disable the subchannel then we are sure the 
device is quiesced.


> Sorry, I can't r-b this. Maybe you can help me gain an understanding of
> this code offline.

I hope the above explanation helps.

> 
> I guess, the approval of the people who actually understand what it is
> going on (i.e. Connie and Eric) will have to suffice.
> 
> Regards,
> Halil
> 
> 
