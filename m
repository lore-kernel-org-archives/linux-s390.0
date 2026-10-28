Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202254;
	b=y87GzmIlm624njwnZgqYzBkm9dC4SPq1TndPw8LFIhze5g3ArxceowR3oYwM1guW+WUs
	 tNHZhPo86tz3D9huFzskNVmMNNK0+RRJp7aQM6s4LGlBqmj5Hzkt+1QzVDm+x+v+dWUUN
	 Rznm3XBpPa6eJZ2nH2tm6gZZ3nXPTLTI725xzMdWShf+sR4yqRNdYx+L+IVAV42bASRyO
	 k52lJBE1eKRtSlEZ1tDCgsjrRdeNCB9+J962xu+qBwEs9AOykJvG/WUAYjcrZWmUgmlqI
	 Zm4Zyj8NHSxq3axZvT+ucXTlkU49LUBXuzkfOtUyLmgJQvZms74UfDMwd77W0UPaHWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yYkjQupRlE7l86e5bqGCEZ26EFSZ9PshuTtqdF1FOUI=;
	b=PI0vK6oZAGIFHbroOz+ulbNQsaWf5ziRCO5ob6F0I5OTbIzP7nEH419OMRFaaUXESHzO
	 PUJm3hVRav5eHvevx35QF10RHuaD0qvUNdUe8mP2wGnT2joFa3tt/z9fv72zG1ZumdKVw
	 1u4e74/UUy3RSyuZd8XkZ5wv3HPRdx7kklFLfBGvjsQkFlEfbNvG7anPwuDX7nilt/FuN
	 flvMNz8E9Fy0Q/+ppFjqQ98Fkvi2yPMzyzLqha+YOpg9oARPuvsOolgKreZ6zUlZ+JQpI
	 sj80KFCasAeLsaVe1twIdXqBGuMfTvcIbOvHKMyQEYlhdm7a9kdA934avBSkwOAuaIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LybOxQL+;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE460A261A;
	Wed, 28 Oct 2026 15:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DBE460A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LybOxQL+
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEcat1575801;
	Wed, 28 Oct 2026 15:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yYkjQupRlE7l86e5b
	qGCEZ26EFSZ9PshuTtqdF1FOUI=; b=LybOxQL+BPLDR5sj4fBN2Grvp5gwv8gQl
	qr4R3wsJ4ofHXZGQfYedfCPcWVQb7y9h7xYPSGv3fgUn1g8ZhjJR8FZTwBGFbV01
	t5qDiczJmay78EP0Rplti3PnSmKPJhEXdw8IUtVF3kNB+cjiAfNm2CC7vRbW3Wcg
	o2rzvZbGZ0t2dv6K+lXemB09R6S3MdDWFA0Z4uMx9nZfrADrycH9e6RvsiOUI/XD
	4n82hGc6q8L7m+ksfXxWKDRPDhvTjhyO0Qk4OzwedUDaIZjwjYG5/XOOQh1ApFyy
	ynpeHKEHNsDadlrnFH25AiK8JeQ4ZCJ8hZjCpWzFFYF9IYI3l+ZoA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd75k8x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFYn621760082;
	Wed, 28 Oct 2026 15:44:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pawvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFi7MF8192562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:44:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FB3D5805E;
	Wed, 28 Oct 2026 15:44:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18EEE58054;
	Wed, 28 Oct 2026 15:44:05 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:44:04 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v11 4/5] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Wed, 28 Oct 2026 11:43:51 -0400
Message-ID: <20261028154352.15108-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028154352.15108-1-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae2184a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX6bTRS8k/kAWt
 gAZXH70Tz9wylzfJoRvD0DnJPKDLcvLItnM//rfhkt34twkGbVmKMhXRRmqAi3Pqfob5iNlDVyJ
 vV5eeZir3uon91XHAD+gyAWbcsAhx0LYRv0fqOZ+JkiC8Q3jaSrTwrWyrwfaAsNwTzMf4BofDhs
 gVyXyqql29PsEU9C2fNYPljqsTqpF3VhZ+anJ6//ogqA5+5MEqYDuEi79RIjk6Il1A52EE5/tQ8
 Z3BopXV7zWWccEwNpS29bGw8uhifihhYqrighqRwplLgd1b8A3qUJL5k3SbM3WxC1vQmawibfSj
 YpI0wyh3xi8WGF2oXQBn58expRkROqjczhrKbkxMZSaYrLTCnLllMB3NoOMJMqJrv5SifeKkhCU
 czsvZZxwG0dU5M1vdRk1Pc0+NT2RluGvh6tcBUGM1f07rkjn8RLI+HR3wboWugC++5W8ddQaDAF
 BcD2/bux24zvYd5mgTw==
X-Proofpoint-GUID: YT5L6nq1o6NRmSxLOm3xcgKfAYTIfJsr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX6XXIXYSOwsbP
 4Vkr7W1g9AtO2CNDQP8cYs0CAS81ThbbCCCesFeXZDSx2F4EDu1+LbUx0j0q9HVIXOdlxy1ON0k
 jfQfu/NtttwbIA/+FH068BfK/ONXwGg=
X-Proofpoint-ORIG-GUID: YT5L6nq1o6NRmSxLOm3xcgKfAYTIfJsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280062

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
index e479763858cd..21d08410799e 100644
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

