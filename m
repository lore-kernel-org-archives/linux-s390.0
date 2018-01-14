From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sun, 14 Jan 2018 18:56:34 +0000
Subject: [man-pages PATCH 3/5] s390_sthyi.2: wfix
Message-Id: <20180114185634.GA23726@asgard.redhat.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

---
 man2/s390_sthyi.2 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man2/s390_sthyi.2 b/man2/s390_sthyi.2
index 21a0de6..8c33041 100644
--- a/man2/s390_sthyi.2
+++ b/man2/s390_sthyi.2
@@ -51,7 +51,7 @@ Return CP (Central Processor) and IFL (Integrated Facility for Linux)
 capacity information.
 .PP
 The
-.I resp_buffer 
+.I resp_buffer
 argument specifies the address of a response buffer.
 If the system call returns 0,
 the response buffer will be filled with CPU capacity information.
@@ -98,7 +98,7 @@ is set appropriately.
 .TP
 .B EFAULT
 The value specified in
-.I resp_buffer 
+.I resp_buffer
 or
 .I return_code
 is not a valid address.
@@ -113,7 +113,7 @@ Allocating memory for handling the CPU capacity information failed.
 .TP
 .B EOPNOTSUPP
 The value specified in
-.I function_code 
+.I function_code
 is not valid.
 .SH VERSIONS
 This system call is available since Linux 4.15.
-- 
2.1.4
