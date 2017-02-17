Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: crypto make ap_bus explicitly non-modular
References: <20170209144810.6347-1-paul.gortmaker@windriver.com>
 <fdc4a694-8752-fd8b-aa4c-504e46a59fbb@linux.vnet.ibm.com>
From: Harald Freudenberger <freude@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 16:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <fdc4a694-8752-fd8b-aa4c-504e46a59fbb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <928e7d58-d316-f3ed-b630-39b944d920e9@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: Harald Freudenberger <freude@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02/13/2017 01:03 PM, Harald Freudenberger wrote:
> On 02/09/2017 03:48 PM, Paul Gortmaker wrote:
>> The Makefile in drivers/s390 has:
>>
>> 	obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
>>
>> ..and the Makefile in crypto/ has:
>>
>> 	ap-objs := ap_bus.o ap_card.o ap_queue.o
>>
>> ...meaning that it currently is not being built as a module by anyone.
>>
>> Lets remove the modular code that is essentially orphaned, so that
>> when reading the driver there is no doubt it is builtin-only.
>>
>> Since module_init translates to device_initcall in the non-modular
>> case, the init ordering remains unchanged with this commit.
>>
>> Also note that MODULE_ALIAS is a no-op for non-module builds.
>>
>> We also delete the MODULE_LICENSE tag etc. since all that information
>> is already contained at the top of the file in the comments.
>>
>> We replace module.h with moduleparam.h since the file does declare
>> some module parameters even though it is not modular itself.
>>
>> Cc: Harald Freudenberger <freude@de.ibm.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  drivers/s390/crypto/ap_bus.c | 54 +++-----------------------------------------
>>  1 file changed, 3 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 5fa699192864..7183a316f9be 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -27,7 +27,7 @@
>>  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>>
>>  #include <linux/kernel_stat.h>
>> -#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>>  #include <linux/init.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>> @@ -54,16 +54,7 @@
>>  #include "ap_debug.h"
>>
>>  /*
>> - * Module description.
>> - */
>> -MODULE_AUTHOR("IBM Corporation");
>> -MODULE_DESCRIPTION("Adjunct Processor Bus driver, " \
>> -		   "Copyright IBM Corp. 2006, 2012");
>> -MODULE_LICENSE("GPL");
>> -MODULE_ALIAS_CRYPTO("z90crypt");
>> -
>> -/*
>> - * Module parameter
>> + * Module parameters; note though this file itself isn't modular.
>>   */
>>  int ap_domain_index = -1;	/* Adjunct Processor Domain Index */
>>  static DEFINE_SPINLOCK(ap_domain_lock);
>> @@ -1270,43 +1261,4 @@ int __init ap_module_init(void)
>>  	kfree(ap_configuration);
>>  	return rc;
>>  }
>> -
>> -/**
>> - * ap_modules_exit(): The module termination code
>> - *
>> - * Terminates the module.
>> - */
>> -void ap_module_exit(void)
>> -{
>> -	int i;
>> -
>> -	initialised = false;
>> -	ap_reset_domain();
>> -	ap_poll_thread_stop();
>> -	del_timer_sync(&ap_config_timer);
>> -	hrtimer_cancel(&ap_poll_timer);
>> -	tasklet_kill(&ap_tasklet);
>> -
>> -	/* first remove queue devices */
>> -	bus_for_each_dev(&ap_bus_type, NULL, NULL,
>> -			 __ap_queue_devices_unregister);
>> -	/* now remove the card devices */
>> -	bus_for_each_dev(&ap_bus_type, NULL, NULL,
>> -			 __ap_card_devices_unregister);
>> -
>> -	/* remove bus attributes */
>> -	for (i = 0; ap_bus_attrs[i]; i++)
>> -		bus_remove_file(&ap_bus_type, ap_bus_attrs[i]);
>> -	unregister_pm_notifier(&ap_power_notifier);
>> -	root_device_unregister(ap_root_device);
>> -	bus_unregister(&ap_bus_type);
>> -	kfree(ap_configuration);
>> -	unregister_reset_call(&ap_reset_call);
>> -	if (ap_using_interrupts())
>> -		unregister_adapter_interrupt(&ap_airq);
>> -
>> -	ap_debug_exit();
>> -}
>> -
>> -module_init(ap_module_init);
>> -module_exit(ap_module_exit);
>> +device_initcall(ap_module_init);
> Thanks Paul for this patch.
> I am struggling with the change as I still like to build the ap device driver as a kernel module.
> It makes the development cycle somewhat easier to have this possibility with just a oneline
> change in the Makefile (replace obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
> with obj-$(CONFIG_ZCRYPT) += ap.o).
>
> However, you are right. As the ap driver is official not supported as a module the module
> code may get removed. Let me think about this some hours ...
>
> regards H.Freudenberger
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
patch applied.
Thanks
