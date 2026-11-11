Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414522;
	b=2zD/C4owbn7aZSU772ibFLrPVOXcLnIQwHz+NcWevlE9CkPsbNw9nHKxQZ0cVCxK+RGA
	 P/VuZY9DhthA7w6jrVLlkPx38NnV5MFET6F+SAbgfnGkaF5AWqTDKuBsHJo83xLn2ti2g
	 lWYaw2s6irFDuUB0xq5Q7Kim59TBcTT+AL6diSiRgYsF0pOzVsnfETUjhAMfxVFwhtOwH
	 q3A75t5pQ8KGb4+01k+dK731Trf4dxr/BGi5eg8xfK5n4SDapoird0mUOntf77mBWK6cS
	 iGGyE5Y+HLpsAu6FG2U3pcJ7uP2fLU/Rl5EP9sKiRr4uzXljIkpIS9CWK6xWiEItnmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414522;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NCgH/0NZBvuYLkZ+Xnii9Hopgve4VG4cBhlJXngC6a4=;
	b=im/5foOFUZuMWAW2h2pvkDgrwV1dnJY3tQ6JNQKZCEEdTuDn8NjhTXEBFijHcLrwLuj6
	 IHf9qlldl3RW3nwLcSQgu+XdvUqhXNymeNB24MdgFzrmmLcgaoQh5c+YGqOrW1M0/Zes8
	 JgVAYxd1Ur4smReVS0Gitk3QVOplgV0lEqrL7h6WqdGWOBti10MzNut9IpPW62oXs/o5T
	 Y+nkJb3CbnURTDucBSCe6Df3LOm9ixA8HfKyTFMTm+gLKed2aCdCk0RgYXPjKs542ud4D
	 RIatdoLho09s9//oQqvY+MG3vmERPcGFHkwdEdlvAouLoJKhklk9Q0ePVBJfXmojkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E2D6l8bj;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60740606A324;
	Wed, 11 Nov 2026 16:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60740606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E2D6l8bj
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFEE6a236842;
	Wed, 11 Nov 2026 16:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NCgH/0NZBvuYLkZ+X
	nii9Hopgve4VG4cBhlJXngC6a4=; b=E2D6l8bjCTj8dsqWK4zbbqLRJRXAxhlsd
	yBjr7JRk4asnQF68p8eiBmdIspUwm5SDtbhYyxadvUMQp5xRZv377JneAfQe3Dfo
	2kJxkpSG+xp9DKbxGNQ+F1jVCarA8gIvRyTEAZgsdRTRJ3+E363c+6M9g2yJqpQR
	FfkSGi5UKGnjmE06LbJMBLfVQfoZCX/SbQ5SZEVeqUgPbtXNRmilPGV+YMoFNnJN
	R+hKET+swBnLoRDWaXCxxQOeuTvOzKZM0MhFmWlokLiDvBcZnqTK0/XJgWi2k/CV
	ZF3yqrzhkxhrjEHMDQXByvpHfZ3tsKsbOIEt+HbzIlWH0y7KrthEA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgaguv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFJoSA3536665;
	Wed, 11 Nov 2026 16:28:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0spdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABGSaCG4588128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:28:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E965805B;
	Wed, 11 Nov 2026 16:28:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F99F58028;
	Wed, 11 Nov 2026 16:28:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.186])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 16:28:33 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v13 4/5] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Wed, 11 Nov 2026 11:27:57 -0500
Message-ID: <20261111162758.9792-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162758.9792-1-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af497b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfXwLHpHyG6TWHa
 9sGVJV6M9NSMScPuPOyXOe6Q+vuxtgaNAWric1xA/+GAtWDqZenM5hNLrrwBMoxnSP72UXJ57lN
 PfqNZ11snp/zz0Ob3SgscykNDTmHwxePnS9hqR9WiJ8QWyE6yWurR8w44veMFhHWaT25/KskDq6
 Fml3iRqChKPI/cfDBnvS/+Sqf961Dw6OFTf1oRodNzeVzcxZJK5WgbcOWwMDbsbGMCDSaTGQLFP
 PD8xwiEmevQk3MEjaqERO1hlhLGXYm9ER+7oMSlFFFJ4pcx9U51LS364JU+l9iruMgyeMYJcnYz
 qIEce6ekK+n1N4jUx4EH8FOcmIeC25h/PASBhAv+iu7tFC2MiCV1w8cyzfnfdO4/o0LfuRyb960
 uBWNeW0u1OP3K11sD9OarYgVtFXjFhBjSL9ljN0yWYuwl4j1717EZr0tOQpwUgvusC6MA5K6aRe
 ANCgIztDPxsJpPxoUzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfXysyRKLq7ikSM
 d09Kr3UR/q+UD655dHSuptfnJKAEbX4MfGPrEg6U6AMBb1R/RFQ6YhE464zKx9kHxTQUJz0rbM6
 1l/Dw+niwobTMyrwVIBvnVgMq+aHGRM=
X-Proofpoint-GUID: WUUjFcD-cVK-C0UOXtCbNapPQZZbczqt
X-Proofpoint-ORIG-GUID: WUUjFcD-cVK-C0UOXtCbNapPQZZbczqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110064

Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
device is associated with a KVM. This will prevent processes on the host
from tampering with the FMB while the guest is still using it, which may
cause partial counter resets and inconsistent reads which have no parallel
in the architecture.

For VFIO devices that are not associated with a KVM (i.e., for userspace
drivers other than QEMU), this fence does not take effect.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 454121bc274c..02da077b5170 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -153,6 +153,12 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	if (rc)
 		return rc;
 
+	mutex_lock(&zdev->kzdev_lock);
+	if (zdev->kzdev) {
+		rc = -EPERM;
+		goto out_unlock_kzdev;
+	}
+
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
 	case 0:
@@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 		break;
 	}
 	mutex_unlock(&zdev->fmb_lock);
+
+out_unlock_kzdev:
+	mutex_unlock(&zdev->kzdev_lock);
 	return rc ? rc : count;
 }
 
-- 
2.56.0

