Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632591;
	b=mvLaf4WKs/YrRiqmQvX4qXT4XUZYsfo/5m47/COzNIqcv8jXxMTYfwGvJrP3FTCSjWIC
	 fk3OxsYFyGburucvHmAADmyusuCP3CiMb+eEbwISy3d6g6rMls4fkZhfhAA3N59idOnnA
	 D913adUBbV4yFFIZZk0S2VmYBpDX+9Prqn/6tjXFJ0Hkq+tCfDQhSQYkT+OCrgwofI6Bi
	 R/cBml96eDyfJ+fCpq/ayIh0yFuAhrkI1hBtWh2o3xoHuXMHrr9MHd58Uy+u4ZB2eATQ9
	 V/yKr6dMauphN/n9ugll9g1rcvPuC3JNSxIPU6xJlPXc4ZBlpH3fL0FvKvXVrPkc/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632591;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qg4VdgFKzBFMkL6A+koKUiGfjurci+RSLcEK9fmi54k=;
	b=V8DIm6QXp5lpqU+vyU4Dee+ZEW0/DtmGknBznTzoGSxAilRnqw2KaR/hIrAr7C0bjiNo
	 aW2qS7Yhk0fJx0T09tCPEocGPygDtbTJiXH1+NAURycJUZd8dFHEYJkaFLhTyycNCIIzr
	 9dR16nkbKP9nI9yHUtnDU7LxXrRr/UWyKh+YhFKi2ac0sGFw26IjrktOnn6EmpMWpO4JT
	 rrNJF6jFa6dSn4naNtpx12OwQfHXF4LjloNQaYvTdmvb51uX6QC7A4BJFJQKVFZ15V6Da
	 Iq97a7De615qOo4BVxI4nO4hk0s/yLXaQWASwq1F0oUrj/xuNs2srjljYHUBYQaJwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j5GxZ5vU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2460B995A;
	Mon,  2 Nov 2026 15:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E2460B995A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j5GxZ5vU
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EELFF3334043;
	Mon, 2 Nov 2026 15:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qg4VdgFKzBFMkL6A+
	koKUiGfjurci+RSLcEK9fmi54k=; b=j5GxZ5vUpuetdgxQkW/WS4zCm8V20v+cs
	onwHR2kW9rCkIQFqV9S+hWnSAIe7leTQXXG4O1Ga6qYC9Jo3n4GTu4BIASgQJa/8
	tCOAnfupeeCpp2cmtfA91eQJoY92Q9swlhiwoDpuvjXJVG5KfWOPe4T8bUlW2Uvw
	F46vQFPqIdKnveLNlEiCRdWCduKFgid9uJV/G8gzsXjTbehLD2lw8cl6R/yCGDk1
	BukUE/wemywpzMHU4Hxwn7BlIxK0jEVgTpuPEI/ZBNezCQc56WqPZbE/j+JIdYqX
	5RC7jn7vVtpg4hrTVtBHDyhX450pXUCreA2mbk6DB3TnWsKNiyd7g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u399rs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp30m932204;
	Mon, 2 Nov 2026 15:16:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjxf5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FGOfG30016082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:16:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F3F5805D;
	Mon,  2 Nov 2026 15:16:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6349658054;
	Mon,  2 Nov 2026 15:16:23 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:23 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 13/14] s390/vfio-ap: Add 'migration' feature to sysfs 'features' attribute
Date: Mon,  2 Nov 2026 10:14:53 -0500
Message-ID: <20261102151604.2150055-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae8a94a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=mmLkksitYsIcdlCVxmsA:9
X-Proofpoint-ORIG-GUID: ZH7h80slaSnOq8LovurqK9N06Yygaucm
X-Proofpoint-GUID: ZH7h80slaSnOq8LovurqK9N06Yygaucm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX/4qXMAeDLC9u
 Rn0pVLXBVQ7qxFq58TV9nRiLGUbxbfKSZb/DwPkynrsZd04N0i0ouHCEdtbCI094DU5e1b5DAb6
 EoYDh9augjaEif/hYNDKbrtTQ7E+lkzLm4yD578e4iipfOWPN/d4PsGPev3Z9+rHMvBe0dNs3Vy
 5clDB0W+l37ux5fCNhWCMoOulr2ziakxgH9D2L03UeMcah0dn8dNsL8AyLRBoWrW2Ofz5nhc85r
 3mkdUjZYfBT0QpeM8CmUtpt+N/c7OFz90BcgOX4bcVeRySvxfz1ah1vqrdoaMQ5mO1QA66epx9o
 VRCeAPbFjzsch5ytB+EyMK4N5MN5+zIjxShWxOIRT9ouNq8lc9OvoXDnlokGIGBWan6bRWiK01k
 daizDRbdd+a+UBC52Bx2xXfFaFWgrl28UNIPzGv4FUiEz8W38vW/5+Gus5BfTR5Jhn3lZbUBH5k
 rkiGmazYzYroU6Z3bbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX4xmu13kE6Oll
 5hhYhqayGQXGuN6/oHnX0R0+tJMmwlvYBoYi6rBziQrvtRtMYB52QMljUn96WdGW3jx5jKeGFCM
 nW7Z+kSaGuAu/XePilbeiyRqdVZQcZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020060

Add the 'migration' feature to the features provided by the sysfs
/sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
of vfio devices is supported. Since live guest migration is not supported
for SE guests, the 'migration' feature will not be included when the
feature attribute is displayed.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8e69ed286bb9..c63a050a2356 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -26,9 +26,21 @@ MODULE_LICENSE("GPL v2");
 struct ap_matrix_dev *matrix_dev;
 debug_info_t *vfio_ap_dbf_info;
 
+#define VFIO_AP_BASE_FEATURES	"guest_matrix hotplug ap_config"
+#define VFIO_AP_SE_EXCLUDED_FEATURES "migration"
+
 static ssize_t features_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
+	/*
+	 * SE guests do not support live guest migration; emit only the base
+	 * feature set for them.
+	 */
+	if (ap_is_se_guest())
+		return sysfs_emit(buf, "%s\n", VFIO_AP_BASE_FEATURES);
+
+	/* Non-SE: base features plus those not available on SE guests */
+	return sysfs_emit(buf, "%s %s\n", VFIO_AP_BASE_FEATURES,
+			  VFIO_AP_SE_EXCLUDED_FEATURES);
 }
 static DEVICE_ATTR_RO(features);
 
-- 
2.53.0

