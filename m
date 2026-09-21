Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84D4C2252;
	Mon, 21 Sep 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006303; cv=none; b=GKu0I+nTnX/CwNOawRJsvklVGdvIze064tQQynIoJFC0+tG9qnWJz6Z13ldV/EbzNEoA/WQcREfIEQvAT/S9gwQy0SUCoMvIwBQaKQTQlqiMu5nyuQwRziTNGdFgXSQKcgx9b7mpopfG923KAuMwZn+hGcOSbS0j9VbEfDytfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006303; c=relaxed/simple;
	bh=Su7sJp4PolGeOOs8L1MNG5ZVxwB1v+NWwbtvFp2GpUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCQWCFELW04Pv+s0uH7RzHtPLe/iSV+nNv8prukPEMWawcAgqGxyiUaomts4I15r/iPRIhwOFrSKkXuNJlpEXd47xu0q3fWDss8Y1q2X0OEDmTH5S+7EbynFgaeSWxWBOnde4bycv/U1u7vvw4cwO52w0Ga5XwkOxpY2rR7aWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQF1usEe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQF1usEe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8CMh1869520;
	Mon, 21 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O51KxBvtVfbHMzPOo
	XoHcywhUhm2H4kz862QP8ALIJw=; b=aQF1usEeXAooZBnZjBx742PWbsXJlZ7zI
	n0eXiojUq4lgl14O1FNch3XYNUTjWPGAYDBJyP4VDBWKEjdvU45YRy0T7tYv4qKM
	0FKW7AacTWvRgO2aX5ljyfe/0Gg4yxttzYGcYF5mbEKmVTn6rdmebXhZyv+NRIf9
	aCMOF1h+c37xZuvzsUy6veKOWxAsxJSo0ySZdWIODX4Up0cklaukTJJcMI3Ye0Ya
	YJeik9qxnosSmXvmEG6sdajQfuoR9+BJBlMrm8LDubJc21SUF7HmqEZiY4y8tnea
	FAFlNwknqg4i9lTB6IcrMXkrPSEooosgDA7a9dEgTi3rOtPLNHJ3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs1fk1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHTEC2399617;
	Mon, 21 Sep 2026 15:58:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy5r3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw6Yu41287986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC30F20043;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 975252004D;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 15:58:06 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 02/11] s390/percpu: Add sanity check to GEN_MVIY macro
Date: Mon, 21 Sep 2026 17:57:56 +0200
Message-ID: <20260921155806.2447506-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921155806.2447506-1-hca@linux.ibm.com>
References: <20260921155806.2447506-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab15413 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nXcjTbxpPpxkwf3kCnwA:9
X-Proofpoint-ORIG-GUID: OSMPmh4CRiuqyRMx-JXlDF0sbNQL_bf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX933hFn+mm+hD
 B9QxP3S0tWDH5J3KZ55RZHHu/sFrMxb6MP1/dGuDQqhzoPUjAll+w68I43B/m7c3/5C7ExzS9W8
 TQSz4oADGseEoGKQiMr/+BEYo5k4Fwf/yRY2RvBQsMy0kp1AnweBIvxJtM5BaBR6kyjf/eG1VpW
 ZNuAkAgn3URbhLFwDiHZaejq6Ag1v1K9Z8JjYFZrs0KMVp2/0YLoLB5ieEIHTmeIgpC2QfPtEdz
 FCGRylCKiqYdw6jNwbg9xLd4C+ViNrDGzHp7f063zgoZ3EMR1DEaQ5qDW9YFeGUzuh5s7c0EMJ6
 p8jFwz+/ucFJEnP+8TnJdSxEejQaBm62Y3WpGV2RGSzO1bZPuhqdXHIxfW160DE31kuh/dPQjS+
 LFIkYKlyMYe0xTHu9IwvXAEo1RgL92BGbuKfqBGREldGr07rsPcP6tzFn+7mJk4q9f7PL59v5i/
 ArXpunjdSpcz4hUqGKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX44angYovkGQ0
 uzvU5JijCvt6G0YZic9GqW/GuDMg8GhNWb07qANYEsvV7KCzqwUGFo5KUVwNV/BsH1OZCWIqiiM
 XKVm+2VgsSjMeFVP/REzXmh0dOxxcEw=
X-Proofpoint-GUID: OSMPmh4CRiuqyRMx-JXlDF0sbNQL_bf0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210227

Emit an error if the GEN_MVIY macro fails to parse the passed register
string. This will make it more obvious if something similar which was
fixed with [1] happens again.

[1] commit 101782f8945a ("s390/percpu: Fix MVIY_PERCPU() with older binutils")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 31012abe8292..9888b38dedab 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -100,12 +100,17 @@
  */
 
 #define MVIY_PERCPU(disp, dispalt, reg)						\
-	".macro GEN_MVIY disp reg\n"						\
+	".macro GEN_MVIY disp, reg\n"						\
+	".set	.Lreg,255\n"							\
 	".irp	rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"			\
 	"	.ifc \\reg,%%r\\rs\n"						\
-	"	mviy	\\disp(%%r0),\\rs\n"					\
+	"		.set	.Lreg,\\rs\n"					\
 	"	.endif\n"							\
 	".endr\n"								\
+	".if .Lreg == 255\n"							\
+	"	.error \"Illegal register number\"\n"				\
+	".endif\n"								\
+	"mviy	\\disp(%%r0),.Lreg\n"						\
 	".endm\n"								\
 	ALTERNATIVE("GEN_MVIY " disp    ", " reg "\n",				\
 		    "GEN_MVIY " dispalt ", " reg "\n",				\
-- 
2.53.0

