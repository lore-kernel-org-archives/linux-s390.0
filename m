Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbgFDLUy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 07:20:54 -0400
Date: Thu, 4 Jun 2020 13:20:45 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] vfio-ccw: make vfio_ccw_regops variables declarations static
Message-ID: <patch.git-a34be7aede18.your-ad-here.call-01591269421-ext-5655@work.hours>
References: <20200603112716.332801-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603112716.332801-1-cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

Fixes the following sparse warnings:
drivers/s390/cio/vfio_ccw_chp.c:62:30: warning: symbol 'vfio_ccw_schib_region_ops' was not declared. Should it be static?
drivers/s390/cio/vfio_ccw_chp.c:117:30: warning: symbol 'vfio_ccw_crw_region_ops' was not declared. Should it be static?

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 876f6ade51cc..a646fc81c872 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -59,7 +59,7 @@ static void vfio_ccw_schib_region_release(struct vfio_ccw_private *private,
 
 }
 
-const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
+static const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
 	.read = vfio_ccw_schib_region_read,
 	.write = vfio_ccw_schib_region_write,
 	.release = vfio_ccw_schib_region_release,
@@ -131,7 +131,7 @@ static void vfio_ccw_crw_region_release(struct vfio_ccw_private *private,
 
 }
 
-const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
+static const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
 	.read = vfio_ccw_crw_region_read,
 	.write = vfio_ccw_crw_region_write,
 	.release = vfio_ccw_crw_region_release,
-- 
2.21.0
