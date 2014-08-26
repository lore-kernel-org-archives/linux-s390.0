From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/15] KVM: clarify the idea of kvm_dirty_regs
Date: Tue, 26 Aug 2014 10:28:15 +0200
Message-ID: <1409041707-39938-4-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch clarifies that kvm_dirty_regs are just a hint to the kernel and
that the kernel might just ignore some flags and sync the values (like done for
acrs and gprs now).

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index beae3fd..6485750 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2861,6 +2861,10 @@ kvm_valid_regs for specific bits. These bits are architecture specific
 and usually define the validity of a groups of registers. (e.g. one bit
  for general purpose registers)
 
+Please note that the kernel is allowed to use the kvm_run structure as the
+primary storage for certain register types. Therefore, the kernel may use the
+values in kvm_run even if the corresponding bit in kvm_dirty_regs is not set.
+
 };
 
 
-- 
1.8.4.2
