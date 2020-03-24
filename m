Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20026 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbgCXMRk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:17:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/2] s390x: add linux-s390 list
Date: Tue, 24 Mar 2020 13:17:22 +0100
Message-Id: <20200324121722.9776-3-cohuck@redhat.com>
In-Reply-To: <20200324121722.9776-1-cohuck@redhat.com>
References: <20200324121722.9776-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

It makes sense to cc: patches there as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 471767a355c6..8912533e441d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -83,6 +83,7 @@ M: David Hildenbrand <david@redhat.com>
 R: Janosch Frank <frankja@linux.ibm.com>
 R: Cornelia Huck <cohuck@redhat.com>
 L: kvm@vger.kernel.org
+L: linux-s390@vger.kernel.org
 F: s390x/*
 F: lib/s390x/*
=20
--=20
2.21.1
