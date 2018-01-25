From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v2 05/12] s390/css: indicate the availability of the AIV
 facility
Date: Thu, 25 Jan 2018 14:54:03 +0100
Message-ID: <20180125145403.5ccb2691@mschwideX1>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-6-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-6-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 14:28:41 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The patch adds an indication for the presence Adapter Interruption
> Virtualization facility (AIV) of the general channel subsystem
> characteristics.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [change wording]
> ---
>  arch/s390/include/asm/css_chars.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/css_chars.h b/arch/s390/include/asm/css_chars.h
> index a478eb6..fb56fa3 100644
> --- a/arch/s390/include/asm/css_chars.h
> +++ b/arch/s390/include/asm/css_chars.h
> @@ -20,7 +20,9 @@ struct css_general_char {
>  	u32 aif_tdd : 1; /* bit 56 */
>  	u32 : 1;
>  	u32 qebsm : 1;	 /* bit 58 */
> -	u32 : 8;
> +	u32 : 2;
> +	u32 aiv : 1;     /* bit 61 */
> +	u32 : 5;
>  	u32 aif_osa : 1; /* bit 67 */
>  	u32 : 12;
>  	u32 eadm_rf : 1; /* bit 80 */

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
