Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984416FF47
	for <linux-s390@vger.kernel.org>; Thu,  2 May 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670735; cv=none; b=K5gGmjqlfGU1dEOrWOxVfn8KXzXwr6cmlx8WuYj11svokAVpNGX+nDKUC/pG379ZImO9JU2coQku4dPDogLUMRQhyLskZwTJk8mrauKYrEGIYKAdGiOVo842u9Cqa++x3S5Q2THrqZy6vsfXceU4oHEyoqtlxVRnXS8lUWj6HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670735; c=relaxed/simple;
	bh=9sK3cgXcw0kGGdqcttliMVoT7IUpCFpfEgwKdV1yFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDCKsFB070+1fXNpqY2YQhSK9h4jbxTZ23Gk0Gzhp3mXBVjHtZksSZePMzHbWoxp8h656jpa/nPNd2pZ3nWVFcCqaDFkG7pl4vpnh/4YMGCH4d4ODUK81GZ1hse6Vi6mVAt8hHTO8L0poezcCHi87qASC/4qm+uroAujpX4/u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiKSJ0kl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiKSJ0kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714670732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBG6GaiLjRiP4gKHlRkscXOFUfjsp8h8LuC83O9Byb0=;
	b=MiKSJ0klBs5aFnCfzg/itsDMmCmZ3H+gt2fAfQjyvntUV1nuI1Lj1N/2L9B5i9bCNK7Sky
	Ci++otxtqweFqpZcUef1u/TaOd4ddw1tSccK6LCloA1f13QYKwIbPjznkwvYCC2up8lcUO
	fg0Ezt2JIk4uGCFJ3++auQvt2RM3eX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-xluJ9S7dP_ClqJymeEvQpA-1; Thu, 02 May 2024 13:25:29 -0400
X-MC-Unique: xluJ9S7dP_ClqJymeEvQpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1447F830D37;
	Thu,  2 May 2024 17:25:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9C7CC15771;
	Thu,  2 May 2024 17:25:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] s390: Remove comment about TIF_FPU
Date: Thu,  2 May 2024 19:25:27 +0200
Message-ID: <20240502172527.56835-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

It has been removed in commit 2c6b96762fbd ("s390/fpu: remove TIF_FPU"),
so we should not mention TIF_FPU in the comment here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index dd456b475861..3e7df2e579f1 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -88,8 +88,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	/*
 	 * Save the floating-point or vector register state of the current
-	 * task and set the TIF_FPU flag to lazy restore the FPU register
-	 * state when returning to user space.
+	 * task.
 	 */
 	save_user_fpu_regs();
 
-- 
2.44.0

