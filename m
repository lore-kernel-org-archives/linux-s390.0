Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F82F657A;
	Thu,  4 Dec 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866084; cv=none; b=sFhHtWhuPEd7Jx7RHb3f4WmX+a8q0eIx5UcidwkOLItkkk6ZWAAtHI1RRSp7TnCwjakAquBCYBMveZnYkj58xv0jFecDUD2w4LxWzZ6gDE40Nn7QAYTGPmd2yf40cYj85KLEt11R6P4lYj9CPCW6njcf+QToOTij3juDiZK+2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866084; c=relaxed/simple;
	bh=SBwKV1683hilE/YnjJtjIU6yQTEBAdYAFfhwvVye2KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbtd1C2IzQ++fvZxQlJ46Gl2CRgiiVtRAF+EuybglwWL81fsKCVfLnZMTDFztgT4XhWD5mzpp9gEMCxwq8HNbRvjOTtLOd82kF9xh2ozaFh9DNyRRwBTqiby9QqDCdLDCgx8C9OILcc9id5v8g/XYduf6NMIvYiz9rZ+el/Ca6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WhWVJkpD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WhWVJkpD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4CFSmL008756;
	Thu, 4 Dec 2025 16:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1TTwowJHV1IV+siS3
	BB8WlznPeu2Px/clxR8zvfDujw=; b=WhWVJkpDQiIbHXAZ6OaEF/1qQsTe+WLgE
	OVSEdx91NRNTuxMs8KFlhx/U+3BxI7+0o+cj0tBYY/CJ4Jx6j7LGiTt5Ke0huh9N
	FiOFgf9/dhRq911at5IAlLJgT5tuMCsKkKbYznrnOzQs58BbATXHGUF5LEQa5MnY
	DlJ5Rv2TpA/UIaajFopWouNyDtP2x0y8zXU43QXpprwjrscqJBQd9sicR5Q2w7+v
	jbRaDNcEzoXxqLiQ0BwaBuM2gLfrXI+6aX+U0jaZ8FTIN82OiBRNNJPfZKZwkrY6
	DqHEgeInhPfSEmGFmPS7hCgmwJ3z5v6fccweXFoJrL0ZfyIspvbZg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q923j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4G1Mvs029338;
	Thu, 4 Dec 2025 16:34:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1rhc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:34:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4GYXr647448494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 16:34:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D013920040;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C6420043;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 16:34:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] scripts/gdb: add lx_lowcore convenience function on s390
Date: Thu,  4 Dec 2025 17:34:24 +0100
Message-ID: <20251204163425.370783-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204163425.370783-1-jremus@linux.ibm.com>
References: <20251204163425.370783-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX7z2KGx7468cG
 uLxSQJBM1D4yKAuCubDGAH/I6In591f36vGplUXqLdEFWR8oMpKsQjLLv1XoyQFOLABmRfBnL4c
 6aapUzZe4ww5pRZ12J1HeoK1+JFe15l1GZHJnoHVtHHPPYhdY9TMzwSYXF2aSskOCDWkiXK8+MT
 qrmvJp1kWHERF3QV9xclG7F+Wgt1uYgUCm0Dtk+B8o2PbBGe6D2TXxAI6kLjSwho5eOZVaOhI65
 PASqsdEBo7d3KEZy+4B+MWdsxstOGlGHcR4gbKWyjVgwRC5h7b+22yMshJrUAlR+y0ZgIO1sR7H
 czRIyquMbS1TjyQ7kSOvW9uMCQrAHvQG+UqY/t/b6S68sQTdDLTPqMxoJaU448PKxPYBLSvrhsF
 5CCWG6Uv9TAgn2XcG6fzZ3Q8sQH/Hw==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=6931b81e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-VuqP4I8GYHZTKfSeCkA:9
X-Proofpoint-ORIG-GUID: FZsyc8iKHlSM4xlKmYmRV7Ok9u3IscQv
X-Proofpoint-GUID: FZsyc8iKHlSM4xlKmYmRV7Ok9u3IscQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

lx_lowcore is a convenience function to retrieve the lowcore of the
active context or a specific CPU on s390.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 scripts/gdb/linux/cpus.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 12bf37d6a4e5..3e17550cd577 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -258,3 +258,20 @@ def s390_lowcore(cpu):
 
     lowcore_ptr_type = gdb.lookup_type("struct lowcore").pointer()
     return lowcore.cast(lowcore_ptr_type)
+
+
+class LxLowcoreFunc(gdb.Function):
+    """Return current s390 lowcore.
+
+$lx_lowcore([CPU]): Return the s390 lowcore for the given CPU number.
+If CPU is omitted, the CPU of the current context is used."""
+
+    def __init__(self):
+        super(LxLowcoreFunc, self).__init__("lx_lowcore")
+
+    def invoke(self, cpu=-1):
+        return s390_lowcore(cpu)
+
+
+if constants.LX_CONFIG_S390:
+    LxLowcoreFunc()
-- 
2.51.0

