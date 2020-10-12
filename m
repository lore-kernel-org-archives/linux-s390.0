Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391168AbgJLTGr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Oct 2020 15:06:47 -0400
Date: Mon, 12 Oct 2020 21:06:37 +0200
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
Message-ID: <20201012183550.GA12341@imap.linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi Jens,

quick ping. Are you going to apply this for 5.10?

Best regards,
Stefan

Stefan Haberland <sth@linux.ibm.com> schrieb am Thu, 08. Oct 15:13:
> Hi Jens,
>=20
> please apply the following patches that add a new DASD feature to show
> fibre channel endpoint security.
>=20
> The patches apply on you for-next branch and are intended for 5.10.
>=20
> The s390/cio patches should also go upstream through your tree this time
> since they are required for the DASD patches to build.
>=20
> Best regards,
> Stefan
>=20
> v1->v2:
>  - fix memleak in "s390/dasd: Fix operational path inconsistency"
>  - add comment suggested by Cornelia Huck
>=20
> Jan H=F6ppner (7):
>   s390/dasd: Remove unused parameter from dasd_generic_probe()
>   s390/dasd: Move duplicate code to separate function
>   s390/dasd: Store path configuration data during path handling
>   s390/dasd: Fix operational path inconsistency
>   s390/dasd: Display FC Endpoint Security information via sysfs
>   s390/dasd: Prepare for additional path event handling
>   s390/dasd: Process FCES path event notification
>=20
> Sebastian Ott (1):
>   s390/cio: Export information about Endpoint-Security Capability
>=20
> Vineeth Vijayan (2):
>   s390/cio: Provide Endpoint-Security Mode per CU
>   s390/cio: Add support for FCES status notification
>=20
>  arch/s390/include/asm/ccwdev.h   |   2 +
>  arch/s390/include/asm/cio.h      |   1 +
>  drivers/s390/block/dasd.c        |  22 ++--
>  drivers/s390/block/dasd_devmap.c | 109 +++++++++++++++++++
>  drivers/s390/block/dasd_eckd.c   | 175 +++++++++++++++++++++----------
>  drivers/s390/block/dasd_fba.c    |   2 +-
>  drivers/s390/block/dasd_int.h    | 111 +++++++++++++++++++-
>  drivers/s390/cio/chp.c           |  15 +++
>  drivers/s390/cio/chp.h           |   1 +
>  drivers/s390/cio/chsc.c          | 145 +++++++++++++++++++++++--
>  drivers/s390/cio/chsc.h          |   3 +-
>  drivers/s390/cio/device.c        |  15 ++-
>  12 files changed, 523 insertions(+), 78 deletions(-)
>=20
> --=20
> 2.17.1
>=20
