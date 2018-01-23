Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/3] s390/docs: mention subchannel types
Date: Tue, 23 Jan 2018 16:02:43 +0100
Message-Id: <20180123150245.30312-2-cohuck@redhat.com>
In-Reply-To: <20180123150245.30312-1-cohuck@redhat.com>
References: <20180123150245.30312-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: corbet@lwn.net, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Since the original inception of the s390-drivers document, the
common I/O layer has grown support for more types of subchannels.
Give at least a pointer for the various types.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/driver-api/s390-drivers.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/driver-api/s390-drivers.rst b/Documentation/driver-api/s390-drivers.rst
index ecf8851d3565..42350f21357d 100644
--- a/Documentation/driver-api/s390-drivers.rst
+++ b/Documentation/driver-api/s390-drivers.rst
@@ -22,9 +22,28 @@ While most I/O devices on a s390 system are typically driven through the
 channel I/O mechanism described here, there are various other methods
 (like the diag interface). These are out of the scope of this document.
 
+The s390 common I/O layer also provides access to some devices that are
+not strictly considered I/O devices. They are considered here as well,
+although they are not the focus of this document.
+
 Some additional information can also be found in the kernel source under
 Documentation/s390/driver-model.txt.
 
+The css bus
+===========
+
+The css bus contains the subchannels available on the system. They fall
+into several categories:
+
+* Standard I/O subchannels, for use by the system. They have a child
+  device on the ccw bus and are described below.
+* I/O subchannels bound to the vfio-ccw driver. See
+  Documentation/s390/vfio-ccw.txt.
+* Message subchannels. No Linux driver currently exists.
+* CHSC subchannels (at most one). The chsc subchannel driver can be used
+  to send asynchronous chsc commands.
+* eADM subchannels. Used for talking to storage class memory.
+
 The ccw bus
 ===========
 
-- 
2.13.6
