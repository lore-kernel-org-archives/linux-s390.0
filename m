Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D040DB2D;
	Mon,  3 Aug 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777712; cv=none; b=lKZTx9K4tvA+vZzHNBnMaUkbWKgnOxz1czBD7AH9CTlOGFz3h5pBa6L+H+KXeDoC6VMSR32EzhLQ0X2e8QUcnltfdPpRVoXQ+h6yOa6Jbj5BVyRq8TTcyW776TrpXYOhwQXICLYjitIx7k9ZSBVRUWeUFb2ZPHZP3i5mRU978L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777712; c=relaxed/simple;
	bh=nwo0pIuMXIRzy8uChIlROmg1+wOl1KXBKhZhjgLUaM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mox0kaM9vjmUBgOEN/gSnxeV832cb85YIw7Ozv/Moy9zjG/C5Bx5JBRbon3NYkJ+3JucJjfWTs4j2uCRufMofPAbtM8zT41/99LB9JNlLm9X0Uho8iErpKKWOgSygHZfMaLqT2VcCvS/MSZnN6cV0iUaEBsj58+7m94MgcWGA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I4YsC5mS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I4YsC5mS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HHYnR815111;
	Mon, 3 Aug 2026 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Jy0vMWgdjy8AGWGeOMbZ9Ocs3X43pSUjxKcYaaRtO
	O4=; b=I4YsC5mSyC0Y6TvaoSwCyK+1OD285Q7tJNTWQ3pAgif7p8WfPIqv6WfDa
	EQXJn4kg+JichJQcAYXuOaEJlHhn12sS36WS5jk/mGMgJN4O5E9lKvfJ46erewnn
	KrHYY+eWEUJj8QahBvAuoRtP58l5k/GQja1lKXjki9K4J00Bom/pda+e1sSlGkwE
	vSFb4n7kudZdsBnholLnud3J3uvFRstCc4L29YbIFMYWh7vY3s3qJlevaSTORJI+
	SqKKTfwflixd2DQ/YUCLT4aad3v4yc165CYgyW/OD5SNe3Jgeo6RhGTGdldsWH98
	cIhbIVuWyasxxsBO9NI9TABqrlH1Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqj07h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673HBghu023012;
	Mon, 3 Aug 2026 17:21:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jxfmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673HLibC25166514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 17:21:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA78F2004E;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0472004D;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] s390: Enable CONTEXT_ANALYSIS for various directories
Date: Mon,  3 Aug 2026 19:21:40 +0200
Message-ID: <20260803172144.827049-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zxnEzrmrTfOXE0AK5fF3Wg-DFIXdT0kZ
X-Proofpoint-ORIG-GUID: zxnEzrmrTfOXE0AK5fF3Wg-DFIXdT0kZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX/DFEqIVAZ/PX
 AeWSdVavhIxExrIAuL+8y3+YrvuGy6Ey+7RfLns5jbLYm1DdqVHEEmwnIMZ4lvodTT8fSc0hfuv
 AB50ihs8lTc4mncPqJWedeqonRP6IXs=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70ce2e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=jW6YlCM5X9v_IRLvDUIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX6S/XGOM4fvAH
 1NoXprcN7l4Z3UaiS9Z1EM69UDLS4x//WfbnTlD0ZZevvRRs+QX19yc5/TX0PvWpKbnqLrEdmJs
 X7ZMAFKCiNe7JPdsnuMaxdc2xw4V+gc4EKMIaQ0avBJQhNcvdzEAjP+Ilr+z/BHfWXQdXkHWBS8
 OSw0cDgX7tu0TnhQ07hgyLkjGWzIBNHHhULosmtbXb2DN/LXppFfIoqp4rb9UnvtKVRnZjsCXto
 dbZxDn2r/OnllVotJ0EFWUNJ7c/roZhQeDmBJCUNnbvoUYhPeng8P8BrXQfdb7ZLlhFLk+Pzm/1
 EJMex7Zt6CCjWJVHUPJCCm1xtGoeRvqIpVAAClJnLqt0VO9L6zvO5GDxjtP+NhzlDRLq11W504K
 5uF4vGnHJMaXwBXLMMKULEr0IB0D81P33+SyJmuFpeTJchMedrRMn+/UQMknTLYzdyAxroTFaik
 vhN+XBmhMOtCw5CmqDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030154

Enable CONTEXT_ANALYSYS for various directories.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for various directories. In order to avoid valid warnings add
attributes (sysinfo), or disable context analysis for specific functions
(mm). Disabling context analysis for specific functions still keeps
analysis enabled for the rest of a file.

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Notes:

- More patches for other s390 specific subsystems will follow

- "Pre-existing issues" reported by AI will not be addressed in the
  context of this series

Heiko Carstens (4):
  s390/sysinfo: Add context analysis attributes
  s390/mm: Add __context_unsafe() attribute to do_secure_storage_access()
  s390/mm: Add __context_unsafe() attribute to gmap helper functions
  s390: Enable CONTEXT_ANALYSIS for various directories

 arch/s390/appldata/Makefile  | 2 ++
 arch/s390/hypfs/Makefile     | 2 ++
 arch/s390/kernel/Makefile    | 2 ++
 arch/s390/kernel/sysinfo.c   | 2 ++
 arch/s390/lib/Makefile       | 2 ++
 arch/s390/mm/Makefile        | 2 ++
 arch/s390/mm/fault.c         | 1 +
 arch/s390/mm/gmap_helpers.c  | 3 +++
 arch/s390/net/Makefile       | 3 +++
 arch/s390/purgatory/Makefile | 2 ++
 10 files changed, 21 insertions(+)

-- 
2.53.0

