Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4D449C28.90202@weilnetz.de>
Date: Sun, 30 Jan 2011 00:00:56 +0100
From: Stefan Weil <stefan@weilnetz.de>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] s390: Fix possibly wrong size in strncmp (smsglucv)
References: <1296336808-2809-1-git-send-email-weil@mail.berlios.de> <1296336808-2809-2-git-send-email-weil@mail.berlios.de> <alpine.LNX.2.00.1101292237220.19392@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1101292237220.19392@swampdragon.chaosbits.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux390@de.ibm.com, Ursula Braun <ursula.braun@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 29.01.2011 22:38, schrieb Jesper Juhl:
> On Sat, 29 Jan 2011, Stefan Weil wrote:
>
>    
>> This error was reported by cppcheck:
>> drivers/s390/net/smsgiucv.c:63: error: Using sizeof for array given as function argument returns the size of pointer.
>>
>> Although there is no runtime problem as long as sizeof(u8 *) == 8,
>> this misleading code should get fixed.
>>
>> Cc: Ursula Braun<ursula.braun@de.ibm.com>
>> Cc: linux390@de.ibm.com
>> Cc: Frank Blaschka<blaschka@linux.vnet.ibm.com>
>> Cc: Martin Schwidefsky<schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Stefan Weil<weil@mail.berlios.de>
>> ---
>>   drivers/s390/net/smsgiucv.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
>> index 65e1cf1..207b7d7 100644
>> --- a/drivers/s390/net/smsgiucv.c
>> +++ b/drivers/s390/net/smsgiucv.c
>> @@ -60,7 +60,7 @@ static struct iucv_handler smsg_handler = {
>>   static int smsg_path_pending(struct iucv_path *path, u8 ipvmid[8],
>>   			     u8 ipuser[16])
>>   {
>> -	if (strncmp(ipvmid, "*MSG    ", sizeof(ipvmid)) != 0)
>> +	if (strncmp(ipvmid, "*MSG    ", 8) != 0)
>>      
> Hmm, shouldn't this really be  ARRAY_SIZE(ipvmid)  ??
>    

I think that would be wrong, too (only in this special case where
an array is passed as a function parameter).
