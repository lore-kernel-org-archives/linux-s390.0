Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88F33DEF3;
	Thu,  6 Nov 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445355; cv=none; b=PoXIdET8Oznm2xSkvIUw4Wnn4nx5/B7CiMJy0+ZlLAommG1gGsgsfzZTCxBe1WV/YTUgMMPyAX92Z3zFuZUrVF7XrnvYL9uzrmvSidiKyshci47Mi6RdqtWsd//6X0L6NGOTgNe3F4A8/06FYBiBbqe7fZ2Jp3iefAFxcstzGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445355; c=relaxed/simple;
	bh=CUoxdL2hu9SjwD8on3W0rrXhbdYozJabVNtQ81qFKaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmAtCvexiWSYH8FYKOoLatKW9zUeAOzozXJetCzbT9+MulGcfxxT/M8U2aN6UlBOdHj00F2pcShhA3g9fCQau/ZJqsdbQK6TYjET/X7L6frjP0+teExiRMHmYGqufLYcTNhvDLBP88pXII8s1oDq+jiwARvzgLVg+2eA3G+3+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Age+i2ve; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Age+i2ve"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A68oc4A030782;
	Thu, 6 Nov 2025 16:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kBkC7zrPOewXW/Pk0CVDrxMn8x8sMd++XtEVOn85z
	Q8=; b=Age+i2vePvB+LSLLLbPL22On/jr3dDndzvp0l0zg+j4ybFKYUSEqOOFT8
	rFNvgnVaqDypYIqjbDZ+8PfzNUViKkd/3CeLqeanToAOHGQfblNpmpN+1GvqM2h2
	1HmS/iHc0J37uOF4Yx5Yghw00W/QZFi9+QaCTRw8j9iPW2XyzIYgqc6klp4z8JpI
	OfLNVzDMxGpAbcU95Y4lXoLWwu0kvVisI8v2b3roxqOAOVm+R+C7zBv8DFb4Vv5R
	hyjiujyLjGbVSXGYU/uHmnvLbGwJslC/JYx/2zhCIflxUQ3gb2qEzmrtT/EpoI7n
	uVHIQIwsSkjqf+D5WkUP0mwV9AQig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vur6gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A6G5juR007347;
	Thu, 6 Nov 2025 16:09:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vur6gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6Eddvg027371;
	Thu, 6 Nov 2025 16:09:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwypfgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6G8v4h32113122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 16:08:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59DE220043;
	Thu,  6 Nov 2025 16:08:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65D9820040;
	Thu,  6 Nov 2025 16:08:56 +0000 (GMT)
Received: from li-26e6d1cc-3485-11b2-a85c-83dbc1845c5e.ibm.com.com (unknown [9.111.24.158])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 16:08:56 +0000 (GMT)
From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: [PATCH 0/2] s390/fpu: Fix kmsan false-positive report
Date: Thu,  6 Nov 2025 17:08:44 +0100
Message-ID: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JOWFrIeWMqn245vgRdby_F5E58YycLMN
X-Proofpoint-GUID: RJ6XjdSFawZ2LFKDN-n-5Vl7DDYv_MyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX1ELoPqIfaNGt
 pAGzcEvZn/IFCkh4ow9Wt7zqiZLP3CvoGPoEwl7ACHl0M5ihGA8+jBbE1F9O5mP34x/ZxB59+Hv
 wGII6SGUw1pp8AyxgFjzqUgev8DzvHk6HXlnRqqv/1hIJlCAvPxVUG7a18lAgtrV+FZkovdbu8z
 +Zm9Ywgkn4KJ72fqd0/dT5ypV12/sFlm5OYRbqorr+KF9jh28OJbCRzujL7BanbQi02FAYYTRkT
 7qX/geCOAyFBHeYH581bkuHLB7Mq6avMqfhliGyeHLcoPMONQEXOOf/l4YHr6ooOMInFyaekoi6
 U/Pt3mXlAN8xAmMZXjmIVfgzRE4U5gSD+hlVeXtlX26SOoYRpNclm8/fxTYnTrGyL9DiKdjb7id
 +yBQJcQIc9/mAcdEnuQphbZQQ9z2sA==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690cc81f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VIxkIzLlmwRAJRPTlxkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

A false-positive kmsan report is detected when running ping command.

An inline assembly instruction 'vstl' can write varied amount of bytes
depending on value of one of arguments. clang generates kmsan write helper
call depending on inline assembly constraints. Constraints are evaluated
compile-time, but value of argument is known only at runtime.

Due to this, clang cannot generate kmsan write helper call with correct
size and a kmsan helper is implemented and called to correct this and
remove false-positive report.

Aleksei Nikiforov (2):
  instrumented.h: Add function instrument_write_after
  s390/fpu: Fix kmsan in fpu_vstl function

 arch/s390/include/asm/fpu-insn.h |  2 ++
 include/linux/instrumented.h     | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.43.7

