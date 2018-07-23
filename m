Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 5/5] net/smc: remove local variable page in smc_rx_splice()
Date: Mon, 23 Jul 2018 13:53:12 +0200
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
Message-Id: <20180723115312.54694-6-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

The page map address is already stored in the RMB descriptor.
There is no need to derive it from the cpu_addr value.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_rx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c99c987097b1..bbcf0fe4ae10 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -155,10 +155,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	struct splice_pipe_desc spd;
 	struct partial_page partial;
 	struct smc_spd_priv *priv;
-	struct page *page;
 	int bytes;
 
-	page = virt_to_page(smc->conn.rmb_desc->cpu_addr);
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -170,7 +168,7 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 
 	spd.nr_pages_max = 1;
 	spd.nr_pages = 1;
-	spd.pages = &page;
+	spd.pages = &smc->conn.rmb_desc->pages;
 	spd.partial = &partial;
 	spd.ops = &smc_pipe_ops;
 	spd.spd_release = smc_rx_spd_release;
-- 
2.16.4
