Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C01386C3B;
	Mon, 23 Mar 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258385; cv=none; b=BtRIm7dxtn92Uj/ptSduaV1eCLkUwVq+7lCeysMkVsgC0qHGH1dy+6fRi3z1iR17K9cZxWKwcMPY22F998pkcJuLmyH7WPJbYnGAlqWiiVj1bveNSV4zoafCRPO5PmFXIj79Mop9embOemKAdtgsKFRELY8pyFduBbW6C/KeKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258385; c=relaxed/simple;
	bh=tVXzc3TZ4XXEho6yf6ZcstI8WffvhcP9cbTZPPwmM0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFMzyIQtIC3yos62TN2149Ft80PybIDBXbzX8rkM/F85woVpecFYjNvI1jwsIz4X78hgVAA99tB9bZ35eniY3omqlOqCui/t324ur9owGuadeWTO3bH1OoE56ERXH5fZcBN9XCBIblPeNA8DQu+D9jxOIXlQ7up70owcWrEDAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IfJg+hAp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IfJg+hAp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNPEJ7666646;
	Mon, 23 Mar 2026 09:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=768lj2
	UP4Q5lJI10ZC9GKEZTGjBOEkuSn54mj3bw9aA=; b=IfJg+hAp2OQeoOaSPH2yog
	Twp6Eza6KcArv98HlPmetI+9a1kN/vCCJYHx1L3fe/YfvJCYTzqB0Lf2F6Q0iuBY
	U2EMSRqAjvohN0r7O7zor4ndk0cp4JFi7PV0AXSglCbA3TVyrD9u02O6LIjxmzXa
	IlKClBSgdRaLsKSij2Tlv9nI6w0Mzcd8hAOGyGtGROovc9/BbpN2B0RP2ADKYPUb
	jGLxVRFCX0fgtUUT2P6GsPMqCwqKL9y87mIIs5RUtciIWitswZxX453GrxUSc+DF
	4DsT/z2+a8B0OdLC7MvJqxhdV0hH6kfzAwkg8CFRTfj2T8DALj/1DgFKK6hCpfUg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxp6jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:33:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8bfcZ004392;
	Mon, 23 Mar 2026 09:32:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1vheb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:32:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9WtIY53477886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:32:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D142004D;
	Mon, 23 Mar 2026 09:32:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98A812004B;
	Mon, 23 Mar 2026 09:32:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:32:54 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Mon, 23 Mar 2026 10:32:47 +0100
Subject: [PATCH v7 3/3] MAINTAINERS: add VFIO ISM PCI DRIVER section
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-vfio_pci_ism-v7-3-abf537150408@linux.ibm.com>
References: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
In-Reply-To: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c108cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=jBZh5NATpTL4zB9YInYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3MSBTYWx0ZWRfXyGgBYiIEaQTO
 MDkF8doeMUSTArbSE3ocFghQWU4nQc4PYxTlrCAkGjeRhP1OjH8GnzsLoEMSv8PJ+RtKIh3YTNZ
 ByHzmTSLpAPN1vnbNdkQT1VqcM8Y+LEM7hUOvCWhUhAAHOjsmfiMVZjm1rSK1UKtYfuUu+GSAQV
 WpoRetB7qtra6wmOs5iKaUGZxj/PftQLjGIdi63lU/+HR43PMjzZJ264xiSo7LOScIZPsnCWUVr
 ssXxCMHkffI2sJyVl7M4rhwaarCrEIgBuuFCVE4sWWG28X1MNGXA56OrTJ4fi4NpJEo7+v02aPi
 hR5M/WmQd2HAMHsqON72qXsBxZa8XBnK8ZQd4RaWuVN9btX5fHEJDs0DXt95isdr4xWSg/wInfV
 MBgXduafLALH2qPclitCKmgFKnrECpCNbLXLJ4hBGuR4wD6rFp/yODaPx9mgI6z/Rl5f2bjHv3o
 MW9+HhMa6/Cv6rk2+EQ==
X-Proofpoint-GUID: DwnaN1iHTM5ftuciKLxbK_LGs8P4zSsu
X-Proofpoint-ORIG-GUID: DwnaN1iHTM5ftuciKLxbK_LGs8P4zSsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230071

ism_vfio_pci is a new kernel component that allows
to use the ISM device from userspace. Add myself
as a maintainer.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62b77515aa1a1fee1c7d3e594869fa..4784a2514c0e057fded12364c680c928bde5876c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27704,6 +27704,12 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/hisilicon/
 
+VFIO ISM PCI DRIVER
+M:	Julian Ruess <julianr@linux.ibm.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	drivers/vfio/pci/ism/
+
 VFIO MEDIATED DEVICE DRIVERS
 M:	Kirti Wankhede <kwankhede@nvidia.com>
 L:	kvm@vger.kernel.org

-- 
2.51.0

