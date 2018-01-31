From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 3/3] MAINTAINERS: update KVM/s390 maintainers
Date: Wed, 31 Jan 2018 10:24:12 +0100
Message-ID: <20180131092412.9997-4-cohuck@redhat.com>
References: <20180131092412.9997-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180131092412.9997-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com, rkrcmar@redhat.com
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, david@redhat.com, pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

As I have neither too much time nor access to the architecture
documentation anymore, let's switch my status from maintainer to
reviewer. Janosch will step in as second maintainer.

Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 990ac01c319d..71781ad422f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7692,8 +7692,9 @@ F:	arch/powerpc/kernel/kvm*
 
 KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
-M:	Cornelia Huck <cohuck@redhat.com>
+M:	Janosch Frank <frankja@linux.vnet.ibm.com>
 R:	David Hildenbrand <david@redhat.com>
+R:	Cornelia Huck <cohuck@redhat.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
-- 
2.13.6
