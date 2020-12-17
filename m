Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbgLQJyw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 04:54:52 -0500
Subject: Re: [kvm-unit-tests PATCH v3 7/8] s390x: Add diag318 intercept test
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-8-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4f689585-ae2e-4632-9055-f2332d9f7751@redhat.com>
Date: Thu, 17 Dec 2020 10:53:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201211100039.63597-8-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 11/12/2020 11.00, Janosch Frank wrote:
> Not much to test except for the privilege and specification
> exceptions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/sclp.c  |  2 ++
>  lib/s390x/sclp.h  |  6 +++++-
>  s390x/intercept.c | 19 +++++++++++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index cf6ea7c..0001993 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -138,6 +138,8 @@ void sclp_facilities_setup(void)
>  
>  	assert(read_info);
>  
> +	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
> +
>  	cpu = (void *)read_info + read_info->offset_cpu;
>  	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
>  		if (cpu->address == cpu0_addr) {
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 6c86037..58f8e54 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -105,7 +105,8 @@ extern struct sclp_facilities sclp_facilities;
>  
>  struct sclp_facilities {
>  	uint64_t has_sief2 : 1;
> -	uint64_t : 63;
> +	uint64_t has_diag318 : 1;
> +	uint64_t : 62;
>  };
>  
>  typedef struct ReadInfo {
> @@ -130,6 +131,9 @@ typedef struct ReadInfo {
>      uint16_t highest_cpu;
>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>      uint32_t hmfai;
> +    uint8_t reserved7[134 - 128];
> +    uint8_t byte_134_diag318 : 1;
> +    uint8_t : 7;
>      struct CPUEntry entries[0];

... the entries[] array can be moved around here without any further ado?
Looks confusing to me. Should there be a CPUEntry array here at all, or only
in ReadCpuInfo?

>  } __attribute__((packed)) ReadInfo;
>  

 Thomas
