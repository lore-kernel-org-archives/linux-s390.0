Return-Path: <linux-doc-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 3 Apr 2019 13:28:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190402174636.15175-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <92d69cf5-0510-cf22-9f72-ab3efe4ede9b@de.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 02.04.19 19:46, Collin Walling wrote:
> Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
> for the availability of hardware support for the instruction.
> 
> In order to support this instruction for a KVM/QEMU guest, we
> would need to provide modifications to the SCLP Read SCP Info
> data, which will in turn reduce the maximum number of CPUs that
> may be provided to the guest. This issue introduces compatability
> and legacy concerns.
> 
> Let's circumvent this issue by removing the bit check and blindly
> executing the instruction. An exception table rule is in place to
> catch the case where hardware does not support this instruction.


No, please keep the check. We have to extend the read scp field anyway
for future extensions.


> 
> While we're at it, let's condense the version code fields in the
> diag318_info struct until we can determine how it will be used.
> 
> This modifies commit 4ad78b8651aacf26b3ab6d1e784952eb70469c43
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  arch/s390/include/asm/diag.h |  6 ++----
>  arch/s390/kernel/setup.c     | 12 ++++++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
> index 19562be22b7e..215516284175 100644
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
> index 2c642af526ce..fe70201f8b5d 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -1011,15 +1011,15 @@ static void __init setup_control_program_code(void)
>  {
>  	union diag318_info diag318_info = {
>  		.cpnc = CPNC_LINUX,
> -		.cpvc_linux = 0,
> -		.cpvc_distro = {0},
> +		.cpvc = 0,
>  	};
>  
> -	if (!sclp.has_diag318)
> -		return;
> -
>  	diag_stat_inc(DIAG_STAT_X318);
> -	asm volatile("diag %0,0,0x318\n" : : "d" (diag318_info.val));
> +	asm volatile(
> +		"	diag	%0,0,0x318\n"
> +		"0:	nopr	%%r7\n"
> +		EX_TABLE(0b,0b)
> +		: : "d" (diag318_info.val));
>  }
>  
>  /*
> 
