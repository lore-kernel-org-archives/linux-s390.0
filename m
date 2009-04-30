Return-Path: <linux-kernel-owner+w=401wt.eu-S932181AbZEAAJh@vger.kernel.org>
From: Tim Abbott <tabbott@MIT.EDU>
Subject: [PATCH 5/6] s390: use new macro for .data.read_mostly section.
Date: Thu, 30 Apr 2009 19:57:20 -0400
Message-Id: <1241135841-9619-6-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135841-9619-5-git-send-email-tabbott@mit.edu>
References: <1241135841-9619-1-git-send-email-tabbott@mit.edu>
 <1241135841-9619-2-git-send-email-tabbott@mit.edu>
 <1241135841-9619-3-git-send-email-tabbott@mit.edu>
 <1241135841-9619-4-git-send-email-tabbott@mit.edu>
 <1241135841-9619-5-git-send-email-tabbott@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>
List-ID: <linux-s390.vger.kernel.org>

.data.read_mostly should not need a separate output section; this
change moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/vmlinux.lds.S |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index b10a950..7e83e99 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -63,14 +63,10 @@ SECTIONS
 		PAGE_ALIGNED_DATA
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(0x100)
+		READ_MOSTLY_DATA(0x100)
 		DATA_DATA
 		CONSTRUCTORS
 	}
-
-	. = ALIGN(0x100);
-	.data.read_mostly : {
-		*(.data.read_mostly)
-	}
 	_edata = .;		/* End of data section */
 
 	/* will be freed after init */
-- 
1.6.2.1
