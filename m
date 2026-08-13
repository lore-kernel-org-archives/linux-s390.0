Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9C40BCDF
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619226; cv=none; b=ZJ7yV8Fa0E8Eg9ZlkN9GhH3DZh21fs/HCOMuhT1gSn68H/KyTNNOFSMotxA8rwpdzFYuKjfnUZvV49IaKwe2pifwEkzY3qsTwgVUJJDwsrginivXe1/p6Irt1HPclhZUNHWsmHOaxGBVIdDa0RBlMUzr8Mk+A/iCuDbX5yjDWjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619226; c=relaxed/simple;
	bh=6o+43TZ98kVSF698+tjR1CNKYYA0mHTDmNqWhf5BF8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLW6rzwkSRhdJg+iQcs2ljEn3i7MFBElYHC3TwyTHufOvoNQoHPbtSci+6an0HKAb4fvRXxwe4Bjhl2jbnu57920gmg+tg60b749DMAttVCfg+TDo73LqaULrREr2wkeVHLpyIiEHz3+qip4zWclHaGq+880oSO6LfeCJ2fA+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lrmdEKjr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lrmdEKjr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98guw1865162
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WUubORbvuEpFO+tn9YgIq1jFhlBF+F
	mBDUPON5u673c=; b=lrmdEKjrg31xbC3vzfS56zWzXXtRK+7g4rlF6EYbh3lIXW
	kTqCEtkYHY7whnIH88m1eepmSTnqMdCnG7QTvn9q6nKNp+bmBh8X90leANBKiYXc
	9ljtI9T4mjqriDRR7orkCYQpNNjSQkcBGNgF8G7ofTXwHftPkmiM8K9HElTjPkbt
	Ni7Ti6eP9ai4AM8dWZ7nrVWLEkYB/mox91G7So9UzfDqY6PcsydvzLyUl2T5nn3W
	h6aR2F1C36AdoTtq505tZXtZLoFcD4XhkHqaLhi6BE5Zrh4LBPh0BJNFms3jOaj+
	FmRUso+vytc9pcRaOf8g+AvzP29wi0n/JQS1hiBQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9qgwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DAfNTX021615
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfyahe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:06:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DB6sKj38732118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:06:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BC820043;
	Thu, 13 Aug 2026 11:06:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D66F20040;
	Thu, 13 Aug 2026 11:06:54 +0000 (GMT)
Received: from localhost (unknown [9.111.42.87])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 11:06:54 +0000 (GMT)
Date: Thu, 13 Aug 2026 13:06:54 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390/ipl: Fix NULL deref in kdump without re-IPL parm
 block
Message-ID: <p01-02.g87de83845c5f.ttjpfvt@ub.hpns>
References: <c00-02.ttjpfvt@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-02.ttjpfvt@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N9DRxeoG0-1HdOVSQqHkTkXaj29ruqZK
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7da553 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=p24_dXYSCWyD--oCIqYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfXxYTbecSkPA+k
 7i5pXgYfkI/EADgOAlt+7F0no+I4AfSQyPNQ/g3H6ks2Oe32rjz5dR2ZUlrJrwxbJns/vmvPJEm
 YhAPdX0qxheG0tJFHiDNOhC62l23WazI2kySNg1xy9pxX58hLcAAjWFpmpRbSh0oHUXdZ6UzI0d
 Xj0VlOthcXusVHzV95cMiFL/1qvCH/GdvzTm7kadBA8V3eGAJvHXCrCtACbvE4OsQN5kELAcC3x
 bsCekn31RXs5ymZdQYrJqtDO9JzVrDHhjuQago32fRwTNyDUJ7i7PgSOXs0mwUmYSYWEJLOoRnd
 JkdXPvU7qyKWv2BC7ELMBAZHtcGwj+sgDDBdjA4MdlFd0NIYXMXqORrod1oo4wZL9mW0eTx6PFP
 4V1pKhutCImWQatws4L8/9vDKKVIBzVvZLDc/2balBWuXXhM4GX6L1nLJNTrsHCYQBdOIiXJbZL
 YUZDgvX6iV1eJG0aE3g==
X-Proofpoint-ORIG-GUID: N9DRxeoG0-1HdOVSQqHkTkXaj29ruqZK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfXwKVCVvo5mVTp
 ApkNSLWqFUvyNsA0ex57HcyLYa9ZBbeNTq9tlkyXY5lyAaAYLaTkbaO9gKpde4vN4t2YoNYV1fZ
 4nChhyLjzYkDctcGDppztXDcCabZPqs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130077

Some IPL types, like HMC FTP boot or QEMU direct kernel boot, might
not provide an IPL parameter block. In this case, reipl_type_init()
selects IPL_TYPE_UNKNOWN, and reipl_block_actual remains NULL.

kdump passes the re-IPL parameter block to the dump kernel through
os_info. Before commit 3b9678472bab ("s390/ipl: correct kdump reipl
block checksum calculation"), the os_info entry was added only for
IPL types which initialized reipl_block_actual. That commit moved the
os_info update to machine_crash_shutdown(), making it unconditional. As
a result, set_os_info_reipl_block() dereferences reipl_block_actual for
IPL_TYPE_UNKNOWN. This may happen to work by chance when address zero
contains readable lowcore data and the resulting empty os_info entry is
ignored by the dump kernel.

Skip the os_info update when no re-IPL parameter block is available.
Kdump then collect the dump and reboot without setting re-IPL parameter
block.

Fixes: 3b9678472bab ("s390/ipl: correct kdump reipl block checksum calculation")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..7024fc413715 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1157,6 +1157,8 @@ static struct attribute_group reipl_nss_attr_group = {
 
 void set_os_info_reipl_block(void)
 {
+	if (!reipl_block_actual)
+		return;
 	os_info_entry_add_data(OS_INFO_REIPL_BLOCK, reipl_block_actual,
 			       reipl_block_actual->hdr.len);
 }
-- 
2.53.0

