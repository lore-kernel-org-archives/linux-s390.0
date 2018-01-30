From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/3] MAINTAINERS: add David as a reviewer for KVM/s390
Date: Tue, 30 Jan 2018 16:24:45 +0100
Message-ID: <20180130152447.29871-2-cohuck@redhat.com>
References: <20180130152447.29871-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180130152447.29871-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, david@redhat.com, pasic@linux.vnet.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82ad0eabce4f..cd7a416c516b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7693,6 +7693,7 @@ F:	arch/powerpc/kernel/kvm*
 KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
 M:	Cornelia Huck <cohuck@redhat.com>
+R:	David Hildenbrand <david@redhat.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
-- 
2.13.6
