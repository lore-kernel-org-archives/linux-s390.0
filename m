From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 24 Jan 2019 16:26:12 +0000
Subject: Re: [PATCH v2 1/2] s390/setup: set control program code via diag 318
Message-Id: <f82b4b05-a12c-147d-8fce-610f7f2cca2f@de.ibm.com>
In-Reply-To: <01ab19e5-0969-0d1f-152a-95a42e86bd00@linux.ibm.com>
References: <01ab19e5-0969-0d1f-152a-95a42e86bd00@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 06.12.2018 23:30, Collin Walling wrote:
> The s390x diagnose 318 instruction sets the control program name code (CPNC)
> and control program version code (CPVC) to provide useful information
> regarding the OS during debugging. The CPNC is explicitly set to 4 to
> indicate a Linux/KVM environment.
> 
> The CPVC is a 7-byte value containing:
> 
>  - 3-byte Linux version code
>  - 3-byte unique value, currently set to 0
>  - 1-byte trailing null
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks. applied with the changes as outlined 
and scheduled for Martins tree.
> ---
>  arch/s390/include/asm/diag.h   | 12 ++++++++++++
>  arch/s390/include/asm/sclp.h   |  1 +
>  arch/s390/kernel/diag.c        |  1 +
>  arch/s390/kernel/setup.c       | 21 +++++++++++++++++++++
>  drivers/s390/char/sclp.h       |  4 +++-
>  drivers/s390/char/sclp_early.c |  2 ++
>  6 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
> index cdbaad5..19562be 100644
> --- a/arch/s390/include/asm/diag.h
> +++ b/arch/s390/include/asm/diag.h
> @@ -32,6 +32,7 @@ enum diag_stat_enum {
>  	DIAG_STAT_X2FC,
>  	DIAG_STAT_X304,
>  	DIAG_STAT_X308,
> +	DIAG_STAT_X318,
>  	DIAG_STAT_X500,
>  	NR_DIAG_STAT
>  };
> @@ -293,6 +294,17 @@ struct diag26c_mac_resp {
>  	u8	res[2];
>  } __aligned(8);
>  
> +#define CPNC_LINUX		0x4
> +union diag318_info {
> +	unsigned long val;
> +	struct {
> +		unsigned int cpnc : 8;
> +		unsigned int cpvc_linux : 24;
> +		unsigned char cpvc_distro[3];
> +		unsigned char zero;
> +	};
> +};
> +
>  int diag204(unsigned long subcode, unsigned long size, void *addr);
>  int diag224(void *ptr);
>  int diag26c(void *req, void *resp, enum diag26c_sc subcode);
> diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
> index 0cd4bda..ef4c9de 100644
> --- a/arch/s390/include/asm/sclp.h
> +++ b/arch/s390/include/asm/sclp.h
> @@ -78,6 +78,7 @@ struct sclp_info {
>  	unsigned char has_skey : 1;
>  	unsigned char has_kss : 1;
>  	unsigned char has_gisaf : 1;
> +	unsigned char has_diag318 : 1;
>  	unsigned int ibc;
>  	unsigned int mtid;
>  	unsigned int mtid_cp;
> diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
> index 53a5316..7edaa73 100644
> --- a/arch/s390/kernel/diag.c
> +++ b/arch/s390/kernel/diag.c
> @@ -45,6 +45,7 @@ static const struct diag_desc diag_map[NR_DIAG_STAT] = {
>  	[DIAG_STAT_X2FC] = { .code = 0x2fc, .name = "Guest Performance Data" },
>  	[DIAG_STAT_X304] = { .code = 0x304, .name = "Partition-Resource Service" },
>  	[DIAG_STAT_X308] = { .code = 0x308, .name = "List-Directed IPL" },
> +	[DIAG_STAT_X318] = { .code = 0x318, .name = "CP Name and Version Codes" },
>  	[DIAG_STAT_X500] = { .code = 0x500, .name = "Virtio Service" },
>  };
>  
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 72dd23e..9999bcc 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -49,6 +49,7 @@
>  #include <linux/memory.h>
>  #include <linux/compat.h>
>  #include <linux/start_kernel.h>
> +#include <linux/version.h>
>  
>  #include <asm/ipl.h>
>  #include <asm/facility.h>
> @@ -990,6 +991,25 @@ static void __init setup_task_size(void)
>  }
>  
>  /*
> + * Issue diagnose 318 to set the control program name and
> + * version codes.
> + */
> +static void __init setup_control_program_code(void)
> +{
> +	union diag318_info diag318_info = {
> +		.cpnc = CPNC_LINUX,
> +		.cpvc_linux = LINUX_VERSION_CODE,
> +		.cpvc_distro = {0},
> +	};
> +
> +	if (!sclp.has_diag318)
> +		return;
> +
> +	diag_stat_inc(DIAG_STAT_X318);
> +	asm volatile("diag %0,0,0x318\n" : : "d" (diag318_info.val));
> +}
> +
> +/*
>   * Setup function called from init/main.c just after the banner
>   * was printed.
>   */
> @@ -1031,6 +1051,7 @@ void __init setup_arch(char **cmdline_p)
>  	os_info_init();
>  	setup_ipl();
>  	setup_task_size();
> +	setup_control_program_code();
>  
>  	/* Do some memory reservations *before* memory is added to memblock */
>  	reserve_memory_end();
> diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
> index b3fcc24..367e9d3 100644
> --- a/drivers/s390/char/sclp.h
> +++ b/drivers/s390/char/sclp.h
> @@ -195,7 +195,9 @@ struct read_info_sccb {
>  	u16	hcpua;			/* 120-121 */
>  	u8	_pad_122[124 - 122];	/* 122-123 */
>  	u32	hmfai;			/* 124-127 */
> -	u8	_pad_128[4096 - 128];	/* 128-4095 */
> +	u8	_pad_128[134 - 128];	/* 128-133 */
> +	u8	byte_134;			/* 134 */
> +	u8	_pad_135[4096 - 135];	/* 135-4095 */
>  } __packed __aligned(PAGE_SIZE);
>  
>  struct read_storage_sccb {
> diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
> index e792cee..8332788 100644
> --- a/drivers/s390/char/sclp_early.c
> +++ b/drivers/s390/char/sclp_early.c
> @@ -44,6 +44,8 @@ static void __init sclp_early_facilities_detect(struct read_info_sccb *sccb)
>  		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
>  	if (sccb->fac91 & 0x40)
>  		S390_lowcore.machine_flags |= MACHINE_FLAG_TLB_GUEST;
> +	if (sccb->cpuoff > 134)
> +		sclp.has_diag318 = !!(sccb->byte_134 & 0x80);
>  	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
>  	sclp.rzm = sccb->rnsize ? sccb->rnsize : sccb->rnsize2;
>  	sclp.rzm <<= 20;
> 
