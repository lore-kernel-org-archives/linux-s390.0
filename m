From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 18 Oct 2018 07:48:38 +0000
Subject: Re: [PATCH 2/5] vfio: ccw: Register mediated device once all structures are initialized
Message-Id: <691e1552-0001-06d4-48c8-144f492d990e@linux.ibm.com>
In-Reply-To: <d2e9ad39-730c-47bf-9a34-cb0b7c94557f@linux.ibm.com>
References: <d2e9ad39-730c-47bf-9a34-cb0b7c94557f@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17/10/2018 22:03, Eric Farman wrote:
> 
> 
> On 10/17/2018 05:18 AM, Pierre Morel wrote:
>> There is a risk that the mediated device is used before all the
>> data are initialized if it is register too early.
> 
> s/register/registered/

yes

> 
>>
>> Let's register the mediated device when all the data structures
>> which could be used are initialized.
> 
> I need to look at the later patches more, because I think that helps 
> this situation too.� But fixing up this ordering seems good to me.
> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Thanks for the review Eric

Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
