From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 27/53] docs-rst: convert s390-drivers DocBook to ReST
Date: Tue, 16 May 2017 09:16:19 -0300
Message-Id: <bcb1a87a8b94182f57312a8d93dc69e9a3ace9e8.1494935649.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494935649.git.mchehab@s-opensource.com>
References: <cover.1494935649.git.mchehab@s-opensource.com>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-mtd@lists.infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jani Nikula <jani.nikula@intel.com>, Markus Heiser <markus.heiser@darmarit.de>, "Herton R. Krzesinski" <herton@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Use pandoc to convert documentation to ReST by calling
Documentation/sphinx/tmplcvt script.

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/DocBook/Makefile            |   2 +-
 Documentation/DocBook/s390-drivers.tmpl   | 161 ------------------------------
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/s390-drivers.rst | 111 ++++++++++++++++++++
 4 files changed, 113 insertions(+), 162 deletions(-)
 delete mode 100644 Documentation/DocBook/s390-drivers.tmpl
 create mode 100644 Documentation/driver-api/s390-drivers.rst

diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index abe71345160b..a25bf10384e1 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -10,7 +10,7 @@ DOCBOOKS := z8530book.xml  \
 	    networking.xml \
 	    lsm.xml \
 	    mtdnand.xml librs.xml rapidio.xml \
-	    s390-drivers.xml scsi.xml \
+	    scsi.xml \
 	    sh.xml w1.xml
 
 ifeq ($(DOCBOOKS),)
diff --git a/Documentation/DocBook/s390-drivers.tmpl b/Documentation/DocBook/s390-drivers.tmpl
deleted file mode 100644
index 95bfc12e5439..000000000000
--- a/Documentation/DocBook/s390-drivers.tmpl
+++ /dev/null
@@ -1,161 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
-	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
-
-<book id="s390drivers">
- <bookinfo>
-  <title>Writing s390 channel device drivers</title>
-
-  <authorgroup>
-   <author>
-    <firstname>Cornelia</firstname>
-    <surname>Huck</surname>
-    <affiliation>
-     <address>
-       <email>cornelia.huck@de.ibm.com</email>
-     </address>
-    </affiliation>
-   </author>
-  </authorgroup>
-
-  <copyright>
-   <year>2007</year>
-   <holder>IBM Corp.</holder>
-  </copyright>
-
-  <legalnotice>
-   <para>
-     This documentation is free software; you can redistribute
-     it and/or modify it under the terms of the GNU General Public
-     License as published by the Free Software Foundation; either
-     version 2 of the License, or (at your option) any later
-     version.
-   </para>
-
-   <para>
-     This program is distributed in the hope that it will be
-     useful, but WITHOUT ANY WARRANTY; without even the implied
-     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-     See the GNU General Public License for more details.
-   </para>
-
-   <para>
-     You should have received a copy of the GNU General Public
-     License along with this program; if not, write to the Free
-     Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
-     MA 02111-1307 USA
-   </para>
-
-   <para>
-     For more details see the file COPYING in the source
-     distribution of Linux.
-   </para>
-  </legalnotice>
- </bookinfo>
-
-<toc></toc>
-
-  <chapter id="intro">
-   <title>Introduction</title>
-  <para>
-    This document describes the interfaces available for device drivers that
-    drive s390 based channel attached I/O devices. This includes interfaces for
-    interaction with the hardware and interfaces for interacting with the
-    common driver core. Those interfaces are provided by the s390 common I/O
-    layer.
-  </para>
-  <para>
-    The document assumes a familarity with the technical terms associated
-    with the s390 channel I/O architecture. For a description of this
-    architecture, please refer to the "z/Architecture: Principles of
-    Operation", IBM publication no. SA22-7832.
-  </para>
-  <para>
-    While most I/O devices on a s390 system are typically driven through the
-    channel I/O mechanism described here, there are various other methods
-    (like the diag interface). These are out of the scope of this document.
-  </para>
-  <para>
-    Some additional information can also be found in the kernel source
-    under Documentation/s390/driver-model.txt.
-  </para>
-  </chapter>
-  <chapter id="ccw">
-   <title>The ccw bus</title>
-  <para>
-	The ccw bus typically contains the majority of devices available to
-	a s390 system. Named after the channel command word (ccw), the basic
-	command structure used to address its devices, the ccw bus contains
-	so-called channel attached devices. They are addressed via I/O
-	subchannels, visible on the css bus. A device driver for
-	channel-attached devices, however, will never interact	with the
-	subchannel directly, but only via the I/O device on the ccw bus,
-	the ccw device.
-  </para>
-    <sect1 id="channelIO">
-     <title>I/O functions for channel-attached devices</title>
-    <para>
-      Some hardware structures have been translated into C structures for use
-      by the common I/O layer and device drivers. For more information on
-      the hardware structures represented here, please consult the Principles
-      of Operation.
-    </para>
-!Iarch/s390/include/asm/cio.h
-    </sect1>
-    <sect1 id="ccwdev">
-     <title>ccw devices</title>
-    <para>
-      Devices that want to initiate channel I/O need to attach to the ccw bus.
-      Interaction with the driver core is done via the common I/O layer, which
-      provides the abstractions of ccw devices and ccw device drivers.
-    </para>
-    <para>
-      The functions that initiate or terminate channel I/O all act upon a
-      ccw device structure. Device drivers must not bypass those functions
-      or strange side effects may happen.
-    </para>
-!Iarch/s390/include/asm/ccwdev.h
-!Edrivers/s390/cio/device.c
-!Edrivers/s390/cio/device_ops.c
-    </sect1>
-    <sect1 id="cmf">
-     <title>The channel-measurement facility</title>
-  <para>
-	The channel-measurement facility provides a means to collect
-	measurement data which is made available by the channel subsystem
-	for each channel attached device.
-  </para>
-!Iarch/s390/include/asm/cmb.h
-!Edrivers/s390/cio/cmf.c
-    </sect1>
-  </chapter>
-
-  <chapter id="ccwgroup">
-   <title>The ccwgroup bus</title>
-  <para>
-	The ccwgroup bus only contains artificial devices, created by the user.
-	Many networking devices (e.g. qeth) are in fact composed of several
-	ccw devices (like read, write and data channel for qeth). The
-	ccwgroup bus provides a mechanism to create a meta-device which
-	contains those ccw devices as slave devices and can be associated
-	with the netdevice.
-  </para>
-   <sect1 id="ccwgroupdevices">
-    <title>ccw group devices</title>
-!Iarch/s390/include/asm/ccwgroup.h
-!Edrivers/s390/cio/ccwgroup.c
-   </sect1>
-  </chapter>
-
-  <chapter id="genericinterfaces">
-   <title>Generic interfaces</title>
-  <para>
-	Some interfaces are available to other drivers that do not necessarily
-	have anything to do with the busses described above, but still are
-	indirectly using basic infrastructure in the common I/O layer.
-	One example is the support for adapter interrupts.
-  </para>
-!Edrivers/s390/cio/airq.c
-  </chapter>
-
-</book>
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index c3c50b1bb96c..a9687731810e 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -34,6 +34,7 @@ available subsections can be seen below.
    edac
    libata
    miscellaneous
