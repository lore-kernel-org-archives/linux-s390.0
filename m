Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:55354 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXRw3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Feb 2020 12:52:29 -0500
Subject: Re: [PATCH] zfcp: fix wrong data and display format of SFP+ temperature
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <d6e3be5428da5c9490cfff4df7cae868bc9f1a7e.1582039501.git.bblock@linux.ibm.com>
Date: Mon, 24 Feb 2020 12:52:22 -0500
In-Reply-To: <d6e3be5428da5c9490cfff4df7cae868bc9f1a7e.1582039501.git.bblock@linux.ibm.com>
        (Benjamin Block's message of "Wed, 19 Feb 2020 16:09:25 +0100")
Message-ID: <yq14kvfhnzd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org


Benjamin,

> When implementing support for retrieval of local diagnostic data from
> the FCP channel, the wrong data format was assumed for the temperature
> of the local SFP+ connector. The Fibre Channel Link Services (FC-LS-3)
> specification is not clear on the format of the stored integer, and
> only after consulting the SNIA specification SFF-8472 did we realize
> it is stored as two's complement. Thus, the used data and display
> format is wrong, and highly misleading for users when the temperature
> should drop below 0=C2=B0C (however unlikely that may be).

Applied to 5.6/scsi-fixes, thanks!

--=20
Martin K. Petersen	Oracle Linux Engineering
