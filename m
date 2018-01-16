From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 11/12] s390/sclp: expose the GISA format facility
Date: Tue, 16 Jan 2018 21:13:38 +0100
Message-ID: <20b7ac8a-dc97-5325-2cf4-2f9efa1c244e@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-12-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-12-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 16.01.2018 21:02, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The GISA format facility is required by the host to be able to process
> a format-1 GISA. If not available, the used GISA format will be format-0.
> All format-1 related extension will not be available in this case.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/sclp.h   | 1 +
>  drivers/s390/char/sclp_early.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
> index d3c1a8a2e3ad..3cae9168f63c 100644
> --- a/arch/s390/include/asm/sclp.h
> +++ b/arch/s390/include/asm/sclp.h
> @@ -77,6 +77,7 @@ struct sclp_info {
>  	unsigned char has_ibs : 1;
>  	unsigned char has_skey : 1;
>  	unsigned char has_kss : 1;
> +	unsigned char has_gisaf : 1;
>  	unsigned int ibc;
>  	unsigned int mtid;
>  	unsigned int mtid_cp;
> diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
> index d06bc5674e5f..6b1891539c84 100644
> --- a/drivers/s390/char/sclp_early.c
> +++ b/drivers/s390/char/sclp_early.c
> @@ -49,7 +49,7 @@ struct read_info_sccb {
>  	u8	_pad_112[116 - 112];	/* 112-115 */
>  	u8	fac116;			/* 116 */
>  	u8	fac117;			/* 117 */
> -	u8	_pad_118;		/* 118 */
> +	u8	fac118;			/* 118 */
>  	u8	fac119;			/* 119 */
>  	u16	hcpua;			/* 120-121 */
>  	u8	_pad_122[124 - 122];	/* 122-123 */
> @@ -100,6 +100,7 @@ static void __init sclp_early_facilities_detect(struct read_info_sccb *sccb)
>  	sclp.has_esca = !!(sccb->fac116 & 0x08);
>  	sclp.has_pfmfi = !!(sccb->fac117 & 0x40);
>  	sclp.has_ibs = !!(sccb->fac117 & 0x20);
> +	sclp.has_gisaf = !!(sccb->fac118 & 0x08);
>  	sclp.has_hvs = !!(sccb->fac119 & 0x80);
>  	sclp.has_kss = !!(sccb->fac98 & 0x01);
>  	if (sccb->fac85 & 0x02)
> 

No public documentation to validate.

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
