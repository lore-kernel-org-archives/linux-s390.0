Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729299AbgGHNMd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 09:12:33 -0400
Date: Wed, 8 Jul 2020 15:12:19 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH 0/7] zfcp: cleanups and small changes for 5.9
Message-ID: <20200708131219.GA7244@t480-pf1aa2c2>
References: <cover.1593780621.git.bblock@linux.ibm.com>
 <159418828149.5152.2055440250302680177.b4-ty@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <159418828149.5152.2055440250302680177.b4-ty@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, George Spelvin <lkml@sdf.org>

On Wed, Jul 08, 2020 at 02:06:45AM -0400, Martin K. Petersen wrote:
> On Fri, 3 Jul 2020 15:19:56 +0200, Benjamin Block wrote:
>=20
> > here are some cleanups and small changes for zfcp I'd like to include in
> > 5.9 if possible.
> >=20
> > One of the changes touches documentation in `Documentation/scsi/`, so I
> > put Jonathan on To, hope that was correct. I hope you can still pull
> > this all in one go to minimize work. IBM did retire some old URLs and
> > content from our public website, so we have to clean that up in the
> > documentation so there are not dead links. I changed these in the hopes
> > we can minimize documentation churn going forward, just to replace URLs.
> >=20
> > [...]
>=20
> Applied to 5.9/scsi-queue, thanks!
>=20
> [1/7] scsi: zfcp: Use prandom_u32_max() for backoff
>       https://git.kernel.org/mkp/scsi/c/0cd0e57ec858
> [2/7] scsi: zfcp: Fix an outdated comment for zfcp_qdio_send()
>       https://git.kernel.org/mkp/scsi/c/459ad085d87b
> [3/7] scsi: docs: Update outdated link to IBM developerworks
>       https://git.kernel.org/mkp/scsi/c/b9789bfbfe9d
> [4/7] scsi: docs: Remove invalid link and update text for zfcp kernel con=
fig
>       https://git.kernel.org/mkp/scsi/c/c06de6e28c9e
> [5/7] scsi: zfcp: Clean up zfcp_erp_action_ready()
>       https://git.kernel.org/mkp/scsi/c/b43cdb5ac856
> [6/7] scsi: zfcp: Replace open-coded list move
>       https://git.kernel.org/mkp/scsi/c/6bcb7c171a0c
> [7/7] scsi: zfcp: Avoid benign overflow of the Request Queue's free-level
>       https://git.kernel.org/mkp/scsi/c/c3bfffa5ec69
>=20

Thanks Martin!

--=20
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
