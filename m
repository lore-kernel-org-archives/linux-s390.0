Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH] arch/s390/kernel/crash_dump.c: included linux/crash_dump.h twice
Date: Thu, 16 Feb 2012 14:55:41 +0100
Message-Id: <1329400541-31849-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Danny Kukawka <dkukawka@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

arch/s390/kernel/crash_dump.c included 'linux/crash_dump.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/s390/kernel/crash_dump.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 39f8fd4..c383ce4 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
-#include <linux/crash_dump.h>
 #include <linux/bootmem.h>
 #include <linux/elf.h>
 #include <asm/ipl.h>
-- 
1.7.8.3
