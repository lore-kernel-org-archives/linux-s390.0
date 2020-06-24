Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgFXE3x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 00:29:53 -0400
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] zfcp: fix panic on ERP timeout for previously dismissed ERP action
Date: Wed, 24 Jun 2020 00:29:40 -0400
Message-Id: <159297296072.9797.12946914828075340057.b4-ty@oracle.com>
In-Reply-To: <20200623140242.98864-1-maier@linux.ibm.com>
References: <20200623140242.98864-1-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steffen Maier <maier@linux.ibm.com>, "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org, stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>

On Tue, 23 Jun 2020 16:02:42 +0200, Steffen Maier wrote:

> Suppose that, for unrelated reasons, FSF requests on behalf of recovery
> are very slow and can run into the ERP timeout.
> 
> In the case at hand, we did adapter recovery to a large degree.
> However due to the slowness a LUN open is pending
> so the corresponding fc_rport remains blocked.
> After fast_io_fail_tmo we trigger close physical port recovery
> for the port under which the LUN should have been opened.
> The new higher order port recovery
> dismisses the pending LUN open ERP action and
> dismisses the pending LUN open FSF request.
> Such dismissal decouples the ERP action from the pending corresponding
> FSF request by setting zfcp_fsf_req->erp_action to NULL
> (among other things) [zfcp_erp_strategy_check_fsfreq()].
> 
> [...]

Applied to 5.8/scsi-fixes, thanks!

[1/1] scsi: zfcp: Fix panic on ERP timeout for previously dismissed ERP action
      https://git.kernel.org/mkp/scsi/c/936e6b85da04

-- 
Martin K. Petersen	Oracle Linux Engineering
