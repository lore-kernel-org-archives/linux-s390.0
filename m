Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531491;
	b=gJSBrTxFuR7gPAqLYhzOFCsfI9mMBUHiDMYnd8ADLcNOfCQmXW+y5Fo1HZ6wfSSeKdFs
	 Ss4q5l3sXiBP5rKrhYqelvlH78tvuPjsLZHs8u8zamQFD5tC/3foG4ipGAaRQ1l4HMaR6
	 pXPtE1a36jnX5hcft4aVMD8PlGvZZhuS87bcfaz338y/S+OdaCUqDIjEXUQNuC/CvuF24
	 i2eu+Gg5hhuGHSWsltrZifgJIqJSKiFNuN0TG8dpf4VorovIlEB7urrUtpUlbE2jH+0We
	 wVSs71NX0Ik3ExO4DLEhsIzd04zGl8btflCFg+GYGoTig1lSIzB7As5b+ecvXNoLckA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531491;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yYkjQupRlE7l86e5bqGCEZ26EFSZ9PshuTtqdF1FOUI=;
	b=Pr0NwZESmcU0nO8FcWPArUUbUNFHh5whDS0rl1+Acj1GsfZV6vMaamv0QKU91w8cfi0P
	 CTCw94c7FbhaeAPLuhzE8R4fD7UgEvzCYx1fDMdCtyWiAxG8iTAkUHqvWZWStovjCqMCi
	 ZEJowvltypSe0546uuCpE7HgwDxDcbM8bl5rk7WHhE9QpNcriOOyMhbrTvEI/15GHnLAT
	 qDJrKHLJhOgpIUcthowpJZAyxrNpw5GwqLhqnuaZxaGeBKdAhu7RTAl4TuxHaZjtZqYig
	 a/Q44CG8M3e2tEwTwLpoSpwdLXHfPgpa4oqpUttZ2wKeooeB//26llzK0fZF/aajAIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LE+nYf4y;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E92606A335;
	Tue, 20 Oct 2026 21:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E92606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LE+nYf4y
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLEMni2394516;
	Tue, 20 Oct 2026 21:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yYkjQupRlE7l86e5b
	qGCEZ26EFSZ9PshuTtqdF1FOUI=; b=LE+nYf4y0jV35dsk0wgro4DA6qEu0M0oH
	pgEgla9tIFHXa9Z19VHNwn5PkOCw7kMoVj3DwTU4XaZUsjrRmG9v2HEXP44xC12P
	sNhqZIj6dREBOa+LindVbZFqxHm4yQYIt6hDiHitRe9qXRAJb94c1OQ2+FbTXH6O
	7hdSIT9ChFneZHEvJegeBsydVD5uA8JhAXMky7Neo/VyERB3AIEnB+oAy4N/yL3b
	45GxiThXpckVXt4oczQ9ExswxStSgMYMXtUpSogOhf4HEA9fZmz50X2LHHc3a/kE
	lxZo/SHpWGEqew1gXyq+0YblNnmEq1BvwPV/RJOTsKeLGVQocwZ/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw585951-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KL4uJK883709;
	Tue, 20 Oct 2026 21:24:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss03cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KLOjd021103298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 21:24:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB655803F;
	Tue, 20 Oct 2026 21:24:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D555E58056;
	Tue, 20 Oct 2026 21:24:43 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.182])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 21:24:43 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v10 4/5] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Tue, 20 Oct 2026 17:24:26 -0400
Message-ID: <20261020212427.2561-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020212427.2561-1-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX9fR3aTnJOJFA
 ZMiwJscv6s6dB4Zb5omnkAxLM/859KEZIggF3m+ksD8rw6NDSg7EeUD1EFE36IoMlAgSgjgepH5
 DW5UEvE6NosL/11dSas0QmLDBWqLioY=
X-Proofpoint-GUID: MWps29AlcuYls9esE87nTf6qB9qq7yiu
X-Proofpoint-ORIG-GUID: MWps29AlcuYls9esE87nTf6qB9qq7yiu
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ad7dc20 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX4rs8Wdk8gYZ9
 84z1/Qner96tJpU6abksTseqslMc6OtuYFOKv1IZmBNqEn93XE0hX+m2CHZKDLYh+t4/T143PJp
 hhOlHx67GwPYEv8+to6HEXVY8YSRBYWmTLt4P8VRjQ/AdgMErCbSURJBJexY+MqScB475wzbKKz
 LOzwF6iuHobRO2ixixXU4on2Qc/CCpbS47x5dpAwYCnZ5SeelvwsG5oxC6Tm7NJ6Z6zSrQb0CJV
 I3bJaoMce9o1FiuVaqduVSpNBT4KjDO2I8wnsuypHhfoMNwfClF1aBWTZwXirvDY5PybzsFFgo+
 RWUwVInX1+KB0gqjcxlg2nyg+Qg7Y2guCoAZXL22aVeXXiJGZGHHVmpPuhacuDk6ZbHpNmTRqoC
 RJuhzSKhIfnFfmYedVd/tIwkGKwyKJRmJme9EA0bw7+X1EyqzouBkDYx1GC60RR13S8QuNij7mi
 BDTXySmNCPrjM8cEDRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200084

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

