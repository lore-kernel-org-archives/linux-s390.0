Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Dec 2020 12:58:36 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: irq/core] net/mlx5: Replace irq_to_desc() abuse
In-Reply-To: <20201210194044.769458162@linutronix.de>
References: <20201210194044.769458162@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791646.3364.2505749639821754000.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Saeed Mahameed <saeedm@nvidia.com>, x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3d18847680102182fed60b90ae65cbbb3d929a3c
Gitweb:        https://git.kernel.org/tip/3d18847680102182fed60b90ae65cbbb3d929a3c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:06 +01:00

net/mlx5: Replace irq_to_desc() abuse

No driver has any business with the internals of an interrupt
descriptor. Storing a pointer to it just to use yet another helper at the
actual usage site to retrieve the affinity mask is creative at best. Just
because C does not allow encapsulation does not mean that the kernel has no
limits.

Retrieve a pointer to the affinity mask itself and use that. It's still
using an interface which is usually not for random drivers, but definitely
less hideous than the previous hack.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20201210194044.769458162@linutronix.de

---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2f05b0f..45fd585 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -669,7 +669,7 @@ struct mlx5e_channel {
 	spinlock_t                 async_icosq_lock;
 
 	/* data path - accessed per napi poll */
-	struct irq_desc *irq_desc;
+	const struct cpumask	  *aff_mask;
 	struct mlx5e_ch_stats     *stats;
 
 	/* control */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b3f02aa..0e19b3c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1998,7 +1998,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->num_tc   = params->num_tc;
 	c->xdp      = !!params->xdp_prog;
 	c->stats    = &priv->channel_stats[ix].ch;
-	c->irq_desc = irq_to_desc(irq);
+	c->aff_mask = irq_get_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll, 64);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index d586867..793e313 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -40,12 +40,8 @@
 static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
 {
 	int current_cpu = smp_processor_id();
-	const struct cpumask *aff;
-	struct irq_data *idata;
 
-	idata = irq_desc_get_irq_data(c->irq_desc);
-	aff = irq_data_get_affinity_mask(idata);
-	return cpumask_test_cpu(current_cpu, aff);
+	return cpumask_test_cpu(current_cpu, c->aff_mask);
 }
 
 static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
