Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72643746C;
	Mon, 13 Jul 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953760; cv=none; b=Rsy0bnoQ2Mpz+rqnEWaFTmsaRFeZ803LJ4FWwuKMBqg1zkyIoMGDV1H8Arjpw79Ey4r9oJjZO0HiFOrJZC5Oy9DPGdtptXGfdzn0d5UoUz9Y9SL9jyMUObGoAUzgAFH8vpDqXTmsQ7KTVEWvhTdRHJBYDDnM2CdPbvdCZFKHNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953760; c=relaxed/simple;
	bh=eTYYt0CErZYxOX27AuUqSAMBEtvgGy3JMg5lyuxUUKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a46F5bnDMME1ryPzwKULWf+g7H3pcm4/G3TuWJ/alj7EpLEmjoPmfCniBKkyNHl32wgLOqb8fILcQy5+irRYA57KJmo7p2HKP+QvrxgSGnkwYb+P9PIxt1WHp2CQM2zE+TwRDN+35rYKXUVIQDEAioozWskue82SYF99Ji8WVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nVuehPzf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nVuehPzf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCCqWr554014;
	Mon, 13 Jul 2026 14:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3kauEQNxKsFZx2Wb8
	CaVwtdJPF0hNpi7hW06ZYqynGc=; b=nVuehPzfwsYBxk277eqUKLZ/KXKUJv1gw
	3M2iCwS+KO6vnDqfTi42jrAOR3d4eKrAAkKIbZ8Ekt6nr+YFbR6ppvS0aTSwKWf0
	zryX9tEoYvEAbDOcQ3PT+QnqMOxdiw5AP+rXB2B8Dvl71MQfuXLIcdHk5Ib+LdZ4
	JmZywI5JTrCQypV9z17DUeUgY1A3EXNEATNyRn1lo1spg+h8cyj3vOrLg96/4ZBy
	H0xvh68j5y2vJLpz94MrnfAL1QBQmkwr6M1WDyXi5TU18O66Z1wFdXAUoqf8e8YM
	LwCicO8cstEM+NtoGS9svdEUDQ53apXH6OjxOZYmw6b1pKI6d6Jcw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv331qqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:42:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DEYa6L025090;
	Mon, 13 Jul 2026 14:42:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxwu31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:42:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DEgYPL39125472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 14:42:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22D182005A;
	Mon, 13 Jul 2026 14:42:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7F220043;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 14:42:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] s390/vdso: Use symbolic constants for the PHDR permission flags
Date: Mon, 13 Jul 2026 16:42:31 +0200
Message-ID: <20260713144231.1251145-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713144231.1251145-1-jremus@linux.ibm.com>
References: <20260713144231.1251145-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX6QRkZAYMdZIj
 hDwSR0AZnZ50Cx5a+x3JM/8rhridnIrbRoRB5v/PVrwv7QEyz77DNFcLZDCBxVvkVVkKa/5mkl/
 sDEOjrlSMMjqNhZ+HxR6crZ0fnZrVlo=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54f95e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Mk8Ik3_Xw2e2UI5hhpgA:9
X-Proofpoint-GUID: ZYIZo1ZEPMz__7ti3U1jTc4HUuqYSbH7
X-Proofpoint-ORIG-GUID: ZYIZo1ZEPMz__7ti3U1jTc4HUuqYSbH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX8QvqKKz2BOHl
 9VduIjrkohbkVQ+oCe6Hi/zKHyM7HRTGgvgS0MoHuzPPnLxEhu2sR4hG9v4qTrpZjxPpH75Cet/
 vsS/hwXxIoGwxbHxMJl6CnMP8Wvd1AODsu1zOcL6k0rLRx/ERT/3mAT2NaMk9MRIulRkFHLxkcJ
 sFwEZBm42Yrjm0LKRhYoNavnCcd8dCDttYp5bceEkDLlO73jWudd+p5sk6Tgap0mwpTlnEonqMc
 MdOhTisE6IJ2d31iIhJq1qa7p+6Qeegw7VEkJiPB4DoHr5vMUxes/Oib1F7g0d48rfQQIsYbWbY
 4K/BjCtJmZlpfJt7koLMMopxhQv7Hj6lnqRD2AE/rjrQMD6eTXtmCIqZXSs3VzP3WfV/zwXPnn8
 bQSacTorBWe09PrKIVALqvNWBpjVVtTNrFR58dr+/HuZWXiUNpXNxbQ4dLU0BjR5TkAWu7JquTS
 hlcIWdaQao+RTIFgnpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

While at it explicitly specify GNU_EH_FRAME PHDR to be read-only.

Inspired by x86 commit 8717b02b8c03 ("x86/entry/vdso: Include
GNU_PROPERTY and GNU_STACK PHDRs").

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v2:
    - Drop unused PF_RW. (Ilya)

 arch/s390/kernel/vdso/vdso.lds.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 7bec4de0e8e0..841daeec4be2 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -82,12 +82,15 @@ SECTIONS
  * We must supply the ELF program headers explicitly to get just one
  * PT_LOAD segment, and set the flags explicitly to make segments read-only.
  */
+#define PF_R	FLAGS(4)
+#define PF_RX	FLAGS(5)
+
 PHDRS
 {
-	text		PT_LOAD FILEHDR PHDRS FLAGS(5);	/* PF_R|PF_X */
-	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
-	note		PT_NOTE FLAGS(4);		/* PF_R */
-	eh_frame_hdr	PT_GNU_EH_FRAME;
+	text		PT_LOAD		PF_RX FILEHDR PHDRS;
+	dynamic		PT_DYNAMIC	PF_R;
+	note		PT_NOTE		PF_R;
+	eh_frame_hdr	PT_GNU_EH_FRAME	PF_R;
 }
 
 /*
-- 
2.53.0

