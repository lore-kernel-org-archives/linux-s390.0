Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0684A6CE5;
	Mon, 21 Sep 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006306; cv=none; b=gSTZHp0v8E5wSSooAvCJlg6sDTu19T84s0A83bGeRb94wDe065IrN5lE5xwTvxXJrV4Fu4shTOllZzLV758XKd0yazFI3Gb9+Bb0dSmW/4rKx71Gz04b1VxgLITyFt/FKwzqiH5kxCBKrgLeDpoerIa7iq0M8FPIBYh7znHcB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006306; c=relaxed/simple;
	bh=QuLPXVAFgIJ9fPxmYJemmPvdwZIjvEMVor4YZEw3MJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPZht5+947+WsEeM9VJT+d34Z5Hcp2TChG3DcjpUaVGhGO3tU3V4vZ6Jb7EsxbSDEq/z5g27I/T6VJ8EFskv9U5p8MHv02GfUTYK0GDEbAOg+NeJWHAF/rvPhXvfBWJr7TkHX9cQU8WOE2PBODfZIkRtZI/OgMNuU5q165VNk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qi3szAWH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qi3szAWH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8EGX1860564;
	Mon, 21 Sep 2026 15:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UbSM4J6q9wHJGxcag
	Fzwg95TRKRs0Sfalw4VwKXSGug=; b=qi3szAWHqoUlIFHmjrdz9N5Ozyf53u3Ru
	5bLMfIMwOBNvkkxa/BH4iOHU3akxnwwcCU+EE96BHiQGNNbPJZk+YmrEyD48C2gw
	R1PzmXMpLX0pHZCS9wxof3DFFtXEvgmMCi8DPUxcEEvrl/ZZOp74ucjorjUdS4aj
	AmGP17c3W8x/mid1meUmxzA59U9GceoW3C5KQSAJB7yTX6tkGU5T7YgFwiKUW56d
	j/bW7G6BOm79nhPZGn09uoJ48vnV9dNiwmZRsHwU+vsD8KfWXvNnpz71p+WSbihf
	YVcm1nPUzmMaUHks3bFPWM9UIJRIr8vzV09ZaIq14+j6z1W96ZdFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg29fr1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFHY8T1489468;
	Mon, 21 Sep 2026 15:58:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq64dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 15:58:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LFw7wD40042768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 15:58:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13E6220040;
	Mon, 21 Sep 2026 15:58:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B372004B;
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
Subject: [PATCH v4 03/11] s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
Date: Mon, 21 Sep 2026 17:57:57 +0200
Message-ID: <20260921155806.2447506-4-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ujl8E45IAdKJQeZFFxVw6dJ4x9r4jNEv
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab15413 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=phCDqYjOjFlr_q_ZZjMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXyjCHfL5sOLrO
 HjiRNIsyK2PBwB12tdPwRixJFUJOMbLgsagSBKBprMwy9vfbf5qi+4HVk35OypS8/WCCnyyW74d
 MlHk+OjZGUX5qYB/jjMwCmLGd7N37H5LuoGvf15InM53wBDeaYASVXroPSelf8oIBvNjozs2YQB
 YUwEzdborUL8rIXG907WBFhYVFunKNew8EWjFeDdgRc9CiLCB2QHL671mCn3UuCQaPi7I68eDE2
 nU+C80HbvDUIa6+1SAEfkDMg/R7Durm9bowgtnU2GTR0xeJY+2hBey7gWRVWngq8o4s8XFijJLQ
 3OIw9hHAy4FRowSF8bwQjR1xSfOC+MRnCnKlH6+I4rvVKbOTVBsbU6yy10Kpf62IfIqh1IpxA3q
 MjL5b79tSuYgGErqFcEAdwZv2xccj1Sojbt7mOnzaOTme5TcATZPu3ebeda6yxwrF3RPaxBGeP+
 Qw+pq0k8yJoIuDIZP1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX/zymZYhk+RmS
 k/qnDqzRA0ICzENcpsfmD2EAUwI2DVvVM2eMzG7CZyDEmSRp4+0F6oyd20zoi6mP+CDoMmxgdZ+
 493JZmYJOVBpB+M/XaGzLKcZNfts+Zk=
X-Proofpoint-GUID: ujl8E45IAdKJQeZFFxVw6dJ4x9r4jNEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210227

Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
looking at the current users this should not cause any changes.

This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
assemblies, which otherwise wouldn't work because of the UL suffix.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/lowcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 5cef215d30e7..f0364a9f8a19 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -21,7 +21,7 @@
 #define LC_ORDER 1
 #define LC_PAGES 2
 
-#define LOWCORE_ALT_ADDRESS	_AC(0x70000, UL)
+#define LOWCORE_ALT_ADDRESS	0x70000
 
 #ifndef __ASSEMBLER__
 
-- 
2.53.0

