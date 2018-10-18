From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 18 Oct 2018 07:42:10 +0000
Subject: Re: [PATCH 1/5] vfio: ccw: Merge BUSY and BOXED states
Message-Id: <55485c0c-7c2d-1e9b-b6d9-e1035fd6f7c5@linux.ibm.com>
In-Reply-To: <e6eb7332-1d0c-09bf-c599-aa4af38845fc@linux.ibm.com>
References: <e6eb7332-1d0c-09bf-c599-aa4af38845fc@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17/10/2018 22:01, Eric Farman wrote:
> 
> 
> On 10/17/2018 05:18 AM, Pierre Morel wrote:
>> VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY have
>> identical actions for the same events.
>>
>> Let's merge both into a single state to simplify the code.
>> We choose to keep VFIO_CCW_STATE_BUSY.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> I like this.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> 
>> --

Thanks,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
