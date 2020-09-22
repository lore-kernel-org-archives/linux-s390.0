Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:36682 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgIVFOO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Sep 2020 01:14:14 -0400
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/2] zfcp: small changes for 5.10
Date: Mon, 21 Sep 2020 23:56:45 -0400
Message-Id: <160074695008.411.13328105917017372358.b4-ty@oracle.com>
In-Reply-To: <cover.1599765652.git.bblock@linux.ibm.com>
References: <cover.1599765652.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Thu, 10 Sep 2020 21:49:14 +0200, Benjamin Block wrote:

> here are some small changes for zfcp I'd like to include in 5.10 if
> possible. They apply cleanly on Martin's `scsi-queue`, and James' `misc`
> branches.
> 
> Both patches make the driver a bit cleaner, and hopefully easier to
> maintain.
> 
> [...]

Applied to 5.10/scsi-queue, thanks!

[1/2] scsi: zfcp: Use list_first_entry_or_null() in zfcp_erp_thread()
      https://git.kernel.org/mkp/scsi/c/addf13729615
[2/2] scsi: zfcp: Clarify access to erp_action in zfcp_fsf_req_complete()
      https://git.kernel.org/mkp/scsi/c/d251193d1732

-- 
Martin K. Petersen	Oracle Linux Engineering
