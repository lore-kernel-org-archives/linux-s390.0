Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DC442FB7;
	Tue,  4 Aug 2026 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833942; cv=none; b=blq35KxcF+O13nLvDilyOajbtSMcMlw1HKfSTwFLJfQCsKulzlLQvQ8ZEjDtuCaE+tvCKYn9awWYff41yBOKo6A4oSHrgwVC8s+ms/eXwSdv7kFW1dRPRK/k8rQt9gB6sMgCzdQruRCKEQn/FcaLPCw6pBkwUtdCDTzsk5zA2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833942; c=relaxed/simple;
	bh=Je6vKkUp/+7zRMPokN8+f1do3UhOUA0E54l3kWOWZ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NH8HUgwJDCPkqO8bLOrBdnTkNu9nUKJbBVGRl0P5rTqa0/a2DIRaxZH+025Th66/d1kJiNYaJz1W22Uf8wbr+kj3JaZeP1q2Hdj4q0y6ETZ6IQBCWAZADHCCMUe7ddAaDZ4IcXJTWq9SdBG9+14lc8Ve+jzrn+wtDKjBdrhXubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyQrhK3R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyQrhK3R"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HY3Z2640220;
	Tue, 4 Aug 2026 08:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QNg/HbvmC/rx8tp89ixJSSZjEJr5cqSrnJvxm+Bwm
	bg=; b=LyQrhK3RJcYe2+WKObZmabOe7PCKs2ZRAcLtTTvntOp8fPD0KtbTxtqHJ
	l50Sk4Ay6NhLAm1aDIctTMjXYNBM+AymLBEdvURSD4UmCrcZWOETq+EQ6/6zDCnD
	Q3wwP589Riyr6wL9AcHf8h/jFaM51tc37wYeNvPia26x/h+JvWYOOlAV8f7VW7I3
	zgfCYQJ++J1QhtXQ7oChTIW446A9yT+bZHt781jqSP4mph0AJTf5vZzbD/qmhfQ+
	9TUHcHQhqMYOBD9AQVv3z4Y3evAT7Zj3EBKx9hp1C/CKe3nI+nWOcX0MxTEZQM+f
	RpfVznj350f37VHpLxX/fZkcXGJUA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqmyk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 08:58:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6748uEup010042;
	Tue, 4 Aug 2026 08:58:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtygysv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 08:58:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6748wmoB42926338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 08:58:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF982004B;
	Tue,  4 Aug 2026 08:58:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 547CE20043;
	Tue,  4 Aug 2026 08:58:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  4 Aug 2026 08:58:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 342461628DA; Tue, 04 Aug 2026 10:58:48 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Hidayath Khan <hidayath@linux.ibm.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del()
Date: Tue,  4 Aug 2026 10:58:48 +0200
Message-ID: <20260804085848.3579518-1-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: dJ8rKf8KJihxKqjlmOwusvoi6369nmJR
X-Proofpoint-ORIG-GUID: MIXW45-rt74MP9nk1bJwGNJcYUawEiE5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA2OCBTYWx0ZWRfX1nTRh7d3gY7w
 hUUubkw3s6j/DCt3x6OHvb1H0f1cjC1GbPlANmWMO0F7q7vq6s6FKErs3HBmUnPyvKG0QnMthzs
 OcC6RwOtAUNKVJu7nDcDQF49Pk7eR2w=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71a9cd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ULihBTfnfYTdAxTj7HYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA2OCBTYWx0ZWRfX/Qfhmxe9hvmG
 hw8M+QctmLoWEl0P2ZSDztiOpt6eubtKRMdiQLPDfwpYRFp76x1U3xTREb6Mxm/cxZovzLSW0fG
 9yS5VoujBX40UfyOQsi/mF7wP49CRDAcCaRrLg8T9TRadWdpQ9HoGdENc5+yvCCMZkJyLjC7GrA
 HtTJQk0675LF+HB6kVRURtgOVIWiMVDIsQNdyjWkVcUITI7oivbOy12yspYZfZ6FHDIwEhiuLHJ
 UUmQ5xbv2KWCDoybtw7Zl4pzls+IlcGg84nac3twJbjekwXJ7GPerwjyKOdN5PCEaYZBNX0qzAl
 +w8zNNpaF2PJ2/p5E9mtGnGoy6SYl+2Sti0ITyaxipJWoE4SqtpYUDJvWKTPKrDtRrwaF5X1PtM
 QqUACrqEs86NmtugnabVeK0tjWxmQj8xSYpnt3KzuhY8LkFN8/0ZMeCRDNTypiH85wn42/HQWP4
 F+j0xuLmwa9Mc9qLz1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040068

A dibs device interrupt handler can be active after dibs_dev_del() and
may still access dmb_clientid_arr.

Free dmb_clientid_arr in dibs_dev_release() after last reference is gone.
Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
for now, because no dmbs can be registered before dibs_dev_add().

Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
Cc: stable@vger.kernel.org
Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 14c3e2d84902..f059fefb09bf 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -128,6 +128,7 @@ static void dibs_dev_release(struct device *dev)
=20
 	dibs =3D container_of(dev, struct dibs_dev, dev);
=20
+	kfree(dibs->dmb_clientid_arr);
 	kfree(dibs);
 }
=20
@@ -194,12 +195,13 @@ int dibs_dev_add(struct dibs_dev *dibs)
=20
 	ret =3D device_add(&dibs->dev);
 	if (ret)
-		goto free_client_arr;
+		return ret;
=20
 	ret =3D sysfs_create_group(&dibs->dev.kobj, &dibs_dev_attr_group);
 	if (ret) {
 		dev_err(&dibs->dev, "sysfs_create_group failed for dibs_dev\n");
-		goto err_device_del;
+		device_del(&dibs->dev);
+		return ret;
 	}
 	mutex_lock(&dibs_dev_list.mutex);
 	mutex_lock(&clients_lock);
@@ -214,13 +216,6 @@ int dibs_dev_add(struct dibs_dev *dibs)
 	mutex_unlock(&dibs_dev_list.mutex);
=20
 	return 0;
-
-err_device_del:
-	device_del(&dibs->dev);
-free_client_arr:
-	kfree(dibs->dmb_clientid_arr);
-	return ret;
-
 }
 EXPORT_SYMBOL_GPL(dibs_dev_add);
=20
@@ -247,7 +242,6 @@ void dibs_dev_del(struct dibs_dev *dibs)
 	mutex_unlock(&dibs_dev_list.mutex);
=20
 	device_del(&dibs->dev);
-	kfree(dibs->dmb_clientid_arr);
 }
 EXPORT_SYMBOL_GPL(dibs_dev_del);
=20
--=20
2.53.0

