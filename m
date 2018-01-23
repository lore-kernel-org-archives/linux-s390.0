Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/3] s390/docs: reword airq section
Date: Tue, 23 Jan 2018 16:02:44 +0100
Message-Id: <20180123150245.30312-3-cohuck@redhat.com>
In-Reply-To: <20180123150245.30312-1-cohuck@redhat.com>
References: <20180123150245.30312-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: corbet@lwn.net, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Also mention the iv helpers as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/driver-api/s390-drivers.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/s390-drivers.rst b/Documentation/driver-api/s390-drivers.rst
index 42350f21357d..30e6aa7e160b 100644
--- a/Documentation/driver-api/s390-drivers.rst
+++ b/Documentation/driver-api/s390-drivers.rst
@@ -121,10 +121,15 @@ ccw group devices
 Generic interfaces
 ==================
 
-Some interfaces are available to other drivers that do not necessarily
-have anything to do with the busses described above, but still are
-indirectly using basic infrastructure in the common I/O layer. One
-example is the support for adapter interrupts.
+The following section contains interfaces in use not only by drivers
+dealing with ccw devices, but drivers for various other s390 hardware
+as well.
+
+Adapter interrupts
+------------------
+
+The common I/O layer provides helper functions for dealing with adapter
+interrupts and interrupt vectors.
 
 .. kernel-doc:: drivers/s390/cio/airq.c
    :export:
-- 
2.13.6
