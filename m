Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60812B93;
	Wed, 13 Aug 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083807; cv=none; b=ULKQ2SNbqpRtLRniwKGCcZ6Nu8Dkt3EeTdJcXsYGnFUT334ACM6ova9xBsrX4kDB7/nyetUEq+QZMTzF4oKP2ONIIRyTJwUXDxbGiLmjnIf3+RebYdSfSGyAy+oUqsMfgicfFo9xRnF4zi1U3wb1UFkJJo9xzGhV4SpkX8uGxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083807; c=relaxed/simple;
	bh=110FpfBIwTsQ5L/Y0WLWnUkzAzWn/HY/bh17xUk/uFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfcT5Rdx6NrHMC4etHCL1iRUqYhJkP/2fO6+V6yXfhYubzfSRUA4jn60UfmaWegs+YzN8shRaeaK5tbEG0Feuo1W5jY7mG8Y8y5NRlNgz6uMzIiF5/ZT8EM+ZUpw4F4UhuMPoM3Ef/Yva9C0mgoUnLwaH58vn22jIzIh231ig4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HlhmmyAE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HlhmmyAE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQK7a029936;
	Wed, 13 Aug 2025 11:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ExjGljI8lS0e+F1e0JhOF/zhAVPV7s4/oKfS171Uj
	1M=; b=HlhmmyAEtgH9muYullwGiPij4+FM+A0nVpVgGH6ycZkP8AGIfkFCsvYEm
	d/eZrVi5xXbwuACOOtF/I+/WTt5xhqiXCtpPhpPUVswm5uGG4TAKsbpNnneAtkRf
	j4eYK4fluwDi71XNzXsE575R66mFg7kIoIOMVeiCO+qVxhYZ8Lky1mZkUmRqA5h5
	fUzredX620R63HArTX0cxxoFkkkbuep86VWYhqsE4kOLClCfpvfrlSkzuGYundUz
	eCKqG6QM/jsmgASd9opj4KqVjNIJbr+lw0cit6kWUooBd26QP3bkaVHtbuuYM1IT
	dtMd95uFIUWml2/EXKO3wBftBs/rQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudc428-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 11:16:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57DBA0cf029510;
	Wed, 13 Aug 2025 11:16:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudc425-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 11:16:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D7l2WG028658;
	Wed, 13 Aug 2025 11:16:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n6w73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 11:16:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DBGXW953346726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 11:16:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A40B2004B;
	Wed, 13 Aug 2025 11:16:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899C320040;
	Wed, 13 Aug 2025 11:16:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Aug 2025 11:16:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 5D21CE1267; Wed, 13 Aug 2025 13:16:33 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Aswin Karuvally <aswin@linux.ibm.com>
Subject: [PATCH net-next] MAINTAINERS: update s390/net
Date: Wed, 13 Aug 2025 13:16:33 +0200
Message-ID: <20250813111633.241111-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX76iiPHqjkk28
 47EKFAXXUoi8DmUnD9BbZ4cVjBgpuLD9Bg8KmP3oRmHPR7/TjYoobzoCTeaJbrdSQaf1ucoXKAt
 WjH9rTZ9SjCtJDujEfhGHtLfElVbpv0CvzG2cf+WPTzPyudw2266LhfTg4htcWwXhMJ0Z45NEJ2
 wgN07832ISLS0xOXGVIDIF5R2j5NKdjw0Onb8r5U9S3A4wogx+nOLci2hE7gLk3jyC9Qp2Af1XX
 tABodu33xcV+YQmdehuAQBBsFdZ9xpFdsv8saDUG4qMWjjIONjRJLcT816odbpoLVNPNNV96+nh
 /fOYWpROco1+DbVT+95a+JJ5Z8Mtoej8te4pv8IbvliMRhO0tG5Co+vBHZLhJD4BPfNIDs7vdZJ
 m/9IQBnI
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689c7417 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=kMCnDhkBFyQEV54F0A0A:9
X-Proofpoint-GUID: 5uWZkWZZkKnAKjz40ttzUc0pWkzJahIy
X-Proofpoint-ORIG-GUID: 0sU_bio1Bx8uOD5I8DLdxyMgQ7KDz7iZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Remove Thorsten Winkler as maintainer and add Aswin Karuvally as reviewer.

Thank you Thorsten for your support, welcome Aswin!

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Thorsten Winkler <twinkler@linux.ibm.com>
Acked-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd62ad58a47f..cb65a686faf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22168,7 +22168,7 @@ F:	arch/s390/mm
 
 S390 NETWORK DRIVERS
 M:	Alexandra Winter <wintera@linux.ibm.com>
-M:	Thorsten Winkler <twinkler@linux.ibm.com>
+R:	Aswin Karuvally <aswin@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.48.1

