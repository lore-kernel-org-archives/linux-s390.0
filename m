From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:09:32 +0000
Subject: Re: [PATCH 08/23] zfcp: group sort internal structure definitions for proximity
Message-Id: <736673a5-78fd-78e0-7ea8-cdf36461b85e@suse.de>
In-Reply-To: <20181108144458.29012-9-maier@linux.ibm.com>
References: <20181108144458.29012-9-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> Have structures just before the structures that use them
> (without disrupting sequences of using structures such as
>   zfcp_unit and zfcp_scsi_dev):
> - zfcp_adapter_mempool embedded in zfcp_adapter,
> - zfcp_latenc... embedded in zfcp_scsi_dev.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 58 ++++++++++++++++++++++----------------------
>   1 file changed, 29 insertions(+), 29 deletions(-)
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
