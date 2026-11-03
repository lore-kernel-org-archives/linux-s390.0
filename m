Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718120;
	b=UzXCjiQme05cMSU5nRfTY+2bNvV+qKJHa4Ex+3NpuvYqcFZUNk7bDxUF1J4nSFr9Ihef
	 BxFQDWPfFog3w2AoqkDN/vt7bTKOHRt0HFcjjfA/QYoovcUoktwIPnX9qjUFWcDnHWRii
	 49NJql24PvEze7oIuMk/znAaaluITXGUxn95g5yJs5B2jc5eE1fMfNvgKu/ycTjQPkIjR
	 rQnxj1E70KTVptZsBP7kI47/UOT2pVaLZ6ob/MIN6sjtvzMkbQ8/U4XbwELwCZHzKnlxH
	 7a47V9zONokcp9XbZiLJ/s29Ir+h1iBGxDZ9hjtsMKI7L4rXziPg20be4OPH98fpmYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718120;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NCgH/0NZBvuYLkZ+Xnii9Hopgve4VG4cBhlJXngC6a4=;
	b=Lx0IngKHAvqSpEDmJ/8ZdLQSBAk3VJuOoBoFhtA7y3mRrv99364uWzKFiGg3humzSUiU
	 vFRkPOh1BQfEuUO2SM3GJ9oW4Bef7qUi7e8zKZw+twTVYWIIOLF+AriQX43qa2w+lVOgO
	 mgPpNZ4hu8C6AN5mmMb3t32Q50rOtGm4tVHAf6nLp2oMbbUDNQd5T/dF7g9UUs+AjTrT1
	 hbQ8byivGUy3hrWNRjU7Eo+6b9NDp3/csouRtKxT2+zfrmDyBDvK0AR4wCnyPR5UdctBH
	 +DVLdiKAqFlb2k7ktyrDPGlB5cMu78NqQYim5f4gwc/5INVsgCWIyiVe1kPjSyAxLpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="n/tAhZII";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BF606B267;
	Tue,  3 Nov 2026 15:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4BF606B267
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n/tAhZII
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEEVF860860;
	Tue, 3 Nov 2026 15:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NCgH/0NZBvuYLkZ+X
	nii9Hopgve4VG4cBhlJXngC6a4=; b=n/tAhZII7/aHCmyXf1ljKrtTWSGySlp/G
	bTlmqh6Lmkv4sDYik8hQ5SoRWAjdCBmQlwoWa4l4rdxNxxVRdh0p8oCrMGL3SQeb
	t6iKF8j+0Tg8F6pvHukxFNaeOMnQRxo699bSLgdpIG6fjctUNn/pxeJvRBFIXmuM
	9reYGaPve9E3ki2FgWzCb+eGrw8RjbCFjuKdn3avDcLJHWqpFXkH/MebCZlsPkkM
	PFrQG1Q8THGbXM3qqNv4gWVgGkU/zjxnmYN2z5RVDFBa2QHrosw9E6NpDw0uyR8o
	elm6v5CffRl2uXiZgt+kHbFn7ChUnORd/mQthFpwQ/9UNS2oGLI6g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd68sy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK0Ui1451562;
	Tue, 3 Nov 2026 15:01:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfttjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3F1PDs64880984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 15:01:26 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D31BC5806F;
	Tue,  3 Nov 2026 15:01:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC3F58056;
	Tue,  3 Nov 2026 15:01:24 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.67])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 15:01:24 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v12 4/5] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Tue,  3 Nov 2026 10:01:13 -0500
Message-ID: <20261103150114.68873-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103150114.68873-1-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX9N1I6SDJvFLo
 bbhiKb7LxcqdxkYs6VShmtwLLDal4Yr/yy+1MELu5w4Q8/GmP0SEzIKQ+qq7CXJSXpqg7ImHyFX
 sN0W/Ete4E5TPTNj8OvF9jSEhP/XaYk=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae9f749 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-GUID: 7SKEhQ8HtzAw1etk2KQZAe59OkeycnN3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX8vKDzNScimQA
 z+fBUQAm/0heS8l65cWSqF8YRM8F7ygkjsjvn8ZAA1PqKVXjaJ6HE8T2bf0s2e3XU3G4WcoFaFa
 KlLdhEN/Ktr+hBaMrjHZTbuNeCyRHjxYDMRFRoXmZX3DxPY2XzKXXUQWj3LipPBK5403R/D3CKw
 BR3KsgPZxwsAR/FgE8LwYPVdQJzDYY5Kg4kD0EmmHMiOTNCrsvSa6Ob89z1YD04YsnSDXCPNwd8
 ehlGdeTDn1fX3Rkkv2LneqPNYvYof20XesWeFYn8gFR/zMdQBsUC9OsbwGe0e4Sow0U+hqeBiWy
 bUdeA4UjwqA7eqC7FcgicT/Nar0s3qAyXNgbdtP1zxPeScAhn0WN35g2wq+iWOmYVZczXC0ag9m
 LYNrtd/QwTczbUDU8DDdR+Vs2c+qGw==
X-Proofpoint-ORIG-GUID: 7SKEhQ8HtzAw1etk2KQZAe59OkeycnN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611030058

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

