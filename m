Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:41218 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbgDACYr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Mar 2020 22:24:47 -0400
Subject: Re: [PATCH] zfcp: use fallthrough;
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <d14669a67a17392490d3184117941123765db1a4.1585663010.git.bblock@linux.ibm.com>
Date: Tue, 31 Mar 2020 22:24:38 -0400
In-Reply-To: <d14669a67a17392490d3184117941123765db1a4.1585663010.git.bblock@linux.ibm.com>
        (Benjamin Block's message of "Tue, 31 Mar 2020 16:21:48 +0200")
Message-ID: <yq1r1x854ex.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Joe Perches <joe@perches.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>


Benjamin,

> Heiko C. applied the other changes from this series to the other parts
> of the s390x architecture, so we would like to have them for zfcp as
> well.
>
> I ran them through our regression suite with error-recovery and I/O,
> all looks well for us.

Applied to 5.7/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
