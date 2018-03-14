From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:51 +0000
Subject: [GIT PULL 03/10] KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
Message-Id: <20180314192858.172855-4-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

commit 35b3fde6203b ("KVM: s390: wire up bpb feature") has no
documentation for KVM_CAP_S390_BPB. While adding this let's also add
other missing capabilities like KVM_CAP_S390_PSW, KVM_CAP_S390_GMAP and
KVM_CAP_S390_COW.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 792fa8717d13..e2e9ce67ba31 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4467,3 +4467,33 @@ Parameters: none
 This capability indicates if the flic device will be able to get/set the
 AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and allows
 to discover this without having to create a flic device.
+
+8.14 KVM_CAP_S390_PSW
+
+Architectures: s390
+
+This capability indicates that the PSW is exposed via the kvm_run structure.
+
+8.15 KVM_CAP_S390_GMAP
+
+Architectures: s390
+
+This capability indicates that the user space memory used as guest mapping can
+be anywhere in the user memory address space, as long as the memory slots are
+aligned and sized to a segment (1MB) boundary.
+
+8.16 KVM_CAP_S390_COW
+
+Architectures: s390
+
+This capability indicates that the user space memory used as guest mapping can
+use copy-on-write semantics as well as dirty pages tracking via read-only page
+tables.
+
+8.17 KVM_CAP_S390_BPB
+
+Architectures: s390
+
+This capability indicates that kvm will implement the interfaces to handle
+reset, migration and nested KVM for branch prediction blocking. The stfle
+facility 82 should not be provided to the guest without this capability.
-- 
2.14.3
