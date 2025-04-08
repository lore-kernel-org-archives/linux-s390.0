Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C622CBF6;
	Tue,  8 Apr 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130920; cv=none; b=tty2qD/+s2Cl4RmVrWjDDcyBCiL2y0H5oPYcqn7ynGDCERMY2jUcd3yGKnD/T41eNaq2VMhW6psebrwCNrcP7rxfNJjfboEI4odLL8nT51gAkQ40vEMRnxiZUuF6xK+QfnIAUsAbG61N1l99RvT7dMG4LbZWNM5rDnu6ZQvjsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130920; c=relaxed/simple;
	bh=sji1Ful87U2nTvAchEoyyKPkkk00VNHGYdfD21yXfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6jGd8qeLCqEWfzK5pVuuCKj4vvox5fnCwP3nULqiEbO6mZVNNPSWrmRcP0ttnBMHz0uWWDEyNcqCPoKPV1JJaRTB8VJdkbjlP1dx3v3dXQ+423hKdXqfLj9hlGoRmhmjfSyII8MElC2urJOiqqkk0EQe4HisSLsCOWwWGQGFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiKCXr6T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiKCXr6T"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538ALfiF029326;
	Tue, 8 Apr 2025 16:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QM4al/xj53GBa3LLwST0BolJHuyjXTKV2KANwXmTG
	RQ=; b=HiKCXr6TZIh10pi+5k2U4UJf8Tp/PusX7BfaakyPe3OCL5gB6Loneo9Xu
	YTysEKEam/6/8veAtq80U2ME6RvhvbD6v6GVxkHz7BBGkqvFIsWSUU2BIQGQ9Ybs
	KVKzt74/owya8ZW1dEnHicmfxsP992OB3fYuDh/GeY+/9UtdbYDAdDSeyep9qeTY
	DumxFWz1tsELL+snzxHvJmk3mbUwwT+W3KdLr5FjOPJ7zSZgkcY+d7Q8lctwu7V0
	zbiSuGmySz99MuA4omOuOFVuHbnSUGLqd8I49hnrZm3QJfUaGgn6+svhbGXDc94I
	+S+3xhS4aErSrMmVrVy4Xx6M6GTXQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnx0mumt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:48:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538GNNfi014473;
	Tue, 8 Apr 2025 16:48:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunkjw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:48:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538GmW9U57475360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 16:48:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4837020049;
	Tue,  8 Apr 2025 16:48:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3733320040;
	Tue,  8 Apr 2025 16:48:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Apr 2025 16:48:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D2AC4E0628; Tue, 08 Apr 2025 18:48:31 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 0/1] mm: Allow detection of wrong arch_enter_lazy_mmu_mode() context
Date: Tue,  8 Apr 2025 18:48:30 +0200
Message-ID: <cover.1744129955.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gid_6NkxRdZRLJrt0qzhj-LZy0ROYxBK
X-Proofpoint-ORIG-GUID: Gid_6NkxRdZRLJrt0qzhj-LZy0ROYxBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_07,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=340 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080114

Hi All,

This patch is aimed at 6.16-rc1 and should be applied not before [1].

Changes since v1:
- this patch is split into a separate series;

1. https://lore.kernel.org/stable/ef8f6538b83b7fc3372602f90375348f9b4f3596.1744128123.git.agordeev@linux.ibm.com/

Thanks!

Alexander Gordeev (1):
  mm: Allow detection of wrong arch_enter_lazy_mmu_mode() context

 include/linux/pgtable.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.45.2

