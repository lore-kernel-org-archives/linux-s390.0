From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:12:28 +0000
Subject: Re: [PATCH 11/23] zfcp: drop duplicate seq_no from zfcp_fsf_req which is also in QTCB header
Message-Id: <2a820a41-a3bc-2c92-5e9d-c70246daa82a@suse.de>
In-Reply-To: <20181108144458.29012-12-maier@linux.ibm.com>
References: <20181108144458.29012-12-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> There is no point for double bookkeeping especially just for tracing.
> The trace can take it from the QTCB which always exists for non-SRB
> responses traced with zfcp_dbf_hba_fsf_res().
> 
> As a side effect, this removes an alignment hole and reduces the
> size of struct zfcp_fsf_req, and thus of each pending request, by
> 8 bytes.
> Before:
> $ pahole -C zfcp_fsf_req drivers/s390/scsi/zfcp.ko
> ...
> 	struct fsf_qtcb *          qtcb;                 /*   144     8 */
> 	u32                        seq_no;               /*   152     4 */
> 	/* XXX 4 bytes hole, try to pack */
> 	void *                     data;                 /*   160     8 */
> ...
> 	/* size: 296, cachelines: 2, members: 14 */
> 	/* sum members: 288, holes: 2, sum holes: 8 */
> 	/* last cacheline: 40 bytes */
> After:
> $ pahole -C zfcp_fsf_req drivers/s390/scsi/zfcp.ko
> ...
> 	struct fsf_qtcb *          qtcb;                 /*   144     8 */
> 	void *                     data;                 /*   152     8 */
> ...
> 	/* size: 288, cachelines: 2, members: 13 */
>          /* sum members: 284, holes: 1, sum holes: 4 */
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_dbf.c | 2 +-
>   drivers/s390/scsi/zfcp_def.h | 2 --
>   drivers/s390/scsi/zfcp_fsf.c | 1 -
>   3 files changed, 1 insertion(+), 4 deletions(-)
> 
Makes one wonder what we need the sequence number for ...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
