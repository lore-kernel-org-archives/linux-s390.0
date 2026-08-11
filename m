Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C043E077
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458203; cv=none; b=jG72Rtsy1KuprDWvpbn4cT0gLtAzPlLqZMBrpitvLtWRLnhFR9u0mXkNVwD7PI3ZoxxAl7bezP/3nr3xJz1R38/GBs3nWOjPtj1oV9qauQPSmiZQsRqdr2o1Sozkk0rNckG7fVKn8rmd1e5Gvg2jljup2Cl1Lo1It3P0Af7kA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458203; c=relaxed/simple;
	bh=uK1GjMWZfAl0cHqhD3gDHVM/y7DCQY4PKyXZU+DTxC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toyHQA7F0lqMLnb46wXKpS5ZCLiDNMVEBV3ELphPYayKLJ33hovgIVui8Bt99tMze0t/7o09TXd0tnKrTnCJ3BLgfwimpF+56Wk95x3O3nJZVuf70LWgrC7pYYcsR+kbKx/CXYUT0StjTdKwdFydREqrBg/tbXsK8lJzMCBw/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E9jJdPNX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E9jJdPNX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWutW538101
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=W/euflnqmMBw7y7F7cnoMc5ZcjkKnt0ZOzqAMqdbe
	Rs=; b=E9jJdPNX2MvJ3RSP0JmHuCchENqKfL3lwb9YnkhaFBDx/OU0rIH9Crvrw
	IKMKsv6WRKaY/OxZQJw1J87vSmkExHFFg8Zwdm68RZJBckfj5sxZpB07zTdB8hiz
	/wctObQBT2z7aPRFHV61i3lEKk88ZikskFe19Qi8MPrkiLI1vgtFmZdc0q487pvf
	0VmlJoJrgHdvfv/yf7fH+t/pW0Cnzz4e6typ6kiNlPbJ9nTfmw5lSzOHbRFq5FVm
	TC2Dyh2U3rUtHAJ8JiIdziDWIMgkXaeQG8JWSs+W6abE4Mjv3qKUMU6jLE1GISEx
	kIM/VCOh8DEXMnKqVtnD0qxacLPnw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9nct0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:23:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEBIS4002750
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:23:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjs9gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:23:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BENGa032768298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:23:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58BE020049;
	Tue, 11 Aug 2026 14:23:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FF9D20040;
	Tue, 11 Aug 2026 14:23:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:23:16 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: sumanthk@linux.ibm.com
Subject: [PATCH] s390/diag324: Preserve -EBUSY return code
Date: Tue, 11 Aug 2026 16:23:06 +0200
Message-ID: <20260811142306.4032721-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX6jraTaBf8Evp
 WSBWMddmdkxKljUPy3UtmXUMsBMr2sDoYuhmZjA2ixoFRJISDyVmcSz11vkhvuEnRFG8ZTdE4eu
 70eU//WsFuXVCRev+3Tq4vnRlhMjfUqtewHZr/qxQN2MMSGQxmgnTgEG29fIWi7rzUeyQgTyOL0
 zkRgWfjPh7NrGD1YtkASqp5/Eh6C8YxZxSDf/5BYdpwy9KCNpab7LubRSlNvQJ6zsIO3TS6iYlP
 MhPtTl5Y57EAerItzpMqCl5fmTINcWdO+DAHlYiKYFpl7Fco3OhkBr9dMqK1341GCVcrFcqTH4T
 IOBKIsLsJWXrStp00jthQoNYkWqWUR9fdmlrQHyGhqA0Bei0rDY8loAKUww/tP8baZqog2ZQ6ct
 WDoERbOhwiOPk10SyVby1kOuUui0GN43NsX1xEkDUD+K76VOsRKUlM07rZDmh0Ru/cqFrtpV7S5
 8EsY2GJbQ4A/+y1bq5Q==
X-Proofpoint-ORIG-GUID: 88OlkJtkDt8th-EkLcS5ccj3O3B5Qx0u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX9A5A/4iOfE51
 XNEB9CL+o9QLL+eWyucFJ+Rxh1eW6o7CxTt+j4+PBW7fw0VhGjbZON30RcuLDPS3vKtpULSRo2h
 rHKX9lQN4CZmF2gETcaCBiFay6TlFmw=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b3059 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=YkybIm3N304ORUdPPj8A:9
X-Proofpoint-GUID: 88OlkJtkDt8th-EkLcS5ccj3O3B5Qx0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110117

When diag324 reports -EBUSY, the error code is
overwritten by the result of copy_to_user() and put_user(). As a result,
the ioctl may incorrectly return success instead of -EBUSY.

Preserve the original diag324 return code and only return -EFAULT when
copying data to userspace fails.

Fixes: 90e6f191e1ee ("s390/diag324: Retrieve power readings via diag 0x324")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/diag/diag324.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
index fe325c2a2d0d..3eec0cc8fb9e 100644
--- a/arch/s390/kernel/diag/diag324.c
+++ b/arch/s390/kernel/diag/diag324.c
@@ -182,8 +182,7 @@ long diag324_pibbuf(unsigned long arg)
 		goto out;
 	rc = copy_to_user((void __user *)address, data->pib, data->pib->len);
 	rc |= put_user(data->sequence, &udata->sequence);
-	if (rc)
-		rc = -EFAULT;
+	rc = rc ? -EFAULT : data->rc;
 out:
 	mutex_unlock(&pibmutex);
 	return rc;
-- 
2.54.0

