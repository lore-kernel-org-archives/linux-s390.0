Return-Path: <SRS0=rjjQ=ST=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v3 1/1] vfio-ccw: Prevent quiesce function going into an
 infinite loop
References: <cover.1555449329.git.alifm@linux.ibm.com>
 <4d5a4b98ab1b41ac6131b5c36de18b76c5d66898.1555449329.git.alifm@linux.ibm.com>
 <20190417110348.28efc8e3.cohuck@redhat.com>
 <b7daaf7d-72e9-7e59-890c-620a4733b93d@linux.ibm.com>
 <20190417171311.3478402b@oc2783563651>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 17 Apr 2019 11:18:19 -0400
MIME-Version: 1.0
In-Reply-To: <20190417171311.3478402b@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f457d63a-69b9-43da-c425-5c34fb0d9dd4@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 04/17/2019 11:13 AM, Halil Pasic wrote:
>>> Otherwise, looks good to me. Will queue when I get some ack/r-b.
>>>
>> I like it, but I feel weird giving an r-b to something I suggested:
>>
>> Acked-by: Eric Farman<farman@linux.ibm.com>
>>
> I think r-b is fine. You did verify both the design and the
> implementation I guess. So I don't see why not.
> 
> How urgent is this. I could give this some love till the end of the
> week. Should I @Connie,@Farhan?

Having more people review it is always a good thing :)

This patch (and other patches in the original series) are queued for 
5.2, and 5.1 is not released yet. I would say we have some time.

> 
> I was mostly ignoring these patches so I can't capitalize on my
> understanding from reviewing the previous versions and need some time to
> say something about it.
> 
> Regards,
> Halil
> 
