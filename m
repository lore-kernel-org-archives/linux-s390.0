Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391410AbhASNOz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 08:14:55 -0500
Date: Tue, 19 Jan 2021 14:11:33 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390: uv: Fix sysfs max number of VCPUs reporting
Message-ID: <20210119141133.186273c1@ibm-vm>
In-Reply-To: <20210119100402.84734-2-frankja@linux.ibm.com>
References: <20210119100402.84734-1-frankja@linux.ibm.com>
        <20210119100402.84734-2-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

On Tue, 19 Jan 2021 05:04:01 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The number reported by the query is N-1 and I think people reading the
> sysfs file would expect N instead. For users creating VMs there's no
> actual difference because KVM's limit is currently below the UV's
> limit.
> 
> The naming of the field is a bit misleading. Number in this context is
> used like ID and starts at 0. The query field denotes the maximum
> number that can be put into the VCPU number field in the "create
> secure CPU" UV call.

once you address Christian's comments:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: a0f60f8431999 ("s390/protvirt: Add sysfs firmware interface
> for Ultravisor information") Cc: stable@vger.kernel.org
> ---
>  arch/s390/boot/uv.c        | 2 +-
>  arch/s390/include/asm/uv.h | 4 ++--
>  arch/s390/kernel/uv.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index a15c033f53ca..afb721082989 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -35,7 +35,7 @@ void uv_query_info(void)
>  		uv_info.guest_cpu_stor_len = uvcb.cpu_stor_len;
>  		uv_info.max_sec_stor_addr =
> ALIGN(uvcb.max_guest_stor_addr, PAGE_SIZE); uv_info.max_num_sec_conf
> = uvcb.max_num_sec_conf;
> -		uv_info.max_guest_cpus = uvcb.max_guest_cpus;
> +		uv_info.max_guest_cpu_id = uvcb.max_guest_cpu_num;
>  	}
>  
>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 0325fc0469b7..c484c95ea142 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -96,7 +96,7 @@ struct uv_cb_qui {
>  	u32 max_num_sec_conf;
>  	u64 max_guest_stor_addr;
>  	u8  reserved88[158 - 136];
> -	u16 max_guest_cpus;
> +	u16 max_guest_cpu_num;
>  	u8  reserveda0[200 - 160];
>  } __packed __aligned(8);
>  
> @@ -273,7 +273,7 @@ struct uv_info {
>  	unsigned long guest_cpu_stor_len;
>  	unsigned long max_sec_stor_addr;
>  	unsigned int max_num_sec_conf;
> -	unsigned short max_guest_cpus;
> +	unsigned short max_guest_cpu_id;
>  };
>  
>  extern struct uv_info uv_info;
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 883bfed9f5c2..b2d2ad153067 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -368,7 +368,7 @@ static ssize_t uv_query_max_guest_cpus(struct
> kobject *kobj, struct kobj_attribute *attr, char *page)
>  {
>  	return scnprintf(page, PAGE_SIZE, "%d\n",
> -			uv_info.max_guest_cpus);
> +			uv_info.max_guest_cpu_id + 1);
>  }
>  
>  static struct kobj_attribute uv_query_max_guest_cpus_attr =
