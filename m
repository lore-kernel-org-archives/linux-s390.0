From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:11:18 +0000
Subject: Re: [PATCH 10/23] zfcp: drop duplicate fsf_command from zfcp_fsf_req which is also in QTCB header
Message-Id: <d4005aab-d2b3-7eaa-3a3b-926e8b1bd42c@suse.de>
In-Reply-To: <20181108144458.29012-11-maier@linux.ibm.com>
References: <20181108144458.29012-11-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> Status read buffers (SRBs, unsolicited notifications) never use a QTCB
> [zfcp_fsf_req_create()]. zfcp_fsf_req_send() already uses this to
> distinguish SRBs from other FSF request types. We can re-use this method
> in zfcp_fsf_req_complete(). Introduce a helper function to make the check
> for req->qtcb less magic.
> 
> SRBs always are FSF_QTCB_UNSOLICITED_STATUS, so we can hard-code this for
> the two trace functions dealing with SRBs.
> 
> All other FSF request types have a QTCB and we can get the fsf_command
> from there.
> 
> zfcp_dbf_hba_fsf_response() and thus zfcp_dbf_hba_fsf_res() are only called
> for non-SRB requests so it's safe to dereference the QTCB
> [zfcp_fsf_req_complete() returns early on SRB,  else calls
>   zfcp_fsf_protstatus_eval() which calls zfcp_dbf_hba_fsf_response()].
> In zfcp_scsi_forget_cmnd() we guard the QTCB dereference with a preceding
> NULL check and rely on boolean shortcut evaluation.
> 
> As a side effect, this causes an alignment hole which we can close in
> a later patch after having cleaned up all fields of struct zfcp_fsf_req.
> Before:
> $ pahole -C zfcp_fsf_req drivers/s390/scsi/zfcp.ko
> ...
> 	u32                        status;               /*   136     4 */
> 	u32                        fsf_command;          /*   140     4 */
> 	struct fsf_qtcb *          qtcb;                 /*   144     8 */
> ...
> After:
> $ pahole -C zfcp_fsf_req drivers/s390/scsi/zfcp.ko
> ...
> 	u32                        status;               /*   136     4 */
> 	/* XXX 4 bytes hole, try to pack */
> 	struct fsf_qtcb *          qtcb;                 /*   144     8 */
> ...
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_dbf.c  |  8 ++++----
>   drivers/s390/scsi/zfcp_dbf.h  |  4 ++--
>   drivers/s390/scsi/zfcp_def.h  |  7 +++++--
>   drivers/s390/scsi/zfcp_fsf.c  | 14 ++++++--------
>   drivers/s390/scsi/zfcp_scsi.c |  4 +++-
>   5 files changed, 20 insertions(+), 17 deletions(-)
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
