Return-Path: <SRS0=sFCg=TC=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 1/2] s390/setup: diag318: refactor struct
References: <1556751063-21835-1-git-send-email-walling@linux.ibm.com>
 <1556751063-21835-2-git-send-email-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5c81a3b6-19a7-7e75-1ecc-8276a4ccc981@redhat.com>
Date: Thu, 2 May 2019 14:34:08 +0200
MIME-Version: 1.0
In-Reply-To: <1556751063-21835-2-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02.05.19 00:51, Collin Walling wrote:
> The diag318 struct introduced in include/asm/diag.h can be
> reused in KVM, so let's condense the version code fields in the
> diag318_info struct for easier usage and simplify it until we
> can determine how the data should be formatted.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  arch/s390/include/asm/diag.h | 6 ++----
>  arch/s390/kernel/setup.c     | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
> index 19562be..2155162 100644
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
> index 2c642af..cb88062 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -1011,8 +1011,7 @@ static void __init setup_control_program_code(void)
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
