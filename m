Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C7218AA5;
	Tue, 29 Apr 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942933; cv=none; b=ABiLzVAkRmEDoaJZKB2uTnEI6mcMRRr4/cgyS0VKX3BpqPI2Kl0EOGQgQZCVF0bOAECjM1yJCEppFOAqpb/ZebhyL7nkLW9cfxNEKHWji4niVH0wzaPEMFJ7Uu6bkwMTzGEwCW1HpURqp0CbTUn3UnDrTXyf30xs7RTcsKF15TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942933; c=relaxed/simple;
	bh=xNEIfHJKcyOb2oWk92IBpklWB6rBC+6xUQ/NvTDr8kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiUZuxIolzRXD8mLsqGTjYKzvWJvxlX9ObUs/DhwioYkO9NMiGG+lTiVyMLCD4lq+VoY2PGltSOEfpjH1cq4jSGDWXkDKRFJQPU1tiwUJF9qOlxp/4mHqFE4XkfIbr+2IT5VgECZrGeR6er5OKg9m9Hn/0TT1frUK3qM/dFqoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gbNW+wZh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gbNW+wZh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TAf99I009668;
	Tue, 29 Apr 2025 16:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vNOzSBSOSEnG/goQiLTZesHUpOBG2VowETXI+5leB
	H0=; b=gbNW+wZhrZwdnCPC0WOmb4LBo6NvePpFGj3kI0rnmXKQ9R77Y7+BvK2j1
	x1wrr9vQiFWqZnBjXrJMr+Xx7IYAOPca0/qpGC1noyJQNmI9mlvZgnxZzObFp6Tg
	tLYK4Frkl6YOUQrr2ESTdDMLSzrSOZuDTN0E95bgXoiUX4gysQiueDebIspifkuc
	mipXEmxWDBlCdCXVeULBkW8s0oiF6uNWL+AMTb9AaQ1wAe6gHq51DwTs0YnHz1JH
	/6U0kKuTqoaRuu9ZcYGzsDyNdhYzgSzd2cOXtkmTZncYLL1yj7Qu76kVAdQkux+7
	gXqZnjuB+0+9xc7m9WU+Nh4lc8kRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46aw7t1hxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:08:44 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53TG8iis007753;
	Tue, 29 Apr 2025 16:08:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46aw7t1hxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:08:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDXUel000717;
	Tue, 29 Apr 2025 16:08:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpc0jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:08:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TG8f9o52625900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:08:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9DBD20049;
	Tue, 29 Apr 2025 16:08:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B1220040;
	Tue, 29 Apr 2025 16:08:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Apr 2025 16:08:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 4D4F5E05FF; Tue, 29 Apr 2025 18:08:41 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Tue, 29 Apr 2025 18:08:40 +0200
Message-ID: <cover.1745940843.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMCBTYWx0ZWRfX6b2AMYNSl2Qj whmcHnWA2LOtwMkhM1ZGagtfNeXgKHA3/XAeqegiBht+FHwH9U5rcd0CBy9wu/VDJ4XNgUMbXn+ fDKVBUOzUH+zbhfkybKBO0eol93PXaax7ZLZJAt14imrORL8cZtVLtQZlP4S4hn3hV/WuoMVNG3
 WWn+aJGKlnIvDuF1S01X+DeQFUh6jFA9QKRkDg7fSNrL2ZRq8H3yBSjFt47vfzMHM5nJjKo291h 4I69VCZa2kvA6qcxLa0Le/BO8HqKmhE5SCu7EEWJp/PREUuJB/raZ39oPHGH8a3PSgvGPrODOTz 86kQGvbOYiRqLxTf/lE5fQgr1DCB6XXgwExiby59qF2j48O6rfECHjs3cYD+lRGXZZZET0LTJAB
 8L4rhs3KMR7kv7Lb6REj4WHWsooNw3V++PaSNpjmcHpWDBgRYuoNF9E2eu2SwBLJHcgDa0hM
X-Proofpoint-GUID: NsphRUiY2q1Gr5aRWLKjtKe-3YuLzCiX
X-Authority-Analysis: v=2.4 cv=MJRgmNZl c=1 sm=1 tr=0 ts=6810f98c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=Jfx5KTgcOMEgCse_l18A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: aTUTgI_UqpX2h7jR88zO9b2BtzhZz50p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=539
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290120

Hi All,

Chages since v2:
- page allocation moved out of the atomic context

Chages since v1:
- Fixes: and -stable tags added to the patch description

Thanks!

Alexander Gordeev (1):
  kasan: Avoid sleepable page allocation from atomic context

 mm/kasan/shadow.c | 65 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 16 deletions(-)

-- 
2.45.2

