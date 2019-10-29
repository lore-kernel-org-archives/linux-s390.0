Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:40484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfJ2CQx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 22:16:53 -0400
Subject: Re: [PATCH v2 00/11] zfcp: retrieve local RDP data, fix and cleanup
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1571934247.git.bblock@linux.ibm.com>
Date: Mon, 28 Oct 2019 22:16:44 -0400
In-Reply-To: <cover.1571934247.git.bblock@linux.ibm.com> (Benjamin Block's
        message of "Fri, 25 Oct 2019 18:12:42 +0200")
Message-ID: <yq18sp48feb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org


Benjamin,

> this is the second version of my RDP patchset for zfcp, after I
> noticed a memory-leak in the first version earlier this year. Here is
> the original description, which remains valid:

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
