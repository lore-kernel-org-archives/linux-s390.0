Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48734 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727088AbgD3PY5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:24:57 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PULL 08/17] s390x: unittests: Use smp parameter
Date: Thu, 30 Apr 2020 17:24:21 +0200
Message-Id: <20200430152430.40349-9-david@redhat.com>
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
References: <20200430152430.40349-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, Andrew Jones <drjones@redhat.com>, David Hildenbrand <david@redhat.com>

From: Andrew Jones <drjones@redhat.com>

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20200403094015.506838-1-drjones@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 s390x/unittests.cfg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 535db21..b307329 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -75,7 +75,7 @@ extra_params=3D-name kvm-unit-test --uuid 0fb84a86-727c=
-11ea-bc55-0242ac130003 -sm
=20
 [smp]
 file =3D smp.elf
-extra_params =3D-smp 2
+smp =3D 2
=20
 [sclp-1g]
 file =3D sclp.elf
--=20
2.25.3
