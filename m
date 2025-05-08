Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5F26AAAA;
	Thu,  8 May 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713757; cv=none; b=ItJfQUkikU6X69fzaFoWaUty3+x2u4FaUL60Vktb2lAw5czDuOwowajDfi7ZXfWihyqp9mnOuGOqei/wboUGDMnqcrQrn+rwnUOak2jE/zwhloZuhZVoIDfF+KDJ/F+hjRYbmuzwXFnxqYvOwjfV6HAw1D+9OyiwsQE9sYv+MLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713757; c=relaxed/simple;
	bh=qbGBXEmSNCxdNzsIynDhYoXEEWiIhWZoE2CIrXQZ9Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsJ1cbe44DSW5SvKLYhBS2mDNzVtTJ9AnYVME4lFyWPaxEveYjvPMORfm3uctCmq/1FaJipkpjVEZ2xC0XRSyq76MEtDFUae0GCMtRNagsgULOXOZkcfuwz9x8SQNhwcwJzdRZsAWuR8XElYcr+xNsFH7W6BJ15Pjy21OuM6ZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KCTxDK7Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KCTxDK7Y"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548C0mJj008209;
	Thu, 8 May 2025 14:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=f+m+xTEPHEMKdR3eEwuuaViB2V+AZubNzaEp9oZeZ
	wc=; b=KCTxDK7YBYMdup7/DgPxO2rjYr7IF2JE3q0pxUgU4PPLPTgVu5kT1BJVU
	dA/eDM7E2rorFyXAAXrW0eDXDMwCqjorAjIQ+yI0rlfYAGGoDXU//hSfCcCtD5Me
	pxkOMXAOGON9lwh1pPqF2mHsKQMjXf7f8vzxunAfRRYmqo3VJ5pCVsqF7xvPkGP2
	TNo6k+J+IAxKWsLXn6cf5u0m44RAHvfM1Un9E7MmkKtz2DElgEA31pcj9iWuEjmP
	nzfWKJI2Cg3XiCDbATG4Y/+NM1PenzhAxYFc6kUVXYpXly3e0h+ub+nbxgBDhzT+
	Kk2HVnyjxL9wSlfySi/4UrHZXuiPw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ghg2bfkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:15:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 548E9AAY009667;
	Thu, 8 May 2025 14:15:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ghg2bfkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:15:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548Dux4V002826;
	Thu, 8 May 2025 14:15:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp64hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 14:15:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548EFk6D51380482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 14:15:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4EBB2004B;
	Thu,  8 May 2025 14:15:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91C8320043;
	Thu,  8 May 2025 14:15:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 May 2025 14:15:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 3C41DE05EF; Thu, 08 May 2025 16:15:46 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v6 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Thu,  8 May 2025 16:15:45 +0200
Message-ID: <cover.1746713482.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AKtVaM5uVmYE74Iy9WuCxbmTNkixOYKg
X-Authority-Analysis: v=2.4 cv=VJLdn8PX c=1 sm=1 tr=0 ts=681cbc95 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=c7xF9FPc4WhyVLjLziMA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEyMCBTYWx0ZWRfX9evs2pW/vmvI uaQ9MXcNNnG2WrBEb/SSaxVUazPyJ/p7AwWxdoy3r7C0qY5G1W9mNyZvHZ/2+16PzTw37K//HUL zutS8z1JcDbiKXsTOs7Az7YeVzta+i1EnxTq8wWyxHn9OsGG/I+NLv6KckZXDhsXX2H7YbgkIuT
 5918/oA6NCLqzyHc4/2KK+mfT/NizNO68J8Bvza61/U5gHBS1/+WYlTryMGeU5xYzA82hvwW0vV Tsm/hhGOcwaAoVyC2LxfQwzirkBo+/kHOGri10XMD0l3kYZFnGHoAro37wu/tDKSMXdYx+uWhO3 XpA+s48NO/qIBXjA3u/s2MPyxBrZkWktG4fAeE/2ipJcinuSilGhpbF1u439yuV1+sbY9wb6Fdu
 kEKyN2DpLAn7xPMQdiZKFY2jsRZzWaaW7+FdP0pEDMdqsEC2Rj8lxP57EnsdQIIhuba4Nbh2
X-Proofpoint-ORIG-GUID: PNKKMLgrIrAIgjC9ptEXSfm69CYYsH-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=608 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080120

Hi All,

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

 mm/kasan/shadow.c | 77 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)

-- 
2.45.2

