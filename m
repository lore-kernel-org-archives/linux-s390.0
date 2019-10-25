Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409654AbfJYRGl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 13:06:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PH3fNh081382
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv4ax9qgw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 25 Oct 2019 18:06:39 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 3/5] s390x: sclp: expose ram_size and max_ram_size
Date: Fri, 25 Oct 2019 19:06:32 +0200
In-Reply-To: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
Message-Id: <1572023194-14370-4-git-send-email-imbrenda@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

Expose ram_size and max_ram_size through accessor functions.

We only use get_ram_size in an upcoming patch, but having an accessor
for the other one does not hurt.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/s390x/sclp.h |  2 ++
 lib/s390x/sclp.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index f00c3df..6d40fb7 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -272,5 +272,7 @@ void sclp_console_setup(void);
 void sclp_print(const char *str);
 int sclp_service_call(unsigned int command, void *sccb);
 void sclp_memory_setup(void);
+uint64_t get_ram_size(void);
+uint64_t get_max_ram_size(void);
 
 #endif /* SCLP_H */
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 56fca0c..7798f04 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -167,3 +167,13 @@ void sclp_memory_setup(void)
 
 	mem_init(ram_size);
 }
+
+uint64_t get_ram_size(void)
+{
+	return ram_size;
+}
+
+uint64_t get_max_ram_size(void)
+{
+	return max_ram_size;
+}
-- 
2.7.4
