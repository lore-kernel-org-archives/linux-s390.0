Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158C47CA78
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938364; cv=none; b=H1vFCjhZGMZNNRebm6pS0UxVL9yS4o1Y+2mHQmD8g1IwWm0gmIwsX3MD480Cw54wFGK0gfcZGc8bD92fhhOGZwUUEkKfywgzAha35jScVXXF+M4yl/ccTOaOWP+Qgzu4nvmiN1rSo9AMlIFdip80/XT0bR8u8zFqpGTRcnBTCqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938364; c=relaxed/simple;
	bh=+Z+VXIRnlYCSW95dSW1/G4bprlhw9cPoPUqqNga1OHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7UcKqzZ0fQIUnhYTLZOjoKC1jIwvJZQv4+kEe9ci8lOcmNkrSxCuagpk6pNXgYXxUv066R0GEJXOiykiMXRdmvmxjK8x06DT2OpCxsMqqDoiqvJ9BmIOiIcN8sw6sFvm7YOYvyeW0MWTaM7Ow28HUf9k4L408UYVMe53aLgL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kMBe00Bx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kMBe00Bx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692A5iKg243391
	for <linux-s390@vger.kernel.org>; Fri, 2 Oct 2026 10:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+iAWHEsVDQL4kStoKlhj7mnJ920GWKxe8hQjf87L9
	QY=; b=kMBe00BxL1B2y5NykT1Q/dpJCL2zUCIErGLaKnnbqrzPGPU73ZchVKjIe
	DU+AXmcvdOaOLedgn5bTt0N2DaNj/a/mPTTZXZ+9TC1W1cLvjFTR7aKsQlh+RAeE
	GPNeomje0Py7DUg4JAJamf2mbrDxXa41fvJajhZPn77Br524WFiRGwPiOs3x+zs5
	+fo0GcrgsK0OhVZ261oomWDDVtf8L6Xju6mO4AmP8HDcHaETwdcYf5MJB9VdDJ+x
	EqKFkXGi2QppSz5iROv730kA20yBs0QI3tn2i81v3GHcV71iVjRAM+HoGxD/dapo
	52AhiNvgbY6BPfYWIj5ujSWkiP2LQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5rx47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 10:52:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692A2Vme2335481
	for <linux-s390@vger.kernel.org>; Fri, 2 Oct 2026 10:52:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsjf1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 10:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692AqaCk50921736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 10:52:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 939DA20043;
	Fri,  2 Oct 2026 10:52:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70CF620040;
	Fri,  2 Oct 2026 10:52:36 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.164.207])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 10:52:36 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 0/1] Fix and improve zcrypt reply message checks
Date: Fri,  2 Oct 2026 12:52:35 +0200
Message-ID: <20261002105236.52049-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX07L2F5k+eZwY
 rnLrWDshKDiRg8j6nfX6I8s2EyonhPxn2cesA1b4iqBmqi2NucIjr/Hmo15hD4XvxiMjYeee9v8
 0G9pJGbE9DnCu8KsiiB6rWPSe8M/CPw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX8EhfSww4ciia
 b/EidIpOPX+TBEnbz6K2S0iF0W7fB6dDQJ082LtPv5iVqsg5Bx6KxA2YHoaw5r+Yb16c5NT2m6p
 yJG0+080VqDoygcCJ5JGBzD5ewrIrKEsQBT5q+MCNz9ujwzXzaFx9J0absLUYgGqnFPZ/kIv1/K
 B/ZtnaUReqMVef1mZImxbLFDuLWD1WAuGU1TN6zU+mtZ6YN5RDXX732Dx00J8ghq9l1xRRO4Tbr
 uklyllfsOYKq644X52VkNNKJ2zNccWkOUmAzcaemoRtMExKPNLiMr4DXJUDy5rV6K0vVDGrBHmi
 s3Bt/iXf4cqZt1KkZ6rvIVEjfO5s/NGieDepKEFn/BaPWSbY/NNKmLopvfdyz8afNJAdHl867QU
 fBW9byBgFIITG+DpnIfh+IiE6tGxSjgvodSBLxlVsNp/+R8Eh+zYyjMeDy5q+G4+UXXricsh623
 JG9xMwHSp3SmZBS/mVQ==
X-Proofpoint-GUID: bVYIV7smD0UWmcY0rtT9SXuCVkMOBMdO
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abf8cfa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=grT_BttEAMHKJgu9PewA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: bVYIV7smD0UWmcY0rtT9SXuCVkMOBMdO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020042

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
v5: Sashiko noticed that for two functions (convert_response_ica and
    convert_response_ep11_xcrb) the length check comes before the
    processing of short error replies - fixed.

Harald Freudenberger (1):
  s390/zcrypt: Fix and improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype50.c |  95 ++++++++----
 drivers/s390/crypto/zcrypt_msgtype6.c  | 202 ++++++++++++++++++-------
 2 files changed, 218 insertions(+), 79 deletions(-)

--
2.43.0

