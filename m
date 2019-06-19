Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfFSUxk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jun 2019 16:53:40 -0400
Subject: Re: [RFC PATCH v1 1/5] vfio-ccw: Move guest_cp storage into common
 struct
References: <20190618202352.39702-1-farman@linux.ibm.com>
 <20190618202352.39702-2-farman@linux.ibm.com>
 <0e55d558-08ee-996e-f9c2-f51e8695064a@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <50cf003b-017d-f475-238d-83aef2df7200@linux.ibm.com>
Date: Wed, 19 Jun 2019 16:53:33 -0400
MIME-Version: 1.0
In-Reply-To: <0e55d558-08ee-996e-f9c2-f51e8695064a@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 6/19/19 4:13 PM, Farhan Ali wrote:
> 
> 
> On 06/18/2019 04:23 PM, Eric Farman wrote:
>> Rather than allocating/freeing a piece of memory every time
>> we try to figure out how long a CCW chain is, let's use a piece
>> of memory allocated for each device.
>>
>> The io_mutex added with commit 4f76617378ee9 ("vfio-ccw: protect
>> the I/O region") is held for the duration of the VFIO_CCW_EVENT_IO_REQ
>> event that accesses/uses this space, so there should be no race
>> concerns with another CPU attempting an (unexpected) SSCH for the
>> same device.
>>
>> Suggested-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>> Conny, your suggestion [1] did not go unnoticed.  :)
>>
>> [1] https://patchwork.kernel.org/comment/22312659/
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c  | 23 ++++-------------------
>>   drivers/s390/cio/vfio_ccw_cp.h  |  7 +++++++
>>   drivers/s390/cio/vfio_ccw_drv.c |  7 +++++++
>>   3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c
>> b/drivers/s390/cio/vfio_ccw_cp.c
>> index 90d86e1354c1..f358502376be 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -16,12 +16,6 @@
>>     #include "vfio_ccw_cp.h"
>>   -/*
>> - * Max length for ccw chain.
>> - * XXX: Limit to 256, need to check more?
>> - */
>> -#define CCWCHAIN_LEN_MAX    256
>> -
>>   struct pfn_array {
>>       /* Starting guest physical I/O address. */
>>       unsigned long        pa_iova;
>> @@ -386,7 +380,7 @@ static void ccwchain_cda_free(struct ccwchain
>> *chain, int idx)
>>    */
>>   static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>>   {
>> -    struct ccw1 *ccw, *p;
>> +    struct ccw1 *ccw = cp->guest_cp;
>>       int cnt;
>>         /*
>> @@ -394,15 +388,9 @@ static int ccwchain_calc_length(u64 iova, struct
>> channel_program *cp)
>>        * Currently the chain length is limited to CCWCHAIN_LEN_MAX (256).
>>        * So copying 2K is enough (safe).
>>        */
>> -    p = ccw = kcalloc(CCWCHAIN_LEN_MAX, sizeof(*ccw), GFP_KERNEL);
>> -    if (!ccw)
>> -        return -ENOMEM;
>> -
>>       cnt = copy_ccw_from_iova(cp, ccw, iova, CCWCHAIN_LEN_MAX);
> 
> Just a minor concern, should we clear out cp->guest_cp memory before we
> do the copying? Given that the ccwchain_calc_length will also call be
> called during tic handling, it's possible there might be some garbage
> data in guest_cp, no?

Yeah, they'll be garbage there, but I'm not sure it's a problem.  By the
time we get here again (ccwchain_loop_tic() -> ccwchain_handle_ccw()),
we'll have saved the relevant CCWs for the first segment.  And the
second time through we'll be copying a fresh 2K from the target of the
TIC to cp->guest_cp, overwriting all that stale data with new CCWs (and
new garbage data).

> 
> 
>> -    if (cnt) {
>> -        kfree(ccw);
>> +    if (cnt)
>>           return cnt;
>> -    }
>>         cnt = 0;
>>       do {
>> @@ -413,10 +401,8 @@ static int ccwchain_calc_length(u64 iova, struct
>> channel_program *cp)
>>            * orb specified one of the unsupported formats, we defer
>>            * checking for IDAWs in unsupported formats to here.
>>            */
>> -        if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw)) {
>> -            kfree(p);
>> +        if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
>>               return -EOPNOTSUPP;
>> -        }
>>             /*
>>            * We want to keep counting if the current CCW has the
>> @@ -435,7 +421,6 @@ static int ccwchain_calc_length(u64 iova, struct
>> channel_program *cp)
>>       if (cnt == CCWCHAIN_LEN_MAX + 1)
>>           cnt = -EINVAL;
>>   -    kfree(p);
>>       return cnt;
>>   }
>>   @@ -461,7 +446,7 @@ static int ccwchain_handle_ccw(u32 cda, struct
>> channel_program *cp)
>>       struct ccwchain *chain;
>>       int len, ret;
>>   -    /* Get chain length. */
>> +    /* Copy the chain from cda to cp, and count the CCWs in it */
>>       len = ccwchain_calc_length(cda, cp);
>>       if (len < 0)
>>           return len;
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.h
>> b/drivers/s390/cio/vfio_ccw_cp.h
>> index 3c20cd208da5..7cdc38049033 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.h
>> +++ b/drivers/s390/cio/vfio_ccw_cp.h
>> @@ -16,6 +16,12 @@
>>     #include "orb.h"
>>   +/*
>> + * Max length for ccw chain.
>> + * XXX: Limit to 256, need to check more?
>> + */
>> +#define CCWCHAIN_LEN_MAX    256
>> +
>>   /**
>>    * struct channel_program - manage information for channel program
>>    * @ccwchain_list: list head of ccwchains
>> @@ -32,6 +38,7 @@ struct channel_program {
>>       union orb orb;
>>       struct device *mdev;
>>       bool initialized;
>> +    struct ccw1 *guest_cp;
>>   };
>>     extern int cp_init(struct channel_program *cp, struct device *mdev,
>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c
>> b/drivers/s390/cio/vfio_ccw_drv.c
>> index 66a66ac1f3d1..34a9a5e3fd36 100644
>> --- a/drivers/s390/cio/vfio_ccw_drv.c
>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
>> @@ -129,6 +129,11 @@ static int vfio_ccw_sch_probe(struct subchannel
>> *sch)
>>       if (!private)
>>           return -ENOMEM;
>>   +    private->cp.guest_cp = kcalloc(CCWCHAIN_LEN_MAX, sizeof(struct
>> ccw1),
>> +                       GFP_KERNEL);
>> +    if (!private->cp.guest_cp)
>> +        goto out_free;
>> +
>>       private->io_region = kmem_cache_zalloc(vfio_ccw_io_region,
>>                              GFP_KERNEL | GFP_DMA);
>>       if (!private->io_region)
>> @@ -169,6 +174,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>>           kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>>       if (private->io_region)
>>           kmem_cache_free(vfio_ccw_io_region, private->io_region);
>> +    kfree(private->cp.guest_cp);
>>       kfree(private);
>>       return ret;
>>   }
>> @@ -185,6 +191,7 @@ static int vfio_ccw_sch_remove(struct subchannel
>> *sch)
>>         kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>>       kmem_cache_free(vfio_ccw_io_region, private->io_region);
>> +    kfree(private->cp.guest_cp);
>>       kfree(private);
>>         return 0;
>>
