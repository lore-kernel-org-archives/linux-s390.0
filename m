Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6E4718C7
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131957; cv=none; b=JSPzw8KWLScJ8M+FGUStb+sulp1mH4/zS8fqRRUEM/kDz7HheAmLoOuaT4FaSyMn+YBdMGJxWbG+4p3lwxH68fh3ruxelpTiaPR9+28TdXyh0xEcxoI6014n+Qf6JwU29o4G5lbYvV+mXwkY+HdmsCjRUBZyXI5E1fRPzkbl2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131957; c=relaxed/simple;
	bh=ZwLMxnKz+TkOZukf+kOPYFa6CYvP5yj55K8SBWHJ43o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4O4lYlG3OA2Hoe0K9Xdk0v/C6IMRPQFmB0AA+yVT1wjKhVt7eCTCOy02s1J76i+xSvk7DF87YNrra4Hg4GElk2Lfj1vwzA2//z4WBXLhRSGYxF+b5r+1XUIh4d/p33fGV+5FJPVKDuuzoUdGBKLvYRfFDVy5hUeFYRhs90ye+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sw9mrqT9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sw9mrqT9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BD1WW11849570
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=q/dUnuiTr8JIjXMn5s3Eabuz/MWtqScTQIamCPPMp
	eY=; b=sw9mrqT9Z43te5ycnVkmNIzT84cwFma8nI7PufJ+qKn2jIqF3apdsrB/G
	1SWJruUxdv/9WwTDq680ZIIU3X0nMEBBbN8s6HgDHOoxm8Eugu1j1MVJHlGpPzu5
	AsfDQwB1akFf/ec3H6zAaEiAotCK/1GXHtKF1zlKjRhhvmBG9xKa/VWK4Bw3jmY1
	KhucOWk4N9JasAV4Qu7W1baNxftBBTZvubDX+/cx0PoRtft3e59NCXaAAbyXiTSu
	jGiYKWV+mCUU9Q9xpDM75bnJLEHzesJVi7jp8UpMV4+h5aGMq72WMlZXUPVKnVqJ
	5o/x0T+b0+9/p6wYAzU1Hr2XxUMCA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8pumhk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCo4IR1632620
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk6dfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 13:05:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BD5n5N39387478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 13:05:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AAF32004B;
	Fri, 11 Sep 2026 13:05:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3F82004E;
	Fri, 11 Sep 2026 13:05:49 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.203.157])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 13:05:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 0/1] Fix and improve zcrypt reply message checks
Date: Fri, 11 Sep 2026 15:05:43 +0200
Message-ID: <20260911130544.43484-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa3fcb2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=grT_BttEAMHKJgu9PewA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: RoAa8Qr49ojZGiApOngHK9AmnhzRPYO4
X-Proofpoint-GUID: RoAa8Qr49ojZGiApOngHK9AmnhzRPYO4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE4MyBTYWx0ZWRfX9d5tk6rnrDN2
 ykyUOjbwCBCALpyUC4iiQk74Dkp52P7b3P9qb/Cvn+8BuWedfIfzoQmVc0t8k+iBtZf+NDZzCPf
 g3zUB5g1pSotm9an1tHx3/0UZO4vf18=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE4MyBTYWx0ZWRfX1H2orJi6TJW4
 NgKcLthTiUxQv+VwkIUn5B0oLrrsN4EHOtlqDhyID3xLgZ7RMNxN+zuBLEhW2zFUiu8lElbCDMf
 Mg7cl2hD/8etu7y775Vz1lt8yQPi0i/Rlwt4EQNxUe5rMtiFnEjgpMGPp+WnKVycQoeOpoCuJR8
 9kuS5yWc4O/voOziU9GznmixJ1kqz+17wTzddaEHd2vWwsrdgy4+46itAEdGz7L0Uof2oIId/2K
 GX+Ct53YwJP0i/N5r1LauJIyq1WoZauI9Mz86jrCz6ENOwMu9ntz63ywk0DOtTHODz8qt9RbRas
 Gp+4VyJdovM+eIu/8nXpmmYv29Oc1RqySLpbeZwUWyoYF3EfVo1ila82n/AHp6N6EuvbdgUDYFk
 z9TMQkCx6grdrZatykqKGz1JWH5yAEW0J6mDM71202Iatfyy+kOjW5tlkq/Z0nimdP33A4iA+9J
 ywFi/VQB+3HAt8bttrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110183

Fix and improve zcrypt reply messages checks of type 6 - CCA and EP11
- and type 50 - ICA.

Changelog:
v1: Initial version
v2: Sashiko complained about not checking offset1/count1 at all if
    count2 for an CCA type6 reply is given. And a check like this was
    in place before the rework. So now offset1/count1 is always
    checked and only if count2 is non zero offset2/count2 is
    additionally checked.
v3: Again Sashiko had some complains which let to a broader review of
    the reply processing functions. Especially the zcrypt_type50.c
    functions convert_type80() and convert_response() got slight but
    significant improvements - and also a mysterious BUG_ON has been
    removed.
v4: Again Sashiko had a complain about my restrictions are too
    tight. So now in convert_response_xcrb() the exact length
    verification is:
	case TYPE86_RSP_CODE:
		...
		if (reply->len < sizeof(struct type86_fmt2_msg) +
		    offsetof(struct CPRBX, cprb_ver_id) +
		    sizeof(msg->cprbx.cprb_ver_id))
			return -EINVAL;
		...
    thus postponing the final length check to the convert function
    (which does the job hopefully correct).

Harald Freudenberger (1):
  s390/zcrypt: Fix and improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  95 ++++++++----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 198 ++++++++++++++++++-------
 2 files changed, 216 insertions(+), 77 deletions(-)

--
2.43.0

