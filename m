Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 21 Feb 2019 11:42:25 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1901301912380.2372@schleppi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 30.01.19 19:32, Sebastian Ott wrote:
> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>> +#if IS_ENABLED(CONFIG_ZCRYPT)
>> +void ap_bus_cfg_chg(void);
>> +#else
>> +#error "no CONFIG_ZCRYPT"
>    ^
> I don't think that's the right thing to do here.
>
>
>> +++ b/drivers/s390/cio/chsc.h
>> @@ -9,6 +9,7 @@
>>  #include <asm/chsc.h>
>>  #include <asm/schid.h>
>>  #include <asm/qdio.h>
>> +#include <asm/ap.h>
> This should be moved to chsc.c
>
>
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/ctype.h>
>> +#include <asm/crw.h>
> This is not needed here.
>
>
>>  /*
>> +* A config change has happened, Force an ap bus rescan.
>> +*/
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
> There is no need for the export symbol - you don't call that function
> from module code.
That's what I have learned now: You don't need to export a symbol
as long as the symbol is only called in static code parts of the kernel.
But you need to export it when it is intended to be used by code
which sits in a kernel module. So now the big question:
How does a provider of a function in the kernel know, if the caller is in static
code or in module code ? And ... maybe this may even change over
the time. So my recommendation is to always export the symbol with
the EXPORT_SYMBOL macro. This way you don't need to change the
code providing a function when the caller code changes or additional
code uses the symbol.

Other opinions ?


> As an unrelated question, just to be sure: ap_bus.c is compiled as
> built-in even with ZCRYPT=m, right?
>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
>
> Regards,
> Sebastian
