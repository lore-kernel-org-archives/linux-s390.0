Return-Path: <linux-kselftest-owner@vger.kernel.org>
From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 7/8] selftests/vm: run_vmtest.sh: update and clean up gup_test invocation
Date: Tue, 29 Sep 2020 14:27:46 -0700
Message-ID: <20200929212747.251804-8-jhubbard@nvidia.com>
In-Reply-To: <20200929212747.251804-1-jhubbard@nvidia.com>
References: <20200929212747.251804-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>

Run benchmarks on the _fast variants of gup and pup, as originally
intended.

Run the new gup_test sub-test: dump pages. In addition to exercising the
dump_page() call, it also demonstrates the various options you can use
to specify which pages to dump, and how.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/run_vmtest.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtest.sh b/tools/testing/selft=
ests/vm/run_vmtest.sh
index d1843d5f3c30..e3a8b14d9df6 100755
--- a/tools/testing/selftests/vm/run_vmtest.sh
+++ b/tools/testing/selftests/vm/run_vmtest.sh
@@ -124,9 +124,9 @@ else
 fi
=20
 echo "--------------------------------------------"
-echo "running 'gup_test -U' (normal/slow gup)"
+echo "running 'gup_test -u' (fast gup benchmark)"
 echo "--------------------------------------------"
-./gup_test -U
+./gup_test -u
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
@@ -134,10 +134,22 @@ else
 	echo "[PASS]"
 fi
=20
-echo "------------------------------------------"
-echo "running gup_test -b (pin_user_pages)"
-echo "------------------------------------------"
-./gup_test -b
+echo "---------------------------------------------------"
+echo "running gup_test -a (pin_user_pages_fast benchmark)"
+echo "---------------------------------------------------"
+./gup_test -a
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=3D1
+else
+	echo "[PASS]"
+fi
+
+echo "--------------------------------------------------------------"
+echo "running gup_test -ct -F 0x1 0 19 0x1000"
+echo "   Dumps pages 0, 19, and 4096, using pin_user_pages (-F 0x1)"
+echo "--------------------------------------------------------------"
+./gup_test -ct -F 0x1 0 19 0x1000
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
--=20
2.28.0
