Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45643 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLYMVH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Dec 2019 07:21:07 -0500
Date: Wed, 25 Dec 2019 17:50:58 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH] vfio-ccw: Use the correct style for SPDX License Identifier
Message-ID: <20191225122054.GA4598@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to S/390 common i/o drivers.
It assigns explicit block comment to the SPDX License
Identifier.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/s390/cio/vfio_ccw_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index 30162a318a8a..f5d31887d413 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Tracepoints for vfio_ccw driver
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Tracepoints for vfio_ccw driver
  *
  * Copyright IBM Corp. 2018
  *
-- 
2.17.1
