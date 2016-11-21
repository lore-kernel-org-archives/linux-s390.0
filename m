From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v4 02/15] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
Date: Mon, 21 Nov 2016 11:14:18 -0800
Message-ID: <ab8ba289-f102-dee1-9c04-44849f867c12@linux.vnet.ibm.com>
References: <cover.1479374719.git.jthumshirn@suse.de>
 <70cda0c20ecedf82323ff96e62ed6250a4cb575d.1479374719.git.jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <70cda0c20ecedf82323ff96e62ed6250a4cb575d.1479374719.git.jthumshirn@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>, James Bottomley <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>, Dick Kennedy <dick.kennedy@avagotech.com>, Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>, Anil Gurumurthy <anil.gurumurthy@qlogic.com>, "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, "open list:FCOE SUBSYSTEM libfc, libfcoe, fcoe" <fcoe-devel@open-fcoe.org>, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, James Smart <james.smart@avagotech.com>, Paul Mackerras <paulus@samba.org>, Hannes Reinecke <hare@suse.de>, Steffen Maier <maier@linux.vnet.ibm.com>, Johannes Thumshirn <jth@kernel.>
List-ID: <linux-s390.vger.kernel.org>

On 11/17/2016 07:09 AM, Johannes Thumshirn wrote:
> Don't use fc_bsg_job::request and fc_bsg_job::reply directly, but use
> helper variables bsg_request and bsg_reply. This will be helpfull  when
> transitioning to bsg-lib.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/s390/scsi/zfcp_fc.c      |   9 +-
>  drivers/scsi/bfa/bfad_bsg.c      |  40 +++---
>  drivers/scsi/ibmvscsi/ibmvfc.c   |  22 ++--
>  drivers/scsi/libfc/fc_lport.c    |  23 ++--
>  drivers/scsi/lpfc/lpfc_bsg.c     | 199 ++++++++++++++++++-----------
>  drivers/scsi/qla2xxx/qla_bsg.c   | 264 ++++++++++++++++++++++-----------------
>  drivers/scsi/qla2xxx/qla_iocb.c  |   5 +-
>  drivers/scsi/qla2xxx/qla_isr.c   |  46 ++++---
>  drivers/scsi/qla2xxx/qla_mr.c    |  10 +-
>  drivers/scsi/scsi_transport_fc.c |  55 ++++----
>  10 files changed, 398 insertions(+), 275 deletions(-)

For ibmvfc portion...

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
