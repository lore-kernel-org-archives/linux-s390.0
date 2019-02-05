Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <20190131105555.4af6d8ea.cohuck@redhat.com>
 <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
 <20190201153522.4f72cf00.cohuck@redhat.com>
 <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 5 Feb 2019 15:30:45 -0500
MIME-Version: 1.0
In-Reply-To: <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <13b5a2b8-3deb-174f-660c-78282bda3f36@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/4/19 5:15 AM, Harald Freudenberger wrote:
> On 01.02.19 15:35, Cornelia Huck wrote:
>> On Thu, 31 Jan 2019 18:50:57 -0500
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> On 1/31/19 4:55 AM, Cornelia Huck wrote:
>>>> On Wed, 30 Jan 2019 12:48:46 -0500
>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>> Two questions:
>>>> - Does the event cover _any_ change to the AP configuration, or can the
>>>>     periodic scan detect changes that are not signaled?
>>> It can detect any change, such as a change to the CRYCB masks.
>> Nice. I suppose we can not rely on those messages being generated,
>> though, and therefore need to keep the periodic scan...
> As you wrote, I am not sure if the ap bus code can rely on this to
> cover all changes. For kvm guests I think it is currently not working
> as there is no such notification generated at all. So I'd like to
> have the periodic scan in place.

I verified that a dynamic change to the CRYCB (via the SE) is not
signaled by CHSC Adjunct Processor changed notification. Apparently only
configuration changes are signaled, so we will definitely need to keep
the scan unless somebody knows otherwise.

Tony K

>>
>>>> - Do we want to generate such an event in QEMU on plugging/unplugging
>>>>     the vfio-ap device?
>>> We've discussed this quite a bit internally and decided not to implement
>>> that at this time. We will address it as a future enhancement.
>> Ok, but I think it would be nice to have.
>>
>>>>> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
>>>>> index a0baee25134c..dccccc337078 100644
>>>>> --- a/drivers/s390/cio/chsc.c
>>>>> +++ b/drivers/s390/cio/chsc.c
>>>>> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>>>>>    			      " failed (rc=%d).\n", ret);
>>>>>    }
>>>>>    
>>>>> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
>>>>> +{
>>>>> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
>>>>> +	if (sei_area->rs != 5)
>>>>> +		return;
>>>> I'm guessing that a reporting source of 5 means ap, right? (The code is
>>>> silent on all those magic rs values :/)
>>> The 5 indicates the accessibility of one or more adjunct processors has
>>> changed. The reason this gets called is because the CC sent with the
>>> instruction indicates the AP configuration has changed, so the reporting
>>> belongs where it is. There is only one RS associated with it.
>> So if we'd ever get there anything but rs == 5, it would be a hardware
>> or hypervisor bug? Then the code makes sense, I guess.
>>
>>>> If so, should the debug logging be moved after the check?
>>> covered in the response above.
>>>
>>>>    
>>>>> +
>>>>> +	ap_bus_cfg_chg();
>>>>> +}
>>>>> +
> 
