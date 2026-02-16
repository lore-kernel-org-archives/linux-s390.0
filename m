Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22C2744F
	for <linux-s390@vger.kernel.org>; Mon, 16 Feb 2026 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771223369; cv=none; b=PNqWy2xe1Pp48wzyM5/OHxjTyB8EjmEQDjJaHYUSFiFlmE2uXr3hVqwKNtpekkAH1KtAJ0JwydDfoX+fRZ8+LCgyEnw5+zrv4fRcQfKMydhqYJCOctsnRILzU64XFiNQvssltu1vT8z5hHA/+xXcQIo9hsVzuh1u/6asaPf3aiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771223369; c=relaxed/simple;
	bh=zQHZUG+5Q1s04Lp786znYjaEL+UnuGeLxVFCY7iEpcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lea89tXOv056KH7rMOvmlg7I2Tqb/RpAebeBSwi5EQj+n0Q4Uyq/DWzsGPmRAIcJaqB7OLA9/di9vBT2c0Gkcpm3dhoygzh5XiIrubfOIyWugBEq+/A79Tvte+7jDaGPyLSxqx3zKcCJtFh0GQJHg6TRGr8UbEcsZUG5X+y5550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CwkCukL6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwkCukL6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FLeRP53631665;
	Mon, 16 Feb 2026 06:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sLdy+1+jDG8t7qH8K8wqnya/kQPdeXMTNShmHEWAG
	RE=; b=CwkCukL6b4+W33UhhTDVCDII5QuxJfupxjK0NvBlfbYCRJBLZy+NL/wYe
	pxSvWRSb9/IYcJxxtBTIgSCq9yC6qyjAHpnzHiFZjCm5Cj0j2y69IsMneOvXPDjI
	xOtGGJmpCWcAJmrTz3gLjb3eSUka5WqcI2yD9IUTlhNb32fSjHrdT7yEHbC92Xki
	QWPALnk6JPC8rLS2U1Dvde1LygisC19FLEGMBvD0yc+WZpZb8v8JoxUgxGN6XpjI
	mvwzXQD2dzMLQAX7QrwHBiY5wElByOfVruywsOkUCZdBmL+cBzH75ipOHUsLt6zb
	OuMV371vLfrSLm1nog6V9yey9ksAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj60qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:29:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G3P2tS029073;
	Mon, 16 Feb 2026 06:29:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb63140tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:29:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G6THAL31260978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 06:29:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4F5720043;
	Mon, 16 Feb 2026 06:29:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3CD520040;
	Mon, 16 Feb 2026 06:29:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 06:29:16 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: akpm@linux-foundation.org, bhe@redhat.com, gor@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n
Date: Mon, 16 Feb 2026 07:29:16 +0100
Message-ID: <20260216062916.818071-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rqyoeAl6rPuKv2bmwXPx0AsqhJcm9Qme
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6992b941 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=xCAFoSNEsD0Fk5WBT_MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA1MCBTYWx0ZWRfX7Wel10NfqARt
 9SdTaNdwbeeqhFyX4ePgfLq/QVcBZDexeJnzQamyvJ7vhZMeCtsh37qVjkQdrE8VNDDORKH0tU7
 QtSGhBGiSpKgg+OLC7njNRThCysoZqrfyW8ltHHPxoNUh3y1dprQeVdW5v00n4i3cDYBkU19Go2
 um0xlPYpUZ4CQFTxj20OSbmvb38F3BUuNo8T7g/8/EajRaU6zOG6V4LNx1DFCbNOb1ctD5inHXc
 NJcEcosiJgYknbAo/38MIE0xXOnR4m5IWiXzxNAXt1U1bBPm42qcGTvER5M06G1FiS3Q1iDXU0G
 CJiduBIS5fv0x4Qijt9TRJ3VTa5Iicx1HzCe0LHm5EyVLGN6RrxAtRFOQkLVujs4/GyPNcEr/ga
 3Kghp9ZkaADravFqpUlyJ2YmVrR+wWPoYIqNc1VOsVMqeUtvOXZpKL2IstgxDseWI2fx6BcZxS5
 V96ZEz6Vw6pQ7zQ1OkA==
X-Proofpoint-GUID: rqyoeAl6rPuKv2bmwXPx0AsqhJcm9Qme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160050

The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
in s390 kernels built with MODULES=n if nothing else selects
MODULE_SIG_FORMAT.

Furthermore, the signature verification in s390 kexec does not require
MODULE_SIG_FORMAT because it requires only the struct module_signature and,
therefore, does not depend on code in kernel/module_signature.c.

But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
is also incorrect because it makes KEXEC_SIG available on s390 only
if some other arbitrary option (for instance a file system or device driver)
selects it directly or indirectly.

To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
as well as MODULES=n _and_ also not depend on arbitrary options selecting
SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.

Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---

Changes v1 -> v2:
- Let S390 config option select SYSTEM_DATA_VERIFICATION if KEXEC_SIG is selected

 arch/s390/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c2c7bf974397..edc927d9e85a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -279,6 +279,7 @@ config S390
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
+	select SYSTEM_DATA_VERIFICATION if KEXEC_SIG
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
@@ -313,7 +314,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool MODULE_SIG_FORMAT
+	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
 	def_bool y
-- 
2.51.0

