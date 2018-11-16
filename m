From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:15:35 +0000
Subject: Re: [PATCH 14/23] zfcp: clarify function argument name for trace tag string
Message-Id: <31c9e6e7-859a-84c5-b12e-5649848efbef@suse.de>
In-Reply-To: <20181108144458.29012-15-maier@linux.ibm.com>
References: <20181108144458.29012-15-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> v2.6.30 commit 5ffd51a5e495 ("[SCSI] zfcp: replace current ERP logging
> with a more convenient version") changed trace record distinguishing from a
> numerical ID to a 7 character string called "trace tag". While starting to
> use function arguments with different type and semantics, it did not change
> the argument name accordingly.
> 
> v2.6.38 commit ae0904f60fab ("[SCSI] zfcp: Redesign of the debug tracing
> for recovery actions.") renamed variable names "id" into "tag" but only
> within zfcp_dbf.*, not within zfcp_erp.c.
> 
> This was a bit confusing since the remainder of zfcp does use the term
> "trace tag". Also "id" is quite generic and it's not obvious for what.
> Just unify it consistently and use the "dbf" prefix to relate the arguments
> to the code in zfcp_dbf.*.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_erp.c  | 92 ++++++++++++++++++++++---------------------
>   drivers/s390/scsi/zfcp_ext.h  |  8 ++--
>   drivers/s390/scsi/zfcp_qdio.c |  8 ++--
>   3 files changed, 57 insertions(+), 51 deletions(-)
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
