Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:36 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] net/mlx4: Use effective interrupt affinity
In-Reply-To: <20201210194044.672935978@linutronix.de>
References: <20201210194044.672935978@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791672.3364.17648709739154869994.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Tariq Toukan <tariqt@nvidia.com>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f23130b1af7bccb23dff1e9223d826869c2ad45d
Gitweb:        https://git.kernel.org/tip/f23130b1af7bccb23dff1e9223d826869c2ad45d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

net/mlx4: Use effective interrupt affinity

Using the interrupt affinity mask for checking locality is not really
working well on architectures which support effective affinity masks.

The affinity mask is either the system wide default or set by user space,
but the architecture can or even must reduce the mask to the effective set,
which means that checking the affinity mask itself does not really tell
about the actual target CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.672935978@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 2a250f3..d5fc72b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -117,7 +117,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 			assigned_eq = true;
 		}
 		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
-		cq->aff_mask = irq_get_affinity_mask(irq);
+		cq->aff_mask = irq_get_effective_affinity_mask(irq);
 	} else {
 		/* For TX we use the same irq per
 		ring we assigned for the RX    */
