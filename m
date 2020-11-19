Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgKSIws (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:52:48 -0500
References: <20201117154215.45855-1-frankja@linux.ibm.com>
 <20201117154215.45855-3-frankja@linux.ibm.com>
 <e1c4a7f0-21a1-1a4e-1f40-f5f2de9d138e@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 2/5] s390x: Consolidate sclp read info
Message-ID: <968879af-3dd2-56f4-def7-fc478b6f882d@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:52:42 +0100
MIME-Version: 1.0
In-Reply-To: <e1c4a7f0-21a1-1a4e-1f40-f5f2de9d138e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On 11/19/20 9:41 AM, Thomas Huth wrote:
> On 17/11/2020 16.42, Janosch Frank wrote:
>> Let's only read the information once and pass a pointer to it instead
>> of calling sclp multiple times.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/io.c   |  1 +
>>  lib/s390x/sclp.c | 29 +++++++++++++++++++++++------
>>  lib/s390x/sclp.h |  3 +++
>>  lib/s390x/smp.c  | 23 +++++++++--------------
>>  4 files changed, 36 insertions(+), 20 deletions(-)
>>
>> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
>> index c0f0bf7..e19a1f3 100644
>> --- a/lib/s390x/io.c
>> +++ b/lib/s390x/io.c
>> @@ -36,6 +36,7 @@ void setup(void)
>>  {
>>  	setup_args_progname(ipl_args);
>>  	setup_facilities();
>> +	sclp_read_info();
>>  	sclp_console_setup();
>>  	sclp_memory_setup();
>>  	smp_setup();
>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>> index 4054d0e..ea6324e 100644
>> --- a/lib/s390x/sclp.c
>> +++ b/lib/s390x/sclp.c
>> @@ -25,6 +25,8 @@ extern unsigned long stacktop;
>>  static uint64_t storage_increment_size;
>>  static uint64_t max_ram_size;
>>  static uint64_t ram_size;
>> +char _read_info[PAGE_SIZE] __attribute__((__aligned__(4096)));
>> +static ReadInfo *read_info;
>>  
>>  char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>>  static volatile bool sclp_busy;
>> @@ -110,6 +112,22 @@ static void sclp_read_scp_info(ReadInfo *ri, int length)
>>  	report_abort("READ_SCP_INFO failed");
>>  }
>>  
>> +void sclp_read_info(void)
>> +{
>> +	sclp_read_scp_info((void *)_read_info, SCCB_SIZE);
>> +	read_info = (ReadInfo *)_read_info;
>> +}
>> +
>> +int sclp_get_cpu_num(void)
>> +{
>> +	return read_info->entries_cpu;
>> +}
> [...]
>>  int smp_query_num_cpus(void)
>>  {
>> -	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
>> -	return info->nr_configured;
>> +	return sclp_get_cpu_num();
>>  }
> 
> You've changed from ->nr_configured to ->entries_cpu ... I assume that's ok?
> Worth to mention the change and rationale in the patch description?

Well, it's not so much a change of struct members than a change of
structs themselves. Looking at our QEMU implementation, both struct
members transport the same data so I don't see a problem there.

> 
>>  struct cpu *smp_cpu_from_addr(uint16_t addr)
>> @@ -245,22 +244,18 @@ extern uint64_t *stackptr;
>>  void smp_setup(void)
>>  {
>>  	int i = 0;
>> +	int num = smp_query_num_cpus();
>>  	unsigned short cpu0_addr = stap();
>> -	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
>> +	struct CPUEntry *entry = sclp_get_cpu_entries();
>>  
>> -	spin_lock(&lock);
>> -	sclp_mark_busy();
>> -	info->h.length = PAGE_SIZE;
>> -	sclp_service_call(SCLP_READ_CPU_INFO, cpu_info_buffer);
>> +	if (num > 1)
>> +		printf("SMP: Initializing, found %d cpus\n", num);
>>  
>> -	if (smp_query_num_cpus() > 1)
>> -		printf("SMP: Initializing, found %d cpus\n", info->nr_configured);
>> -
>> -	cpus = calloc(info->nr_configured, sizeof(cpus));
>> -	for (i = 0; i < info->nr_configured; i++) {
>> -		cpus[i].addr = info->entries[i].address;
>> +	cpus = calloc(num, sizeof(cpus));
>> +	for (i = 0; i < num; i++) {
>> +		cpus[i].addr = entry[i].address;
>>  		cpus[i].active = false;
>> -		if (info->entries[i].address == cpu0_addr) {
>> +		if (entry[i].address == cpu0_addr) {
>>  			cpu0 = &cpus[i];
>>  			cpu0->stack = stackptr;
>>  			cpu0->lowcore = (void *)0;
>>
> 
> What about smp_teardown()? It seems to use cpu_info_buffer->nr_configured,
> too, which is now likely not valid anymore?

Good catch, I forgot to remove the whole cpu info buffer.

> 
>  Thomas
> 
