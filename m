Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728954AbgFVO4M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 10:56:12 -0400
Subject: Re: [PATCH v8 1/2] s390/setup: diag 318: refactor struct
References: <20200618222222.23175-1-walling@linux.ibm.com>
 <20200618222222.23175-2-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <e3edb120-33cb-9f3a-bf05-79b3a48613fe@de.ibm.com>
Date: Mon, 22 Jun 2020 16:56:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200618222222.23175-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com


On 19.06.20 00:22, Collin Walling wrote:
> The diag 318 struct introduced in include/asm/diag.h can be
> reused in KVM, so let's condense the version code fields in the
> diag318_info struct for easier usage and simplify it until we
> can determine how the data should be formatted.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Series looks good to me. Can you respin the 2nd patch regarding the VSIE things
and I can then apply it.


> ---
>  arch/s390/include/asm/diag.h | 6 ++----
>  arch/s390/kernel/setup.c     | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
> index 0036eab14391..ca8f85b53a90 100644
> --- a/arch/s390/include/asm/diag.h
> +++ b/arch/s390/include/asm/diag.h
> @@ -298,10 +298,8 @@ struct diag26c_mac_resp {
>  union diag318_info {
>  	unsigned long val;
>  	struct {
> -		unsigned int cpnc : 8;
> -		unsigned int cpvc_linux : 24;
> -		unsigned char cpvc_distro[3];
> -		unsigned char zero;
> +		unsigned long cpnc : 8;
> +		unsigned long cpvc : 56;
>  	};
>  };
>  
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 5853c9872dfe..878cacfc9c3e 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -1021,8 +1021,7 @@ static void __init setup_control_program_code(void)
>  {
>  	union diag318_info diag318_info = {
>  		.cpnc = CPNC_LINUX,
> -		.cpvc_linux = 0,
> -		.cpvc_distro = {0},
> +		.cpvc = 0,
>  	};
>  
>  	if (!sclp.has_diag318)
> 
