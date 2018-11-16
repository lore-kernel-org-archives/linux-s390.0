From: Hannes Reinecke <hare@suse.de>
Date: Fri, 16 Nov 2018 11:20:39 +0000
Subject: Re: [PATCH 20/23] zfcp: silence remaining kdoc warnings in header files
Message-Id: <3a7dd358-f5c6-c081-4434-684dce3bed83@suse.de>
In-Reply-To: <20181108144458.29012-21-maier@linux.ibm.com>
References: <20181108144458.29012-21-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/8/18 3:44 PM, Steffen Maier wrote:
> Improve whatever the following simple invocation reported:
> $ ./scripts/kernel-doc -none drivers/s390/scsi/*.h
> 
> While at it, improve some related kdoc,
> including struct zfcp_fsf_ct_els in zfcp_fsf.h.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>   drivers/s390/scsi/zfcp_dbf.h     | 10 +++++++++-
>   drivers/s390/scsi/zfcp_fc.h      | 21 ++++++++++++++++++---
>   drivers/s390/scsi/zfcp_fsf.h     |  4 ++--
>   drivers/s390/scsi/zfcp_qdio.h    |  9 +++++++--
>   drivers/s390/scsi/zfcp_reqlist.h |  2 +-
>   5 files changed, 37 insertions(+), 9 deletions(-)
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
