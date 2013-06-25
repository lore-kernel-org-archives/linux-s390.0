Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <51C8F685.6000209@asianux.com>
Date: Tue, 25 Jun 2013 09:46:45 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [PATCH] arch: s390: kernel: reset 'c->hotpluggable' when failure
 occurs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20130625014645.qczOugAFBrMJO-5iGZyzyXFtqrHbXhehGoqqp8JU2eQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

When smp_add_present_cpu() fails, it has reset all things excluding
'c->hotpluggable', so need reset it as original state completely.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/s390/kernel/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 15a016c..c4c6f42 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1016,6 +1016,7 @@ out_cpu:
 	unregister_cpu(c);
 #endif
 out:
+	c->hotpluggable = 0;
 	return rc;
 }
 
-- 
1.7.7.6
