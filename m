Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389432AbfJ2Ohi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 10:37:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TEYHxA056041
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 10:37:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxptv1m27-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 10:37:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 29 Oct 2019 14:37:34 -0000
Date: Tue, 29 Oct 2019 15:37:26 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] zfcp: retrieve local RDP data, fix and cleanup
References: <cover.1571934247.git.bblock@linux.ibm.com>
 <yq18sp48feb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <yq18sp48feb.fsf@oracle.com>
Message-Id: <20191029143726.GA25907@t480-pf1aa2c2>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

On Mon, Oct 28, 2019 at 10:16:44PM -0400, Martin K. Petersen wrote:
>=20
> Benjamin,
>=20
> > this is the second version of my RDP patchset for zfcp, after I
> > noticed a memory-leak in the first version earlier this year. Here is
> > the original description, which remains valid:
>=20
> Applied to 5.5/scsi-queue, thanks!
>=20

Thanks, Martin.

--=20
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Develop=
ment
IBM Systems & Technology Group   /  IBM Deutschland Research & Development =
GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
