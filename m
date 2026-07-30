Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF43AB5CA;
	Thu, 30 Jul 2026 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389685; cv=none; b=DGS7pXK1mRIKPPulfR5iD1yO445R4Vxl5ORAny46Wlth9AP6pUsyjyUAqk8d9K5ZALQTnBkShygmvDYXnUtpve90JZi+rBzR7PSasW7FKW+ioY4Kp1lZSIAV1YiKpy0zEMaqaOI0k90oIWQoKoUQLJ9sQTHWVztDNDQgPdWXLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389685; c=relaxed/simple;
	bh=xmiVlc/G9KIfdrQJC4ROCuezBmMa+ZhJmI109/GrorI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulFBecgbSoAjxKvdHB+qspuzWkd7SGwe92SRWwH8HO6i/9ax/S3hWB3JNukjbXgMlKP6QDXDVmoxwp5nyGrUbHnhsxgvL0Hguxi01HnuedSAvYoVzGpzENFOpF5PYyCqWz2GnJxpkimp/Lk/ZPKY8i5EwjhgMiaUSSMcrurI0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d0vPPegE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d0vPPegE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mMnF1825445;
	Thu, 30 Jul 2026 05:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xmzvxQXiu03U89fVGbz8jCxYjNwmZXD7hWyUAP4dR
	Ek=; b=d0vPPegE7/P+WgA9IFvGUgclC4PWPmF7SP68XuqoTFNcD3jgHHlo4C+bC
	RbzzuxiywScuuMMMYSebk/YlwUD+NoHnL5tmW832fdnMzzY50il3ILYZdtpVXQdP
	X0Y6WWR6gg6tm23BhSrk35R0DOZ8OW6ylRU6kccZNEKhnCvryjKSbWsxIlYL9gER
	TkdahrGOBQINQcxyYA+YTf6k+f4+ASEf/MCHVYBQvCiReHyhYOTe3WrpfxFFMJqr
	AXgqIXESDXbxth1guCUImChJPDoaAV7+KhYwXx9l7Kso8U50DCzI+VaqdZYlsJvO
	3l3Mkj7xEeE8N0l0Nu2XoEp82pTtQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjdahu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:34:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5QFQ1010506;
	Thu, 30 Jul 2026 05:34:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqj3m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:34:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5YcDP28705256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:34:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9172004B;
	Thu, 30 Jul 2026 05:34:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE80520040;
	Thu, 30 Jul 2026 05:34:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:34:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update s390 specific vfio sections
Date: Thu, 30 Jul 2026 07:34:37 +0200
Message-ID: <20260730053437.3288650-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX302rektQwM1h
 IVH58+j8cfTdy2eFaxWFtra8CqSKVJ1UAdPS5w55BNit4o/DNDGUCeISylGnytk8i+s44IgLDBd
 Cpuk7gm9IBBdm2oetpiAhwjK8T/i6Wc=
X-Proofpoint-GUID: DoZwnXnm3xI8cvMANe15_HtgkSd8voIt
X-Proofpoint-ORIG-GUID: DoZwnXnm3xI8cvMANe15_HtgkSd8voIt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX4V1eBPFDReFH
 p9IATRO3UXru6wBugYS0DW4oouQT9QB2FVX4Dz4SFqcLwYl5wt1o+Ii036wOWewY0c2BcA4jWDR
 YvB4rMirGyCl3OPuEW/in1W464NXOl24jZntbjDFdy6Vvyltnub9lywlF1m5c/5mcZowi8YLyfq
 g0sS/rQgs9PKxiYv4V+Bmat5Sn+a8uIk4i5DdRHbtysDM2aG9lLWBOt3gTmyrMdVS5CNKKbuk/I
 P1zYuPgxn7bTL9/hueLFaGkJS3bDQinLKCdJ4CRf4kAkDOCzRq1dPCuGdG6guvirjJHooPs4RY+
 Sewk/3S9nlgU0VfClJ8ueFA0T7T3Y2421OH5UtZDAvN+OQXEG60SrL3M0TE/V6dm7fAfap4JBjO
 rp25UEOS2BUvvqNlD8tNWfsqawc33Z+ztwjEJz7AVObOCqdXHAPXNN8IgGKmbZ6kiE8AgGvxuLv
 7gTz+4OQFBiX7fXiRKg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6ae272 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HXouF8ib0_UHXk9rWhcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300033

Update all three s390 vfio sections to clarify that s390 specific
vfio code normally will go upstream via the kvms390 git tree.
Add a corresponding T entry to reflect that.

For consistency with the other s390 specfic vfio sections rename
"VFIO AP" to "VFIO-AP" and add an L entry for the kvm mailing list.

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 716acfc3d7c1..b95bebe8a78a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23890,12 +23890,14 @@ S:	Supported
 F:	drivers/s390/block/scm*
 F:	drivers/s390/cio/scm.c
 
-S390 VFIO AP DRIVER
+S390 VFIO-AP DRIVER
 M:	Tony Krowiak <akrowiak@linux.ibm.com>
 M:	Halil Pasic <pasic@linux.ibm.com>
 M:	Jason Herne <jjherne@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
+L:	kvm@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 F:	Documentation/arch/s390/vfio-ap*
 F:	drivers/s390/crypto/vfio_ap*
 
@@ -23906,6 +23908,7 @@ R:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 F:	Documentation/arch/s390/vfio-ccw.rst
 F:	drivers/s390/cio/vfio_ccw*
 F:	include/uapi/linux/vfio_ccw.h
@@ -23917,6 +23920,7 @@ R:	Eric Farman <farman@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 F:	arch/s390/kvm/pci*
 F:	drivers/vfio/pci/vfio_pci_zdev.c
 F:	include/uapi/linux/vfio_zdev.h
-- 
2.53.0

