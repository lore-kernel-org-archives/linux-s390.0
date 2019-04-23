Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
References: <cover.1555449329.git.alifm@linux.ibm.com>
 <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
 <20190417110348.28efc8e3.cohuck@redhat.com>
 <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
 <20190417171311.3478402b@oc2783563651>
 <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
 <20190419221251.5b4aa9c8.pasic@linux.ibm.com>
 <8bd8ec0b-8b0c-3e74-1b14-7fad7470679e@linux.ibm.com>
 <20190423194251.093304c7.pasic@linux.ibm.com>
 <a2618478-4b98-a2c2-5f14-a91b193ebf53@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 23 Apr 2019 16:37:36 -0400
MIME-Version: 1.0
In-Reply-To: <a2618478-4b98-a2c2-5f14-a91b193ebf53@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <55061641-439f-8964-48e1-fa70f5c4b490@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 4/23/19 3:41 PM, Farhan Ali wrote:
> 
> 
> On 04/23/2019 01:42 PM, Halil Pasic wrote:

...snip...

>> TL;DR:
>>
>> I welcome  this batch (with an r-b) but I would like the commit message
>> and the comment changed so that the misleading 'flush all I/O in the
>> workqueue'.
>>
>> I think 'vfio-ccw: fix cio_cancel_halt_clear() usage' would reflect the
>> content of this patch better, because reasoning about the upper limit,
>> and what happens if this upper limit is hit is not what this patch is
>> about. It is about a client code bug that rendered iretry ineffective.
>>
> 
> I politely disagree with the change in subject line. I think the current 
> subject line describe what we are trying to prevent with this patch. But 
> again if anyone else feels otherwise, I will go ahead and change :)

I think the entire patch is fine as-is.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> 
> Thanks
> Farhan
> 
> 
>> Regards,
>> Halil
>>
>>
