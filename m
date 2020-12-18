Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgLROS7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Dec 2020 09:18:59 -0500
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/4] s390/kvm: VSIE: stop leaking host addresses
Date: Fri, 18 Dec 2020 15:18:08 +0100
Message-Id: <20201218141811.310267-2-imbrenda@linux.ibm.com>
In-Reply-To: <20201218141811.310267-1-imbrenda@linux.ibm.com>
References: <20201218141811.310267-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

The addresses in the SIE control block of the host should not be
forwarded to the guest. They are only meaningful to the host, and
moreover it would be a clear security issue.

Subsequent patches will actually put the right values in the guest SIE
control block.

Fixes: a3508fbe9dc6d ("KVM: s390: vsie: initial support for nested virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f3cbf6003a9..ada49583e530 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -416,11 +416,6 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		memcpy((void *)((u64)scb_o + 0xc0),
 		       (void *)((u64)scb_s + 0xc0), 0xf0 - 0xc0);
 		break;
-	case ICPT_PARTEXEC:
-		/* MVPG only */
-		memcpy((void *)((u64)scb_o + 0xc0),
-		       (void *)((u64)scb_s + 0xc0), 0xd0 - 0xc0);
-		break;
 	}
 
 	if (scb_s->ihcpu != 0xffffU)
-- 
2.26.2
