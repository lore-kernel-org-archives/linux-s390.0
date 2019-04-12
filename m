Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC v2 3/3] vfio-ccw: Release any channel program when
 releasing/removing vfio-ccw mdev
References: <cover.1554756534.git.alifm@linux.ibm.com>
 <ae9f20dc8873f2027f7b3c5d2aaa0bdfe06850b8.1554756534.git.alifm@linux.ibm.com>
 <20190411182755.1f3a2bd5.cohuck@redhat.com>
 <7123f8b7-0348-4140-1b94-5d35ea1ef567@linux.ibm.com>
 <20190412101236.4f753e6d.cohuck@redhat.com>
 <a2e726c1-95fe-227b-b256-f0a79636c8e7@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 12 Apr 2019 17:03:06 -0400
MIME-Version: 1.0
In-Reply-To: <a2e726c1-95fe-227b-b256-f0a79636c8e7@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ca0d189a-db19-ee36-9ed7-69d204650718@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 4/12/19 10:13 AM, Farhan Ali wrote:
> 
> 
> On 04/12/2019 04:12 AM, Cornelia Huck wrote:
>> On Thu, 11 Apr 2019 16:39:32 -0400
>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>
>>> On 04/11/2019 12:27 PM, Cornelia Huck wrote:
>>>> On Mon,  8 Apr 2019 17:05:33 -0400
>>>> Farhan Ali<alifm@linux.ibm.com>  wrote:
>>>>> When releasing the vfio-ccw mdev, we currently do not release
>>>>> any existing channel program and it's pinned pages. This can
>>>> s/it's/its/
>>>
>>> Will fix.
>>>
>>> Thanks for taking a look at the patches.
>>
>> NP, I really want to queue them soon :)
>>
>> Just give me a quick hint about dependencies: Do I need anything else
>> before I can queue patch 1 and 3? I've lost track a bit...
>>
>>
> 
> Patch 1 can be queued without any problems and it has no dependencies.
> 
> Patch 3 would depend on your [PATCH v4 1/6] vfio-ccw: make it safe to 
> access channel programs. Since I want to call cp_free without any problems.

I'm sorry; I'm working as a LIFO queue this afternoon.  At least I 
reviewed patch 1 of that series.  :)

> 
> I know you are waiting for acks/r-bs for patch 3, so if no one has 
> problems then we can go ahead and queue it.
> 
> 
> Thanks
> Farhan
> 
