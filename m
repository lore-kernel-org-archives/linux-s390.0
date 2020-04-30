Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30402 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbgD3PYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:24:43 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 02/17] MAINTAINERS: s390x: add myself as reviewer
Date: Thu, 30 Apr 2020 17:24:15 +0200
Message-Id: <20200430152430.40349-3-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

From: Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20200324121722.9776-2-cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 082be95..4642909 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -81,6 +81,7 @@ S390X
 M: Thomas Huth <thuth@redhat.com>
 M: David Hildenbrand <david@redhat.com>
 M: Janosch Frank <frankja@linux.ibm.com>
+R: Cornelia Huck <cohuck@redhat.com>
 L: kvm@vger.kernel.org
 F: s390x/*
 F: lib/s390x/*
--=20
2.25.3
