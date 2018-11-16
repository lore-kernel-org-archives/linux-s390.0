From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:03:30 +0000
Subject: Re: [PATCH 03/23] zfcp: move SG table helper from aux to fc and make them static
Message-Id: <e69097fc-555a-96b0-2ca4-42888d24fee5@suse.de>
In-Reply-To: <20181108144458.29012-4-maier@linux.ibm.com>
References: <20181108144458.29012-4-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> Since commit 663e0890e31c ("[SCSI] zfcp: remove access control tables
> interface") these helper functions are only used for auto port scan in
> zfcp_fc.c. Also change them to the corresponding namespace prefix.
> 
> This is a small cleanup for the miscellaneous catchall compile unit
> zfcp_aux.c.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_aux.c | 44 +-----------------------------------------
>   drivers/s390/scsi/zfcp_fc.c  | 46 ++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 45 insertions(+), 45 deletions(-)
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
