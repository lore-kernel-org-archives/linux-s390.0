Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] MAINTAINERS: change list for KVM/s390
Date: Fri,  9 Aug 2019 09:19:16 +0200
Message-Id: <1565335156-28660-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: frankja@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>

KVM/s390 does not have a list of its own, and linux-s390 is in the
loop anyway thanks to the generic arch/s390 match.  So use the generic
KVM list for s390 patches.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aec93695040..6498ebaca2f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8788,7 +8788,7 @@ M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Janosch Frank <frankja@linux.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
 R:	Cornelia Huck <cohuck@redhat.com>
-L:	linux-s390@vger.kernel.org
+L:	kvm@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 S:	Supported
-- 
1.8.3.1
