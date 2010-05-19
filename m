From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Wed, 19 May 2010 23:12:09 +0000
Subject: [PATCH 2/3] [S390] remove duplicated #include
Message-Id: <1274310729-5160-1-git-send-email-weiyi.huang@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Remove duplicated #include('s) in
  arch/s390/kvm/sie64a.S

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/s390/kvm/sie64a.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/s390/kvm/sie64a.S b/arch/s390/kvm/sie64a.S
index 31646bd..6bab37e 100644
--- a/arch/s390/kvm/sie64a.S
+++ b/arch/s390/kvm/sie64a.S
@@ -14,7 +14,6 @@
 #include <linux/errno.h>
 #include <asm/asm-offsets.h>
 #include <asm/setup.h>
-#include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
-- 
1.6.1.3
