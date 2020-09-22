Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64822 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbgIVKFm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 06:05:42 -0400
Date: Tue, 22 Sep 2020 12:05:31 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH 0/2] zfcp: small changes for 5.10
Message-ID: <20200922100531.GA6903@t480-pf1aa2c2>
References: <cover.1599765652.git.bblock@linux.ibm.com>
 <160074695008.411.13328105917017372358.b4-ty@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <160074695008.411.13328105917017372358.b4-ty@oracle.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Mon, Sep 21, 2020 at 11:56:45PM -0400, Martin K. Petersen wrote:
> On Thu, 10 Sep 2020 21:49:14 +0200, Benjamin Block wrote:
>=20
> > here are some small changes for zfcp I'd like to include in 5.10 if
> > possible. They apply cleanly on Martin's `scsi-queue`, and James' `misc`
> > branches.
> >=20
> > Both patches make the driver a bit cleaner, and hopefully easier to
> > maintain.
> >=20
> > [...]
>=20
> Applied to 5.10/scsi-queue, thanks!
>=20
> [1/2] scsi: zfcp: Use list_first_entry_or_null() in zfcp_erp_thread()
>       https://git.kernel.org/mkp/scsi/c/addf13729615
> [2/2] scsi: zfcp: Clarify access to erp_action in zfcp_fsf_req_complete()
>       https://git.kernel.org/mkp/scsi/c/d251193d1732
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
