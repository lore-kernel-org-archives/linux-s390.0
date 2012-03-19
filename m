Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Chen, Dennis (SRDC SW)" <Dennis1.Chen@amd.com>
Subject: RE: [PATCH]s390/char/vmur.c: memory leak Fix in the driver
Date: Mon, 19 Mar 2012 01:55:40 +0000
Message-ID: <491D6B4EAD0A714894D8AD22F4BDE04304FF5A@SCYBEXDAG04.amd.com>
References: <491D6B4EAD0A714894D8AD22F4BDE0430495F2@SCYBEXDAG04.amd.com>
In-Reply-To: <491D6B4EAD0A714894D8AD22F4BDE0430495F2@SCYBEXDAG04.amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "beattiem@uk.ibm.com" <beattiem@uk.ibm.com>, "holzheu@de.ibm.com" <holzheu@de.ibm.com>, "munzert@de.ibm.com" <munzert@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "Chen, Dennis (SRDC SW)" <Dennis1.Chen@amd.com>
List-ID: <linux-s390.vger.kernel.org>

CC'ing maintainer: Martin Schwidefsky &  Heiko Carstens...

-----Original Message-----
From: Chen, Dennis (SRDC SW) 
Sent: Sunday, March 18, 2012 3:41 AM
To: linux-kernel@vger.kernel.org
Cc: beattiem@uk.ibm.com; holzheu@de.ibm.com; munzert@de.ibm.com; linux390@de.ibm.com; linux-s390@vger.kernel.org; Chen, Dennis (SRDC SW)
Subject: [PATCH]s390/char/vmur.c: memory leak Fix in the driver

This patch is used to fix a memory leak issue in s390/char/vmur.c: a character device instance is 
allocated by cdev_alloc, the cdev_del will not free that space if cdev_init is applied before. 

Signed-off-by: dennis1.chen@amd.com
--- a/s390/char/vmur.c  2012-03-18 02:50:47.950963949 +0800
+++ b/s390/char/vmur.c  2012-03-18 03:12:04.790936740 +0800
@@ -903,7 +903,7 @@ static int ur_set_online(struct ccw_devi
                goto fail_urdev_put;
        }

-       cdev_init(urd->char_device, &ur_fops);
+       urd->char_device->ops = &ur_fops;
        urd->char_device->dev = MKDEV(major, minor);
        urd->char_device->owner = ur_fops.owner;
