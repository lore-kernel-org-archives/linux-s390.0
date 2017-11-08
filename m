Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ffe1ebfd-36d3-3408-429f-76aceec04055@linux.vnet.ibm.com>
References: <20171106140328.1498644-1-arnd@arndb.de> <ffe1ebfd-36d3-3408-429f-76aceec04055@linux.vnet.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Nov 2017 14:56:23 +0100
Message-ID: <CAK8P3a3tLNE1rMgJS1vEeTZEPQxrO7B5dbK6QOrdX7uYq+su9w@mail.gmail.com>
Subject: Re: [PATCH] s390/dasd: avoid calling do_gettimeofday()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 8, 2017 at 2:27 PM, Stefan Haberland <sth@linux.vnet.ibm.com> wrote:
> On 06.11.2017 15:02, Arnd Bergmann wrote:
>> diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
>> index 4630782b5456..5169c717c9d6 100644
>> --- a/drivers/s390/block/dasd_eer.c
>> +++ b/drivers/s390/block/dasd_eer.c
>> @@ -296,7 +296,7 @@ static void dasd_eer_write_standard_trigger(struct
>> dasd_device *device,
>>   {
>>         struct dasd_ccw_req *temp_cqr;
>>         int data_size;
>> -       struct timeval tv;
>> +       struct timespec64 ts64;
>
> ...
>>
>> +       ktime_get_real_ts64(&ts);
>> +       header.tv_sec = ts.tv_sec;
>> +       header.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>>
>
> I renamed ts64 to ts to match the usage below and fix the compile error.
>
> Beside of this, applied. Thanks for the patch.
>

Thanks and sorry for not build-testing it properly, I thought I had at
least compiled
this one separately with my cross-toolchain, but maybe I renamed the variable
after testing it, or I misremember testing it.

        Arnd
