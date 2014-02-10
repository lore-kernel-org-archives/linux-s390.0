Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52F8B95F.5030401@arm.com>
Date: Mon, 10 Feb 2014 11:34:55 +0000
From: Sudeep Holla <Sudeep.Holla@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC/RFT v2 3/8] s390: move cacheinfo sysfs to generic
 cacheinfo infrastructure
References: <1391791763-28518-1-git-send-email-sudeep.holla@arm.com> <1391791763-28518-4-git-send-email-sudeep.holla@arm.com> <20140210095020.GB19013@osiris>
In-Reply-To: <20140210095020.GB19013@osiris>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sudeep.Holla@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 10/02/14 09:50, Heiko Carstens wrote:
> On Fri, Feb 07, 2014 at 04:49:18PM +0000, Sudeep Holla wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> This patch removes the redundant sysfs cacheinfo code by making use of
>> the newly introduced generic cacheinfo infrastructure.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: linux390@de.ibm.com
>> Cc: linux-s390@vger.kernel.org
>> ---
> 
> [...]
> 
>> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
>> index 2461202..1f875db 100644
>> --- a/arch/s390/kernel/processor.c
>> +++ b/arch/s390/kernel/processor.c
>> @@ -58,7 +58,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>  			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
>>  				seq_printf(m, "%s ", hwcap_str[i]);
>>  		seq_puts(m, "\n");
>> -		show_cacheinfo(m);
>>  	}
>>  	get_online_cpus();
>>  	if (cpu_online(n)) {
> 
> You can't remove that. It's a user space visible change.
> 
Correct, I wanted to add show_cacheinfo back as its user ABI already, missed it.

Is it ok if I use cpu0 cacheinfo or to be safer as cpu0 can be offline, use
the cacheinfo of the cpu executing this ?

Regards,
Sudeep
