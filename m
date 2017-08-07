From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC 6/9] scsi: fc: start decoupling fc_block_scsi_eh from scsi_cmnd
Date: Mon, 07 Aug 2017 13:08:37 -0400
Message-ID: <yq1bmnrb90q.fsf@oracle.com>
References: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
        <20170725141427.35258-7-maier@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20170725141427.35258-7-maier@linux.vnet.ibm.com> (Steffen
        Maier's message of "Tue, 25 Jul 2017 16:14:24 +0200")
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


Steffen,

> Scsi_cmnd is an unsuitable argument for eh_device_reset_handler(),
> eh_target_reset_handler(), and eh_host_reset_handler() which do not
> have the scope of one single SCSI command.  These callbacks tend to
> use fc_block_scsi_eh() requiring scsi_cmnd.  In order to start
> decoupling above eh callbacks from scsi_cmnd, introduce a new variant
> of the function called fc_block_rport() taking an fc_rport as
> argument.  Refactor the old fc_block_scsi_eh() to simply delegate to
> fc_block_rport().

Applied to 4.14/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
