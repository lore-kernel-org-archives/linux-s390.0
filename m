Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 12/14] s390/topology: use atomic_dec_not_zero()
Date: Mon, 30 Jan 2017 19:48:33 +0100
Message-Id: <20170130184833.19095-1-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
List-ID: <linux-s390.vger.kernel.org>

instead of atomic_add_unless(value, -1, 0)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/s390/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 7b2b19b..820ef64 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -300,7 +300,7 @@ static atomic_t topology_poll = ATOMIC_INIT(0);
 
 static void set_topology_timer(void)
 {
-	if (atomic_add_unless(&topology_poll, -1, 0))
+	if (atomic_dec_not_zero(&topology_poll))
 		mod_timer(&topology_timer, jiffies + HZ / 10);
 	else
 		mod_timer(&topology_timer, jiffies + HZ * 60);
-- 
2.9.3
