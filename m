From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390: vfio-ccw: push down unsupported IDA check
Date: Mon, 14 May 2018 15:37:17 +0200
Message-ID: <d0eb5f47-bb71-f615-3780-e753a22daf5b@linux.ibm.com>
References: <20180509173647.61367-1-pasic@linux.ibm.com>
 <20180514135554.29569999.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514135554.29569999.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 05/14/2018 01:55 PM, Cornelia Huck wrote:
> On Wed,  9 May 2018 19:36:47 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> There is at least one relevant control program (CP) that don't set the
> 
> I'd prefer not to talk about 'control program' here, as it is not a
> term commonly used in Linux. Call it 'guest'?
> 
> Also, s/don't/doesn't/
> 
> 

I will use guest instead.

>> IDA flags in the ORB as we would like them, but never uses any IDA. So
>> instead of saying -EOPNOTSUPP when observing an ORB such that a channel
>> program specified by it could be a not supported one, let us say
>> -EOPNOTSUPP only if the channel program is a not supported one.
>>
>> Of course, the real solution would be doing proper translation for all
>> IDA. This is possible, but given the current code not straight forward.
> 
> I agree, this seems useful for now, but we really need to support the
> different ida flags to be fully architecture compliant.
> 

I think this support is deeply buried in Dong Jia's backlog. FWIW
I'm unaware of any (relevant) exploiter (guest) for the old IDA.
Thus testing could also prove challenging, that is require extra
test code. So given the estimated pain/gain ratio I don't see this
coming soon.

With my QEMU changes related to this patch we will also get the full
IDA support as soon as the kernel is there.

>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>
>> QEMU counterpart comming soon.
>> ---
>>   drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index 2c7550797ec2..adfff492dc83 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>> @@ -365,6 +365,9 @@ static void cp_unpin_free(struct channel_program *cp)
>>    * This is the chain length not considering any TICs.
>>    * You need to do a new round for each TIC target.
>>    *
>> + * The program is also validated for absence of not yet supported
>> + * indirect data addressing scenarios.
>> + *
>>    * Returns: the length of the ccw chain or -errno.
>>    */
>>   static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>> @@ -391,6 +394,14 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
>>   	do {
>>   		cnt++;
>>   
>> +		/*
>> +		 * 2k byte block IDAWs (fmt1 or fmt2) are not yet supported.
>> +		 * There are however CPs that don't use IDA at all, and can
>> +		 * benefit from not failing until failure is eminent.
> 
> The second sentence is confusing (What is 'CP' referring to here?
> 'Control program' or struct channel_program?)

Control program. I was under impression that in mainframe context CP
mostly stands for control program.

> 
> What about:
> 
> "As we don't want to fail direct addressing even if the orb specified
> one of the unsupported formats, we defer checking for IDAWs in
> unsupported formats to here."

Was the second sentence only confusing because of CP? I'm not perfectly
satisfied with your version either:
* 'fail direct addressing even if the orb specified one of the unsupported formats'
    I wanted to say: 'hey it does not matter what format for IDA the orb implies
    if the channel program does not use any IDA at all'. That could be paraphrased
    as channel programs using direct addressing exclusively. But failing the direct
    addressing does not fit for me.
* 'defer' is IMHO trivial from the perspective that we used to fence the unsupported
    scenarios earlier (by just looking at the orb). But if one just reads the new code
    defer does not make much sense to me.

But no strong opinions here. If you think your version is the way to go I
will just take it.

> 
>> +		 */
>> +		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
>> +			return -EOPNOTSUPP;
>> +
>>   		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
>>   			break;
>>   
>> @@ -656,10 +667,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>>   	/*
>>   	 * XXX:
>>   	 * Only support prefetch enable mode now.
>> -	 * Only support 64bit addressing idal.
>> -	 * Only support 4k IDAW.
>>   	 */
>> -	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
>> +	if (!orb->cmd.pfch)
>>   		return -EOPNOTSUPP;
>>   
>>   	INIT_LIST_HEAD(&cp->ccwchain_list);
>> @@ -688,6 +697,10 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>>   	ret = ccwchain_loop_tic(chain, cp);
>>   	if (ret)
>>   		cp_unpin_free(cp);
>> +	/* It is safe to force: if not set but idals used
>> +	 * ccwchain_calc_length returns an error.
> 
> s/returns/already returned/ ?
> 

Yes we can do that. I think returns is also grammatical. Present simple
can be used for expressing something that is always true.

>> +	 */
>> +	cp->orb.cmd.c64 = 1;
>>   
>>   	return ret;
>>   }
> 
> The patch looks sane, I have only issues with the description/comments.
> 

Thanks for having a look. Please give me short feedback about the one
open point and I will respin with the requested changes.

Regards,
Halil
