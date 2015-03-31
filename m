From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/8] KVM: s390: enable more features that need no hypervisor changes
Date: Tue, 31 Mar 2015 15:01:57 +0200
Message-ID: <1427806923-21910-3-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

After some review about what these facilities do, the following
facilities will work under KVM and can, therefore, be reported
to the guest if the cpu model and the host cpu provide this bit.

There are plans underway to make the whole bit thing more readable,
but its not yet finished. So here are some last bit changes and
we enhance the KVM mask with:

9 The sense-running-status facility is installed in the
  z/Architecture architectural mode.
  ---> handled by SIE or KVM

10 The conditional-SSKE facility is installed in the
   z/Architecture architectural mode.
  ---> handled by SIE. KVM will retry SIE

13 The IPTE-range facility is installed in the
   z/Architecture architectural mode.
  ---> handled by SIE. KVM will retry SIE

36 The enhanced-monitor facility is installed in the
   z/Architecture architectural mode.
  ---> handled by SIE

47 The CMPSC-enhancement facility is installed in the
   z/Architecture architectural mode.
  ---> handled by SIE

48 The decimal-floating-point zoned-conversion facility
   is installed in the z/Architecture architectural mode.
  ---> handled by SIE

49 The execution-hint, load-and-trap, miscellaneous-
   instruction-extensions and processor-assist
  ---> handled by SIE

51 The local-TLB-clearing facility is installed in the
   z/Architecture architectural mode.
  ---> handled by SIE

52 The interlocked-access facility 2 is installed.
  ---> handled by SIE

53 The load/store-on-condition facility 2 and load-and-
   zero-rightmost-byte facility are installed in the
   z/Architecture architectural mode.
  ---> handled by SIE

57 The message-security-assist-extension-5 facility is
  installed in the z/Architecture architectural mode.
  ---> handled by SIE

66 The reset-reference-bits-multiple facility is installed
  in the z/Architecture architectural mode.
  ---> handled by SIE. KVM will retry SIE

80 The decimal-floating-point packed-conversion
   facility is installed in the z/Architecture architectural
   mode.
  ---> handled by SIE

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9072127..a130885 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -105,8 +105,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 
 /* upper facilities limit for kvm */
 unsigned long kvm_s390_fac_list_mask[] = {
-	0xff82fffbf4fc2000UL,
-	0x005c000000000000UL,
+	0xffe6fffbfcfdfc40UL,
+	0x205c800000000000UL,
 };
 
 unsigned long kvm_s390_fac_list_mask_size(void)
-- 
2.3.0
