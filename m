Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728088AbgDGLQP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 07:16:15 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] vfio-ccw: document possible errors
Date: Tue,  7 Apr 2020 13:16:05 +0200
Message-Id: <20200407111605.1795-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

Interacting with the I/O and the async regions can yield a number
of errors, which had been undocumented so far. These are part of
the api, so remedy that.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/s390/vfio-ccw.rst | 54 ++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-cc=
w.rst
index fca9c4f5bd9c..4538215a362c 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -210,7 +210,36 @@ Subchannel.
=20
 irb_area stores the I/O result.
=20
-ret_code stores a return code for each access of the region.
+ret_code stores a return code for each access of the region. The followi=
ng
+values may occur:
+
+``0``
+  The operation was successful.
+
+``-EOPNOTSUPP``
+  The orb specified transport mode or an unidentified IDAW format, did n=
ot
+  specify prefetch mode, or the scsw specified a function other than the
+  start function.
+
+``-EIO``
+  A request was issued while the device was not in a state ready to acce=
pt
+  requests, or an internal error occurred.
+
+``-EBUSY``
+  The subchannel was status pending or busy, or a request is already act=
ive.
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
=20
 This region is always available.
=20
@@ -231,6 +260,29 @@ This region is exposed via region type VFIO_REGION_S=
UBTYPE_CCW_ASYNC_CMD.
=20
 Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
=20
+command specifies the command to be issued; ret_code stores a return cod=
e
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
+  A request was issued while the device was not in a state ready to acce=
pt
+  requests.
+
+``-EAGAIN``
+  A request was being processed, and the caller should retry.
+
+``-EBUSY``
+  The subchannel was status pending or busy while processing a halt requ=
est.
+
+
 vfio-ccw operation details
 --------------------------
=20
--=20
2.21.1
