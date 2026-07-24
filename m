Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BF31352B;
	Fri, 24 Jul 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895800; cv=none; b=qaK7X4G9v/+WifYiBIhMyY0br57vhQHQqx3iPxqfxaW1O/EbAjMi6B3Hltm6g/5IA49Ei0a7wWn4rxmwgSP49I34InPj+GPQtSpvJMGoblcNVHzY3LpK6XwUeFzFMz5jTV88DTlewbLNh63b2F8vAJqG4YHiXSZcY0KYUoCyQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895800; c=relaxed/simple;
	bh=mIgw4ny6VESI5tQDeLCA3LmmiuWJznZqNOwdOwgvr+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dWRoj8XJLYp6pSBOJf0+bvKbOisOFqQ1SG2iyfwH4BMnokT1yQcfqT003ABTuE08FEuYhQ3nDSapytWKx5fKmJiJhOalBQbQ7EKt5pHLLHSpXZditOpuQhPUgobLa81l0mMk096aqkLcW/cmlXHYBRAxV0UHsPQedtbIhmYGgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NAvrzOL0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NAvrzOL0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCCpQl4100813;
	Fri, 24 Jul 2026 12:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=KvCrI8OH/acybDMGqcsVQcqrsUgP
	4yoXURW7n/cEC/w=; b=NAvrzOL0EwTS86Y8nKMPlyRwFgTX4rKAiG96Nr82d+FZ
	MuHUF1qoUYERFvNfMJOrh3OviAu5Q7XaYt1eMwcVGV+it4UOTgp+V//0IWOw7Uv+
	eWX0aN1MFsc+mxwNXy/ubPVqgx/3PuN/FJSGLiHtxZIm9I07bMBdBC4/Jy6OT/r5
	NMEtFVHJHTHTkJgY4Rp2JTMJUH+rxMBEcS2i9L7gp1BHqyEoHe3CdgZRbl5qqbPv
	RkqmSNZd77G15h2WYSMJf6/O6TaFRFB07woREUZrkVVfTv+KCq0Th3jfRNppmDDw
	F30vepucslXGVwDcCTgegujoF/UPRZD03QDpiAvoSA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77avkm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:23:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OCJjl2017766;
	Fri, 24 Jul 2026 12:23:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wgwxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:23:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OCNFEH58523994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 12:23:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 840DF5805C;
	Fri, 24 Jul 2026 12:23:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4935158064;
	Fri, 24 Jul 2026 12:23:12 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 12:23:12 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Fri, 24 Jul 2026 14:23:01 +0200
Subject: [PATCH] s390/sclp: Allow SCLP Action Qualifiers for Spyre card
 status reporting
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBNKw6yrRIjUVANS5kA/RHdPW
 n6L9x5gjIQMbfZAxIOYtjWhzDMYFrfOKGhMBllIXdRSCh58sM777bRuZ8vhjiiUMsZo3VSu1pD
 SEHGi6992/ft+wbY7QmYAAAA=
X-Change-ID: 20260722-sclp_allow_aqs_spyre-338886694a76
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=mIgw4ny6VESI5tQDeLCA3LmmiuWJznZqNOwdOwgvr+8=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLKSI/W/LF6b9lGJbd+1shsvjqjevrh/hn7M0xkfv0+ek
 lX4SkpGvaOUhUGMi0FWTJFlUZez37qCKaZ7gvo7YOawMoEMYeDiFICJiHoy/K/LO/s3awJzhkXb
 cvlDId1iqRn/mbkVIl9Zl0zfWM7OGsPwPyRyTzsD45tOr8w+tr5jE+Ry5vkw9Ens4f7wTX5/9LF
 bTAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uK-NK5M-wxu28BsYogmXlMmbuvCiRsuW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExMSBTYWx0ZWRfX6FU1ny4LMrRX
 PmHjxCyKdal5O66J09qEuueIwFKxJWrH/Z4b7nW+10+ddwumQZdYvfH5UEXmJa9sG+4QaNNowdc
 WldUntaAPs8Bo5QlL0mpFZ4GGvdyaOY=
X-Proofpoint-GUID: uK-NK5M-wxu28BsYogmXlMmbuvCiRsuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExMSBTYWx0ZWRfX4Quj18r19sgf
 JXWLLyMj5PFPtKC4AXEMmU413LWnCteq5hxW0MRlay7gnq679WWSiD+YRjwPk9V8ljfIiy3v8jt
 afqrhXU61HPmImgsBV0q+x38qOttr0FVK+pyc0XzhmdXvnaIq3uod1QO9rrOCRGxjazQ2i/13Dp
 e7Twpn2BZQgBbszI9oUaDQd5Y4VBEu8MYJ4D38yhcWBUPO7XkYseI7esfh2jLytL16Jtv7+5Bcq
 eyEpk6RYFyhg9xA+lGNth908vL0/sffGEojP9Wb3EcjmO0lhfMTj9gda4O2JWRn+4v2/XqJFFHz
 jVQo5pHmZPvy9saonUuBC4S4r4x/mDN3Ccdsxi39XNfKOmk7EoCbK/4JYNZWgOdsIfp6YEj4qJz
 sZZuhUk22Evs836QbDTrQcWPxSGxsfdGbs3A/sW/ZFF6V8gWkY9+E6nFE02ZyhpmXgsL065k+e/
 8dDs8NX73Y0+1cNtPew==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a635936 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7DqZUioUuJSuQz5WCFYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240111

Add SCLP Action Qualifiers used by the Spyre stack for reporting of the
card's initialization status, recoverable errors, and telemetry data.

Co-developed-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/sclp.h | 3 +++
 drivers/s390/char/sclp_pci.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index f2d490558054..44066550b9b1 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -21,6 +21,9 @@
 #define SCLP_ERRNOTIFY_AQ_INFO_LOG		2
 #define SCLP_ERRNOTIFY_AQ_OPTICS_DATA		3
 #define SCLP_ERRNOTIFY_AQ_NVME_SMART_LOG	4
+#define SCLP_ERRNOTIFY_AQ_ADAPTER_INITIALIZED	5
+#define SCLP_ERRNOTIFY_AQ_RECOVERABLE_ERROR	6
+#define SCLP_ERRNOTIFY_AQ_TELEMETRY_DATA	7
 
 #ifndef __ASSEMBLER__
 #include <linux/uio.h>
diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
index d61a7fc0dd61..b79ef7006e46 100644
--- a/drivers/s390/char/sclp_pci.c
+++ b/drivers/s390/char/sclp_pci.c
@@ -99,6 +99,9 @@ static int sclp_pci_check_report(struct zpci_report_error_header *report)
 	case SCLP_ERRNOTIFY_AQ_INFO_LOG:
 	case SCLP_ERRNOTIFY_AQ_OPTICS_DATA:
 	case SCLP_ERRNOTIFY_AQ_NVME_SMART_LOG:
+	case SCLP_ERRNOTIFY_AQ_ADAPTER_INITIALIZED:
+	case SCLP_ERRNOTIFY_AQ_RECOVERABLE_ERROR:
+	case SCLP_ERRNOTIFY_AQ_TELEMETRY_DATA:
 		break;
 	default:
 		return -EINVAL;

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260722-sclp_allow_aqs_spyre-338886694a76

Best regards,
-- 
Niklas Schnelle

