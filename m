From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/5] stop_machine: yield CPU during stop machine
Date: Fri, 21 Oct 2016 13:58:55 +0200
Message-ID: <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

stop_machine can take a very long time if the hypervisor does
overcommitment for guest CPUs. When waiting for "the one", lets
give up our CPU by using the new cpu_relax_yield.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index ec9ab2f..1eb8266 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax();
+		cpu_relax_yield();
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.5.5
