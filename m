Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402123D297;
	Wed, 25 Mar 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445512; cv=none; b=eOOLyVWweLwl/fIoMONnVu0CFbqSiHZMnWmciGh9wvXl49d5EEu/In1knPe9sBYQlyBtGrBYeHmlrAtQEtqjsqsoMM966y8PPcohMFe8sIxh6hOQMTAqFQDGySaeJ1yxGlZkm+aAKeHzYoKPvBv6CmzwRM2cyUnhBK6Cuptf4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445512; c=relaxed/simple;
	bh=tVXzc3TZ4XXEho6yf6ZcstI8WffvhcP9cbTZPPwmM0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2ADjX8aVcJd/fMwqgrq8s585zfwCNUJvTtNXETD6cUZrC2Ejs+ZvFWKA4QvLVpAQWl+jV5Q8XLPlsr986oQH0PzlcPw1ZjdZ9dTL4QgA7PqUHuYAdN8tkSrAGofvnqB9bLRVpzU06KsbWq2H0O11+u8hP8YRRN1Ye2pNkVp82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XQvz8qns; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XQvz8qns"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P0lWIn2808047;
	Wed, 25 Mar 2026 13:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=768lj2
	UP4Q5lJI10ZC9GKEZTGjBOEkuSn54mj3bw9aA=; b=XQvz8qnsMXCQ4vIvy6LrOF
	lV/1zo3o+APKuSCUwYNNdFlkTkvx3nBl/oQG7ywT42R2IMAxho7GSmlb50GnN4hy
	WBPGXPL1NqrOht2eM+2PRaNFsJHm50iz/4dA8CO26M59miAekrZ9uJOtMsAVd4ri
	p6jULJA0nvAtxeJjZPsVsFtH4aR+uq9kKft05KNnQLLbPf28Lj/dNlA+iU9EiYYJ
	6uOt1zNkmcB2GtoQauu2v77g1NOMd50YpMs9opji2ZUtDUfxKSx5U6+F2THIBBq2
	pPDnIrCQ6TMUyO4+ecDZ7qxu3ubI9Od3yH+9lC5/3p0GGLS4xi4+XuUyJ7+Zo60g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky07r77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:31:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PA5Ct4031598;
	Wed, 25 Mar 2026 13:31:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsxtr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:31:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PDVgjf51904896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 13:31:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CCC32005A;
	Wed, 25 Mar 2026 13:31:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11F7B2004F;
	Wed, 25 Mar 2026 13:31:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 13:31:42 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Date: Wed, 25 Mar 2026 14:31:25 +0100
Subject: [PATCH v8 3/3] MAINTAINERS: add VFIO ISM PCI DRIVER section
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-vfio_pci_ism-v8-3-ddc504cde914@linux.ibm.com>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
In-Reply-To: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5NSBTYWx0ZWRfX4ONqm67yLW0U
 NDIW/dPVD6FLes+nox9xwGIO3XhkCGKTicLL5mCp+gR0m4bJH8HEOyzDc0i6JlwvBdH7sIJ2n3T
 gp5RErYb8+Cf1QdmAkSsg48KCuzQxBzVJ0Zza/LzgMaVTEmkicBDfaxvUxVLibbn/rxoj7NS0Tk
 uiJaAbOPsFJ/DzxYaZzppVnOnCzG+pW80JosQbOAICcmKKXmJQJmnaWrfFbK2U5DcSaOAG1ze8f
 cDIcrFt7yLcmtflOQDXhLCFyYJSj/bbWqGm+vHpqo7m1A9nfu+y6yGUqb7pCVAYSZEDIpd3/h5B
 jlJZzLoej/73N0xcok7WlUNmuzFsKYPa7BEo1DUdTWhMxvmPHgJ+oHHVINPbigEm2mN58ei3wI2
 4WogUBycNU8hcLJ6vMetgZsdfoDhxTIQWvzx3JmNORUDjKn0DpTUttzBsRUJr47+Z271XTSUxFn
 ZlQj4QPQKxo3GWYfYCw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3e3c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=jBZh5NATpTL4zB9YInYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 14imqRo-gxUuki3BF-AriP5GTNrFmurV
X-Proofpoint-GUID: 14imqRo-gxUuki3BF-AriP5GTNrFmurV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250095

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

