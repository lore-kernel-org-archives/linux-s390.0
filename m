Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 31 Jan 2019 18:28:39 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1901301912380.2372@schleppi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 1/30/19 1:32 PM, Sebastian Ott wrote:
> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
>     ^
> I don't think that's the right thing to do here.

I'd like to leave it. If somebody edits .config
and sets CONFIG_ZCRYPT=n, then the build will
fail. The preprocessor error above tells them
why.

> 
> 
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>   #include <asm/chsc.h>
>>   #include <asm/schid.h>
>>   #include <asm/qdio.h>
>> +#include <asm/ap.h>
> 
> This should be moved to chsc.c

I can do that, but I'm curious why.

> 
> 
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <asm/crw.h>
> 
> This is not needed here.

I'll remove it.

> 
> 
>>   /*
>> +* A config change has happened, Force an ap bus rescan.
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
> 
> There is no need for the export symbol - you don't call that function
> from module code.
> As an unrelated question, just to be sure: ap_bus.c is compiled as
> built-in even with ZCRYPT=m, right?

No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
into the zcrypt.ko module. Through some other magic, the zcrypt module
is loaded when linux boots.

> 
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> 
> Regards,
> Sebastian
> 
