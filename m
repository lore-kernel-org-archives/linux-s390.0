Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA32BE043
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696214; cv=none; b=DnpmqHFTp728lO37+/b+IIlZTZu2Hpwog9qqtsOUCU+1Ug79NEnWcTFhg8fJeKzCyQOQqkgwFHwFNoGT9NZuOdqe3uGjk5m77PTdjhgU+AeGeZttv9Ly8BTYHmNQZ+O2zgkj7QictfVxm76DlX//JE5cOEw8kAkp6uzU9ONoB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696214; c=relaxed/simple;
	bh=yoFIbqGuhY+VeWInqHqv4AD1jMDxqhHEpGMevPsR0RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkmnIc0SypesW1DR3J3LADWLATcTt93xEVl3eSMIPcgrwJXHspKAcnC3B3p6/NQ7BsEkOYINFo5bY2mUwO9ax3CjyXNVZwUU7zUzQFvzgzehLCJyNr7lw+fbijy8Ll3fPQGs7v/Mkq4G3hyxU8smw0XYxq26Tl7yd29+W/jg6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EszFLrQH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EszFLrQH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmwpN1545756
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0b79Yy+X90YEGlaRVUtmLsA7PUnbejbz/h8ycvYZn
	v8=; b=EszFLrQHWORAOzur04T/aJOAPHxWvY7KGYiXScKXFTlCcTist4e4wP5sK
	rfEDGs3eLWwCnIGNrS+W+ndhw62J1LCgITw6q+iVeFiYQW7vNDnI/IJ40aYc63t6
	8AfROMQYvEptDo0kx9ayHVQTuB4xFD+Rxsc7za4F+V/1OmILcZSFo73rEXCV9XSG
	wRNDVNVkaJId3CK3HTtiG5hW5awE5ZdpCT8RbQzuu1o2rnmXWH9gNDQHitJBBiNs
	Rx7D2Kzu+81So6U6w8MEFgO1N7YTp6XO5sTU+WEqDaEe1/XB36Il9Of43qnzZPPW
	bQEAtSZlgEtIgkHVyplEmRLiwrC0A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknxn8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AF4cqS005592
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkjj85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:10:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFA6ls8847710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:10:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCD6020043;
	Fri, 10 Jul 2026 15:10:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F6A120040;
	Fri, 10 Jul 2026 15:10:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:10:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 0/1] Improve zcrypt reply message verification checks
Date: Fri, 10 Jul 2026 17:10:04 +0200
Message-ID: <20260710151005.79765-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a510b53 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=d48roj0Ss7RZprFRA_AA:9
X-Proofpoint-GUID: --UqRK2qzkANcSCC1DGL7ICWC-OLw6Qg
X-Proofpoint-ORIG-GUID: --UqRK2qzkANcSCC1DGL7ICWC-OLw6Qg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0OCBTYWx0ZWRfXxcYSsHfrIbE4
 ancgdfE3Id9PMHuVcsJvlzJ6Ed0bUIvH07xKo2BP46xfvJa9p2KJ8IcShHejZt9dyjnJsvRXmAu
 FQrzfe+xRJqEZ6eZKQ59G+NCH4Wcqtk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0OCBTYWx0ZWRfX2VQ4YUm5QzHJ
 6qKLGzvaRMJgZVmU8//fKet1bMURwDt+pQ+dgf7IxbBWIhF1lzse1ssyw0xgjBiSk1wMed92D7S
 8Cxs0wLe7TyDL4TRx0pFYdIQc9mQpZ0ruvSzJ0tz4JvCpPOfHLoUlnMIn0ZDZF3mkSHqO8b8gff
 0hzID2sSdbUpoj0I82KS1vgdso9XXdZNiwA62lNUlwioNgGxw4/YgQnrSRjyHcFfqFvJ/NBVikK
 JqTa8KErYw8tgab9htB1JetS/tzI6Lr03S6cYiXSuuQp0TIgoCfuLW4A/G3W7/X+PbGLegUyIDw
 40aA8Xp//l/kHdwtLOtJ2h0rqfVLcwU0wc5o9Ip+KUxm++r0tQNxqnECnHYB1aLMxe5LrNPcZi1
 a3LmF6tqNfzXbdBeX/bh+nh+27Kdb7fFk7igQY6lBFG7TjN6bCT7WYu27F1vI4YkvL4dj9uwLjZ
 YH/9AC+qdnjDSXS/4fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100148

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

The 3 parts of this patch deal with CCA, EP11 and (CCA) RNG replies
and improve the checking for reply buffer size by using size_t instead
of int. RNG replies an additional check makes sure the hard coded
limit of the data buffer is not exceeded. Also there was a condition
with additional data for an CCA reply where some of the field values
where unchecked used to invoke memcpy into user
space. zcrypt_msgtype6_receive() now checks all the relevant fields
before convert_type86_xcrb() uses them.

Improve zcrypt reply message verification checks

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA and EP11 (AP message
type 6) messages. The verification code related to reply field length
was not designed well and thus firmware deficiencies could lead to
unexpected behavior in the zcrypt device driver. Thus improve the code
to more closely inspect especially length fields at message replies.

Changelog:
v1 - initial patch
v2 - fixed typo in header check_for_overflow -> check_add_overflow.
v3 - rephrased and smoothed subject and text of the patch. It is now
     "s390/zcrypt: Improve zcrypt reply message verification checks"
     and the text does not talk about malicious cards any more.
     Updated Reviewed-by tags
v4 - As sashiko clearly states the addition of two 32 bit values can
     mathematically never overflow a 64 bit value and thus the
     check_add_overflow() was total overkill - removed.
v5 - Sashiko had a by-catch related to the very same fields. Under
     some circumstances the fields count1 and offset1 of the CPRB
     where not checked but used for a memcpy to userspace. So again a
     rework of the check of these x86 header fields in the receiving
     function before the CPRB is processed to be copied in parts to
     userspace. Removed all reviewed-by as I want to have another
     developer look onto this patch again.

Harald Freudenberger (1):
  s390/zcrypt: Improve zcrypt reply message verification checks

 drivers/s390/crypto/zcrypt_msgtype6.c | 42 ++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 8 deletions(-)

--
2.43.0

