Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:37 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] mfd: ab8500-debugfs: Remove the racy fiddling with irq_desc
In-Reply-To: <20201210194044.157283633@linutronix.de>
References: <20201210194044.157283633@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791799.3364.16109636784825298493.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4fa1cf7cde28ad4d7e4388cccfe682dded6a7aca
Gitweb:        https://git.kernel.org/tip/4fa1cf7cde28ad4d7e4388cccfe682dded6a7aca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

mfd: ab8500-debugfs: Remove the racy fiddling with irq_desc

First of all drivers have absolutely no business to dig into the internals
of an irq descriptor. That's core code and subject to change. All of this
information is readily available to /proc/interrupts in a safe and race
free way.

Remove the inspection code which is a blatant violation of subsystem
boundaries and racy against concurrent modifications of the interrupt
descriptor.

Print the irq line instead so the information can be looked up in a sane
way in /proc/interrupts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20201210194044.157283633@linutronix.de

---
 drivers/mfd/ab8500-debugfs.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 6d1bf7c..a320393 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1513,24 +1513,14 @@ static int ab8500_interrupts_show(struct seq_file *s, void *p)
 {
 	int line;
 
-	seq_puts(s, "name: number:  number of: wake:\n");
+	seq_puts(s, "name: number: irq: number of: wake:\n");
 
 	for (line = 0; line < num_interrupt_lines; line++) {
-		struct irq_desc *desc = irq_to_desc(line + irq_first);
-
-		seq_printf(s, "%3i:  %6i %4i",
+		seq_printf(s, "%3i:  %4i %6i %4i\n",
 			   line,
+			   line + irq_first,
 			   num_interrupts[line],
 			   num_wake_interrupts[line]);
-
-		if (desc && desc->name)
-			seq_printf(s, "-%-8s", desc->name);
-		if (desc && desc->action) {
-			struct irqaction *action = desc->action;
-
-			seq_printf(s, "  %s", action->name);
-			while ((action = action->next) != NULL)
-				seq_printf(s, ", %s", action->name);
 		}
 		seq_putc(s, '\n');
 	}
