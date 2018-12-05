From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 025/123] s390/cio: Fix cleanup of pfn_array alloc failure
Date: Wed,  5 Dec 2018 04:34:17 -0500
Message-ID: <20181205093555.5386-25-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit 806212f91c874b24cf9eb4a9f180323671b6c5ed ]

If pfn_array_alloc fails somehow, we need to release the pfn_array_table
that was malloc'd earlier.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20181109023937.96105-2-farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index fd77e46eb3b2..ef5ab45d94b3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -528,7 +528,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 
 	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
 	if (ret < 0)
-		goto out_init;
+		goto out_unpin;
 
 	/* Translate this direct ccw to a idal ccw. */
 	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
-- 
2.17.1
