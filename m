Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbfGLNRB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 09:17:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CDC23D100663
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:17:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tptns0ub5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 09:16:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 12 Jul 2019 14:16:57 +0100
Date: Fri, 12 Jul 2019 15:16:52 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH 0/3] zfcp: fixes for the zFCP device driver
References: <cover.1562098940.git.bblock@linux.ibm.com>
 <yq1pnmg6ozj.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <yq1pnmg6ozj.fsf@oracle.com>
Message-Id: <20190712131652.GC27203@t480-pf1aa2c2.w3ibm.bluemix.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, Jul 11, 2019 at 09:06:08PM -0400, Martin K. Petersen wrote:
>=20
> Benjamin,
>=20
> > So please consider them for the next cycle. Or should I not have send
> > them in that case? Sorry, this step of the process was a bit unclear
> > to me.
>=20
> A fix is a fix. Applied the series to 5.3/scsi-fixes. Thanks!
>=20

Thanks Martin.

--=20
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Develop=
ment
IBM Systems & Technology Group   /  IBM Deutschland Research & Development =
GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
