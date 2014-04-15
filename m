From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 42/47] KVM: s390: add documentation for diag 501
Date: Tue, 15 Apr 2014 14:00:45 +0200
Message-ID: <1397563250-3089-43-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Added documentation for diag 501, stating that no subfunctions are provided and
no parameters are used.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/s390-diag.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virtual/kvm/s390-diag.txt b/Documentation/virtual/kvm/s390-diag.txt
index f1de4fb..48c4921 100644
--- a/Documentation/virtual/kvm/s390-diag.txt
+++ b/Documentation/virtual/kvm/s390-diag.txt
@@ -78,3 +78,5 @@ DIAGNOSE function code 'X'501 - KVM breakpoint
 
 If the function code specifies 0x501, breakpoint functions may be performed.
 This function code is handled by userspace.
+
+This diagnose function code has no subfunctions and uses no parameters.
-- 
1.8.4.2
