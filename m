Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E1BA42;
	Mon, 21 Apr 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221810; cv=none; b=J7j3JK040F1nMcVsa1sHpRYH8OmfX8iEWkPSDRRO8J06G8/vIwZhUqwGdnZ5axDScQI6B1PNG1LaAzjt1Y6iN1+TNfAbLJlKV5JvzZxQP5LDXSiSJaFimVX/hF1tk3n8SJREqe9v7zUEs7f+oR2GPT577ZuYOXzpd3tqV+97p0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221810; c=relaxed/simple;
	bh=wTsZYmm2pAqLelL3UVHkoAMydh9zg7fvSF3SnttQ/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/lfflzQQXrp5ShHvvu3HqvRQvbDfz2dIUHlL4ks8dKhQpX7yFqbJeOzj4ZPWNRu+W/3nh+WTsKa81CJOt8tSOO//7DpJ1pKzgkYo15DPa2gvyAsM2DL6MFnM3Uj5L+ZbgkvZgFrMizYFdJ8q5F9osbDubiUFWJPxj83rPBwSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jFw/cD5p; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jFw/cD5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745221778;
	bh=qu4q51PjxAhfDwTA0u/iISMTedsv2fguCwNOIgWot8c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jFw/cD5pcszJL30jIf7eoePIN2eUbL6tWMQmkiAwrFePRUJ3tVuAsHmCsgilzZLQT
	 QomuqDJgleo8os9m5a1MJGBDx7dcMoEHrDoCkIGS8EsmethVl2EzOjop1oLt3xGron
	 HqFiG9fMt0IEKM7nwptpI627YUR8vv9KVdYzmRNY=
X-QQ-mid: zesmtpip2t1745221766t1e4eed61
X-QQ-Originating-IP: ITFu4vYdFsvIJEiRbyj6+Ap1A91byOWzPNnCEP5NH/U=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Apr 2025 15:49:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12892315890495299956
EX-QQ-RecipientCnt: 22
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	dri-devel@lists.freedesktop.org,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	guanwentao@uniontech.com,
	hca@linux.ibm.com,
	jesse.brandeburg@intel.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	meted@linux.ibm.com,
	niecheng1@uniontech.com,
	obitton@habana.ai,
	shenlichuan@vivo.com,
	svens@linux.ibm.com,
	viro@zeniv.linux.org.uk,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v2] treewide: Fix typo "previlege"
