Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB341D20C
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829519; cv=none; b=DtrA2xbPmWJSSae7ISXaXQRwfgS1emVa8YhOTfUNeK3XiY7vJKa4lcm3QIOFJke6J9hzkRWhd88qe8QW15eD9oJN9Z9L47IqTkUww4ID9H/OGACUe0a/57kVhd98uGvT5I1ECw/qscoVt5h/wxveJqH01TVBxA8Ps0YAfRmpDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829519; c=relaxed/simple;
	bh=sc24+AJVosQz+CNikQw1fT6bsmq+xgFqvuPPh4uzko4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewlQ6aIpJSWYnpzJGBfeokDVwLk2bMtFb6fMtg1HsxQXxZgb5lDZDVlaJGKz7d3kwIda6ak6hicVMXvJb2IdZT+XK7OYYXab6SgCcapYBFn6N1DzrvAGcXeCNyPG3C6E1RbwfxnEeCPCE8Ri1dQcH+wYhnIOBnlP280fadff76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cIXAvtIw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cIXAvtIw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HiOM3631346
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NygxM0SlDLsghAzDKACgGIrRUfXzIHzJcPRq0ECI3
	9g=; b=cIXAvtIwcCG1Jggqa0BBo1cCdeeOg4A5/MwJaP2vnNT1moESD3CGua6fN
	TOfKwzgLn07E0cf8F2Y+EWhveT3cXHTu2FH/fvs9euPzn8oUSaKnAUrJxYbZUYrK
	O2K98q9KAii2Rk0Twf3PabsCSl8wF7F/G06Jn40p7WJla+mpNfvIoDETrwQUyf/x
	qL5m+I8CPMJQK4YYwm/K2xMwvxnX0aTpPGMLe8HheULGyFu3dlSA8ERk4/g4l7v5
	qIB4aXd1kPYL1LxhIZcknvcN5LTBxjPB8puLWKjRu5rOeBP4K4Td9SbE5uDOR2Kl
	rH2rrgtCdHXO1qm75c/D420kmVW5Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3vr8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:45:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747fEce001400
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:45:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw134h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:45:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747jCZK25887178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:45:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21A402004D;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E908F2004B;
	Tue,  4 Aug 2026 07:45:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:45:11 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        oberpar@linux.ibm.com
Subject: [PATCH v2 0/2] s390/sclp: Misc fixes
Date: Tue,  4 Aug 2026 09:45:09 +0200
Message-ID: <20260804074511.236153-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71988d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=S5aoz9dx2N8BGubrCZcA:9
X-Proofpoint-ORIG-GUID: zizTvTXhzp2t0TA0XrFHizslUgU0bura
X-Proofpoint-GUID: zizTvTXhzp2t0TA0XrFHizslUgU0bura
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX3q5h5MXt/JUP
 9HRTYpmsrUNYWOAnig5rqanmz1TtWC1L8CRPPbU0QgssnGn/MjxW/Q6htdBezAIqCoHz8b6Zm6k
 1nYrCF4WzOWTNi/6xaHihS8ANI5MoyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX0YmySxjiLKN+
 hHICbiZpsRGfjo00dP6RPMN656vHzq9K43Lub15pBSX22ra4BI/tOhcjy513EFiph1GaqJ+JBac
 a4w5t1WCyJvE1NsxYe/9jwnZ/yCLqKG5BU50Hl4PJCxYq0q+uSdHEC3TuLGeb90X9E/9lBuVTcf
 oNNyc6mH++Exyb8V7TqP8p88I3J/oe24As9+l8zjUScLUL3lYnsqreCq1xA5bm0Pgx/ghH06INq
 NEwyNN9291pkf5TVFurWqlmJp6kiXrjq4jWNM5DZKdcDc1IawQoMogjpByJ4EAct/0q5jAo1Xww
 JCQ7CztFSnDtxf2rlEYEbBW+Y730yP+uBb9mp0+b/TdG+uN6KkyHR4Yxa8RGY1Q2bVfKO4yxsGw
 Cs9e4b1DN/SHk1vgShdtDN92tRGDnSV0hsPisjN/W/OKq8RTZlhswWFgEtv7o1/zrENpNtaiXsI
 iuu+9SdO4i9h5zE48rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057

The first patch fixes 2 potential illegal memory accesses when reading
the value from a GDS subvector in SCLP event buffers sent by OCF.

The second patch fixes a race situation with sclp_unregister().

Changes since v1
----------------
- Drop redundant empty lines in sclp.c
- Make commit message more verbose for the fix in sclp.c

Alexander Egorenkov (2):
  s390/sclp_ocf: Fix computation of length of GDS values
  s390/sclp: Ensure no callback gets called after sclp_unregister()
    returns

 drivers/s390/char/sclp.c     | 19 +++++++++++++++----
 drivers/s390/char/sclp.h     |  2 ++
 drivers/s390/char/sclp_ocf.c |  4 ++--
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.53.0

