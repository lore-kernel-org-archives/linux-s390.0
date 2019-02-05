Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 5 Feb 2019 13:43:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
Message-Id: <20190205124349.GA10167@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Andreas Krebbel <krebbel@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
> On 1/23/19 5:24 AM, Heiko Carstens wrote:
> >On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
> >>There's a build failure with gcc9:
> >>
> >>  ./arch/s390/include/asm/jump_label.h: Assembler messages:
> >>  ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
> >>  ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
> >>  make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
...
> I've had to turn off s390 in Fedora until this gets fixed :(

Laura, the patch below should fix this (temporarily). If possible,
could you give it a try? It seems to work for me.

rom 4067027c2ccc8d3f1dc3bb19fe2d00da0c65bcd8 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 5 Feb 2019 13:21:56 +0100
Subject: [PATCH] s390: disable section anchors

Disable section anchors to allow to compile with the current gcc 9
experimental version. The section anchors is a new feature for s390
with gcc 9, however it breaks our current usage of the 'X' constraint
within the asm goto construct within our jump label implementation.

Fixing this seems to be non-trivial, therefore (hopefully) temporarily
disable section anchors. We will hopefully have a better solution
before gcc 9 is released, so that this can be removed again.

Reported-by: Laura Abbott <labbott@redhat.com>
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e21053e5e0da..1eac75bc3a29 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -62,6 +62,14 @@ cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 #
 cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
 
+#
+# Disable section anchors. This gcc 9 feature currently breaks the 'X'
+# constraint like it is used in the asm goto construct.
+#
+ifeq ($(call cc-option-yn,-fno-section-anchors),y)
+cflags-y += -fno-section-anchors
+endif
+
 ifeq ($(call cc-option-yn,-mpacked-stack),y)
 cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
 aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
-- 
2.16.4
