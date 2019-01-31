Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <20190131105555.4af6d8ea.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 31 Jan 2019 18:50:57 -0500
MIME-Version: 1.0
In-Reply-To: <20190131105555.4af6d8ea.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 1/31/19 4:55 AM, Cornelia Huck wrote:
> On Wed, 30 Jan 2019 12:48:46 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> The current AP bus implementation periodically polls the AP configuration
>> to detect changes. When the AP configuration is dynamically changed via the
>> SE or an SCLP instruction, the changes will not be reflected to sysfs until
>> the next time the AP configuration is polled. The CHSC architecture
>> provides a Store Event Information (SEI)command to make notification of an
> 
> missing blank ---------------------------^

I'll insert it.

> 
>> AP configuration change. This patch introduces a handler to process
>> notification from the CHSC SEI command BY immediately kickING off an AP bus
> 
> s/BY/by/
> 
> s/kickING/kicking/

Will fix both.

> 
>> scan.
> 
> Scan-after-event sounds useful, yeah.

sure

> 
> Two questions:
> - Does the event cover _any_ change to the AP configuration, or can the
>    periodic scan detect changes that are not signaled?

It can detect any change, such as a change to the CRYCB masks.

> - Do we want to generate such an event in QEMU on plugging/unplugging
>    the vfio-ap device?

We've discussed this quite a bit internally and decided not to implement
that at this time. We will address it as a future enhancement.

> 
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/ap.h   | 12 ++++++++++++
>>   drivers/s390/cio/chsc.c      | 12 ++++++++++++
>>   drivers/s390/cio/chsc.h      |  1 +
>>   drivers/s390/crypto/ap_bus.c | 12 ++++++++++++
>>   4 files changed, 37 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
>> index 1a6a7092d942..c778593d509f 100644
>> --- a/arch/s390/include/asm/ap.h
>> +++ b/arch/s390/include/asm/ap.h
>> @@ -360,4 +360,16 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
>>   	return reg1;
>>   }
>>   
>> +/*
>> + * Interface to tell the AP bus code that a configuration
>> + * change has happened. The bus code should at least do
>> + * an ap bus resource rescan.
>> + */
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
> 
> That #error looks like a development debugging leftover.
> 
>> +static void ap_bus_cfg_chg(void){};
>> +#endif
>> +
>>   #endif /* _ASM_S390_AP_H_ */
>> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
>> index a0baee25134c..dccccc337078 100644
>> --- a/drivers/s390/cio/chsc.c
>> +++ b/drivers/s390/cio/chsc.c
>> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>>   			      " failed (rc=%d).\n", ret);
>>   }
>>   
>> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
>> +{
>> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
>> +	if (sei_area->rs != 5)
>> +		return;
> 
> I'm guessing that a reporting source of 5 means ap, right? (The code is
> silent on all those magic rs values :/)

The 5 indicates the accessibility of one or more adjunct processors has
changed. The reason this gets called is because the CC sent with the
instruction indicates the AP configuration has changed, so the reporting
belongs where it is. There is only one RS associated with it.

> 
> If so, should the debug logging be moved after the check?

covered in the response above.

> 
>> +
>> +	ap_bus_cfg_chg();
>> +}
>> +
>>   static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
>>   {
>>   	switch (sei_area->cc) {
>> @@ -612,6 +621,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
>>   	case 2: /* i/o resource accessibility */
>>   		chsc_process_sei_res_acc(sei_area);
>>   		break;
>> +	case 3: /* ap config changed */
>> +		chsc_process_sei_ap_cfg_chg(sei_area);
>> +		break;
>>   	case 7: /* channel-path-availability information */
>>   		chsc_process_sei_chp_avail(sei_area);
>>   		break;
>> diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
>> index 78aba8d94eec..5651066c46e3 100644
>> --- a/drivers/s390/cio/chsc.h
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>   #include <asm/chsc.h>
>>   #include <asm/schid.h>
>>   #include <asm/qdio.h>
>> +#include <asm/ap.h>
> 
> I would probably include this in chsc.c instead.

Already done per Sebastian's comment.

> 
>>   
>>   #define CHSC_SDA_OC_MSS   0x2
>>   
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 48ea0004a56d..94f621783d6b 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <asm/crw.h>
> 
> Why are you adding this #include?

Already removed per Sebastian's comment.

> 
>>   
>>   #include "ap_bus.h"
>>   #include "ap_debug.h"
>> @@ -860,6 +861,17 @@ void ap_bus_force_rescan(void)
>>   EXPORT_SYMBOL(ap_bus_force_rescan);
>>   
>>   /*
>> +* A config change has happened, Force an ap bus rescan.
> 
> s/Force/force/

Will do.

> 
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
>> +
>> +/*
>>    * hex2bitmap() - parse hex mask string and set bitmap.
>>    * Valid strings are "0x012345678" with at least one valid hex number.
>>    * Rest of the bitmap to the right is padded with 0. No spaces allowed
> 
