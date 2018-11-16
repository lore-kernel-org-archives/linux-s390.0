From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:03:03 +0000
Subject: Re: [PATCH 02/22] zfcp: remove unnecessary null pointer check before mempool_destroy
Message-Id: <cbe58632-63a8-5579-5fb9-36b53e65ca7b@suse.de>
In-Reply-To: <20181108144458.29012-3-maier@linux.ibm.com>
References: <20181108144458.29012-3-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> From: zhong jiang <zhongjiang@huawei.com>
> 
> mempool_destroy has taken null pointer check into account. so remove the
> redundant check.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Acked-by: Benjamin Block <bblock@linux.ibm.com>
> [maier@linux.ibm.com: depends on v4.3 4e3ca3e033d1 ("mm/mempool: allow NULL `pool' pointer in mempool_destroy()")]
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
>   1 file changed, 7 insertions(+), 14 deletions(-)
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
