From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/3] s390/kvm: Fix store status for ACRS/FPRS
Date: Fri, 25 Jan 2013 15:34:15 +0100
Message-ID: <1359124457-51126-2-git-send-email-borntraeger@de.ibm.com>
References: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On store status we need to copy the current state of registers
into a save area. Currently we might save stale versions:
The sie state descriptor doesnt have fields for guest ACRS,FPRS,
those registers are simply stored in the host registers. The host
program must copy these away if needed. We do that in vcpu_put/load.

If we now do a store status in KVM code between vcpu_put/load, the
saved values are not up-to-date. Lets collect the ACRS/FPRS before
saving them.

This also fixes some strange problems with hotplug and virtio-ccw,
since the low level machine check handler (on hotplug a machine check
will happen) will revalidate all registers with the content of the
save area.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: stable@vger.kernel.org
---
 arch/s390/kvm/kvm-s390.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5b01f09..4377d18 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -770,6 +770,14 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	} else
 		prefix = 0;
 
+	/*
+	 * The guest FPRS and ACRS are in the host FPRS/ACRS due to the lazy
+	 * copying in vcpu load/put. Lets update our copies before we save
+	 * it into the save area
+	 */
+	save_fp_regs(&vcpu->arch.guest_fpregs);
+	save_access_regs(vcpu->run->s.regs.acrs);
+
 	if (__guestcopy(vcpu, addr + offsetof(struct save_area, fp_regs),
 			vcpu->arch.guest_fpregs.fprs, 128, prefix))
 		return -EFAULT;
-- 
1.7.12.4
