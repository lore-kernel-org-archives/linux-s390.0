From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:09:08 +0000
Subject: Re: [PATCH 07/23] zfcp: namespace prefix for internal latency data structures
Message-Id: <405fa22c-1af6-713f-82c2-9d9f527abc7a@suse.de>
In-Reply-To: <20181108144458.29012-8-maier@linux.ibm.com>
References: <20181108144458.29012-8-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> In contrast to struct fsf_qual_latency_info, the ones here are not FSF
> but software defined zfcp-internal.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_def.h | 14 +++++++-------
>   drivers/s390/scsi/zfcp_fsf.c |  4 ++--
>   2 files changed, 9 insertions(+), 9 deletions(-)
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
