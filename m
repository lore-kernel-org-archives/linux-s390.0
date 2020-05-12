Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbgELJ2A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 May 2020 05:28:00 -0400
Date: Tue, 12 May 2020 11:27:51 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH 0/8] zfcp: fix DIF/DIX support with scsi-mq host-wide
 tag-set
Message-ID: <20200512092751.GF129511@t480-pf1aa2c2>
References: <cover.1588956679.git.bblock@linux.ibm.com>
 <158925392374.17325.3358760553480361613.b4-ty@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <158925392374.17325.3358760553480361613.b4-ty@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, linux-s390@vger.kernel.org, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

On Mon, May 11, 2020 at 11:28:26PM -0400, Martin K. Petersen wrote:
> On Fri, 8 May 2020 19:23:27 +0200, Benjamin Block wrote:
>=20
> > some time ago we noticed - Fedor did - that our DIV and DIX support in
> > zfcp broke at some point. I tracked that down to a commit made for v5.4
> > (737eb78e82d5), but we didn't notice it back than, because our CI
> > doesn't currently run with either DIV, nor DIX enabled (time allowing
> > this is something we want to improve so we catch stuff like this
> > earlier). It also turned out that the commit in v5.4 was not really the
> > root-cause, and was only making the problem visible more easy.
> >=20
> > [...]
>=20
> Applied to 5.8/scsi-queue, thanks!
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
