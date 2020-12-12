Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:38 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] pinctrl: nomadik: Use irq_has_action()
In-Reply-To: <20201210194044.065003856@linutronix.de>
References: <20201210194044.065003856@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791825.3364.15312294043943937969.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     52ae486b230b6d9508068d49da850fb17d25a174
Gitweb:        https://git.kernel.org/tip/52ae486b230b6d9508068d49da850fb17d25a174
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:04 +01:00

pinctrl: nomadik: Use irq_has_action()

Let the core code do the fiddling with irq_desc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20201210194044.065003856@linutronix.de

---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 657e35a..724abe1 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -948,7 +948,6 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 			   (mode < 0) ? "unknown" : modes[mode]);
 	} else {
 		int irq = chip->to_irq(chip, offset);
-		struct irq_desc	*desc = irq_to_desc(irq);
 		const int pullidx = pull ? 1 : 0;
 		int val;
 		static const char * const pulls[] = {
@@ -969,7 +968,7 @@ static void nmk_gpio_dbg_show_one(struct seq_file *s,
 		 * This races with request_irq(), set_irq_type(),
 		 * and set_irq_wake() ... but those are "rare".
 		 */
-		if (irq > 0 && desc && desc->action) {
+		if (irq > 0 && irq_has_action(irq)) {
 			char *trigger;
 
 			if (nmk_chip->edge_rising & BIT(offset))
