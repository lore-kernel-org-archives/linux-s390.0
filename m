Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E01487F2
	for <linux-s390@vger.kernel.org>; Fri,  3 May 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723620; cv=none; b=mc3Cl8v/rENhEG6p786Ynbu6E1DXzrA4u0VEPKba3f4Ks8NZfN3GnY7hYvs4SCq2B0I01+W2wZSTIh82SqUEtCXDHDJExgZWhLPmUep7BlH6pDhvPkN6bUTwshAvgghxOYGai0T7TGx1dkmMJxZPpbDBK2oKPI9CwlPsxWDSuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723620; c=relaxed/simple;
	bh=XTfAo570ipDqa5PmAidNrBIOxSfaySsMHMjW3Y3DQVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPNy01pWJ+SI3Gk11g6UvZzWNGF1yoIRciII94wMzTs1FhRzTzZI8oHCnqrtQdcaxJL+BHJiNlrSvYgB2zT8HtFQ3srdT14ZmjJljcLwpoEqe2KrOTxharXcp4WFqlr7tLBevhRLL351Y6FMxdWXOy0UZ15Uf017X1oFjYd55tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caGzg8M0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caGzg8M0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714723617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z+zU3AeWmNst/4jBWwt/IVxOgw0orJOeFMMHxayccOs=;
	b=caGzg8M0T2T6wEQHoPRfiF5C+8aIpFWxb/Gq80AF8jAFvLwyE8uGjqlRVGeXk/JGIjrM8J
	QnPs+YJnqiukCi6txQM9NYNxG4l6bynPA/3i3nSvpnuLhhcrjti7ax1IY8jHy9uLoFWlLk
	C64DnrqwUqrMw68FwLMmQgqXUtx6rNM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-IVHiuRcBO_eWr7E1No7rBw-1; Fri,
 03 May 2024 04:06:52 -0400
X-MC-Unique: IVHiuRcBO_eWr7E1No7rBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E2141C0314D;
	Fri,  3 May 2024 08:06:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D94D1C060D0;
	Fri,  3 May 2024 08:06:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2] s390: Remove comment about TIF_FPU
Date: Fri,  3 May 2024 10:06:48 +0200
Message-ID: <20240503080648.81461-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

It has been removed in commit 2c6b96762fbd ("s390/fpu: remove TIF_FPU"),
so we should not mention TIF_FPU in the comment here anymore. Since the
remaining parts of the comment just document the obvious fact that
save_user_fpu_regs() saves the FPU state, simply remove the comment now
completely.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop the comment completely

 arch/s390/kernel/process.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index dd456b475861..d8740631df4b 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -86,11 +86,6 @@ void arch_release_task_struct(struct task_struct *tsk)
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	/*
-	 * Save the floating-point or vector register state of the current
-	 * task and set the TIF_FPU flag to lazy restore the FPU register
-	 * state when returning to user space.
-	 */
 	save_user_fpu_regs();
 
 	*dst = *src;
-- 
2.44.0

