Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:36 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] net/mlx4: Replace irq_to_desc() abuse
In-Reply-To: <20201210194044.580936243@linutronix.de>
References: <20201210194044.580936243@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791699.3364.146087151070915411.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Tariq Toukan <tariqt@nvidia.com>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5ea444c8f27b50f14ccfece192a6199d3ada9253
Gitweb:        https://git.kernel.org/tip/5ea444c8f27b50f14ccfece192a6199d3ada9253
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

net/mlx4: Replace irq_to_desc() abuse

No driver has any business with the internals of an interrupt
descriptor. Storing a pointer to it just to use yet another helper at the
actual usage site to retrieve the affinity mask is creative at best. Just
because C does not allow encapsulation does not mean that the kernel has no
limits.

Retrieve a pointer to the affinity mask itself and use that. It's still
using an interface which is usually not for random drivers, but definitely
less hideous than the previous hack.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.580936243@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 8 +++-----
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 6 +-----
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 3 ++-
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 74d4667..2a250f3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -90,7 +90,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 			int cq_idx)
 {
 	struct mlx4_en_dev *mdev = priv->mdev;
-	int err = 0;
+	int irq, err = 0;
 	int timestamp_en = 0;
 	bool assigned_eq = false;
 
@@ -116,10 +116,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 
 			assigned_eq = true;
 		}
-
-		cq->irq_desc =
-			irq_to_desc(mlx4_eq_get_irq(mdev->dev,
-						    cq->vector));
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
+		cq->aff_mask = irq_get_affinity_mask(irq);
 	} else {
 		/* For TX we use the same irq per
 		ring we assigned for the RX    */
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 502d1b9..399459a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -959,8 +959,6 @@ int mlx4_en_poll_rx_cq(struct napi_struct *napi, int budget)
 
 	/* If we used up all the quota - we're probably not done yet... */
 	if (done == budget || !clean_complete) {
-		const struct cpumask *aff;
-		struct irq_data *idata;
 		int cpu_curr;
 
 		/* in case we got here because of !clean_complete */
@@ -969,10 +967,8 @@ int mlx4_en_poll_rx_cq(struct napi_struct *napi, int budget)
 		INC_PERF_COUNTER(priv->pstats.napi_quota);
 
 		cpu_curr = smp_processor_id();
-		idata = irq_desc_get_irq_data(cq->irq_desc);
-		aff = irq_data_get_affinity_mask(idata);
 
-		if (likely(cpumask_test_cpu(cpu_curr, aff)))
+		if (likely(cpumask_test_cpu(cpu_curr, cq->aff_mask)))
 			return budget;
 
 		/* Current cpu is not according to smp_irq_affinity -
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index a46efe3..48d71e0 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -46,6 +46,7 @@
 #endif
 #include <linux/cpu_rmap.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/irq.h>
 #include <net/xdp.h>
 
 #include <linux/mlx4/device.h>
@@ -380,7 +381,7 @@ struct mlx4_en_cq {
 	struct mlx4_cqe *buf;
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
-	struct irq_desc *irq_desc;
+	const struct cpumask *aff_mask;
 };
 
 struct mlx4_en_port_profile {
