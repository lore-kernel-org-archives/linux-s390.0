Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Feb 2011 20:07:30 +0100
From: Robert Richter <robert.richter@amd.com>
Subject: [PATCH] oprofile, s390: Fix section mismatch of function
 hws_cpu_callback()
Message-ID: <20110214190730.GV5874@erda.amd.com>
References: <20110121100651.821690659@linux.vnet.ibm.com>
 <20110121100842.039354578@linux.vnet.ibm.com>
 <20110214190157.GS5874@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110214190157.GS5874@erda.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: "mingo@elte.hu" <mingo@elte.hu>, "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Maran Pakkirisamy <maranp@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 14.02.11 20:01:57, Robert Richter wrote:
> I reworked some changes in a follow-on patch which I apply on top of
> your patch set.

And another fix below.

-Robert



From 11a2be68e575c02ec74a918e05c590627ff16e9c Mon Sep 17 00:00:00 2001
From: Robert Richter <robert.richter@amd.com>
Date: Mon, 14 Feb 2011 19:08:33 +0100
Subject: [PATCH] oprofile, s390: Fix section mismatch of function hws_cpu_callback()

Fixes the following section mismatch:

 Section mismatch in reference from the variable hws_cpu_notifier to the function .cpuinit.text:hws_cpu_callback()

Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 arch/s390/oprofile/hwsampler.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/oprofile/hwsampler.c b/arch/s390/oprofile/hwsampler.c
index ab3f770e..3d48f4d 100644
--- a/arch/s390/oprofile/hwsampler.c
+++ b/arch/s390/oprofile/hwsampler.c
@@ -578,7 +578,7 @@ static struct notifier_block hws_oom_notifier = {
 	.notifier_call = hws_oom_callback
 };
 
-static int __cpuinit hws_cpu_callback(struct notifier_block *nfb,
+static int hws_cpu_callback(struct notifier_block *nfb,
 	unsigned long action, void *hcpu)
 {
 	/* We do not have sampler space available for all possible CPUs.
-- 
1.7.3.4



-- 
Advanced Micro Devices, Inc.
Operating System Research Center
