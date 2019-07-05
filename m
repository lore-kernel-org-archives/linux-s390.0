Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727510AbfGEI7K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jul 2019 04:59:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x658vPK9005862
        for <linux-s390@vger.kernel.org>; Fri, 5 Jul 2019 04:59:08 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tj2bnad59-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 05 Jul 2019 04:59:08 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 5 Jul 2019 09:59:06 +0100
Subject: Re: linux-next: Tree for Jul 4 -> conflict between s390 and
 driver-core tree
References: <20190704220945.27728dd9@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 5 Jul 2019 10:59:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190704220945.27728dd9@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Message-Id: <e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>

Linus, Vasily, for your attention in the next merge window. (I would sugges=
t to apply
belows fixup during the merge of whatever tree is merged 2nd).


There is now a build conflict between the s390/features branch and the driv=
er-core/driver-core-next
especially between

commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with cla=
ss_find_device()")
and
commit ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")




----------- snip---------------------------
drivers/s390/crypto/vfio_ap_ops.c: In function =EF=BF=BDvfio_ap_get_queue=
=EF=BF=BD:
drivers/s390/crypto/vfio_ap_ops.c:60:13: error: passing argument 4 of =EF=
=BF=BDdriver_find_device=EF=BF=BD from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
   60 |      &apqn, match_apqn);
      |             ^~~~~~~~~~
      |             |
      |             int (*)(struct device *, void *)
In file included from ./include/linux/iommu.h:11,
                 from ./include/linux/vfio.h:12,
                 from drivers/s390/crypto/vfio_ap_ops.c:12:
./include/linux/device.h:341:16: note: expected =EF=BF=BDint (*)(struct dev=
ice *, const void *)=EF=BF=BD but argument is of type =EF=BF=BDint (*)(stru=
ct device *, void *)=EF=BF=BD
  341 | struct device *driver_find_device(struct device_driver *drv,
      |                ^~~~~~~~~~~~~~~~~~
drivers/s390/crypto/vfio_ap_ops.c: In function =EF=BF=BDvfio_ap_irq_disable=
_apqn=EF=BF=BD:
drivers/s390/crypto/vfio_ap_ops.c:1124:13: error: passing argument 4 of =EF=
=BF=BDdriver_find_device=EF=BF=BD from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
 1124 |      &apqn, match_apqn);
      |             ^~~~~~~~~~
      |             |
      |             int (*)(struct device *, void *)
In file included from ./include/linux/iommu.h:11,
                 from ./include/linux/vfio.h:12,
                 from drivers/s390/crypto/vfio_ap_ops.c:12:
./include/linux/device.h:341:16: note: expected =EF=BF=BDint (*)(struct dev=
ice *, const void *)=EF=BF=BD but argument is of type =EF=BF=BDint (*)(stru=
ct device *, void *)=EF=BF=BD
  341 | struct device *driver_find_device(struct device_driver *drv,
      |                ^~~~~~~~~~~~~~~~~~
----------- snip---------------------------


The fix is straighforward but it cannot be added to any of the branches as =
it is
only necessary (and right) when both branches are merged together.

Stephen, can you maybe add something like this to make linux-next build aga=
in
on s390?




diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_a=
p_ops.c
index 2c9fb1423a39..7e85ba7c6ef0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -26,7 +26,7 @@
=20
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
=20
-static int match_apqn(struct device *dev, void *data)
+static int match_apqn(struct device *dev, const void *data)
 {
 	struct vfio_ap_queue *q =3D dev_get_drvdata(dev);
=20
