Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754E1A7046
	for <linux-s390@vger.kernel.org>; Mon, 10 Mar 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602429; cv=none; b=Jm/l5wyeyNl9i1Xs1yhJ9QDBLYbsLAR4apXRMJ4lzkRpJQOFdG/FNX5yLGpRkmW0GMw3zQ51+IO24cXc84C84vDkfMUodVdpGjpeBl8c8jeLhcTS11OF2gTVmIb91OhxUQqes4SxdPqpDI7/RE0ZCLT3MUJ3JZPMPhgDTxTaDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602429; c=relaxed/simple;
	bh=MrBVUwCDm2OakJrVwX6zAR4hOAXk414rT6sUa1Arz4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQbNPdvZIs1VHnuz+x7rLzavSLwNLiA8KrrHUff+pNtxbU24NW/PQ0JSlsR4stFOJ3PDpJZsHdxkXwQtBSk6iMGBdY4Yw326NX13bZL28PkhFWCT+/DHACGGg4/jsCePRFXPMSMhn8kTBcKYT4dLLAK2a4PNHMbsJdqd1xbYamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLypkPaZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLypkPaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741602426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a7eB7B6rszVCe0tDMlDTsG+YUCKsUgoY9Moab3I6Eks=;
	b=DLypkPaZ3SOOtU4rRUam79Ba9X2eEzj3OmatFUp1y7UPhRSvsbZKGxTXtVFCIwMDvH9k+a
	0Qw1YieeajQbtOlcs5ZogWKMvM+ynQFW8AlVc3dMbBhKcTwufwCe56ioaZK4KGhPehqwvS
	+fQlqhorzbIzz14UxgZC0XaNvz/4Yrc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-YFrv94yXMyeRLTgewdaJyg-1; Mon,
 10 Mar 2025 06:27:03 -0400
X-MC-Unique: YFrv94yXMyeRLTgewdaJyg-1
X-Mimecast-MFC-AGG-ID: YFrv94yXMyeRLTgewdaJyg_1741602422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17F6D18004A9;
	Mon, 10 Mar 2025 10:27:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.133])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 582BF1800946;
	Mon, 10 Mar 2025 10:26:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/uapi: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Mon, 10 Mar 2025 11:26:57 +0100
Message-ID: <20250310102657.54557-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
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
2.48.1

