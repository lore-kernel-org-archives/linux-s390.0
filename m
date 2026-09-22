Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D92442FBD
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110153; cv=none; b=RZQ7UxsNiVaPX6qJOb4/uKvaJH44MjIbMGfzlbfgC6nREncewhmqC394MccBd6h4caMduFVX2+W7xM84W2J8sgSqOhpBoPsBsH28KifoVgLpF3KhDTEojo8SmlM3/b9LpsQ38r4ss3qj5ahGLKyvrTGuMmOneCBygK5ORIj825w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110153; c=relaxed/simple;
	bh=bI36uIbC8v28rj6MTQBOtWzPvGo0LUgf4keS3tSUDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t2luH10He4GpHgimrYyviS02nNXxKSnikN5V80Xmk2QwwLLUAm9Rq8E6oQzI2TiNYiAMJSV3cxqWNBRSzT8Ea2aiW3eTS1lLFu8dKHtLkdvsekp9BfImPXaYVyip3e0SB41MqW5bD8KXV6ECcx8Rj7IPS8Nf455FYwc1LGJqBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=APFGVhSS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="APFGVhSS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7Nsq3447412
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 20:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=2PLJY15XiOxW4tnjwcSGUQj7rDx9
	QLM27qtNsy+WjFg=; b=APFGVhSSLCv6yQxwZ0Qn2Uv+EWdAy3cSgoRN8kYgqOAB
	GSYgFS8vbNnvXCaq2PGUPZu4s1CoVCIqdEE0JsVoT6Xggqe9SnZhJ//O/ZRnrCFL
	nCP23Vcm6+WscTSdoBpEnI/fRlKIBg63bIqPKCvQVxKfboeIHsxGnEbObIJ/DPkE
	LXbKCMKX2NcU/NxyubZOhdbLxKWi7tLBj1EOt4AX6iiXZPRLEeyQ49m0ZlhaIxdl
	XIFzZ4bupAj0BN8FZsfkBPH3EzMXZdINW3ulqgyQ8j/vS1hozEHL06aYNveRs36n
	NVmFANqlVZOrCg25PP+dCfcLTrx1O9fsDs+YBdiFjw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qw9x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 20:48:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHVGQ1972701
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 20:48:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bke0n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 20:48:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MKmdDg50004318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 20:48:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF8AF20043;
	Tue, 22 Sep 2026 20:48:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A75D620040;
	Tue, 22 Sep 2026 20:48:39 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 20:48:39 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/cio: Fix NULL dereference in ccw_device_get_util_str()
Date: Tue, 22 Sep 2026 22:48:39 +0200
Message-ID: <20260922204839.965043-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JGUPr12yKOHNfG4dPzXd7TsnRuN5h64A
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2e9ac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=kB-SnXZE3agUgdMp4V4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX+z51QhJuP2mb
 mj5xdTqooWwOS4hIpdpj0WdTCDEo6VbzzQIqGT0Kbca2oCBR+smCgeQCF0etYIEVHTUqpzfEy31
 Q2xxRM2n9HirFFvg8/UnsQiTckNrPMI=
X-Proofpoint-GUID: JGUPr12yKOHNfG4dPzXd7TsnRuN5h64A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX6wt5gDw6gtF3
 er1PtVP05FWvjkRYhiMTIijVyN3ewgoPqFVUZGrfRhFtA5HpPfk1brcvbKr/8zTyoA54iKuNP//
 hdsb9iCXkAf0JgDiM+lrsZX4UFjhCmn9w2+kzRAMruGSA/wilUrVEvUNHyYvGYeSS/d6c1eKB3N
 k44TOGN1ZHpWK6eW/u2J0khOBFHJA8ct07b9gkUSdYgnSoeaB/X54N0gkQ8P5FGPP8WwCGcdnBv
 6NHkTDkJM6uz+wm2Q9vnIQaZrWNyoKmzRg9mIsEdsjuCv/XRiwmfR5noNqpTlZDxvD4kyiV/Juv
 ljz2u1Y3h3fHJP3nVwvF/s2XPQwg+GTsc80NAcpH+6kfzOxmJ2UK77c0kAflfNeQ2pcj2OR6Bfc
 /1cjdAmHjgk2w+lQqoVkiYwQFXPFqiRlKieUm+dFwVn3h3y9gHP8oQJawp1qDeEyOBaxuKGvawM
 0U4G4mkzgoGaPOwRxQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295

The channel path registry entry associated with a CHPID may be removed
while the subchannel's PMCW still references that CHPID. In this case,
chpid_to_chp() can return NULL, leading to a NULL pointer dereference.
 
Add the missing NULL check before dereferencing the returned pointer.

Fixes: 199652309a4d ("s390/cio: add helper to query utility strings per given ccw device")
Cc: stable@vger.kernel.org
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/device_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index f2f7f8cba410..1f7e83fd5087 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -517,6 +517,8 @@ u8 *ccw_device_get_util_str(struct ccw_device *cdev, int chp_idx)
 	chp_id_init(&chpid);
 	chpid.id = sch->schib.pmcw.chpid[chp_idx];
 	chp = chpid_to_chp(chpid);
+	if (!chp)
+		return NULL;
 
 	util_str = kmalloc(sizeof(chp->desc_fmt3.util_str), GFP_KERNEL);
 	if (!util_str)
-- 
2.53.0

