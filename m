From: Harald Freudenberger <freude@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 15:18:21 +0000
Subject: Re: [PATCH] s390/zcrypt: Convert to PM ops
Message-Id: <f6050632-3f1c-52cb-00a2-3c84e1764c0d@linux.vnet.ibm.com>
In-Reply-To: <1479848771-15128-1-git-send-email-lars@metafoo.de>
References: <1479848771-15128-1-git-send-email-lars@metafoo.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Lars-Peter Clausen wrote on 22.11.2016 10:06:

>
>> ----- Original message -----
>> From: Lars-Peter Clausen <lars@metafoo.de>
>> To: Ingo Tuchscherer/Germany/IBM@IBMDE, mschwid2@linux.vnet.ibm.com,
>> heicars2@linux.vnet.ibm.com
>> Cc: linux-s390@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
>> Subject: [PATCH] s390/zcrypt: Convert to PM ops
>> Date: Tue, Nov 22, 2016 10:06 PM
>>
>> Switch the zcrypt bus from legacy suspend/resume callbacks to dev_pm_ops.
>> The conversion is straight forward with the help of SIMPLE_DEV_PM_OPS().
>> The new dev_pm_ops based version is functionally equivalent to the legacy
>> callbacks version.
>>
>> This will allow to eventually remove support for legacy suspend/resume
>> callbacks from the kernel altogether.
>>
>> Also remove the empty no-op resume function. There is no need to keep it
>> around, the PM core handles the case where it is NULL just fine.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/s390/crypto/ap_bus.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index ed92fb0..f407b4f 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -1273,7 +1273,7 @@ static int ap_uevent (struct device *dev,
>> struct kobj_uevent_env *env)
>>   return retval;
>>  }
>>
>> -static int ap_dev_suspend(struct device *dev, pm_message_t state)
>> +static int ap_dev_suspend(struct device *dev)
>>  {
>>   struct ap_device *ap_dev = to_ap_dev(dev);
>>
>> @@ -1287,11 +1287,6 @@ static int ap_dev_suspend(struct device *dev,
>> pm_message_t state)
>>   return 0;
>>  }
>>
>> -static int ap_dev_resume(struct device *dev)
>> -{
>> - return 0;
>> -}
>> -
>>  static void ap_bus_suspend(void)
>>  {
>>   ap_suspend_flag = 1;
>> @@ -1356,12 +1351,13 @@ static struct notifier_block ap_power_notifier =
> {
>>   .notifier_call = ap_power_event,
>>  };
>>
>> +static SIMPLE_DEV_PM_OPS(ap_bus_pm_ops, ap_dev_suspend, NULL);
>> +
>>  static struct bus_type ap_bus_type = {
>>   .name = "ap",
>>   .match = &ap_bus_match,
>>   .uevent = &ap_uevent,
>> - .suspend = ap_dev_suspend,
>> - .resume = ap_dev_resume,
>> + .pm = &ap_bus_pm_ops,
>>  };
>>
>>  void ap_device_init_reply(struct ap_device *ap_dev,
>> --
>> 2.1.4
>>
>>

applied with one slight adaption.
Many thanks !

Harald Freudenberger
