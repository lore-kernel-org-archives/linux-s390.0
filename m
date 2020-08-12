Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727896AbgHLJ1V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Aug 2020 05:27:21 -0400
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [kvm-unit-tests RFC v2 2/4] scripts: add support for architecture dependent functions
Date: Wed, 12 Aug 2020 11:27:03 +0200
Message-Id: <20200812092705.17774-3-mhartmay@linux.ibm.com>
In-Reply-To: <20200812092705.17774-1-mhartmay@linux.ibm.com>
References: <20200812092705.17774-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

This is necessary to keep architecture dependent code separate from
common code.

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 README.md           | 3 ++-
 scripts/common.bash | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 96655c9ffd1f..f9c15fd304bd 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -52,3 +52,8 @@ function for_each_unittest()
 	fi
 	exec {fd}<&-
 }
+
+ARCH_FUNC=scripts/${ARCH}/func.bash
+if [ -f "${ARCH_FUNC}" ]; then
+	source "${ARCH_FUNC}"
+fi
-- 
2.25.4
