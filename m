Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0155154C1E
	for <linux-s390@vger.kernel.org>; Sat, 24 Aug 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501274; cv=none; b=ZltwdMdHPw2cR+/PUbqGTHV82R4tDAn2RnXYw2iz5LSJY9f1V1MhLpLHdUrP5r6Cv9fea18knXQg8opWB1a1LYbGADBycvbiCpCveWPr6Qd9bYAI4u99kHhxZGwEM/DDzYtFepc4IpNs4PudX2RJ2m27TOaeRYWBpxNzkVa0jyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501274; c=relaxed/simple;
	bh=QCAXIfvqzTG0MXrO7ssdim+9D9p+is2V648jofVMSqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELaibFOJduy9NC4/Uyhahbj+pQ2KmTCXYJ/rRBDPjH58DRPG1YG+mMS/Xyn7PsC91GpjFS+A9lrXo/HQcY+dg6vSg9YtWn7uPaSM+lNtJNZztl8eDH2zJI7CNNDVmbFvg0rTWDhGJ354C0Pnig5TM5T4brarRn4NjqMDAO3wsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrbKr2G2Lz1j6fg;
	Sat, 24 Aug 2024 20:07:44 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 59A491402D0;
	Sat, 24 Aug 2024 20:07:50 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:07:49 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <cuigaosheng1@huawei.com>
CC: <linux-s390@vger.kernel.org>
Subject: [PATCH -next] s390/hypfs: Remove obsoleted declaration for hypfs_dbfs_exit
Date: Sat, 24 Aug 2024 20:07:49 +0800
Message-ID: <20240824120749.2519368-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The hypfs_dbfs_exit() have been removed since
commit 3325b4d85799 ("s390/hypfs: factor out filesystem code"),
and now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/s390/hypfs/hypfs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/hypfs/hypfs.h b/arch/s390/hypfs/hypfs.h
index 65f4036fd541..83ebf54cca6b 100644
--- a/arch/s390/hypfs/hypfs.h
+++ b/arch/s390/hypfs/hypfs.h
@@ -78,7 +78,6 @@ struct hypfs_dbfs_file {
 	struct dentry		*dentry;
 };
 
-extern void hypfs_dbfs_exit(void);
 extern void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df);
 extern void hypfs_dbfs_remove_file(struct hypfs_dbfs_file *df);
 
-- 
2.25.1

