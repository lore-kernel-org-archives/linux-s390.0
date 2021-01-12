Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733164AbhALNWD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 08:22:03 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v4 9/9] s390x: sclp: Add CPU entry offset comment
Date: Tue, 12 Jan 2021 08:20:54 -0500
Message-Id: <20210112132054.49756-10-frankja@linux.ibm.com>
In-Reply-To: <20210112132054.49756-1-frankja@linux.ibm.com>
References: <20210112132054.49756-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

Let's make it clear that there is something at the end of the
struct. The exact offset is reported by the cpu_offset member.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sclp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index dccbaa8..395895f 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -134,7 +134,10 @@ typedef struct ReadInfo {
 	uint8_t reserved7[134 - 128];
 	uint8_t byte_134_diag318 : 1;
 	uint8_t : 7;
-	struct CPUEntry entries[0];
+	/*
+	 * The cpu entries follow, they start at the offset specified
+	 * in offset_cpu.
+	 */
 } __attribute__((packed)) ReadInfo;
 
 typedef struct ReadCpuInfo {
-- 
2.25.1
