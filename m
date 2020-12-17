Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbgLQLsM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 06:48:12 -0500
Date: Thu, 17 Dec 2020 12:47:22 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/8] s390x: Consolidate sclp read info
Message-ID: <20201217124722.0686a76d@ibm-vm>
In-Reply-To: <20201211100039.63597-3-frankja@linux.ibm.com>
References: <20201211100039.63597-1-frankja@linux.ibm.com>
        <20201211100039.63597-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On Fri, 11 Dec 2020 05:00:33 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's only read the information once and pass a pointer to it instead
> of calling sclp multiple times.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 31 +++++++++++++++++++++++++------
>  lib/s390x/sclp.h |  3 +++
>  lib/s390x/smp.c  | 27 +++++++++++----------------
>  4 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
> index 1ff0589..6a1da63 100644
> --- a/lib/s390x/io.c
> +++ b/lib/s390x/io.c
> @@ -34,6 +34,7 @@ void setup(void)
>  {
>  	setup_args_progname(ipl_args);
>  	setup_facilities();
> +	sclp_read_info();
>  	sclp_console_setup();
>  	sclp_memory_setup();
>  	smp_setup();
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 08a4813..bf1d9c0 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -23,6 +23,8 @@ extern unsigned long stacktop;
>  static uint64_t storage_increment_size;
>  static uint64_t max_ram_size;
>  static uint64_t ram_size;
> +char _read_info[PAGE_SIZE] __attribute__((__aligned__(4096)));

why not __aligned__((PAGE_SIZE)) ?

> +static ReadInfo *read_info;

I wonder if a union would be cleaner? although later on you check if
the pointer is NULL to see if the information is there, so I guess it
can stay

>  
>  char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>  static volatile bool sclp_busy;
> @@ -108,6 +110,24 @@ static void sclp_read_scp_info(ReadInfo *ri, int
> length) report_abort("READ_SCP_INFO failed");
>  }
>  
> +void sclp_read_info(void)
> +{
> +	sclp_read_scp_info((void *)_read_info, SCCB_SIZE);
> +	read_info = (ReadInfo *)_read_info;
> +}
> +
> +int sclp_get_cpu_num(void)
> +{
> +	assert(read_info);
> +	return read_info->entries_cpu;
> +}
> +
> +CPUEntry *sclp_get_cpu_entries(void)
> +{
> +	assert(read_info);
> +	return (void *)read_info + read_info->offset_cpu;

are you doing arithmetic on a void pointer? please don't, it's ugly and
against the specs. moreover you do have a char pointer...

why not:
return (CPUEntry *)(_read_info + read_info->offset_cpu);

> +}
> +
>  /* Perform service call. Return 0 on success, non-zero otherwise. */
>  int sclp_service_call(unsigned int command, void *sccb)
>  {
> @@ -125,23 +145,22 @@ int sclp_service_call(unsigned int command,
> void *sccb) 
>  void sclp_memory_setup(void)
>  {
> -	ReadInfo *ri = (void *)_sccb;
>  	uint64_t rnmax, rnsize;
>  	int cc;
>  
> -	sclp_read_scp_info(ri, SCCB_SIZE);
> +	assert(read_info);
>  
>  	/* calculate the storage increment size */
> -	rnsize = ri->rnsize;
> +	rnsize = read_info->rnsize;
>  	if (!rnsize) {
> -		rnsize = ri->rnsize2;
> +		rnsize = read_info->rnsize2;
>  	}
>  	storage_increment_size = rnsize << 20;
>  
>  	/* calculate the maximum memory size */
> -	rnmax = ri->rnmax;
> +	rnmax = read_info->rnmax;
>  	if (!rnmax) {
> -		rnmax = ri->rnmax2;
> +		rnmax = read_info->rnmax2;
>  	}
>  	max_ram_size = rnmax * storage_increment_size;
>  
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 9a6aad0..acd86d5 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -268,6 +268,9 @@ void sclp_wait_busy(void);
>  void sclp_mark_busy(void);
>  void sclp_console_setup(void);
>  void sclp_print(const char *str);
> +void sclp_read_info(void);
> +int sclp_get_cpu_num(void);
> +CPUEntry *sclp_get_cpu_entries(void);
>  int sclp_service_call(unsigned int command, void *sccb);
>  void sclp_memory_setup(void);
>  uint64_t get_ram_size(void);
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index c4f02dc..dfcfd28 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -23,7 +23,6 @@
>  #include "smp.h"
>  #include "sclp.h"
>  
> -static char cpu_info_buffer[PAGE_SIZE]
> __attribute__((__aligned__(4096))); static struct cpu *cpus;
>  static struct cpu *cpu0;
>  static struct spinlock lock;
> @@ -32,8 +31,7 @@ extern void smp_cpu_setup_state(void);
>  
>  int smp_query_num_cpus(void)
>  {
> -	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
> -	return info->nr_configured;
> +	return sclp_get_cpu_num();
>  }
>  
>  struct cpu *smp_cpu_from_addr(uint16_t addr)
> @@ -226,10 +224,10 @@ void smp_teardown(void)
>  {
>  	int i = 0;
>  	uint16_t this_cpu = stap();
> -	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
> +	int num = smp_query_num_cpus();
>  
>  	spin_lock(&lock);
> -	for (; i < info->nr_configured; i++) {
> +	for (; i < num; i++) {
>  		if (cpus[i].active &&
>  		    cpus[i].addr != this_cpu) {
>  			sigp_retry(cpus[i].addr, SIGP_STOP, 0, NULL);
> @@ -243,22 +241,19 @@ extern uint64_t *stackptr;
>  void smp_setup(void)
>  {
>  	int i = 0;
> +	int num = smp_query_num_cpus();
>  	unsigned short cpu0_addr = stap();
> -	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
> +	struct CPUEntry *entry = sclp_get_cpu_entries();
>  
>  	spin_lock(&lock);
> -	sclp_mark_busy();
> -	info->h.length = PAGE_SIZE;
> -	sclp_service_call(SCLP_READ_CPU_INFO, cpu_info_buffer);
> +	if (num > 1)
> +		printf("SMP: Initializing, found %d cpus\n", num);
>  
> -	if (smp_query_num_cpus() > 1)
> -		printf("SMP: Initializing, found %d cpus\n",
> info->nr_configured); -
> -	cpus = calloc(info->nr_configured, sizeof(cpus));
> -	for (i = 0; i < info->nr_configured; i++) {
> -		cpus[i].addr = info->entries[i].address;
> +	cpus = calloc(num, sizeof(cpus));
> +	for (i = 0; i < num; i++) {
> +		cpus[i].addr = entry[i].address;
>  		cpus[i].active = false;
> -		if (info->entries[i].address == cpu0_addr) {
> +		if (entry[i].address == cpu0_addr) {
>  			cpu0 = &cpus[i];
>  			cpu0->stack = stackptr;
>  			cpu0->lowcore = (void *)0;
