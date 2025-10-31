Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BAAD4B;
	Fri, 31 Oct 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895198; cv=none; b=alaKlmDkZ5XFDyRl9+hwfO2m/IHapVSfSGa87EgRXKE0XRSxRLG6YA6ZoWKjDs2aNKVGZdO/TEvHMe9+/TxMcyKO32wVgWWlJYNm5Krrxj0+Mn0fBr86Yj/+M9hNMYFrO5vbrIDzeq35z4fkU3llqw7X3LFX4wTRttEj6RAI0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895198; c=relaxed/simple;
	bh=HzsfSmIPMvkYSxvGNg6clmzwnLravppfT8kvOZj7JK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M0dMo2yMFivwqt+yQ+igNZj8TFqIsSfSlvkANnPBMIuWLxvjVmW7RlD/8W7dP6S/293l1ctxJwCOU2/qiZH1k1zXW7Fw0NcYZ7PenxfX/Tl2tkABvD7Od/H2ZzmPuK0jyKSUtrEJQ1Ads3oqinPb2CNAtKWAhaa1e5VALbpgbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510311519484386;
        Fri, 31 Oct 2025 15:19:48 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 31 Oct 2025 15:19:47 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 31 Oct 2025 15:19:47 +0800
Received: from localhost.com (unknown [10.94.18.144])
	by app1 (Coremail) with SMTP id YAJkCsDwdHQSYwRpuDI6AA--.2532S4;
	Fri, 31 Oct 2025 15:19:46 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <sth@linux.ibm.com>, <hoeppner@linux.ibm.com>, <axboe@kernel.dk>
CC: <linux-s390@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] partitions/ibm: Fix a spelling mistake
Date: Fri, 31 Oct 2025 15:18:46 +0800
Message-ID: <20251031071846.3387-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwdHQSYwRpuDI6AA--.2532S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWftr17tr4kWr4rJrW7XFb_yoWfGwb_Gw
	1Ika1UXr18Jr92vwnxCF45KrWvvw1UGF1DWFsrKws3XrW8AF4DCrn29rZFgrZxXayUWr13
	Xr98XF1ayF429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?gMd245RRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KWaEjeGlY+z6GeJZ4PnyUbEMtZbmSBC65wHo7y+C+eKhRf/5Nys9v/8ZqnnSdn8Ecwqx
	cuC+A+VMzGS1ClDofEA=
Content-Type: text/plain
tUid: 20251031151948194737514bba3967b8d3802a14985b86
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The word "formatted" is missing a letter "t" (the incorrect spelling would
 be "formated").

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 block/partitions/ibm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 631291fbb356..9a6c84773cca 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -247,7 +247,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 		size = label->lnx.formatted_blocks * secperblk;
 	} else {
 		/*
-		 * Formated w/o large volume support. If the sanity check
+		 * Formatted w/o large volume support. If the sanity check
 		 * 'size based on geo == size based on nr_sectors' is true, then
 		 * we can safely assume that we know the formatted size of
 		 * the disk, otherwise we need additional information
-- 
2.43.7

