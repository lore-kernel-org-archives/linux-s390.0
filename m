From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:16:17 +0000
Subject: Re: [PATCH 15/23] zfcp: the action field of zfcp_erp_action is actually the type
Message-Id: <5c602fbe-1d46-b447-3f37-5ecf3e6800ab@suse.de>
In-Reply-To: <20181108144458.29012-16-maier@linux.ibm.com>
References: <20181108144458.29012-16-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> &zfcp_erp_action.action ==> &zfcp_erp_action.type
> 
> While at it, make use of the already defined enum for this purpose
> to get at least some build checking (even though an enum is type equivalent
> to an int in C). v2.6.27 commit 287ac01acf22 ("[SCSI] zfcp: Cleanup code
> in zfcp_erp.c") introduced the enum which was cpp defines previously.
> 
> To prevent compiler warnings with the switch(act->type), we have to
> separate the recently added eyecatchers from enum zfcp_erp_act_type.
> 
> Since struct zfcp_erp_action type is embedded into other structures
> living in zfcp_def.h, we have to move enum zfcp_erp_act_type from
> its private definition in zfcp_erp.c to the zfcp-global zfcp_def.h.
> 
> Silence one false -Wswitch compiler warning case: LUNs as the leaves in our
> object tree do not have any follow-up success recovery.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_dbf.c |  2 +-
>   drivers/s390/scsi/zfcp_def.h | 20 +++++++++++-
>   drivers/s390/scsi/zfcp_erp.c | 77 +++++++++++++++++++++-----------------------
>   3 files changed, 56 insertions(+), 43 deletions(-)
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
