Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46024163AA7;
	Sun, 16 Jun 2024 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718511828; cv=none; b=po6b7Vz3okBQbDShnRflXZlp5oVSG8BGfs/HQJhWJuJfpcvAE/CAiDHHBou8n+e42ExN1yKeoyXcrye/M2wUSAV+sfAKa58fWFdmWf8PPdowvIuHAeOhkegkgQehkYC3K0RENGU6LWM81btBMfCsuQmXiGoGfB1QcQLlLYbJ7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718511828; c=relaxed/simple;
	bh=fOLMzkhEKqcyKN7i65MBbrXNQyAbX2KUrdE2+XSBd6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=CBvscsepnImshwFyAAK1TLod4Re0iZWcsYp+lEQvzXlwULQIPmJhsDT9BajgafUugid2/VkrZokybnQchCgDiVSacveRs+uxlUlktbx1GmYIB4Zv8xK/DMhGsxSbNhMYukeiJdUL6hZpmY7JLQhiJ4FcguJev5FFxGsxDBrXDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q9+AaY/l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q9+AaY/l"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G41eIN007829;
	Sun, 16 Jun 2024 04:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qLREtZY5XBtH/YpR8lSO7h
	QPgs4y5KgGGD5cub2iock=; b=Q9+AaY/l8YtLGqusUk8kls07lIzG3dS5aymo74
	rb1SiXGrcRh5W79CqB+0RQaVmd1CGRVIV+twg6WeDOsYLhyi+ffZfPSlfT6XuS5k
	bah2gRXJEv7GCCtDWDUBRCrEppp+zNSbb9/ld9AmQoiFxFEy5eUlaWTJhLlSa4yC
	W4zBoxCclC+oFUOIG8u4fTB7h+7hVomRbdT/MglZustOiQLhAbsCp3RIzw0UVGi6
	+elrORXoYd5Tovk2beU4R6ic7aAaWnPuJwSLliJVuLNiAwX2P+5gsCTzVEmx+z0t
	tBp5Nv0u7u4Af1iwAXkEGIHGnz2C89XBtXk0VU2V5At1EGbw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf1bp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 04:23:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G4Nhe4005618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 04:23:43 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 21:23:42 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 21:23:40 -0700
Subject: [PATCH] s390/lcs: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-s390-drivers-s390-net-v1-1-968cb735f70d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMtobmYC/yXMQQ6CQAxA0auQrm3SQUTwKsbFwBRpItW0SEgId
 3fU5Vv8v4GzCTtcig2MF3F5akY4FNCPUe+MkrKhpLKiOpxwSujHljCZLGz+h/KM5ya2VDdDIKo
 g5y/jQdbf+nrL7qIzdha1H7/Dh+h7xSn6zAb7/gGvE8r8iQAAAA==
To: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler
	<twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZMPyqHGiMIGT40wC6ouxkUgzPvQ-RPhO
X-Proofpoint-ORIG-GUID: ZMPyqHGiMIGT40wC6ouxkUgzPvQ-RPhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_03,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxlogscore=972 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406160031

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/net/lcs.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/s390/net/lcs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 25d4e6376591..83807ce823e9 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -2380,5 +2380,6 @@ module_init(lcs_init_module);
 module_exit(lcs_cleanup_module);
 
 MODULE_AUTHOR("Frank Pavlic <fpavlic@de.ibm.com>");
+MODULE_DESCRIPTION("S/390 Lan Channel Station Network Driver");
 MODULE_LICENSE("GPL");
 

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-drivers-s390-net-78a9068f1004

