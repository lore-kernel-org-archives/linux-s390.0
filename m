Return-Path: <linux-kernel-owner+w=401wt.eu-S1757728AbZCRMtn@vger.kernel.org>
Message-Id: <20090318124844.895336869@de.ibm.com>
References: <20090318124829.637003183@de.ibm.com>
Date: Wed, 18 Mar 2009 13:48:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] __div64_31 broken for CONFIG_MARCH_G5
Content-Disposition: inline; filename=001-div64.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, stable@kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The implementation of __div64_31 for G5 machines is broken. The comments
in __div64_31 are correct, only the code does not do what the comments
say. The part "If the remainder has overflown subtract base and increase
the quotient" is only partially realized, the base is subtracted correctly
but the quotient is only increased if the dividend had the last bit set.
Using the correct instruction fixes the problem.

Cc: stable@kernel.org
Reported-by: Frans Pop <elendil@planet.nl>
Tested-by: Frans Pop <elendil@planet.nl>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/div64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/lib/div64.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/div64.c
+++ quilt-2.6/arch/s390/lib/div64.c
@@ -61,7 +61,7 @@ static uint32_t __div64_31(uint64_t *n, 
 		"	clr	%0,%3\n"
 		"	jl	0f\n"
 		"	slr	%0,%3\n"
-		"	alr	%1,%2\n"
+		"	ahi	%1,1\n"
 		"0:\n"
 		: "+d" (reg2), "+d" (reg3), "=d" (tmp)
 		: "d" (base), "2" (1UL) : "cc" );

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
