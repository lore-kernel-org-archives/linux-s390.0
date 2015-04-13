From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 14/17] target-s390x: Initialize S390 CPU model name in CPUState
Date: Mon, 13 Apr 2015 15:56:33 +0200
Message-ID: <1428933396-37887-15-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The cpu model name now gets initialized during CPU instance
initialization.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 target-s390x/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 65dee3e..771acbd 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -207,6 +207,7 @@ static void s390_cpu_initfn(Object *obj)
     struct tm tm;
 #endif
 
+    cs->model_name = strdup_cpu_name(S390_CPU_GET_CLASS(cs));
     cs->env_ptr = env;
     cpu_exec_init(env);
 #if !defined(CONFIG_USER_ONLY)
-- 
1.8.3.1
