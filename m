Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46863 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbgD3PYo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:24:44 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 01/17] MAINTAINERS: Add Janosch as a s390x maintainer
Date: Thu, 30 Apr 2020 17:24:14 +0200
Message-Id: <20200430152430.40349-2-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Janosch Frank <frankja@de.ibm.com>, David Hildenbrand <david@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Both, David and I, often do not have as much spare time for the
kvm-unit-tests as we would like to have, so we could use a little
bit of additional help here. Janosch did some excellent work for
the s390x kvm-unit-tests in the past months and is listed as reviewer
for these patches since quite a while already, so he's a very well
suited for the maintainer job here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Janosch Frank <frankja@de.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200205101935.19219-1-thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48da1db..082be95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -80,7 +80,7 @@ F: lib/ppc64/*
 S390X
 M: Thomas Huth <thuth@redhat.com>
 M: David Hildenbrand <david@redhat.com>
-R: Janosch Frank <frankja@linux.ibm.com>
+M: Janosch Frank <frankja@linux.ibm.com>
 L: kvm@vger.kernel.org
 F: s390x/*
 F: lib/s390x/*
--=20
2.25.3
