Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58024 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730483AbgLOP5E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:04 -0500
From: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] lib/zlib: fix inflating zlib streams on s390
Date: Tue, 15 Dec 2020 16:55:51 +0100
Message-Id: <20201215155551.894884-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>

Decompressing zlib streams on s390 fails with "incorrect data check"
error.

Userspace zlib checks inflate_state.flags in order to byteswap checksums
only for zlib streams, and s390 hardware inflate code, which was ported
from there, tries to match this behavior. At the same time, kernel zlib
does not use inflate_state.flags, so it contains essentially random
values. For many use cases either zlib stream is zeroed out or checksum
is not used, so this problem is masked, but at least SquashFS is still
affected.

Fix by always passing a checksum to and from the hardware as is, which
matches zlib_inflate()'s expectations.

Fixes: 126196100063 ("lib/zlib: add s390 hardware support for kernel zlib_inflate")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc_inflate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index db107016d29b..fb60b5a6a1cb 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -125,7 +125,7 @@ dfltcc_inflate_action dfltcc_inflate(
     param->ho = (state->write - state->whave) & ((1 << HB_BITS) - 1);
     if (param->hl)
         param->nt = 0; /* Honor history for the first block */
-    param->cv = state->flags ? REVERSE(state->check) : state->check;
+    param->cv = state->check;
 
     /* Inflate */
     do {
@@ -138,7 +138,7 @@ dfltcc_inflate_action dfltcc_inflate(
     state->bits = param->sbb;
     state->whave = param->hl;
     state->write = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
-    state->check = state->flags ? REVERSE(param->cv) : param->cv;
+    state->check = param->cv;
     if (cc == DFLTCC_CC_OP2_CORRUPT && param->oesc != 0) {
         /* Report an error if stream is corrupted */
         state->mode = BAD;
-- 
2.25.4
