From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v2 2/5] stop_machine: yield CPU during stop machine
Date: Tue, 25 Oct 2016 11:03:12 +0200
Message-ID: <1477386195-32736-3-git-send-email-borntraeger@de.ibm.com>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, kvm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Russell King <linux@armlinux.org.uk>, sparclinux@vger.kernel.org, Noam Camus <noamc@ezchip.com>, Catalin Marinas <catalin.marinas@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Some time ago commit 57f2ffe14fd125c2  ("s390: remove diag 44 calls
from cpu_relax()") did stop cpu_relax on s390 yielding to the
hypervisor.

As it turns out this made stop_machine run really slow on virtualized
overcommited systems. For example the kprobes test during bootup took
several seconds instead of just running unnoticed with large guests.

Therefore, the yielding was reintroduced with commit 4d92f50249eb
("s390: reintroduce diag 44 calls for cpu_relax()"), but in fact the
stop machine code seems to be the only place where this yielding
was really necessary. This place is probably the most important one
as it makes all but one guest CPUs wait for one guest CPU.

As we now have cpu_relax_yield, we can use this in multi_cpu_stop.
For now lets only add it here. We can add it later in other places
when necessary.

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
