Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730248AbgK0N7R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 08:59:17 -0500
Subject: Re: [kvm-unit-tests PATCH v2 2/7] s390x: Consolidate sclp read info
References: <20201127130629.120469-1-frankja@linux.ibm.com>
 <20201127130629.120469-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <491a5e03-5c07-97a4-e8e3-99ea97b681b2@redhat.com>
Date: Fri, 27 Nov 2020 14:59:04 +0100
MIME-Version: 1.0
In-Reply-To: <20201127130629.120469-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 27/11/2020 14.06, Janosch Frank wrote:
> Let's only read the information once and pass a pointer to it instead
> of calling sclp multiple times.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/io.c   |  1 +
>  lib/s390x/sclp.c | 29 +++++++++++++++++++++++------
>  lib/s390x/sclp.h |  3 +++
>  lib/s390x/smp.c  | 28 +++++++++++-----------------
>  4 files changed, 38 insertions(+), 23 deletions(-)
...
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 4e2ac18..ff56c44 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -25,6 +25,8 @@ extern unsigned long stacktop;
>  static uint64_t storage_increment_size;
>  static uint64_t max_ram_size;
>  static uint64_t ram_size;
> +char _read_info[PAGE_SIZE] __attribute__((__aligned__(4096)));
> +static ReadInfo *read_info;
>  
>  char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
>  static volatile bool sclp_busy;
> @@ -110,6 +112,22 @@ static void sclp_read_scp_info(ReadInfo *ri, int length)
>  	report_abort("READ_SCP_INFO failed");
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

I forgot to say: Maybe add a

       assert(read_info);

here, just in case? (since we can dereference the NULL pointer in the k-u-t)

> +	return read_info->entries_cpu;
> +}
> +
> +CPUEntry *sclp_get_cpu_entries(void)
> +{

dito.

> +	return (void *)read_info + read_info->offset_cpu;
> +}

 Thomas
