From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 9/9] KVM: s390: add ipte to trace event decoding
Date: Mon, 21 Jul 2014 21:14:25 +0200
Message-ID: <1405970065-3740-10-git-send-email-borntraeger@de.ibm.com>
References: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

IPTE intercept can happen, let's decode that.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/uapi/asm/sie.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index 5d9cc19..d4096fd 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -108,6 +108,7 @@
 	exit_code_ipa0(0xB2, 0x17, "STETR"),	\
 	exit_code_ipa0(0xB2, 0x18, "PC"),	\
 	exit_code_ipa0(0xB2, 0x20, "SERVC"),	\
+	exit_code_ipa0(0xB2, 0x21, "IPTE"),	\
 	exit_code_ipa0(0xB2, 0x28, "PT"),	\
 	exit_code_ipa0(0xB2, 0x29, "ISKE"),	\
 	exit_code_ipa0(0xB2, 0x2a, "RRBE"),	\
-- 
1.8.4.2
