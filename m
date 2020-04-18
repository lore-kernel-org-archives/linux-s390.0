Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgDROKZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:25 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 60/75] KVM: s390: vsie: Fix delivery of addressing exceptions
Date: Sat, 18 Apr 2020 10:08:55 -0400
Message-Id: <20200418140910.8280-60-sashal@kernel.org>
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 4d4cee96fb7a3cc53702a9be8299bf525be4ee98 ]

Whenever we get an -EFAULT, we failed to read in guest 2 physical
address space. Such addressing exceptions are reported via a program
intercept to the nested hypervisor.

We faked the intercept, we have to return to guest 2. Instead, right
now we would be returning -EFAULT from the intercept handler, eventually
crashing the VM.
the correct thing to do is to return 1 as rc == 1 is the internal
representation of "we have to go back into g2".

Addressing exceptions can only happen if the g2->g3 page tables
reference invalid g2 addresses (say, either a table or the final page is
not accessible - so something that basically never happens in sane
environments.

Identified by manual code inspection.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200403153050.20569-3-david@redhat.com
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
[borntraeger@de.ibm.com: fix patch description]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/vsie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 076090f9e666c..4f6c22d72072a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1202,6 +1202,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->iprcc = PGM_ADDRESSING;
 		scb_s->pgmilc = 4;
 		scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, 4);
+		rc = 1;
 	}
 	return rc;
 }
-- 
2.20.1
