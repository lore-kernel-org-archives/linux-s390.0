From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/7] s390/kernel: Update /proc/sysinfo file with Extended
 Name and UUID
Date: Wed, 04 Feb 2015 13:57:59 +0100
Message-ID: <54D21757.7020300@redhat.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com> <1423043092-34044-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423043092-34044-4-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/02/2015 10:44, Christian Borntraeger wrote:
> From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
> 
> Read the additional data fields (Extended Name and UUID) from the
> 1KB block returned by the STSI command and reflect this information in
> the /proc/sysinfo file accordingly
> 
> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Why should this go in via KVM? :)

Paolo

> ---
>  arch/s390/include/asm/sysinfo.h | 10 +++++++---
>  arch/s390/kernel/sysinfo.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/sysinfo.h b/arch/s390/include/asm/sysinfo.h
> index f92428e..9f8f2b5 100644
> --- a/arch/s390/include/asm/sysinfo.h
> +++ b/arch/s390/include/asm/sysinfo.h
> @@ -15,6 +15,7 @@
>  #define __ASM_S390_SYSINFO_H
>  
>  #include <asm/bitsperlong.h>
> +#include <linux/uuid.h>
>  
>  struct sysinfo_1_1_1 {
>  	unsigned char p:1;
> @@ -112,10 +113,13 @@ struct sysinfo_3_2_2 {
>  		char name[8];
>  		unsigned int caf;
>  		char cpi[16];
> -		char reserved_1[24];
> -
> +		char reserved_1[3];
> +		char ext_name_encoding;
> +		unsigned int reserved_2;
> +		uuid_be uuid;
>  	} vm[8];
> -	char reserved_544[3552];
> +	char reserved_3[1504];
> +	char ext_names[8][256];
>  };
>  
>  extern int topology_max_mnest;
> diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> index 811f542..cebab77 100644
> --- a/arch/s390/kernel/sysinfo.c
> +++ b/arch/s390/kernel/sysinfo.c
> @@ -196,6 +196,33 @@ static void stsi_2_2_2(struct seq_file *m, struct sysinfo_2_2_2 *info)
>  	seq_printf(m, "LPAR CPUs Shared:     %d\n", info->cpus_shared);
>  }
>  
> +static void print_ext_name(struct seq_file *m, int lvl,
> +			   struct sysinfo_3_2_2 *info)
> +{
> +	if (info->vm[lvl].ext_name_encoding == 0)
> +		return;
> +	if (info->ext_names[lvl][0] == 0)
> +		return;
> +	switch (info->vm[lvl].ext_name_encoding) {
> +	case 1: /* EBCDIC */
> +		EBCASC(info->ext_names[lvl], sizeof(info->ext_names[lvl]));
> +		break;
> +	case 2:	/* UTF-8 */
> +		break;
> +	default:
> +		return;
> +	}
> +	seq_printf(m, "VM%02d Extended Name:   %-.256s\n", lvl,
> +		   info->ext_names[lvl]);
> +}
> +
> +static void print_uuid(struct seq_file *m, int i, struct sysinfo_3_2_2 *info)
> +{
> +	if (!memcmp(&info->vm[i].uuid, &NULL_UUID_BE, sizeof(uuid_be)))
> +		return;
> +	seq_printf(m, "VM%02d UUID:            %pUb\n", i, &info->vm[i].uuid);
> +}
> +
>  static void stsi_3_2_2(struct seq_file *m, struct sysinfo_3_2_2 *info)
>  {
>  	int i;
> @@ -213,6 +240,8 @@ static void stsi_3_2_2(struct seq_file *m, struct sysinfo_3_2_2 *info)
>  		seq_printf(m, "VM%02d CPUs Configured: %d\n", i, info->vm[i].cpus_configured);
>  		seq_printf(m, "VM%02d CPUs Standby:    %d\n", i, info->vm[i].cpus_standby);
>  		seq_printf(m, "VM%02d CPUs Reserved:   %d\n", i, info->vm[i].cpus_reserved);
> +		print_ext_name(m, i, info);
> +		print_uuid(m, i, info);
>  	}
>  }
>  
> 
