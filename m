Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 16/27] s390/perf: Change CPUM_CF return code in event init function
Date: Wed, 14 Nov 2018 17:25:05 -0500
Message-Id: <20181114222520.99926-16-sashal@kernel.org>
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 0bb2ae1b26e1fb7543ec7474cdd374ac4b88c4da ]

The function perf_init_event() creates a new event and
assignes it to a PMU. This a done in a loop over all existing
PMUs. For each listed PMU the event init function is called
and if this function does return any other error than -ENOENT,
the loop is terminated the creation of the event fails.

If the event is invalid, return -ENOENT to try other PMUs.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 746d03423333..61e91fee8467 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -376,7 +376,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (ev > PERF_CPUM_CF_MAX_CTR)
-		return -EINVAL;
+		return -ENOENT;
 
 	/* Obtain the counter set to which the specified counter belongs */
 	set = get_counter_set(ev);
-- 
2.17.1
