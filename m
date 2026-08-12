Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3684376A15
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521223; cv=none; b=GpX1HFI4DIwPhjggV0xCSboT4afkwXvoiD/Ut2hbHZQ1ZnGpjkdqvxVouiXav4Oa+BoCnJhwnl9cFKCgiJoS8IkP0kFSjV5PbWnm1FtnlVhl9fdMMdDX4hSrv3bYAN5NRa3bM/A7II+BlMjiI8hvXH3G5nYod+P0IbmjhJ8dOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521223; c=relaxed/simple;
	bh=XlDKOYOKtXT01FVf8LXdW6pQ32iPkz1Im8TsaCl3SaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZURVHrE+/X1ncCAmfERldkqwW9ZfP91+gob0WEjrSfKPctYJ2WxInb4Je5S90D3TclJD1dnCJtwLAJYismBIVRkD3lpC6B7I2cIh8sFNjtGVdLo6kyej9dF80KCQtad8l/4sh88L0Jy3Zq03Q1G75/i3OQ89YblNtvnpilyC2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XIhiVUAf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIhiVUAf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62tJm2589899
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 07:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4iYdwotx8gk5cg0Jaki8dcl/+Alpxn2Fx3NYygCA/
	wU=; b=XIhiVUAfRZIYtE/QOGhJ32zyU2JMQBQuaMwQbplC2uJiFRC19r/Lfn70P
	J8Em0AYQ5bUPEpJjIRb73NWbMV0hXfAUB9qCeDnDLi430DwPVlmYGzrOMwgEuvxA
	aDxU93NRMZIZmwsny4GeJAGXF6IxjAarL2cLKKSHpm3AWog059X12llp+HGM8Fvx
	xZJZOof9OKaxiMENq80uqNlhR1JHKlTJJqUQvd3u4U96K7XWYC0o/UmLDBax28ic
	4G5Kvd+u2JuYhJytG3xV354tqNw9GH9R4iiHqUD2h/akZzwpzwRa2op3EcqOY1UD
	o3gpB1BNdL/96t/swqEvP4WWyPSzg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp30n93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 07:53:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7fURI022264
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 07:53:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjw31h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 07:53:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C7raRZ33030472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 07:53:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD7E820043;
	Wed, 12 Aug 2026 07:53:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9192020040;
	Wed, 12 Aug 2026 07:53:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 07:53:36 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] s390/debug: Fix deadlock during unregister
Date: Wed, 12 Aug 2026 09:53:19 +0200
Message-ID: <20260812075319.2007940-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c2684 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6BefsEoFRu_C_CthcTgA:9
X-Proofpoint-GUID: VNTYeSSMdVi-HDijB0-mphaXFwJ5Bkhw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1OSBTYWx0ZWRfX2Jtax1V2YdJR
 1lrpUQGAVqKNoRGFPzCo2Ngo8uIUrwTobseTug3xzA9KNn+/DvjFsiGvO4H+hlo8Fy12Eqjl9op
 OQM/WXMOyiZPq+GZ+/QjUh53YboOddIiYfZY+UKSWL8qOjZJfVfEWPtAYEZ2JouDbm/EBzJDsHn
 ZW2wUMckln6iDvsrjoLbgJSIOXiFMPy886DKMyAd0ktq3LL8vedZvonEcKt8WR066/1+cABSpvp
 Kh5hMzc7OprJwEFzDigHJUnCc6hRGauqEf7rnW7/mY4gSYf5x131DzWTkIxrueDfivu901ommja
 VtHdRSgQRsc6+nph5kB4MHawlet2H8Xc907DVeN2bUA7zky/SAsxNiZ+HQ6zN4nTMj1UwslAUGM
 o3ZzECSmukSMLTYdsH+Ycg/BysFYt4l1f65SDT9rd3+K6q47E10ezJkqKNEj4rGK/6OhbD3pbym
 ftVgYPiR5SdNyf5zmbA==
X-Proofpoint-ORIG-GUID: VNTYeSSMdVi-HDijB0-mphaXFwJ5Bkhw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1OSBTYWx0ZWRfX5zZzoTPyRul6
 Luv2DFOBm/Co2dNp0p5P8L+7vxDfpctekNm0Xbtroiu63th/fNbfJQV/iLeBUNZJXivVWeiR+X6
 ufU8YPzEl0JcaCl/XQFsSBVvmehVM0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120059

Unregistering an s390dbf debug area while one of the associated debugfs
files is being written to can cause a deadlock:

$ echo >.../vmur/level    $ rmmod vmur
===================================================
debugfs write
debugfs_file_get()
                          debug_unregister()
                          mutex_lock(debug_mutex)
                          debugfs_remove()
                          wait for debugfs_file_put()
debug_file_ops.write()
debug_input()
mutex_lock(debug_mutex) ==> DEADLOCK

Fix this by splitting debug_unregister() into an s390dbf and debugfs
part, and running only the s390dbf part with debug_mutex locked.

Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 arch/s390/kernel/debug.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index dbf430f479bd..14d2b58ad093 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -993,8 +993,8 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 	mutex_unlock(&debug_mutex);
 }
 
-/* Remove debugfs entries and remove from internal list. */
-static void _debug_unregister(debug_info_t *id)
+/* Remove debugfs entries. */
+static void _debug_unregister_debugfs(debug_info_t *id)
 {
 	int i;
 
@@ -1004,6 +1004,11 @@ static void _debug_unregister(debug_info_t *id)
 		debugfs_remove(id->debugfs_entries[i]);
 	}
 	debugfs_remove(id->debugfs_root_entry);
+}
+
+/* Remove from internal list. */
+static void _debug_unregister(debug_info_t *id)
+{
 	if (id == debug_area_first)
 		debug_area_first = id->next;
 	if (id == debug_area_last)
@@ -1029,6 +1034,7 @@ void debug_unregister(debug_info_t *id)
 	mutex_lock(&debug_mutex);
 	_debug_unregister(id);
 	mutex_unlock(&debug_mutex);
+	_debug_unregister_debugfs(id);
 
 	debug_info_put(id);
 }
-- 
2.53.0

