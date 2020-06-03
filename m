Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgFCL1g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Jun 2020 07:27:36 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 02/10] vfio-ccw: document possible errors
Date: Wed,  3 Jun 2020 13:27:08 +0200
Message-Id: <20200603112716.332801-3-cohuck@redhat.com>
In-Reply-To: <20200603112716.332801-1-cohuck@redhat.com>
References: <20200603112716.332801-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

Interacting with the I/O and the async regions can yield a number
of errors, which had been undocumented so far. These are part of
the api, so remedy that.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20200407111605.1795-1-cohuck@redhat.com>
---
 Documentation/s390/vfio-ccw.rst | 56 +++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index 23e7d136f8b4..3a946fd45562 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -204,15 +204,44 @@ definition of the region is::
 	  __u32   ret_code;
   } __packed;
 
+This region is always available.
+
 While starting an I/O request, orb_area should be filled with the
 guest ORB, and scsw_area should be filled with the SCSW of the Virtual
 Subchannel.
 
 irb_area stores the I/O result.
 
-ret_code stores a return code for each access of the region.
+ret_code stores a return code for each access of the region. The following
+values may occur:
+
+``0``
+  The operation was successful.
+
+``-EOPNOTSUPP``
+  The orb specified transport mode or an unidentified IDAW format, or the
+  scsw specified a function other than the start function.
+
+``-EIO``
+  A request was issued while the device was not in a state ready to accept
+  requests, or an internal error occurred.
+
+``-EBUSY``
+  The subchannel was status pending or busy, or a request is already active.
+
+``-EAGAIN``
+  A request was being processed, and the caller should retry.
+
+``-EACCES``
+  The channel path(s) used for the I/O were found to be not operational.
+
+``-ENODEV``
+  The device was found to be not operational.
+
+``-EINVAL``
+  The orb specified a chain longer than 255 ccws, or an internal error
+  occurred.
 
-This region is always available.
 
 vfio-ccw cmd region
 -------------------
@@ -231,6 +260,29 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
 
 Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
 
+command specifies the command to be issued; ret_code stores a return code
+for each access of the region. The following values may occur:
+
+``0``
+  The operation was successful.
+
+``-ENODEV``
+  The device was found to be not operational.
+
+``-EINVAL``
+  A command other than halt or clear was specified.
+
+``-EIO``
+  A request was issued while the device was not in a state ready to accept
+  requests.
+
+``-EAGAIN``
+  A request was being processed, and the caller should retry.
+
+``-EBUSY``
+  The subchannel was status pending or busy while processing a halt request.
+
+
 vfio-ccw operation details
 --------------------------
 
-- 
2.25.4
