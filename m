Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727773AbgBFRD4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Feb 2020 12:03:56 -0500
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio-ccw: Use the correct style for SPDX License Identifier
Date: Thu,  6 Feb 2020 18:03:31 +0100
Message-Id: <20200206170331.1032-2-cohuck@redhat.com>
In-Reply-To: <20200206170331.1032-1-cohuck@redhat.com>
References: <20200206170331.1032-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, Cornelia Huck <cohuck@redhat.com>

From: Nishad Kamdar <nishadkamdar@gmail.com>

This patch corrects the SPDX License Identifier style in
header file related to S/390 common i/o drivers.
It assigns explicit block comment to the SPDX License
Identifier.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Fixes: 3cd90214b70f ("vfio: ccw: add tracepoints for interesting error pa=
ths")
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Message-Id: <20191225122054.GA4598@nishad>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_cc=
w_trace.h
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
--=20
2.21.1
