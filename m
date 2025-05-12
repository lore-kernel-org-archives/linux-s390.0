Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0264A3C;
	Mon, 12 May 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060037; cv=none; b=FUJuC5KM07YyCFGcn0yhUhYVrSy+j77S1UVfZNUgXfMAd5eE9AfSqW4wOAO+7GZ2z9r8EoQezfL0hWSyQyijlPXrSAqPC5Vklq9LSSJMnR3Zqz/i/1RxrimbkqDKNi0j1Ev6rWiS0kRMnxTbimqdCJXyMFJuvkFztE1gYizk1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060037; c=relaxed/simple;
	bh=MFWOi/hatrl20vO83HihA/VIkxps3CRX6oucwcr8n/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiNMb4yYEV0JLcXluP7/NkQAzbAN2rcOFedHSnGHegO/RQpbmnTFsAT9k99WRnVC1djCPI6f05izKeMOhAVCta4rDiMrQTGHTFJqS58//T+6+ZGV8w1Cr2WRmeL91dlBCcA3Hk6Rxp2DVdWJ0/FqWekqN/RyvDobM6nOLNF6ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oT1uURl3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oT1uURl3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CDnTtO001587;
	Mon, 12 May 2025 14:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=H0Tkx7+SzjOipSHRz7BPdyfgQj+BfPBXjD5Rb6Pz8
	m0=; b=oT1uURl3e8zh0H2qJTPbwEKmW9Qaxi8k9htZ/MaHYQ3AsMX2ydjOCUbOg
	Ql6DIOT39Ao5OiD+aUoeAMgdabuF5k60eoh9tb20yRHczDUHuSBD5L3jd9qGXNVY
	nQj3IEjy1NM5Y5hoyJyUY6Um3H662sc0uqLYYRxzN6g3POUi5vpPqiOfprgoHVfA
	R2BVskt2MTVlKhcSqenAr0lDzIG2xJaVZZSiPFGLkhrZwZhY8WqYCc/9MUcLlG4x
	3sYgVFJq8E7qPPaOQeCkJnclH01MiZH8PHMwYnegZsm10Ma3jfT0O+4AsIsPJ3ux
	drj2NEMcf0mQPhB82xaUMRlHrxHIw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj7586ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:27:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CEKfRR009975;
	Mon, 12 May 2025 14:27:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj7586tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:27:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCLZN2016348;
	Mon, 12 May 2025 14:27:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jh4tej1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:27:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CER6lD56558036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 14:27:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC25D200BD;
	Mon, 12 May 2025 14:27:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99755200BC;
	Mon, 12 May 2025 14:27:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 May 2025 14:27:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 535AFE0315; Mon, 12 May 2025 16:27:06 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v7 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Mon, 12 May 2025 16:27:05 +0200
Message-ID: <cover.1747059374.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NyBTYWx0ZWRfX4J+iA0krVspB fQXC+GPt+teDfwRbINmzxCYUQOg8HemzNXsTeqjzpOjeOYBI0CnzDijCkjgXOZXdWNhRCgRDnaC +qE1EMDLjSgRkh2PH6GM7/G6SHwdBpu7Ayg1OtUxE10edQ+JDp2UvFh0v45pDUxwMepS4IFwUBG
 uZZpDAU5FpnryRkLfg/Gu+P8WMobEifo8tJWz1nH5jTJqwhruQvOtcILjNad4G053qFfNU7uk01 lHlw7uTQp6IlWDDC6OxheOpA8lS1ssT34q07RwafLp7DxKanPq/ZtLc/hJTchc1WtX5W97W0Pri Fy+MOPMwArVWO6gKRFHx5ROhIjszTPU77LRmv/xx9d5Yfla2BiX4Qm0BosBgIEUvadFAvl5par0
 5AAzwoHXreVc2ZNMcAZ2PXsQm7fDD0+dega9J0HPPKQwuTdp1dQ34D1yNnIJtV9/OFcM7GhK
X-Authority-Analysis: v=2.4 cv=J4mq7BnS c=1 sm=1 tr=0 ts=6822053d cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=gOThRBi6ftkcs8ZoH28A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: qnJ4pF3Y3jPbDL6Rvh_FxR_LAFkxUmHH
X-Proofpoint-GUID: vE3qFts5VaV5FnJpIAEOEtiXGRMzf5Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=680 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120147

Hi All,

Chages since v6:
- do not unnecessary free pages across iterations

Chages since v5:
- full error message included into commit description

Chages since v4:
- unused pages leak is avoided

Chages since v3:
- pfn_to_virt() changed to page_to_virt() due to compile error

Chages since v2:
- page allocation moved out of the atomic context

Chages since v1:
- Fixes: and -stable tags added to the patch description

Thanks!

Alexander Gordeev (1):
  kasan: Avoid sleepable page allocation from atomic context

 mm/kasan/shadow.c | 76 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 14 deletions(-)

-- 
2.45.2

