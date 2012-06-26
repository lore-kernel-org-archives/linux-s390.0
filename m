From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/6] s390/smp: remove redundant check
Date: Tue, 26 Jun 2012 16:06:36 +0200
Message-ID: <1340719601-11867-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

condition code "status stored" for sigp sense running always implies
that only the "not running" status bit is set. Therefore no need to
check if it is set.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kernel/smp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 15cca26..c78074c 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -158,8 +158,8 @@ static inline int pcpu_running(struct pcpu *pcpu)
 	if (__pcpu_sigp(pcpu->address, sigp_sense_running,
 			0, &pcpu->status) != sigp_status_stored)
 		return 1;
-	/* Check for running status */
-	return !(pcpu->status & 0x400);
+	/* Status stored condition code is equivalent to cpu not running. */
+	return 0;
 }
 
 /*
-- 
1.7.10.4
