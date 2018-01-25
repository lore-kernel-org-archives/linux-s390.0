From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 05/12] s390/css: indicate the availability of the AIV
 facility
Date: Thu, 25 Jan 2018 14:59:22 +0100
Message-ID: <5feab3ed-6e64-b7a4-76ef-3e3b099658c3@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-6-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-6-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 14:28, Christian Borntraeger wrote:
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
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
