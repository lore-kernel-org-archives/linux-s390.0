From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:08:38 +0000
Subject: Re: [PATCH 06/23] zfcp: update width in comment for ZFCP_COMMON_FLAGS mask
Message-Id: <1852263d-5c6b-c0e4-bd7e-453a5b11950c@suse.de>
In-Reply-To: <20181108144458.29012-7-maier@linux.ibm.com>
References: <20181108144458.29012-7-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> v2.6.10 history commit 4062e12b2ba2 ("[PATCH] s390: zfcp act enhancements")
> extended this mask by one nibble with the introduction of
> ZFCP_STATUS_COMMON_ACCESS_DENIED == 0x00800000 for ACT
> (access control table).
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
> index 87a1fef5568e..13bfc13eb42d 100644
> --- a/drivers/s390/scsi/zfcp_def.h
> +++ b/drivers/s390/scsi/zfcp_def.h
> @@ -49,8 +49,8 @@
>   /*************** ADAPTER/PORT/UNIT AND FSF_REQ STATUS FLAGS ******************/
>   
>   /*
> - * Note, the leftmost status byte is common among adapter, port
> - * and unit
> + * Note, the leftmost 12 status bits (3 nibbles) are common among adapter, port
> + * and unit. This is a mask for bitwise 'and' with status values.
>    */
>   #define ZFCP_COMMON_FLAGS			0xfff00000
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
