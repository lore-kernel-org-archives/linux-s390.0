From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 06 Mar 2018 15:00:26 +0000
Subject: [GIT PULL 1/2] KVM: s390: provide io interrupt kvm_stat
Message-Id: <20180306150027.175145-2-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We already count io interrupts, but we forgot to print them.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: d8346b7d9b ("KVM: s390: Support for I/O interrupts.")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 77d7818130db..df19f158347e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -86,6 +86,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "deliver_prefix_signal", VCPU_STAT(deliver_prefix_signal) },
 	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
 	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
+	{ "deliver_io_interrupt", VCPU_STAT(deliver_io_int) },
 	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
 	{ "instruction_epsw", VCPU_STAT(instruction_epsw) },
 	{ "instruction_gs", VCPU_STAT(instruction_gs) },
-- 
2.14.3
