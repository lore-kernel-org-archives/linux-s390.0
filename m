Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729707AbfGQJoJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 05:44:09 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 6/6] Documentation: fix vfio-ccw doc
Date: Wed, 17 Jul 2019 11:43:50 +0200
Message-Id: <20190717094350.13620-7-cohuck@redhat.com>
In-Reply-To: <20190717094350.13620-1-cohuck@redhat.com>
References: <20190717094350.13620-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

*Really* mark the literal block as such.

Fixes: 127e62174041 ("vfio-ccw: Update documentation for csch/hsch")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/s390/vfio-ccw.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index be2af10e12b4..3fe918f0c80d 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -218,14 +218,14 @@ vfio-ccw cmd region
 -------------------
 
 The vfio-ccw cmd region is used to accept asynchronous instructions
-from userspace.
-
-#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
-#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
-struct ccw_cmd_region {
-       __u32 command;
-       __u32 ret_code;
-} __packed;
+from userspace::
+
+  #define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+  #define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+  struct ccw_cmd_region {
+         __u32 command;
+         __u32 ret_code;
+  } __packed;
 
 This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
 
-- 
2.20.1
