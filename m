Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A5288527
	for <linux-s390@vger.kernel.org>; Wed, 11 Jun 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650470; cv=none; b=aIbTq4lVOjZXygrYGjz2CTB6AmkjjjtsXTvbOirm9P6yBOVV5jigLVqoXGUzrfQMozaZrj55lIRuPYlpYWdJvScXu6Zodl6fT+0PsVAFaPCiNRndj6S8YiFKm3tQU37aNBnHCic6rmW9/Gq0aaSvLX+NoN2WBI3QgZupsHi83HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650470; c=relaxed/simple;
	bh=revMLyhinwvcorsD62YAA45WO7GTotF+WHUoCxkO3zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOEbM6VGzTKzVhx65n3y0874neU09B4tvndkjudpdMqOKnALYdea83jX0uFB/dUfsBsWVir9fo99E5WSv9H7KHj8UhniWjE1rHt4CWOjrCt4n/qJ/hAX1pQnSZb+mkMRwNwSSNXfI79NeiAqypmtUHX3Mk2o3959Ycc6fGcPubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg4Lo/oX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg4Lo/oX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etE2jqMIW6xwxh/nIOadkwguKp7mltmBvnGaA0W2bd8=;
	b=bg4Lo/oXVWvZseD4Psffoo0gl5AZ8py2IE2qv2VFAvt+Xu1zpy1mXM0dsWDriailrwOP0+
	S7b46D5mlbgdzzXCTmS6WLXPE3pzlOQOgoGYuBBZTj49kEGj35dM1goq9c1GiB+7G7os7P
	qjXzZnIQKFbqMAgqcjsZwvvC9d8ynsc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-6Nweo3WXPLi3ybaCq1f7vQ-1; Wed,
 11 Jun 2025 10:01:02 -0400
X-MC-Unique: 6Nweo3WXPLi3ybaCq1f7vQ-1
X-Mimecast-MFC-AGG-ID: 6Nweo3WXPLi3ybaCq1f7vQ_1749650455
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED9381955F40;
	Wed, 11 Jun 2025 14:00:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7720318003FC;
	Wed, 11 Jun 2025 14:00:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 1/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Wed, 11 Jun 2025 16:00:45 +0200
Message-ID: <20250611140046.137739-2-thuth@redhat.com>
In-Reply-To: <20250611140046.137739-1-thuth@redhat.com>
References: <20250611140046.137739-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Thomas Huth <thuth@redhat.com>

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembler
code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/include/uapi/asm/ptrace.h | 5 +++--
 arch/s390/include/uapi/asm/schid.h  | 4 ++--
 arch/s390/include/uapi/asm/types.h  | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index bb0826024bb95..ea202072f1ad5 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -242,7 +242,8 @@
 #define PTRACE_OLDSETOPTIONS		21
 #define PTRACE_SYSEMU			31
 #define PTRACE_SYSEMU_SINGLESTEP	32
-#ifndef __ASSEMBLY__
+
+#ifndef __ASSEMBLER__
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -450,6 +451,6 @@ struct user_regs_struct {
 	unsigned long ieee_instruction_pointer;	/* obsolete, always 0 */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_S390_PTRACE_H */
diff --git a/arch/s390/include/uapi/asm/schid.h b/arch/s390/include/uapi/asm/schid.h
index a3e1cf1685534..d804d1a5b1b3f 100644
--- a/arch/s390/include/uapi/asm/schid.h
+++ b/arch/s390/include/uapi/asm/schid.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct subchannel_id {
 	__u32 cssid : 8;
@@ -15,6 +15,6 @@ struct subchannel_id {
 	__u32 sch_no : 16;
 } __attribute__ ((packed, aligned(4)));
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPIASM_SCHID_H */
diff --git a/arch/s390/include/uapi/asm/types.h b/arch/s390/include/uapi/asm/types.h
index 84457dbb26b4a..4ab468c5032e3 100644
--- a/arch/s390/include/uapi/asm/types.h
+++ b/arch/s390/include/uapi/asm/types.h
@@ -10,7 +10,7 @@
 
 #include <asm-generic/int-ll64.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef unsigned long addr_t;
 typedef __signed__ long saddr_t;
@@ -25,6 +25,6 @@ typedef struct {
 	};
 } __attribute__((packed, aligned(4))) __vector128;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_S390_TYPES_H */
-- 
2.49.0

