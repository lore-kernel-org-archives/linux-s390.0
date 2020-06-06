Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728812AbgFFST2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 6 Jun 2020 14:19:28 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] kprobes: use strncpy_from_kernel_nofault() in fetch_store_string()
Date: Sat,  6 Jun 2020 20:19:03 +0200
Message-Id: <20200606181903.49384-1-svens@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>

With the latest linux-next i noticed that some tests in the
ftrace test suites are failing on s390, namely:

[FAIL] Kprobe event symbol argument
[FAIL] Kprobe event with comm arguments

The following doesn't work anymore:

cd /sys/kernel/tracing
echo 'p:testprobe _do_fork comm=$comm ' >kprobe_events
echo 1 >events/kprobes/testprobe/enable
cat trace

it will just show

test.sh-519   [012] ....    18.580625: testprobe: (_do_fork+0x0/0x3c8) comm=(fault)

Looking at the source i see that there are two helpers for reading strings:

fetch_store_string_user() -> read string from user space
fetch_store_string() -> read string from kernel space(?)

but in the end both are using strncpy_from_user_nofault(), but
fetch_store_string() should use strncpy_from_kernel_nofault().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b1f21d558e45..ea8d0b094f1b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1278,7 +1278,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * Try to get string again, since the string can be changed while
 	 * probing.
 	 */
-	ret = strncpy_from_user_nofault(__dest, (void *)addr, maxlen);
+	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
 	if (ret >= 0)
 		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
-- 
2.17.1