+   s390-drivers
    vme
    80211/index
    uio-howto
diff --git a/Documentation/driver-api/s390-drivers.rst b/Documentation/driver-api/s390-drivers.rst
new file mode 100644
index 000000000000..7060da136095
--- /dev/null
+++ b/Documentation/driver-api/s390-drivers.rst
@@ -0,0 +1,111 @@
+===================================
+Writing s390 channel device drivers
+===================================
+
+:Author: Cornelia Huck
+
+Introduction
+============
+
+This document describes the interfaces available for device drivers that
+drive s390 based channel attached I/O devices. This includes interfaces
+for interaction with the hardware and interfaces for interacting with
+the common driver core. Those interfaces are provided by the s390 common
+I/O layer.
+
+The document assumes a familarity with the technical terms associated
+with the s390 channel I/O architecture. For a description of this
+architecture, please refer to the "z/Architecture: Principles of
+Operation", IBM publication no. SA22-7832.
+
+While most I/O devices on a s390 system are typically driven through the
+channel I/O mechanism described here, there are various other methods
+(like the diag interface). These are out of the scope of this document.
+
+Some additional information can also be found in the kernel source under
+Documentation/s390/driver-model.txt.
+
+The ccw bus
+===========
+
+The ccw bus typically contains the majority of devices available to a
+s390 system. Named after the channel command word (ccw), the basic
+command structure used to address its devices, the ccw bus contains
+so-called channel attached devices. They are addressed via I/O
+subchannels, visible on the css bus. A device driver for
+channel-attached devices, however, will never interact with the
+subchannel directly, but only via the I/O device on the ccw bus, the ccw
+device.
+
+I/O functions for channel-attached devices
+------------------------------------------
+
+Some hardware structures have been translated into C structures for use
+by the common I/O layer and device drivers. For more information on the
+hardware structures represented here, please consult the Principles of
+Operation.
+
+.. kernel-doc:: arch/s390/include/asm/cio.h
+   :internal:
+
+ccw devices
+-----------
+
+Devices that want to initiate channel I/O need to attach to the ccw bus.
+Interaction with the driver core is done via the common I/O layer, which
+provides the abstractions of ccw devices and ccw device drivers.
+
+The functions that initiate or terminate channel I/O all act upon a ccw
+device structure. Device drivers must not bypass those functions or
+strange side effects may happen.
+
+.. kernel-doc:: arch/s390/include/asm/ccwdev.h
+   :internal:
+
+.. kernel-doc:: drivers/s390/cio/device.c
+   :export:
+
+.. kernel-doc:: drivers/s390/cio/device_ops.c
+   :export:
+
+The channel-measurement facility
+--------------------------------
+
+The channel-measurement facility provides a means to collect measurement
+data which is made available by the channel subsystem for each channel
+attached device.
+
+.. kernel-doc:: arch/s390/include/asm/cmb.h
+   :internal:
+
+.. kernel-doc:: drivers/s390/cio/cmf.c
+   :export:
+
+The ccwgroup bus
+================
+
+The ccwgroup bus only contains artificial devices, created by the user.
+Many networking devices (e.g. qeth) are in fact composed of several ccw
+devices (like read, write and data channel for qeth). The ccwgroup bus
+provides a mechanism to create a meta-device which contains those ccw
+devices as slave devices and can be associated with the netdevice.
+
+ccw group devices
+-----------------
+
+.. kernel-doc:: arch/s390/include/asm/ccwgroup.h
+   :internal:
+
+.. kernel-doc:: drivers/s390/cio/ccwgroup.c
+   :export:
+
+Generic interfaces
+==================
+
+Some interfaces are available to other drivers that do not necessarily
+have anything to do with the busses described above, but still are
+indirectly using basic infrastructure in the common I/O layer. One
+example is the support for adapter interrupts.
+
+.. kernel-doc:: drivers/s390/cio/airq.c
+   :export:
-- 
2.9.3
