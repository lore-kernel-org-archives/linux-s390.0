Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:35164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgHRDOr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 23:14:47 -0400
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] zfcp: fix use-after-free in request timeout handlers
Date: Mon, 17 Aug 2020 23:12:28 -0400
Message-Id: <159772029326.19587.11457042799649167803.b4-ty@oracle.com>
In-Reply-To: <20200813152856.50088-1-maier@linux.ibm.com>
References: <20200813152856.50088-1-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 13 Aug 2020 17:28:56 +0200, Steffen Maier wrote:

> Before v4.15 commit 75492a51568b ("s390/scsi: Convert timers to use
> timer_setup()"), we intentionally only passed zfcp_adapter as context
> argument to zfcp_fsf_request_timeout_handler(). Since we only trigger
> adapter recovery, it was unnecessary to sync against races between timeout
> and (late) completion.
> Likewise, we only passed zfcp_erp_action as context argument to
> zfcp_erp_timeout_handler(). Since we only wakeup an ERP action, it was
> unnecessary to sync against races between timeout and (late) completion.
> 
> [...]

Applied to 5.9/scsi-fixes, thanks!

[1/1] scsi: zfcp: Fix use-after-free in request timeout handlers
      https://git.kernel.org/mkp/scsi/c/2d9a2c5f581b

-- 
Martin K. Petersen	Oracle Linux Engineering
