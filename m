Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4254 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgI1GWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Sep 2020 02:22:02 -0400
From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/8] selftests/vm: use a common gup_test.h
Date: Sun, 27 Sep 2020 23:21:53 -0700
Message-ID: <20200928062159.923212-3-jhubbard@nvidia.com>
In-Reply-To: <20200928062159.923212-1-jhubbard@nvidia.com>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>

Avoid the need to copy-paste the gup_test ioctl commands and the struct
gup_test definition, between the kernel and the user space application,
by providing a new header file for these. This allows easier and safer
adding of new ioctl calls, as well as reducing the overall line count.

Details: The header file has to be able to compile independently,
because of the arguably unfortunate way that the Makefile is written:
the Makefile tries to build all of its prerequisites, when really it
should be only building the .c files, and leaving the other
prerequisites (LOCAL_HDRS) as pure dependencies.

That Makefile limitation is probably not worth fixing, but it explains
why one of the includes had to be moved into the new header file.

Also: simplify the ioctl struct (struct gup_test), by deleting the
unused __expansion[10] field. This sort of thing is what you might see
in a stable ABI, but this low-level, kernel-developer-oriented
selftests/vm system is very much not subject to ABI stability. So
"expansion" and "reserved" fields are unnecessary here.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup_test.c                         | 17 +----------------
 mm/gup_test.h                         | 22 ++++++++++++++++++++++
 tools/testing/selftests/vm/Makefile   |  2 ++
 tools/testing/selftests/vm/gup_test.c | 22 +---------------------
 4 files changed, 26 insertions(+), 37 deletions(-)
 create mode 100644 mm/gup_test.h

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 10f41c0528de..a3c86d0fdff7 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -4,22 +4,7 @@
 #include <linux/uaccess.h>
 #include <linux/ktime.h>
 #include <linux/debugfs.h>
-
-#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
-#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_test)
-#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_test)
-#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_test)
-#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_test)
-
-struct gup_test {
-	__u64 get_delta_usec;
-	__u64 put_delta_usec;
-	__u64 addr;
-	__u64 size;
-	__u32 nr_pages_per_call;
-	__u32 flags;
-	__u64 expansion[10];	/* For future use */
-};
+#include "gup_test.h"
=20
 static void put_back_pages(unsigned int cmd, struct page **pages,
 			   unsigned long nr_pages)
diff --git a/mm/gup_test.h b/mm/gup_test.h
new file mode 100644
index 000000000000..931c2f3f477a
--- /dev/null
+++ b/mm/gup_test.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __GUP_TEST_H
+#define __GUP_TEST_H
+
+#include <linux/types.h>
+
+#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
+#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_test)
+#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_test)
+#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_test)
+#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_test)
+
+struct gup_test {
+	__u64 get_delta_usec;
+	__u64 put_delta_usec;
+	__u64 addr;
+	__u64 size;
+	__u32 nr_pages_per_call;
+	__u32 flags;
+};
+
+#endif	/* __GUP_TEST_H */
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index d1ae706d9927..9cc6bc087461 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -130,3 +130,5 @@ endif
 $(OUTPUT)/userfaultfd: LDLIBS +=3D -lpthread
=20
 $(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap
+
+$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftest=
s/vm/gup_test.c
index e930135727a2..70db259582c3 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -2,39 +2,19 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-
-#include <linux/types.h>
+#include "../../../../mm/gup_test.h"
=20
 #define MB (1UL << 20)
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
=20
-#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
-#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_test)
-
-/* Similar to above, but use FOLL_PIN instead of FOLL_GET. */
-#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_test)
-#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_test)
-#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_test)
-
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
=20
-struct gup_test {
-	__u64 get_delta_usec;
-	__u64 put_delta_usec;
-	__u64 addr;
-	__u64 size;
-	__u32 nr_pages_per_call;
-	__u32 flags;
-	__u64 expansion[10];	/* For future use */
-};
-
 int main(int argc, char **argv)
 {
 	struct gup_test gup;
--=20
2.28.0
