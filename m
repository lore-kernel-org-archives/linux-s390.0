Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC v2 2/3] vfio-ccw: Prevent quiesce function going into an
 infinite loop
References: <cover.1554756534.git.alifm@linux.ibm.com>
 <2c17cf29fbce8fc1cfbf60cfd04559d00c8eeac0.1554756534.git.alifm@linux.ibm.com>
 <20190411182434.07d5f685.cohuck@redhat.com>
 <ffcffd06-5bbd-a97c-021e-855b2240982d@linux.ibm.com>
 <20190412101013.2bf4a5df.cohuck@redhat.com>
 <396cde69-5c1d-b9e5-aaa2-248cf91e6f60@linux.ibm.com>
 <20190415101332.7ebbe5ad.cohuck@redhat.com>
 <00c54029-9f60-4242-8a3a-a87bf1e0434b@linux.ibm.com>
 <20190415161841.75aa61f4.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 15 Apr 2019 10:24:53 -0400
MIME-Version: 1.0
In-Reply-To: <20190415161841.75aa61f4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7f1f3844-9108-fea8-a723-1d1d5c0047cd@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, farman@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/15/2019 10:18 AM, Cornelia Huck wrote:
> On Mon, 15 Apr 2019 09:38:37 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 04/15/2019 04:13 AM, Cornelia Huck wrote:
>>> On Fri, 12 Apr 2019 10:38:50 -0400
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>    
>>>> On 04/12/2019 04:10 AM, Cornelia Huck wrote:
>>>>> On Thu, 11 Apr 2019 16:30:44 -0400
>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>>       
>>>>>> On 04/11/2019 12:24 PM, Cornelia Huck wrote:
>>>>>>> On Mon,  8 Apr 2019 17:05:32 -0400
>>>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>    
>>>>>>> Looking at the possible return codes:
>>>>>>> * -ENODEV -> device is not operational anyway, in theory you should even
>>>>>>>        not need to bother with disabling the subchannel
>>>>>>> * -EIO -> we've run out of retries, and the subchannel still is not
>>>>>>>       idle; I'm not sure if we could do anything here, as disable is
>>>>>>>       unlikely to work, either
>>>
>>> (...)
>>>    
>>>> Thinking a little bit more about EIO, if the return code is EIO then it
>>>> means we have exhausted all our options with cancel_halt_clear and the
>>>> subchannel/device is still status pending, right?
>>>
>>> Yes.
>>>    
>>>>
>>>> I think we should still continue to try and disable the subchannel,
>>>> because if not then the subchannel/device could in some point of time
>>>> come back and bite us. So we really should protect the system from this
>>>> behavior.
>>>
>>> I think trying to disable the subchannel does not really hurt, but I
>>> fear it won't succeed in that case...
>>>    
>>>>
>>>> I think for EIO we should log an error message, but still try to
>>>> continue with disabling the subchannel. What do you or others think?
>>>
>>> Logging an error may be useful (it's really fouled up at that time), but...
>>>    
>>>>
>>>>
>>>>
>>>>   
>>>>>>      
>>>>>>>> +		flush_workqueue(vfio_ccw_work_q);
>>>>>>>> +		spin_lock_irq(sch->lock);
>>>>>>>>      		ret = cio_disable_subchannel(sch);
>>>
>>> ...there's a good chance that we'd get -EBUSY here, which would keep us
>>> in the loop. We probably need to break out after we got -EIO from
>>> cancel_halt_clear, regardless of which return code we get from the
>>> disable.
>>
>> Okay, for EIO we can log an error message and break out of the loop.
>>
>> I will send a v3. Are you going to queue patch 1 or patch 3 soon? If you
>> are then I will just send this patch separately.
> 
> Yes, please do send it separately. I'm currently testing patch 1 and 3
> on top of my patchset, will queue either with or without the halt/clear
> patches proper, depending on how soon I get acks/r-bs (hint, hint :)

I am going through your patches 4 and 6 and hopefully will get back to 
you by the end of the day :).

> 
>>
>> Thanks
>> Farhan
>>
>>>
>>> (It will be "interesting" to see what happens with such a stuck
>>> subchannel in the calling code; but I don't really see many options.
>>> Panic seems way too strong; maybe mark the subchannel as "broken; no
>>> idea how to fix"? But that would be a follow-on patch; I think if we
>>> avoid the endless loop here, this patch is a real improvement and
>>> should just go in.)
>>>    
>>>>>>>>      	} while (ret == -EBUSY);
>>>>>>>>      out_unlock:
>>>>>>>
>>>>>>>          
>>>>>>      
>>>>>
>>>>>       
>>>>   
>>>
>>>    
>>
> 
> 
