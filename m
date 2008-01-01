Return-Path: <linux-kernel-owner+w=401wt.eu-S1754068AbYAAHZv@vger.kernel.org>
Date: Tue, 1 Jan 2008 15:25:55 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch 3/8] S390: Remove 'TOPDIR' from Makefiles
Message-ID: <20080101072555.GD2496@hacking>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
References: <20080101071311.GA2496@hacking>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080101071311.GA2496@hacking>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


TOPDIR is obsolete, use objtree instead.
This patch removes TOPDIR from all s390 Makefiles.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 56cb710..a753a71 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -34,4 +34,4 @@ obj-$(CONFIG_KEXEC) += $(S390_KEXEC_OBJS)
 #
 # This is just to get the dependencies...
 #
-binfmt_elf32.o:	$(TOPDIR)/fs/binfmt_elf.c
+binfmt_elf32.o:	$(objtree)/fs/binfmt_elf.c
