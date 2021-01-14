Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbhANOq2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 09:46:28 -0500
Date: Thu, 14 Jan 2021 14:47:33 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v4 3/9] s390x: SCLP feature checking
Message-ID: <20210114144733.3ec11445@ibm-vm>
In-Reply-To: <20210112132054.49756-4-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
        <20210112132054.49756-4-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On Tue, 12 Jan 2021 08:20:48 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Availability of SIE is announced via a feature bit in a SCLP info CPU
> entry. Let's add a framework that allows us to easily check for such
> facilities.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 25 +++++++++++++++++++++++++
>  lib/s390x/sclp.h | 13 ++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
> index 6a1da63..ef9f59e 100644
> --- a/lib/s390x/io.c
> +++ b/lib/s390x/io.c
> @@ -35,6 +35,7 @@ void setup(void)
>  	setup_args_progname(ipl_args);
>  	setup_facilities();
>  	sclp_read_info();
> +	sclp_facilities_setup();
>  	sclp_console_setup();
>  	sclp_memory_setup();
>  	smp_setup();
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 12916f5..06819a6 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -25,6 +25,7 @@ static uint64_t max_ram_size;
>  static uint64_t ram_size;
>  char _read_info[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
>  static ReadInfo *read_info;
> +struct sclp_facilities sclp_facilities;
>  
>  char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>  static volatile bool sclp_busy;
> @@ -128,6 +129,30 @@ CPUEntry *sclp_get_cpu_entries(void)
>  	return (CPUEntry *)(_read_info + read_info->offset_cpu);
>  }
>  
> +void sclp_facilities_setup(void)
> +{
> +	unsigned short cpu0_addr = stap();
> +	CPUEntry *cpu;
> +	int i;
> +
> +	assert(read_info);
> +
> +	cpu = sclp_get_cpu_entries();
> +	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
> +		/*
> +		 * The logic for only reading the facilities from the
> +		 * boot cpu comes from the kernel. I haven't yet
> found
> +		 * documentation that explains why this is necessary
> +		 * but I figure there's a reason behind doing it this
> +		 * way.
> +		 */
> +		if (cpu->address == cpu0_addr) {
> +			sclp_facilities.has_sief2 = cpu->feat_sief2;
> +			break;
> +		}
> +	}
> +}
> +
>  /* Perform service call. Return 0 on success, non-zero otherwise. */
>  int sclp_service_call(unsigned int command, void *sccb)
>  {
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index acd86d5..6c86037 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -92,12 +92,22 @@ typedef struct SCCBHeader {
>  typedef struct CPUEntry {
>      uint8_t address;
>      uint8_t reserved0;
> -    uint8_t features[SCCB_CPU_FEATURE_LEN];
> +    uint8_t : 4;
> +    uint8_t feat_sief2 : 1;
> +    uint8_t : 3;
> +    uint8_t features_res2 [SCCB_CPU_FEATURE_LEN - 1];
>      uint8_t reserved2[6];
>      uint8_t type;
>      uint8_t reserved1;
>  } __attribute__((packed)) CPUEntry;
>  
> +extern struct sclp_facilities sclp_facilities;
> +
> +struct sclp_facilities {
> +	uint64_t has_sief2 : 1;
> +	uint64_t : 63;
> +};
> +
>  typedef struct ReadInfo {
>      SCCBHeader h;
>      uint16_t rnmax;
> @@ -271,6 +281,7 @@ void sclp_print(const char *str);
>  void sclp_read_info(void);
>  int sclp_get_cpu_num(void);
>  CPUEntry *sclp_get_cpu_entries(void);
> +void sclp_facilities_setup(void);
>  int sclp_service_call(unsigned int command, void *sccb);
>  void sclp_memory_setup(void);
>  uint64_t get_ram_size(void);

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
