From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:20:08 +0000
Subject: Re: [PATCH 19/23] zfcp: silence all W=1 build warnings for existing kdoc
Message-Id: <40d18277-5948-c4fd-2c48-2e420a383745@suse.de>
In-Reply-To: <20181108144458.29012-20-maier@linux.ibm.com>
References: <20181108144458.29012-20-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> While at it also improve some copy&paste kdoc mistakes.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_dbf.c  | 13 ++++++++-----
>   drivers/s390/scsi/zfcp_erp.c  |  6 +++---
>   drivers/s390/scsi/zfcp_fc.c   |  2 +-
>   drivers/s390/scsi/zfcp_fsf.c  | 14 +++++++++-----
>   drivers/s390/scsi/zfcp_qdio.c |  3 +--
>   5 files changed, 22 insertions(+), 16 deletions(-)
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
