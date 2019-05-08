Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
References: <20190503134912.39756-1-farman@linux.ibm.com>
 <20190503134912.39756-8-farman@linux.ibm.com>
 <8625f759-0a2d-09af-c8b5-5b312d854ba1@linux.ibm.com>
 <7c897993-d146-bf8e-48ad-11a914a04716@linux.ibm.com>
 <bba6c0a8-2346-cd99-b8ad-f316daac010b@linux.ibm.com>
 <7ac9fb43-8d7a-9e04-8cba-fa4c63dfc413@linux.ibm.com>
 <1f2e4272-8570-f93f-9d67-a43dcb00fc55@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 8 May 2019 11:22:07 +0200
MIME-Version: 1.0
In-Reply-To: <1f2e4272-8570-f93f-9d67-a43dcb00fc55@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <5c2b74a9-e1d9-cd63-1284-6544fa4376d9@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/05/2019 18:43, Eric Farman wrote:
> 
> 
> On 5/7/19 4:52 AM, Pierre Morel wrote:
>> On 06/05/2019 22:47, Eric Farman wrote:
>>>
>>>
>>> On 5/6/19 11:39 AM, Eric Farman wrote:
>>>>
>>>>
>>>> On 5/6/19 8:56 AM, Pierre Morel wrote:
>>>>> On 03/05/2019 15:49, Eric Farman wrote:
>>>>>> If the CCW being processed is a No-Operation, then by definition no
>>>>>> data is being transferred.  Let's fold those checks into the normal
>>>>>> CCW processors, rather than skipping out early.
>>>>>>
>>>>>> Likewise, if the CCW being processed is a "test" (an invented
>>>>>> definition to simply mean it ends in a zero), let's permit that to go
>>>>>> through to the hardware.  There's nothing inherently unique about
>>>>>> those command codes versus one that ends in an eight [1], or any 
>>>>>> other
>>>>>> otherwise valid command codes that are undefined for the device type
>>>>>> in question.
>>>>>>
>>>>>> [1] POPS states that a x08 is a TIC CCW, and that having any 
>>>>>> high-order
>>>>>> bits enabled is invalid for format-1 CCWs.  For format-0 CCWs, the
>>>>>> high-order bits are ignored.
>>>>>>
>>>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>>>> ---
>>>>>>   drivers/s390/cio/vfio_ccw_cp.c | 11 +++++------
>>>>>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c 
>>>>>> b/drivers/s390/cio/vfio_ccw_cp.c
>>>>>> index 36d76b821209..c0a52025bf06 100644
>>>>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>>>>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>>>>>> @@ -289,8 +289,6 @@ static long copy_ccw_from_iova(struct 
>>>>>> channel_program *cp,
>>>>>>   #define ccw_is_read_backward(_ccw) (((_ccw)->cmd_code & 0x0F) == 
>>>>>> 0x0C)
>>>>>>   #define ccw_is_sense(_ccw) (((_ccw)->cmd_code & 0x0F) == 
>>>>>> CCW_CMD_BASIC_SENSE)
>>>>>> -#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
>>>>>> -
>>>>>>   #define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
>>>>>>   #define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
>>>>>> @@ -314,6 +312,10 @@ static inline int 
>>>>>> ccw_does_data_transfer(struct ccw1 *ccw)
>>>>>>       if (ccw->count == 0)
>>>>>>           return 0;
>>>>>> +    /* If the command is a NOP, then no data will be transferred */
>>>>>> +    if (ccw_is_noop(ccw))
>>>>>> +        return 0;
>>>>>> +
>>>>>>       /* If the skip flag is off, then data will be transferred */
>>>>>>       if (!ccw_is_skip(ccw))
>>>>>>           return 1;
>>>>>> @@ -398,7 +400,7 @@ static void ccwchain_cda_free(struct ccwchain 
>>>>>> *chain, int idx)
>>>>>>   {
>>>>>>       struct ccw1 *ccw = chain->ch_ccw + idx;
>>>>>> -    if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
>>>>>> +    if (ccw_is_tic(ccw))
>>>>>
>>>>>
>>>>> AFAIR, we introduced this code to protect against noop and test 
>>>>> with a non zero CDA.
>>>>> This could go away only if there is somewhere the guaranty that 
>>>>> noop have always a null CDA (same for test).
>>>>
>>>> What was generating either the null or "test" command codes?  I can 
>>>> provide plenty of examples for both these command codes and how they 
>>>> look coming out of vfio-ccw now.
>>>
>>> I've sent both x00 and x03 (NOP) CCWs with zero and non-zero CDAs to 
>>> hardware without this patch.  I don't see anything particuarly 
>>> surpising, so I'm not sure what the original code was attempting to 
>>> protect.
>>>
>>> Maybe, since you question this in ccwchain_cda_free(), you're 
>>> referring to commit 408358b50dea ("s390: vfio-ccw: Do not attempt to 
>>> free no-op, test and tic cda."), which fixed up our attempt to clean 
>>> things up that weren't allocated on the transmit side?  With this 
>>> series, that is reverted, but the cda is indeed set to something that 
>>> needs to be free'd (see below).  So maybe I should at least mention 
>>> that commit here.
>>>
>>> Regardless, while the I/Os work/fail as I expect, the cda addresses 
>>> themselves are wrong in much the same way I describe in patch 4.  
>>> Yes, without this patch we don't convert them to an IDAL so certain 
>>> program checks aren't applicable.  But the addresses that we end up 
>>> sending to the hardware are nonsensical, though potentially valid, 
>>> locations.
>>>
>>
>> I am not comfortable with this.
>> with NOOP no data transfer take place and the role of VFIO is to take 
>> care about data transfer.
>> So in my logic better do nothing and send the original CCW to the 
>> hardware.
>>
>>>>
>>>> The noop check is moved up into the "does data transfer" routine, to 
>>>> determine whether the pages should be pinned or not.  Regardless of 
>>>> whether or not the input CDA is null, we'll end up with a CCW 
>>>> pointing to a valid IDAL of invalid addresses.
>>>>
>>>> The "test" command codes always struck me as funky, because x18 and 
>>>> xF8 and everything in between that ends in x8 is architecturally 
>>>> invalid too, but we don't check for them like we do for things that 
>>>> end in x0. And there's a TON of other opcodes that are invalid for 
>>>> today's ECKD devices, or perhaps were valid for older DASD but have 
>>>> since been deprecated, or are only valid for non-DASD device types. 
>>>> We have no logic to permit them, either.  If those CCWs had a 
>>>> non-zero CDA, we either pin it successfully and let the targeted 
>>>> device sort it out or an error occurs and we fail at that point. 
>>>> (QEMU will see a "wirte" region error of -EINVAL because of 
>>>> vfio_pin_pages())
>>
>> The test command is AFAIU even more sensible that the NOOP command and 
>> in my opinion should never be modified since it is highly device 
>> dependent and do not induce data transfer anyway.
>>
>> We even do not know how the CDA field may be used by the device.
> 
> Exactly, which is why I think sending an unpinned, non-translated, guest 
> address to the hardware (which is what happens today) is a Bad Idea.  If 
> the associated command code WERE going to cause the channel to modify 
> any memory, the provided address from the guest would (best case) cause 
> a program check if the address were not available, or some data 
> corruption if it were.
> 
>> May be I am a little dramatic with this.
>> Just to say that I would feel more comfortable if the test command 
>> reach the device unchanged.
>>
> 
> As I say above, I disagree.  I'd rather that the command (test or 
> otherwise) hit the channel (and the device if applicable) with a valid 
> host address in ccw.cda, so that if any data transfer occurs we're not 
> exposed.
> 
> If there's an application that wants to send a test CCW with an invalid 
> CDA (and thus would fail the pin, as I have seen with NOP), then I guess 
> I can add ccw_is_test() to ccw_does_data_transfer(), but since I still 
> don't see the use case for test CCWs I'm not as thrilled about it.
> 
> Do you recall what caused them to be added originally?



AFAIK they have bin added because they are standard CCW commands.


For the NOOP its clearly stated that it does not start a data transfer.
If we pin the CDA, it could then eventually be the cause of errors if 
the address indicated by the CDA is not accessible.

The NOOP is a particular CONTROL operation for which no data is transfered.
Other CONTROL operation may start a data transfer.

The TEST command is used to retrieve the status of the I/O-device 
__path__ and do not go up to the device.
I did not find clearly that it does not start a data transfer but I 
really do not think it does.
May be we should ask people from hardware.
I only found that test I/O (a specific test command) do not initiate an 
operation.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
