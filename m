Return-Path: <linux-kernel-owner+w=401wt.eu-S1756137AbZHNL33@vger.kernel.org>
Message-Id: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/34] s390 patch queue for the merge window of 2.6.32
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
the current patch queue on git390 for the next merge window.
34 patches, most of it the usual churn: minor bug fixes too
big for 2.6.31-rc, various cleanups and two new things:
a patch to complete the extra kernel parameters via VMPARM
support introduced by git commit a0443fbb and the call home
features. Have fun.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
