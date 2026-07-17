Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE333B6BE6;
	Fri, 17 Jul 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280268; cv=none; b=ojn4txHk11BH5qzioWQyKmXx50hMP5vEinERWx1ckt+2r4PeOSz9fSh1yfSVf9SqmWXdcCFb9JKJGZVk/E1ISfkvABVJFB3GwQ7FSz0cLoB9pRRldE738VLb5VgiyMIVrnwHVxI82N+4oYx6UZCIilod+Zf9Z8ZxPSPLmuUvDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280268; c=relaxed/simple;
	bh=dUsbDZ6HTSkg65F8EIiTZAdGjRgLUwj4dSaPNOkaeWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/T7adhtwoXsW7MgAUJNAwcx2kgIYvLPg3zlhnw5ajwhP0gfHJuhe/OUNG6uiSnwjldbEFrB5DDhjNDWUyzuynkcVuf00fejB8u5rBys3tkTQTc+kEtpbBA4VYt2j8VrQCiFAR1x7oKUlgN+6KaV9XJHJseMzXbtb3zTc50E30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZdeMzfZa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZdeMzfZa"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6frXT1214125;
	Fri, 17 Jul 2026 09:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2gHV5VMvq54+aU8DI
	zL9/w8iQMfGX2oJ+rwuYTn0ctY=; b=ZdeMzfZa1NJX9mLHsNnOXfEwvtZuCCcup
	RGmtJ61/j3/SlTlan8/p/+uCcs9syYsFEjxaHRe7Q6TXjiiGHeQyRzVdBEKllyIM
	272uzDgs8Hb/rG4aoAlHMOx2GZc4+4AOLLt1tsOJdgDjcEjoS5/5fnHjjMjGbNMk
	NE6BG3lsideU7AZpcF/hodgGld5Yql04eQ8fg5a5XBYiZlAX221T71WD1YFI0XZM
	cj3DkcKjjrL5tKvGDPWkrqCYQ0PAagsPKRO/fEwxkMvtbJyxS6ac/b81OsuU9caz
	G3Xa7bAfSEkwrXe5gsRGTOfwYioBRExbRZZD0wnDFo6Em960koxAg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2amqfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H9JmE4009394;
	Fri, 17 Jul 2026 09:24:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhrxqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:24:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H9OG6L50528574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:24:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0B22004F;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 594782004E;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:24:16 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] s390/mm: Fix handling of secure storage access exceptions in vmalloc area
Date: Fri, 17 Jul 2026 11:24:13 +0200
Message-ID: <20260717092415.3039699-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717092415.3039699-1-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX85BykstiHoKa
 HJO9tpR/zq4uXW+K2GuDAKd2NaBTZd52PPK7nwt2wlNm+RH7scoXIKCVLpJvix/ukVJdJBXDpXT
 1O/O+t6lIjqrZkqS/REr8nFx90n4RxY=
X-Proofpoint-GUID: lgjFNo-D_Y4_JVRKUZHxEgCzcpLsLOZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX5CGwNEbikdxb
 DfB5eX4l+3W8peS2fNJTJh9yMwVF+4wkW/IDQIAJRR1JM+D8lBRn7o4cRFZVFJdO1s2EeVJVd+e
 tcTP11Og6uCdnOemNL/nZ9Ha7mG3wWT5U/Vv9bGKlKH7Tsmdp+y6aXEpOdvZSX3aLvuRIdiYWoY
 OgX721PyLM8NsaPQPI+HyBwY9tu4+uJPmB4KHuIZJOLr0ACBwko74LUkWc+5DY/8UsHsdrMIrrR
 lg8I0YWhxg1WMYxjoYvE5Ou7IfVsuIHpc2es02FecfTTK0QL6RkBirpnZVopvRtRAIevRsiI2Z9
 aKactX+o3UNubjjteVJvL1fyxrNM6zhMDecR06gpxd8W1Jem4B18gTs+irXV/ViRokh1o3VtFB1
 GjyH9T7TWRi5voX65vto5nR7Y8TcLXiykdJV4z5u6Kk3trt44j4xK2w2sh2ObbpPOL2NDQ/nXqt
 vX+ImTCIkfvgtjRkFlQ==
X-Proofpoint-ORIG-GUID: lgjFNo-D_Y4_JVRKUZHxEgCzcpLsLOZK
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a59f4c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=aTeQ_7Lur19LOBhsqlcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170091

Secure storage access exceptions in vmalloc area need to be handled
separately since folio_try_get() or virt_to_phys() do not work on such
addresses. Given that there cannot be a valid access let such exceptions
fail immediately. The kernel will either fixup or crash.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 028aeb9c48d6..392e46742039 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		panic("Unexpected PGM 0x3d with TEID bit 61=0");
 	}
 	if (is_kernel_fault(regs)) {
+		if (is_vmalloc_addr((void *)addr))
+			return handle_fault_error_nolock(regs, 0);
 		folio = virt_to_folio((void *)addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-- 
2.53.0

