Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549D37CD44;
	Mon,  2 Mar 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483621; cv=none; b=ng8i739ecN4xOdgNTZZ6E8pqxz2t6Ao6WGTHI4VkpjxUXRp1sEemFj0q2HB8asjU2w7TwU60OtJtUJe7dxh1aQFKw4pL106J9mQu2wh0mzXWjXxYDTdZwNhUwCQ4FDG/pgvX7N3pct07I6SFxFgx7Zwz6JFVdCWyBu7FszDeRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483621; c=relaxed/simple;
	bh=F8dLYvkExedLz01U5bcZ2k2Il7JNn8i3c6tilw8NFy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcmogDDGKNtlkVO/Ca7YNgmOrGKEhBkgRMPBllDxouTLJd/zODG1OLF/MrXBQNxfWZLKLbj/QC14cK7RZ1eSku1P859RtSW+o444t7OlSbF9nyRsePdTOZbkXUGfbQSpl5nu2xT/cBLB3yhqYryoYxun7BoiXKYnhhnW9ljnEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c/+1B6Oa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c/+1B6Oa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622CE72Y1079188;
	Mon, 2 Mar 2026 20:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+SIo8wBaWAmrNbOad
	MPJfvRDqZdg95VfkfWuRH2gc7M=; b=c/+1B6OaRw/yKZYDkOjyYsx5GXwHSvbtO
	48XxPEJGXjQf/AeGxKd4nloW8TEBDpEPNF34UQ9AOxaVbCmbE7dXGmtqfoaBrlpo
	ixp/pZzsb1ZpFHLDtuudP/FsaPYlNjZWabISU99Xg871c1QRYBjyVduSuK15M6S5
	SpxbSsMZyvRJLK9p98q1TLvX6DSS4uSqGq52e1LsW4uZNW6nIxb1NXTbP+BsG7yH
	nmk6xaLZA+2ZnVZu6ZAPm95l38nigucsJD9dfXcOqBv2E+YgXhNnc2bCK+SP+AyK
	w7q1ZCcnWznjYSLHRUZcPAfgne8e2Z1QewEHLpkMomP8g46qLQqoQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbr4ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622JSY9h008803;
	Mon, 2 Mar 2026 20:33:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd17abb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXWOE16253550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B368F58053;
	Mon,  2 Mar 2026 20:33:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5535458043;
	Mon,  2 Mar 2026 20:33:31 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:31 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v10 4/9] PCI: Add additional checks for flr reset
Date: Mon,  2 Mar 2026 12:33:19 -0800
Message-ID: <20260302203325.3826-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302203325.3826-1-alifm@linux.ibm.com>
References: <20260302203325.3826-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -J8NlHwtN1jySgjgGLfiNcLkSw7GeK3-
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a5f41e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_COy7Z8VS3VoYlkUqhYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX67mp/PVQgLnf
 Y2LjFBzz83ny6e2A7CRZCvAy59a1rOhrmR2gagJHtwolUCV3e910x75wAnKji+8FFuZUGPWgDHs
 3HR1qY5de7q0U1AlhfpLotLpB74IPcfQl7I+z2MNtfyZxsFEFzZnpAjfgYIkbO9eSalSFGQu2Tu
 /J38Jh8Zkv/Scr+23/QxC++39Qonrgq4O7EWMmYmh47NMaYhQtZI2/l3uhwbc+qn2Xv28Nldiq3
 O6VHPvCHHfM5q0zaIg1nVjdkDEZvWfiqMORpcH2KL2KVrgtbpT939Q8I4OFNya9HvGFS0LlUKo/
 4ZoxKLZh0caPPVeaHp82OtO8rJN0zbB0wN3YAA9BySruI2Qn3cr0KvKved1qUBh8/MhXSw+LRBw
 o/Rt2jfQPO3eOtKTKoiPLvqChkLXyO6MHU1AmccXr6mjlOS/nkxZ3A94gtu7cX1gFqb/ZRePkyh
 pgg4vC9S9Acx3BhjbQw==
X-Proofpoint-GUID: -J8NlHwtN1jySgjgGLfiNcLkSw7GeK3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

If a device is in an error state, then any reads of device registers can
return error value. Add addtional checks to validate if a device is in an
error state before doing an flr reset.

Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 85a4edf756bd..fabbc7e543b5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4372,12 +4372,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
  */
 int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
+	u32 reg;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
+		pci_warn(dev, "Device unable to do an FLR\n");
+		return -ENOTTY;
+	}
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

