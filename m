Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Oct 2017 09:55:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.14-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171027095519.75216309@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

"A fix for a regression in regard to machine check handling in KVM."

Keeping my fingers crossed that this is the last s390 fix for v4.14.

Martin Schwidefsky (1):
      s390/kvm: fix detection of guest machine checks

 arch/s390/kernel/entry.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 21900e1..d185aa3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -521,12 +521,15 @@ ENTRY(pgm_check_handler)
 	tmhh	%r8,0x0001		# test problem state bit
 	jnz	2f			# -> fault in user space
 #if IS_ENABLED(CONFIG_KVM)
-	# cleanup critical section for sie64a
+	# cleanup critical section for program checks in sie64a
 	lgr	%r14,%r9
 	slg	%r14,BASED(.Lsie_critical_start)
 	clg	%r14,BASED(.Lsie_critical_length)
 	jhe	0f
-	brasl	%r14,.Lcleanup_sie
+	lg	%r14,__SF_EMPTY(%r15)		# get control block pointer
+	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
+	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
+	larl	%r9,sie_exit			# skip forward to sie_exit
 #endif
 0:	tmhh	%r8,0x4000		# PER bit set in old PSW ?
 	jnz	1f			# -> enabled, can't be a double fault
