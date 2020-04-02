Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389888AbgDBSse (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Apr 2020 14:48:34 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/5] KVM: s390: vsie: Fix delivery of addressing exceptions
Date: Thu,  2 Apr 2020 20:48:16 +0200
Message-Id: <20200402184819.34215-3-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org

Whenever we get an -EFAULT, we failed to read in guest 2 physical
address space. Such addressing exceptions are reported via a program
intercept to the nested hypervisor.

We faked the intercept, we have to return to guest 2. Instead, right
now we would be returning -EFAULT from the intercept handler, eventually
crashing the VM.

Addressing exceptions can only happen if the g2->g3 page tables
reference invalid g2 addresses (say, either a table or the final page is
not accessible - so something that basically never happens in sane
environments.

Identified by manual code inspection.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtual=
ization")
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 076090f9e666..4f6c22d72072 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct v=
sie_page *vsie_page)
 		scb_s->iprcc =3D PGM_ADDRESSING;
 		scb_s->pgmilc =3D 4;
 		scb_s->gpsw.addr =3D __rewind_psw(scb_s->gpsw, 4);
+		rc =3D 1;
 	}
 	return rc;
 }
--=20
2.25.1