Date: Mon, 21 Apr 2025 15:49:10 +0800
Message-ID: <46AD404E411A4BAC+20250421074910.66988-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <F3FFD123DE5F85F3+20250421073837.64732-1-wangyuli@uniontech.com>
References: <F3FFD123DE5F85F3+20250421073837.64732-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OLQOzk6QkjoibDvwZzd8988BNL5S2IeNfXJbKWtYdhVeR9W+Ye0eVUbs
	aLPDV1GSQDS4t8M0W9OScTSHMdS8Any4qzupoJiLCVFlU7WTQ1AIPNoNRgmZt/EEAfTGDXa
	gTS7pB25o4mSDQ/DdGx8hyfbrPvptMa87EXYBrFVg6fzHdlKNGptl8thGrpoyPDAzhnl8wd
	AsrBz/tyxVsVCKAMmeuBMNodJ6yRcHuK5xBeGYB4FMuNOc3XPATF1SSEGWWsI73uJ9CP+Pg
	DCnJosW7XeFB1vST/2+umrkejTMl0glkEijGrt/twxNIKPl/W0vwToPV7aPT2b9WaAhFi/p
	jYiM7WdFr9r+GCjtWTvFHDd77eID14ZjCA/1lhFdGuBIxMncOEZRcGPPTSgo4IwAoCmG/iU
	x2/R5oF8muGBnpp6gBAhUVeTVHd6opTMkvcqa6Cydby67BJ7dQ1IUv8cI/VU/bEMxuSAoMT
	G+jq1aaGKvjDlwcXnPnnYNVzXRwsKezMFlNqAtdUG6+zQ/6FGvfgd7l1UW3s+eBJEwjomkT
	QG/4BszAWHKqzJXAkKo4HDLbNCOVDtvyYZbl/LsDDxq2IeAvWCf4J2lwhxjg0L/dsAi/1TD
	xxuzd+JP7SI1YqCGejcBVudE4lIgYgtA6gVYytNgmW7VdrxlHxdJCO1DuiL2eqWNlnvEcwJ
	4YuQPWq0PK699w07gg4SGIxmbjxuaeKy6g3BpttRiTYZEQrJXLizKovM+JJkyFui5kbbP/x
	TXyUVMEWte2/m2m/vbeaWkO3sScvvYfbF8bUSzZzX/plQdZigoIs3c5dD5s8ycCToIwNv0U
	+ldKrvN8oW6YfssI06PL5MopdtQcRqXv/KkLGzcmCBUawdTofWg2IsNzPehYlnoC+LvivVq
	gFhZHYeX2ehsP+B2pEhdobUZCufhZXvhc+c7HTFreytzF3ExmxjD14z60hHRrkkNMB3ZLBZ
	gz1//pcYsm+eeGh/w65+a0FLI+Gi9DXyZEE0gok+qJcITwYYnrPdMyvgXTinIu8ghKGTNh6
	GfKp7KybKIV38PTRwzv7eFXo98TermJRd8pcQS1/c4YOQE5WIFKyDwQ6vzPI5VU7ho9f5Yb
	TBfobwhLhoqzQq/ADP67afnPy0d8i0dhoWXP/UHVkO+yfEZE62eWAA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'previlege' in comments which
should be 'privilege'.

Fix them and add it to scripts/spelling.txt.

The typo in arch/loongarch/kvm/main.c was corrected by a different
patch [1] and is therefore not included in this submission.

[1]. https://lore.kernel.org/all/20250420142208.2252280-1-wheatfox17@icloud.com/

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2: Fix typo in commit msg...
---
 drivers/s390/char/vmlogrdr.c          | 4 ++--
 include/linux/habanalabs/hl_boot_if.h | 2 +-
 scripts/spelling.txt                  | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index dac85294d2f5..e284eea331d7 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -255,7 +255,7 @@ static int vmlogrdr_recording(struct vmlogrdr_priv_t * logptr,
 
 	/*
 	 * The recording commands needs to be called with option QID
-	 * for guests that have previlege classes A or B.
+	 * for guests that have privilege classes A or B.
 	 * Purging has to be done as separate step, because recording
 	 * can't be switched on as long as records are on the queue.
 	 * Doing both at the same time doesn't work.
@@ -557,7 +557,7 @@ static ssize_t vmlogrdr_purge_store(struct device * dev,
 
         /*
 	 * The recording command needs to be called with option QID
-	 * for guests that have previlege classes A or B.
+	 * for guests that have privilege classes A or B.
 	 * Other guests will not recognize the command and we have to
 	 * issue the same command without the QID parameter.
 	 */
diff --git a/include/linux/habanalabs/hl_boot_if.h b/include/linux/habanalabs/hl_boot_if.h
index d2a9fc96424b..af5fb4ad77eb 100644
--- a/include/linux/habanalabs/hl_boot_if.h
+++ b/include/linux/habanalabs/hl_boot_if.h
@@ -295,7 +295,7 @@ enum cpu_boot_dev_sts {
  *					Initialized in: linux
  *
  * CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN	GIC access permission only from
- *					previleged entity. FW sets this status
+ *					privileged entity. FW sets this status
  *					bit for host. If this bit is set then
  *					GIC can not be accessed from host.
  *					Initialized in: linux
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index a290db720b0f..ac94fa1c2415 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1240,6 +1240,8 @@ prefered||preferred
 prefferably||preferably
 prefitler||prefilter
 preform||perform
+previleged||privileged
+previlege||privilege
 premption||preemption
 prepaired||prepared
 prepate||prepare
-- 
2.49.0

