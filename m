Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/3] net/smc: add error handling for get_user()
Date: Wed, 18 Jul 2018 15:22:50 +0200
In-Reply-To: <20180718132251.7222-1-ubraun@linux.ibm.com>
References: <20180718132251.7222-1-ubraun@linux.ibm.com>
Message-Id: <20180718132251.7222-3-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@linux.ibm.com>

For security reasons the return code of get_user() should always be
checked.

Fixes: 01d2f7e2cdd31 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c12a7fc18f56..6e5479067db0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1456,7 +1456,8 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
-	get_user(val, (int __user *)optval);
+	if (get_user(val, (int __user *)optval))
+		return -EFAULT;
 
 	lock_sock(sk);
 	switch (optname) {
-- 
2.16.4
