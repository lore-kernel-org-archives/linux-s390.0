Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:58826 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKEEVz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Nov 2020 23:21:55 -0500
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/5] zfcp: cleanups, refactorings and features for 5.11
Date: Wed,  4 Nov 2020 23:21:46 -0500
Message-Id: <160455005256.26277.4237038702456087390.b4-ty@oracle.com>
In-Reply-To: <cover.1603908167.git.bblock@linux.ibm.com>
References: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed, 28 Oct 2020 19:30:47 +0100, Benjamin Block wrote:

> here is a series of changes for our zfcp driver for 5.11.
> 
> Other than 2 smaller cleanups and clarifications for maintainability we
> have a refactoring of how zfcp uses s390's qdio layer, and we have a
> small feature improving our handling of out-of-band version changes to our
> adapters (or firmware).
> 
> [...]

Applied to 5.11/scsi-queue, thanks!

[1/5] scsi: zfcp: Lift Input Queue tasklet from qdio
      https://git.kernel.org/mkp/scsi/c/0b524abc2dd1
[2/5] scsi: zfcp: Remove orphaned function declarations
      https://git.kernel.org/mkp/scsi/c/84e7b4169f94
[3/5] scsi: zfcp: Clarify & assert the stat_lock locking in zfcp_qdio_send()
      https://git.kernel.org/mkp/scsi/c/efd321768d2e
[4/5] scsi: zfcp: Process Version Change events
      https://git.kernel.org/mkp/scsi/c/a6c37abe6988
[5/5] scsi: zfcp: Handle event-lost notification for Version Change events
      https://git.kernel.org/mkp/scsi/c/d90196317484

-- 
Martin K. Petersen	Oracle Linux Engineering
