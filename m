From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 21/51] s390/mm: remember the int code for the last gmap fault
Date: Tue, 21 Jun 2016 15:12:59 +0200
Message-ID: <1466514809-146638-22-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

For nested virtualization, we want to know if we are handling a protection
exception, because these can directly be forwarded to the guest without
additional checks.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 1 +
 arch/s390/mm/fault.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 94c80b6..8c2922f 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -110,6 +110,7 @@ struct thread_struct {
 	mm_segment_t mm_segment;
 	unsigned long gmap_addr;	/* address of last gmap fault. */
 	unsigned int gmap_write_flag;	/* gmap fault write indication */
+	unsigned int gmap_int_code;	/* int code of last gmap fault */
 	unsigned int gmap_pfault;	/* signal of a pending guest pfault */
 	struct per_regs per_user;	/* User specified PER registers */
 	struct per_event per_event;	/* Cause of the last PER trap */
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b84416c..730e0d3 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -419,6 +419,7 @@ static inline int do_exception(struct pt_regs *regs, int access)
 	if (gmap) {
 		current->thread.gmap_addr = address;
 		current->thread.gmap_write_flag = !!(flags & FAULT_FLAG_WRITE);
+		current->thread.gmap_int_code = regs->int_code & 0xffff;
 		address = __gmap_translate(gmap, address);
 		if (address == -EFAULT) {
 			fault = VM_FAULT_BADMAP;
-- 
2.5.5
