From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: fix build failure
Date: Wed, 8 Jun 2016 07:17:35 +0200
Message-ID: <5757AA6F.705@de.ibm.com>
References: <1465336170-23064-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465336170-23064-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/07/2016 11:49 PM, Sudip Mukherjee wrote:
> etr_ptff definitions are moved and renamed but we missed updating them
> here and as a result s390 defconfig and allmodconfig was failing with
> the error:
> arch/s390/kvm/kvm-s390.c:230:45: error: 'ETR_PTFF_QAF' undeclared
> 
> Fixes: cc8f94656487 ("s390/time: move PTFF definitions")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Thank you for the report and patch.

This is linux-next only. Its a conflict between my kvms390 queue and 
Martins s390 queue. We cannot apply this directly as it would break
the build of my tree when not merged in next. (and it does not apply
on Martins tree).

I will have a look how to fix that up.


> ---
> 
> s390 defconfig build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/135776067
> 
>  arch/s390/kvm/kvm-s390.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fa51aef..3039eaf 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -29,7 +29,7 @@
>  #include <linux/bitmap.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/lowcore.h>
> -#include <asm/etr.h>
> +#include <asm/timex.h>
>  #include <asm/pgtable.h>
>  #include <asm/gmap.h>
>  #include <asm/nmi.h>
> @@ -227,7 +227,9 @@ static void kvm_s390_cpu_feat_init(void)
>  	}
> 
>  	if (test_facility(28)) /* TOD-clock steering */
> -		etr_ptff(kvm_s390_available_subfunc.ptff, ETR_PTFF_QAF);
> +		ptff(kvm_s390_available_subfunc.ptff,
> +		     sizeof(kvm_s390_available_subfunc.ptff),
> +		     PTFF_QAF);
> 
>  	if (test_facility(17)) { /* MSA */
>  		__cpacf_query(CPACF_KMAC, kvm_s390_available_subfunc.kmac);
> 
