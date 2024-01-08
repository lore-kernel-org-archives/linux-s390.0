Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042544C86;
	Mon,  8 Jan 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gl7dQP7I"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408DHfwn028275;
	Mon, 8 Jan 2024 13:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e7+p19b4UQCnAzTIJnD6cayB2XAyQ2W1F6JCV9Zw7co=;
 b=Gl7dQP7IveYQa7BkfqbX/UuCFWXMH9ezNbNtYxZEx1Zwp0nl2pwNNbFcgtqNu0/uDMDg
 QvsQgveyT54qdTlbg7RfBsmvgBBmjQ6/qQNIGj9kNUtRuVy/7ds5uBXV/a2O2RjsklyR
 7NktlfN0gyRtS3iYLr16jLEl1qcqgv/hXkdy8VIlz5splPQjFl9uhm+rARXaITxcvsVw
 yinh+qD48LXfZifTfZGeE2g28cxl9SpPqH/AQ9D/E7ohhHHN3IeAvL9q9zs0wSUeHeRg
 8OUBvgLf+uXLQpV0DNiAk/tuxysO9tdk9xFMGQ/A7Hv6dIRh6FdnQEEhCOQVfJa4C3nR ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vght90g6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:29:51 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408DHeLt028261;
	Mon, 8 Jan 2024 13:29:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vght90g62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:29:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408C2V6s022787;
	Mon, 8 Jan 2024 13:29:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjy8890-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 13:29:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408DTkuO19399400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 13:29:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBFCC20043;
	Mon,  8 Jan 2024 13:29:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B00C82004E;
	Mon,  8 Jan 2024 13:29:46 +0000 (GMT)
Received: from a46lp67.lnxne.boe (unknown [9.152.108.100])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 13:29:46 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com, nsg@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH 5/5] s390x: sclp: Dirty CC before sclp execution
Date: Mon,  8 Jan 2024 13:29:21 +0000
Message-Id: <20240108132921.255769-6-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108132921.255769-1-frankja@linux.ibm.com>
References: <20240108132921.255769-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SmrwoCYeJPXRMqksv-7iz-rp0Y1EYKzj
X-Proofpoint-GUID: cXf9sGag4m-S0CUp9w68kdgs6upJtq7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_04,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxlogscore=676 mlxscore=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080115

Dirtying the CC allows us to find missing CC changes when sclp is
emulated.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/sclp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/s390x/sclp.c b/s390x/sclp.c
index 1abb9029..bc6477eb 100644
--- a/s390x/sclp.c
+++ b/s390x/sclp.c
@@ -399,6 +399,7 @@ out:
 static void test_instbits(void)
 {
 	SCCBHeader *h = (SCCBHeader *)pagebuf;
+	uint64_t spm_cc = 1 << SPM_CC_SHIFT;
 	int cc;
 
 	sclp_mark_busy();
@@ -406,10 +407,12 @@ static void test_instbits(void)
 	sclp_setup_int();
 
 	asm volatile(
+		"       spm     %[spm_cc]\n"
 		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc %1,%2 */
 		"       ipm     %0\n"
 		"       srl     %0,28"
-		: "=&d" (cc) : "d" (valid_code), "a" (__pa(pagebuf))
+		: "=&d" (cc)
+		: "d" (valid_code), "a" (__pa(pagebuf)), [spm_cc] "d" (spm_cc)
 		: "cc", "memory");
 	/* No exception, but also no command accepted, so no interrupt is
 	 * expected. We need to clear the flag manually otherwise we will
-- 
2.40.1

