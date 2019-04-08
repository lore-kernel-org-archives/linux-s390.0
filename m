Return-Path: <SRS0=nFot=SK=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 1/6] vfio-ccw: make it safe to access channel programs
References: <20190301093902.27799-1-cohuck@redhat.com>
 <20190301093902.27799-2-cohuck@redhat.com>
 <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
 <20190408190747.12e3618b.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 8 Apr 2019 13:19:23 -0400
MIME-Version: 1.0
In-Reply-To: <20190408190747.12e3618b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b0ff9cf2-f311-2056-a8b1-415c61a419fc@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/08/2019 01:07 PM, Cornelia Huck wrote:
> On Mon, 8 Apr 2019 13:02:12 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 03/01/2019 04:38 AM, Cornelia Huck wrote:
>>> When we get a solicited interrupt, the start function may have
>>> been cleared by a csch, but we still have a channel program
>>> structure allocated. Make it safe to call the cp accessors in
>>> any case, so we can call them unconditionally.
>>>
>>> While at it, also make sure that functions called from other parts
>>> of the code return gracefully if the channel program structure
>>> has not been initialized (even though that is a bug in the caller).
>>>
>>> Reviewed-by: Eric Farman<farman@linux.ibm.com>
>>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>>> ---
>>
>> Hi Connie,
>>
>> My series of fixes for vfio-ccw depends on this patch as I would like to
>> call cp_free unconditionally :) (I had developed my code on top of your
>> patches).
>>
>> Could we pick this patch up as well when/if you pick up my patch series?
>> I am in the process of sending out a v2.
>>
>> Regarding this patch we could merge it as a stand alone patch, separate
>> from this series. And also the patch LGTM
>>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> 
> Actually, I wanted to ask how people felt about merging this whole
> series for the next release :) It would be one thing less on my plate...
> 
> 

I have been testing with your patches for a while now and I haven't hit 
any problems due to the patches.

IMHO I think we can merge the patches for the next release.

Thanks
Farhan
