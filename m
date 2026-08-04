Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021F3EA953;
	Tue,  4 Aug 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853321; cv=none; b=oZhu5mryb2zgCGlpNTaFgj2BKzYgSTjt18PMrcv9pgNdIV5IGcbwwU/Ca6NhzZebIDjhJzrF/vRwPaX6WmvGEvwNcmmDvqXOTGZFlzcWLbsx7jUI0rclzeyPB24/MQ0TXbxXT8N5bv2gLjZyehN6/jZjnVDYcVE50+r2gclyN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853321; c=relaxed/simple;
	bh=oUN06mSpjaj/96vwfEfNl7zrrca0BZNSSM81kIs593E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTjiy3RmPoyhs/M0IEBFXZja7cOc2U4FPdmxKy6DVCc4iwfs9cnejemTuchTioH3IiKOeRRz77nsR+b7byzBOCT18pbrLHpie5d+u7KCC6/86Wd97VOH1RBQh/On7D7etiBUp2ll3Pk8+s6EUCco8aRs8VAqoBUWOhy1lo0uKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kzOYKDye; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kzOYKDye"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Clp29863652;
	Tue, 4 Aug 2026 14:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2qtWGsEeszTGR7AEQvNi1tWiz8x0fCRWXO3C5tJZ+
	sg=; b=kzOYKDye8gJf51uUJqSh0efBVzU1AJPyfDsAJ53Vi/D9OvCigJgEG6SIh
	a7XFiFSaWBRgNAo6MmsaIKqKxdUdcp6lWql/TergiDjyboV/PrpD+JdfOVh6RS8c
	bkBx6oMV3csVJF5dKV8GnJasIRbG5XI1+qW+81zISNd+VD/vxOKy+tRZ5fxeJQDG
	+iPiw+KDf6reQNIN40MhdkibY1/j7hlGffaJpplVrLEAzAaAupkTq1T85B2WxfOv
	9uBXDYZ6+R9aJvNm62UM3udZqPlKDuOR5TYHzIR06Fif5jDzGmIWVJsu3fb1Lnz3
	uBLNCuD9vZ7zG05P267pSf2OWlnpg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3x8ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:21:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EBi4w012293;
	Tue, 4 Aug 2026 14:21:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmha77q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:21:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674ELhqu51577198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:21:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF8720043;
	Tue,  4 Aug 2026 14:21:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3DF20040;
	Tue,  4 Aug 2026 14:21:42 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:21:42 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 0/2] s390x: Fixup test fencing
Date: Tue,  4 Aug 2026 14:16:27 +0000
Message-ID: <20260804142133.1745878-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71f57c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SP75oxSdw3_Y_uT2PscA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: ObtLvDNeHNqc007Q69UCzJ82sqkoUVGY
X-Proofpoint-GUID: ObtLvDNeHNqc007Q69UCzJ82sqkoUVGY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExNSBTYWx0ZWRfX5rLmnLxoUIAj
 L8jIXxNqV1yuaMCqspJ3jw+Wjj7fvMACIJAPBCVuxEyhwx5HlWpc7OM8s3PwAq6a0oWZvSPomAh
 syrIN/ekxJukTZk/vsU5hIWY/doU4Fo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExNSBTYWx0ZWRfX887lQuLYBvOa
 8TKicYNPkTDO0iNdDz64BfIeC7E5RnlK/2+aUpMdGapW+zLtyn/Q1gDY8VlE7e0lS2CtKSi3XXv
 BvTAWbdurVAfBae+0vIKrzN3HTWyzDMXz+ATDpr4BInLyF5m2PSbzdnaRLGVzcpqzJpO81bITJ0
 a5q11BMoUyDooLuNHnZHebpbh+F9er8mpiBkqLbZ91V41WynNy85rQYng2q6LVkqu0pcYH1bszN
 lWixDuCVQRVN32EROIsnR+ihaU7endQL0LaeVKMeBJFIWxz+uVm9LfjizMvh1WPv1IfymFQwPFU
 rkcT7/KiKzyDkdgqjCj8D+8dDQIyAW1BjEOVp3T944haqScFxAEcQWtpBDxsmfxqBgVghNPXCsr
 MZQJIFhj/fKvcBkXg4Xn18EzHTUDnX7Qiu31KOg5jgf+ZOX4M24x8JnGi7OnsgfHfAnC2imkD11
 B2c2aFR24dTaXnqFHhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040115

Migration tests have been fenced for way too long in TCG due to a TCG
bug that has been fixed ages ago.

The skey access tests will always fail in TCG so it makes more sense
to fence them in the test itself rather than to filter the CI results
so that humans won't see the fail.

Janosch Frank (2):
  s390x: unittests: Reenable tcg for migration tests
  s390x: skey: Fence TCG protection checks

 s390x/skey.c        | 8 ++++++++
 s390x/unittests.cfg | 5 -----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.53.0

