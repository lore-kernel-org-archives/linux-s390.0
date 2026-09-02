Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EDB4A2A78;
	Wed,  2 Sep 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359695; cv=none; b=EkC6ly5bhHVBQyTvxGgA5SPyaA7fE0lTzz7Cwl5ursQeF676Iu8bjphJtk/AugE/s3PysHN4bp2Z+9ORvyS2bfcLRRKZPJtlZ7krbh4PEQ8+7b1znpTVuotcCE8RM74/BDvIJxvjwqC1F2nyHEdaYqIKa7N/1goIfjGfw+LLDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359695; c=relaxed/simple;
	bh=o+SBfyhIwjQVP7iaWx/Mh8m7g20JpJq/u+lkF+fPIQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkwwvhfQVauBAVrYTdoNyS8uN1h+KprXITK5BsgOtuxTlrKdUocLy31u4xU2x0byMVK1NxGzxH3xUxLhK876oHawhvbV6OqsVZRlgp7cQ/QpOaAxs1KcxJ1L6FCI4Q7Jp9RChc1lMEkOWuUv0OSyq0HjDhVNVcYIZDr8VLobmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d3vycU0M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d3vycU0M"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CW0Vu047466;
	Wed, 2 Sep 2026 14:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yS4SGS35PmzrxXgaCOTALVjrqK0P+puvAUOhif4K6
	n0=; b=d3vycU0MthLbWuYeteCtd22xuyokye9MW+YY3lrDvSjs2Yo6fiyuMIz0Z
	dwbKRM5IftlRcrks9pQendxFl7Y/EzVC9J10YtqSe58Ki7d+fXTo1Fb48VMChXKv
	58OqpmlV7o9/jm2D82Os2fQ67aP1k4hmdxQziuw7twAeTKuONlGpMngRtL7nQvvV
	/JWr+cY/LObZNMBlBpXtGdO5mk2oH0iEbMlY0T6lI8D5Y8uPvCFy9Zyi+ifQcvjo
	9ENlIBm15FzfU/Sb9Jn8CspnCpGWmv6ug9kRaFWzBO4pdz/k8BUj4EmbcjItCIzN
	1qT9j97b47t25yOG/BFdz+McXblMQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2terg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:34:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EQFUV030336;
	Wed, 2 Sep 2026 14:34:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqjgtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:34:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682EYdvl41484656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 14:34:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 149292006A;
	Wed,  2 Sep 2026 14:34:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D495C20043;
	Wed,  2 Sep 2026 14:34:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  2 Sep 2026 14:34:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B9E5D160CDB; Wed, 02 Sep 2026 16:34:38 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] dibs: Unregister dibs_class after error
Date: Wed,  2 Sep 2026 16:34:38 +0200
Message-ID: <20260902143438.426664-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a983404 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-X7FXM7bNh0ew3z3AVgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX2nmU3DzSq0rY
 Qs3kXU8fnSr4t34KcEVvxvXMXf0WG+TYMT9N4XB4xVmfSl42vs2SjFD8kB+PrbGAvQECY22xlm8
 jmjYGFZr4DSPt+sp3z9sB2iJBpayc50=
X-Proofpoint-ORIG-GUID: czJ5sV-9pbq6LSKjB_qjbA7yFHFlXRez
X-Proofpoint-GUID: Y_jUNTUsiB0K-SiWfL-mSDhHUhadfRMf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX6Q4ZnxYK1gLo
 hqv/ZpqQQvhu3kX9kt5rJcKDfcJWycmyUovgdBIHAGE9bLg2qekVznLXZWOTf5bgqMexPCCNoRT
 bSWQrE8n12abrZ4zPB0t0YRwFVQsPBO84Cg8Gr2on+IkXmtOVZDqm6XBiLnF8Dmu2V5xcaLzr8h
 paL0MKm0pGUOgH4JhmmAKZ29fp4qCxE7F4YVcX3I1UIF8weoRB+JEdQw9DAeutNP13ksMs8vk4H
 VnYzrCUmghOzqm0XjZM+bhqpuwFjGdC836GujtqtGPgY2KkGtbUUVqqjLeTmxJSBBZmZ2Yow0do
 xRl6b3uf+sok6GENVrp5dQb1d6FTQxdDtQKQiOD/WDfPlqPHfOaQILA5FA09CoPTsk45lt6DxzR
 Kif0aAi625GbtcKAN+J5m7TXBigoza+36SQLagqRehq0nqNG9TfAu2b8LUYCEitgcSHdEGeqlzI
 J8ovtE1v85RK3VTXOow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020128

In case dibs_loopback_init() fails, e.g. because of -ENOMEM, dibs_init()
must unregister dibs_class. Otherwise dibs_class and /sys/class/dibs exis=
t
even though the functionality is not available. A retry to load the modul=
e
fails with -EEXIST.

Unregister dibs_class in the error path of dibs_init.

Note that before
commit ad3dfa80be76 ("dibs: change dibs_class to a const struct")
class_destroy(dibs_class) is required instead of
class_unregister(&dibs_class).

Fixes: 804737349813 ("dibs: Create class dibs")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 2b53a9d277dc..20c50997a7cf 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -251,13 +251,19 @@ static int __init dibs_init(void)
=20
 	rc =3D class_register(&dibs_class);
 	if (rc)
-		return rc;
+		goto err;
=20
 	rc =3D dibs_loopback_init();
 	if (rc)
-		pr_err("%s fails with %d\n", __func__, rc);
+		goto err_unregister;
=20
 	return rc;
+
+err_unregister:
+	class_unregister(&dibs_class);
+err:
+	pr_err("%s fails with %d\n", __func__, rc);
+	return rc;
 }
=20
 static void __exit dibs_exit(void)
--=20
2.53.0

