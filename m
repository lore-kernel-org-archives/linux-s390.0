Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:36870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGHGJN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 02:09:13 -0400
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/7] zfcp: cleanups and small changes for 5.9
Date: Wed,  8 Jul 2020 02:06:45 -0400
Message-Id: <159418828149.5152.2055440250302680177.b4-ty@oracle.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Benjamin Block <bblock@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, George Spelvin <lkml@sdf.org>

On Fri, 3 Jul 2020 15:19:56 +0200, Benjamin Block wrote:

> here are some cleanups and small changes for zfcp I'd like to include in
> 5.9 if possible.
> 
> One of the changes touches documentation in `Documentation/scsi/`, so I
> put Jonathan on To, hope that was correct. I hope you can still pull
> this all in one go to minimize work. IBM did retire some old URLs and
> content from our public website, so we have to clean that up in the
> documentation so there are not dead links. I changed these in the hopes
> we can minimize documentation churn going forward, just to replace URLs.
> 
> [...]

Applied to 5.9/scsi-queue, thanks!

[1/7] scsi: zfcp: Use prandom_u32_max() for backoff
      https://git.kernel.org/mkp/scsi/c/0cd0e57ec858
[2/7] scsi: zfcp: Fix an outdated comment for zfcp_qdio_send()
      https://git.kernel.org/mkp/scsi/c/459ad085d87b
[3/7] scsi: docs: Update outdated link to IBM developerworks
      https://git.kernel.org/mkp/scsi/c/b9789bfbfe9d
[4/7] scsi: docs: Remove invalid link and update text for zfcp kernel config
      https://git.kernel.org/mkp/scsi/c/c06de6e28c9e
[5/7] scsi: zfcp: Clean up zfcp_erp_action_ready()
      https://git.kernel.org/mkp/scsi/c/b43cdb5ac856
[6/7] scsi: zfcp: Replace open-coded list move
      https://git.kernel.org/mkp/scsi/c/6bcb7c171a0c
[7/7] scsi: zfcp: Avoid benign overflow of the Request Queue's free-level
      https://git.kernel.org/mkp/scsi/c/c3bfffa5ec69

-- 
Martin K. Petersen	Oracle Linux Engineering
