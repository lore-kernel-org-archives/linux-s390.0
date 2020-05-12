Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:40658 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgELD2o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 May 2020 23:28:44 -0400
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/8] zfcp: fix DIF/DIX support with scsi-mq host-wide tag-set
Date: Mon, 11 May 2020 23:28:26 -0400
Message-Id: <158925392374.17325.3358760553480361613.b4-ty@oracle.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Steffen Maier <maier@linux.ibm.com>, linux-s390@vger.kernel.org, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

On Fri, 8 May 2020 19:23:27 +0200, Benjamin Block wrote:

> some time ago we noticed - Fedor did - that our DIV and DIX support in
> zfcp broke at some point. I tracked that down to a commit made for v5.4
> (737eb78e82d5), but we didn't notice it back than, because our CI
> doesn't currently run with either DIV, nor DIX enabled (time allowing
> this is something we want to improve so we catch stuff like this
> earlier). It also turned out that the commit in v5.4 was not really the
> root-cause, and was only making the problem visible more easy.
> 
> [...]

Applied to 5.8/scsi-queue, thanks!

[1/8] scsi: zfcp: Move shost modification after QDIO (re-)open into fenced function
      https://git.kernel.org/mkp/scsi/c/978857c7e367
[2/8] scsi: zfcp: Move shost updates during xconfig data handling into fenced function
      https://git.kernel.org/mkp/scsi/c/bd1684817d7d
[3/8] scsi: zfcp: Move fc_host updates during xport data handling into fenced function
      https://git.kernel.org/mkp/scsi/c/52e61fde5ec9
[4/8] scsi: zfcp: Fence fc_host updates during link-down handling
      https://git.kernel.org/mkp/scsi/c/990486f3a850
[5/8] scsi: zfcp: Move p-t-p port allocation to after xport data
      https://git.kernel.org/mkp/scsi/c/ac007adc4d2d
[6/8] scsi: zfcp: Fence adapter status propagation for common statuses
      https://git.kernel.org/mkp/scsi/c/971f2abb4ca4
[7/8] scsi: zfcp: Fence early sysfs interfaces for accesses of shost objects
      https://git.kernel.org/mkp/scsi/c/71159b6ecb06
[8/8] scsi: zfcp: Move allocation of the shost object to after xconf- and xport-data
      https://git.kernel.org/mkp/scsi/c/d0dff2ac98dd

-- 
Martin K. Petersen	Oracle Linux Engineering
