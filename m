Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690861A6814;
	Sun, 19 Jul 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466016; cv=none; b=aB+mGBDoeOPKGw7m2CxLqJ1EU2J3fTMp3UBd/6avu61y44CJaJKCVxIUSFxfAZZxr8MozhqAd8IY+4R/oqQQgHLk8nDmUIeDA5ej+rlQrdvMfv6VZkrUBPyT6W2n8TW59J56UmqiJnqmMcP1PgiX28AKvk0zwzTx9qhan47nm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466016; c=relaxed/simple;
	bh=0jK4btx26Jwvi041xJirsZ+ydMijoK3qrmHGRRxWCAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fol+nvj5BUZgEuZLpvQcDubmAl41f7JaNyjLHnEEu/np/sWxlyL0YwqU2CMO1mnjMqlq0v+kjWVcKMevmm3P9ICdV3h+x9mnzSuteVnAlYGhrJTNUYQ2HtGus+chjlq9UU+mTDzpSeO3NniGNVa5JRq2zXj8QLu5ASv1cROBC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZE4ZYm9y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZE4ZYm9y"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBCl1u3352536;
	Sun, 19 Jul 2026 13:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4fpnUxdPoQ8eIU2iD
	+oHnO8eayYOZEM4N/oAChWRqac=; b=ZE4ZYm9yy4nOUlHgxqVHbJJ9N4rkMG0Vs
	i7CiHT1eG7CWkyZMHlFH8YCIJex+c6TVnuaPUgAYx7hJDPfYJZd7hTF+Ga17haqH
	w3d8iPhb2OM9+rQGFwUMCV/wuGpbBqWaIJ6UXb1YsdSlp/ScnFMU5gCJbCHULNMF
	WDVoJjtegwVInfxEq2f7EyvtXyGbFesAii4KUag5vrGxd9LQSmE1yBrmuOls7b2J
	ID4qghHHKvrbFTqxSWkP+83sgRzkhpj5hMOjavy4RlWqmtN3xJxWOwnGll8o5fRn
	p8cfVBCRr6iZNKUw7kf5ta2nZZnU2crRBrE63hsjzd3hWQq6gs2SA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7aguc1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnlOM000454;
	Sun, 19 Jul 2026 13:00:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g1f98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD07qR30015898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B2020043;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2F542004B;
	Sun, 19 Jul 2026 13:00:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] s390/mm: Add missing mm check to do_secure_storage_access()
Date: Sun, 19 Jul 2026 15:00:02 +0200
Message-ID: <20260719130006.3882764-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130006.3882764-1-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KElNuLGHVxWJTdiF9yBo3gQSOOuSniMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfXwCiZOnz7Xlry
 ceK3UllzFVL43yXwx4MFywC8onRYMhYKTJv9/wwugFswfNBSuTSdxyyjhrCGr30R+q5XzmCLQZE
 FiycDg41NLb7ur5DokhlZ8wI7MaIYxO7MUuk1dnoR1EKmlcb2PMQbB5kn3b2t1ZGGVOIuZuMSbM
 GpYBLRPNvDSEZ3HdjEvCZiopEa+WxHcJf9VI5N20TKk18Dgm6v6B+yzvJdjHz3anO8B74TJ3ddM
 CUJHy89x1kgUSSr5N26lEhJAa/4O5rniwU0y4SMGipa17izcpDFTbGQVJeDsx5xdsXjgm7A9DHt
 6ToH85GHa8QQbFVjf8rReP6w2EQ3dD+V36FHWxQyCJ3APisWvtkPmRmlupQKvWhQ1ihKDQDUZU3
 mp4kPgDRWk+hUKNeMAMm2n1UD7nR8UwuBOEIHxaqln69VIfKd8j61CUsBfq/E9cYtXrTRVsbfTz
 wvqWcKwCw6qlYxtDf0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX4CMff29JZspv
 cSTX/qxUqGtnBGMhESBX5+2OrN43U71ojndroVU+9gMxdzL8uHm10uzOfPNfU2dhoYTIyQL42Y6
 9cU615NYBDmvbWglBIAG7ck3he246mk=
X-Proofpoint-GUID: KElNuLGHVxWJTdiF9yBo3gQSOOuSniMz
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5cca5b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ee2akQ2MmfY_TRJwXSkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

Similar like the normal exception handler the secure storage access
exception handler needs to verify if mm is not NULL, which may happen
with kernel threads.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260717132345.539A11F00A3A@smtp.kernel.org/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 028aeb9c48d6..2839d7a64401 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -409,9 +409,9 @@ void do_secure_storage_access(struct pt_regs *regs)
 {
 	union teid teid = { .val = regs->int_parm_long };
 	unsigned long addr = get_fault_address(regs);
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct folio_walk fw;
-	struct mm_struct *mm;
 	struct folio *folio;
 	int rc;
 
@@ -453,9 +453,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		if (rc)
 			return handle_fault_error_nolock(regs, 0);
 	} else {
-		if (faulthandler_disabled())
+		if (faulthandler_disabled() || !mm)
 			return handle_fault_error_nolock(regs, 0);
-		mm = current->mm;
 		mmap_read_lock(mm);
 		vma = find_vma(mm, addr);
 		if (!vma)
-- 
2.53.0

