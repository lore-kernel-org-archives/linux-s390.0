Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 099/123] s390: put _stext and _etext into .text section
Date: Tue, 13 Aug 2019 22:10:23 -0400
Message-Id: <20190814021047.14828-99-sashal@kernel.org>
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Andreas Krebbel <krebbel@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 24350fdadbdec780406a1ef988e6cd3875e374a8 ]

Perf relies on _etext and _stext symbols being one of 't', 'T', 'v' or
'V'. Put them into .text section to guarantee that.

Also moves padding to page boundary inside .text which has an effect that
.text section is now padded with nops rather than 0's, which apparently
has been the initial intention for specifying 0x0700 fill expression.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vmlinux.lds.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 49d55327de0bc..7e0eb40209177 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -32,10 +32,9 @@ PHDRS {
 SECTIONS
 {
 	. = 0x100000;
-	_stext = .;		/* Start of text section */
 	.text : {
-		/* Text and read-only data */
-		_text = .;
+		_stext = .;		/* Start of text section */
+		_text = .;		/* Text and read-only data */
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
@@ -47,11 +46,10 @@ SECTIONS
 		*(.text.*_indirect_*)
 		*(.fixup)
 		*(.gnu.warning)
+		. = ALIGN(PAGE_SIZE);
+		_etext = .;		/* End of text section */
 	} :text = 0x0700
 
-	. = ALIGN(PAGE_SIZE);
-	_etext = .;		/* End of text section */
-
 	NOTES :text :note
 
 	.dummy : { *(.dummy) } :data
-- 
2.20.1
