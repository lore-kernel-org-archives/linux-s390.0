Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgIWNsP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 09:48:15 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PATCH kvm-unit-tests v2 2/4] scripts: add support for architecture dependent functions
Date: Wed, 23 Sep 2020 15:47:56 +0200
Message-Id: <20200923134758.19354-3-mhartmay@linux.ibm.com>
In-Reply-To: <20200923134758.19354-1-mhartmay@linux.ibm.com>
References: <20200923134758.19354-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org

This is necessary to keep architecture dependent code separate from
common code.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 README.md           | 3 ++-
 scripts/common.bash | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 48be206c6db1..24d4bdaaee0d 100644
--- a/README.md
+++ b/README.md
@@ -134,7 +134,8 @@ all unit tests.
 ## Directory structure
 
     .:                  configure script, top-level Makefile, and run_tests.sh
-    ./scripts:          helper scripts for building and running tests
+    ./scripts:          general architecture neutral helper scripts for building and running tests
+    ./scripts/<ARCH>:   architecture dependent helper scripts for building and running tests
     ./lib:              general architecture neutral services for the tests
     ./lib/<ARCH>:       architecture dependent services for the tests
     ./<ARCH>:           the sources of the tests and the created objects/images
diff --git a/scripts/common.bash b/scripts/common.bash
index 96655c9ffd1f..c7acdf14a835 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -1,3 +1,4 @@
+source config.mak
 
 function for_each_unittest()
 {
@@ -52,3 +53,10 @@ function for_each_unittest()
 	fi
 	exec {fd}<&-
 }
+
+# The current file has to be the only file sourcing the arch helper
+# file
+ARCH_FUNC=scripts/${ARCH}/func.bash
+if [ -f "${ARCH_FUNC}" ]; then
+	source "${ARCH_FUNC}"
+fi
-- 
2.25.4
