Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527F3FE650
	for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373798; cv=none; b=AG42qVB6pitXj5HfSUeshzx3WmOo2sax/JCpwL1YnnkxOi421WmtDKk2udn+N0fTyaOCiwkSu1u6u6OfxSu58/76uzeddYWFZ4Hhsm+CFBJi+cVwtcsJXwhvawjB8m0QJ93UVx+lpJfQWkfJd1Q+LjGFiVf1isuxPqc24ngNeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373798; c=relaxed/simple;
	bh=NMv+VxeuwDNn6g3TW4koZ+em4kr4EvwstGVdl+4Dfw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=FsuId0PKwEttqN3ZMSXrzc1/nYe2w0ZjvhoZ8ySfkf5St3vh5iBg7D3wXTl1wiXp4o5Zc6E2z45XY7PmHNGCOgKrGipxQTZj7agBf7G86Pho0vXRQemsnj9so0vRN8DBNp1dtgrpyBGIvy9KPN49RyF3kO+oMAKFUIxEjn0gpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fMCLfgkL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fMCLfgkL"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260428105634epoutp0186538bde07ba7c6f14ad9b72acd6112b~qgAyEBETl2478824788epoutp01e
	for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 10:56:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260428105634epoutp0186538bde07ba7c6f14ad9b72acd6112b~qgAyEBETl2478824788epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777373794;
	bh=Mj2IP8DLHGXXP4c161i0NJGqeOoEZnUlzGwEj1TVGak=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fMCLfgkLKrZA+YBHoAPcUQ4lo6mV9I7Rt2Ew8LAbQ4F8MpPaKBd+ifYx4cp5HNOjn
	 UbfCBdENKPo/jfNKA+MQT91hjXCuF0cR/9xv91u5MuJOli7yiA/9mynH9zvyjjn3OF
	 bWqgFkeGwPiPoUB741YhmHnKsQ0AClnfRYTmZYyU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260428105633epcas5p4cd4949bb3499e767536ec2d1d1c8b514~qgAxiPoq20050600506epcas5p43;
	Tue, 28 Apr 2026 10:56:33 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4g4cnF4FWVz6B9m7; Tue, 28 Apr
	2026 10:56:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260428105633epcas5p37a93b7abb3d2ce0d1c2fbf6a72634ea7~qgAxE1A200405904059epcas5p39;
	Tue, 28 Apr 2026 10:56:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.97.243.203]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260428105631epsmtip1aa0b712b712c85eb35aa762ed2c9aa0f~qgAvt3f1Q2329723297epsmtip1E;
	Tue, 28 Apr 2026 10:56:31 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>
Subject: [PATCH 1/1] s390: remove extra check of task_stack_page()
Date: Tue, 28 Apr 2026 16:26:07 +0530
Message-Id: <20260428105607.1283661-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260428105633epcas5p37a93b7abb3d2ce0d1c2fbf6a72634ea7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260428105633epcas5p37a93b7abb3d2ce0d1c2fbf6a72634ea7
References: <CGME20260428105633epcas5p37a93b7abb3d2ce0d1c2fbf6a72634ea7@epcas5p3.samsung.com>

There is no need to call task_stack_page(),
because try_get_task_stack() already takes care of that.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/s390/kernel/process.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 0df95dcb2101..dabd569dbba8 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -203,9 +203,6 @@ unsigned long __get_wchan(struct task_struct *p)
 	struct unwind_state state;
 	unsigned long ip = 0;
 
-	if (!task_stack_page(p))
-		return 0;
-
 	if (!try_get_task_stack(p))
 		return 0;
 
-- 
2.34.1

