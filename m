From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: reject invalid modes for runtime instrumentation
Date: Thu, 20 Oct 2016 20:20:06 +0200
Message-ID: <1476987606-123515-2-git-send-email-borntraeger@de.ibm.com>
References: <1476987606-123515-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1476987606-123515-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v4.5+@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Usually a validity intercept is a programming error of the host
because of invalid entries in the state description.
We can get a validity intercept if the mode of the runtime
instrumentation control block is wrong. As the host does not know
which modes are valid, this can be used by userspace to trigger
a WARN.
Instead of printing a WARN let's return an error to userspace as
this can only happen if userspace provides a malformed initial
value (e.g. on migration). The kernel should never warn on bogus
input. Instead let's log it into the s390 debug feature.

While at it, let's return -EINVAL for all validity intercepts as
this will trigger an error in QEMU like

error: kvm run failed Invalid argument
PSW=mask 0404c00180000000 addr 000000000063c226 cc 00
R00=000000000000004f R01=0000000000000004 R02=0000000000760005 R03=000000007fe0a000
R04=000000000064ba2a R05=000000049db73dd0 R06=000000000082c4b0 R07=0000000000000041
R08=0000000000000002 R09=000003e0804042a8 R10=0000000496152c42 R11=000000007fe0afb0
[...]

This will avoid an endless loop of validity intercepts.

Cc: stable@vger.kernel.org # v4.5+
Fixes: c6e5f166373a ("KVM: s390: implement the RI support of guest")
Acked-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1cab8a1..7a27eeb 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -119,8 +119,13 @@ static int handle_validity(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.exit_validity++;
 	trace_kvm_s390_intercept_validity(vcpu, viwhy);
-	WARN_ONCE(true, "kvm: unhandled validity intercept 0x%x\n", viwhy);
-	return -EOPNOTSUPP;
+	KVM_EVENT(3, "validity intercept 0x%x for pid %u (kvm 0x%pK)", viwhy,
+		  current->pid, vcpu->kvm);
+
+	/* do not warn on invalid runtime instrumentation mode */
+	WARN_ONCE(viwhy != 0x44, "kvm: unhandled validity intercept 0x%x\n",
+		  viwhy);
+	return -EINVAL;
 }
 
 static int handle_instruction(struct kvm_vcpu *vcpu)
-- 
2.5.5
