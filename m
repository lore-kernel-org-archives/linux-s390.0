Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8EC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 03:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE6161B96
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 03:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhKPD34 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238455AbhKPD3J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Nov 2021 22:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637033168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=A92HW502rBoBJ7fN3ywOBgWMU5CO0WHpnfLzl9sxtUw=;
        b=jC0iQvDFBy/yuLs048n1aTi0q6lKdy4jvdJRXmhg0N4qhtjGyZdsoN20o1SHZ8meqdm35F
        QNFkX9cuWntwxQ2V/x8hgtCHkULgCH1nnbOI3rXv8+XT7nPizC76mMfgM1nQfqQN/rhPji
        k3n7OF5dtAfhE4t3EKWjADskK5CX6iM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-U6926B4YOx6hQBAQxL6tTw-1; Mon, 15 Nov 2021 22:26:07 -0500
X-MC-Unique: U6926B4YOx6hQBAQxL6tTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4796D1006AA3;
        Tue, 16 Nov 2021 03:26:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACE15DEFB;
        Tue, 16 Nov 2021 03:26:02 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        hca@linux.ibm.com, prudo@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] s390/kexec: check the return value of ipl_report_finish
Date:   Tue, 16 Nov 2021 11:25:56 +0800
Message-Id: <20211116032557.14075-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In function ipl_report_finish(), it could fail by memory allocation
failure, so check the return value to handle the case.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/include/asm/ipl.h           | 2 +-
 arch/s390/kernel/ipl.c                | 6 ++++--
 arch/s390/kernel/machine_kexec_file.c | 5 ++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index 3f8ee257f9aa..864ab5d2890c 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -122,7 +122,7 @@ struct ipl_report_certificate {
 
 struct kexec_buf;
 struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib);
-void *ipl_report_finish(struct ipl_report *report);
+int ipl_report_finish(struct ipl_report *report, void **ipl_buf);
 int ipl_report_free(struct ipl_report *report);
 int ipl_report_add_component(struct ipl_report *report, struct kexec_buf *kbuf,
 			     unsigned char flags, unsigned short cert);
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index e2cc35775b99..a0af0b23148d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2144,7 +2144,7 @@ struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib)
 	return report;
 }
 
-void *ipl_report_finish(struct ipl_report *report)
+int ipl_report_finish(struct ipl_report *report, void **ipl_buf)
 {
 	struct ipl_report_certificate *cert;
 	struct ipl_report_component *comp;
@@ -2195,7 +2195,9 @@ void *ipl_report_finish(struct ipl_report *report)
 	}
 
 	BUG_ON(ptr > buf + report->size);
-	return buf;
+	*ipl_buf = buf;
+
+	return 0;
 }
 
 int ipl_report_free(struct ipl_report *report)
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 528edff085d9..17e961975624 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -170,6 +170,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	struct kexec_buf buf;
 	unsigned long addr;
 	void *ptr, *end;
+	int ret;
 
 	buf.image = image;
 
@@ -199,7 +200,9 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		ptr += len;
 	}
 
-	buf.buffer = ipl_report_finish(data->report);
+	ret = ipl_report_finish(data->report, &buf.buffer);
+	if (ret)
+		return ret;
 	buf.bufsz = data->report->size;
 	buf.memsz = buf.bufsz;
 
-- 
2.17.2

