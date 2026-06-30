Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260723D9DC4;
	Tue, 30 Jun 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838100; cv=none; b=tAMoICN7xgxgiFhjHbHVSo7P+550lAMCAZAK615YFLdC1ZfNpKMaQ9saJOYgB4g+may7CcgIzsvdwS0gYmbA5fsmlsFtkArp/29XqOaHbk+ujKJJsBc3Tm42uL8qd7N6hIWitlmN5jE29yZ3oTmw1uDQrHr6SiWiKk1JstMWMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838100; c=relaxed/simple;
	bh=cX5TZtvSZwarWBI5c6PMZ7i7miA4OLjgPxAssK4YgaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG75ODEzney9APy6gohnJXJ4jiYhZIXz1JWKJKit+kIqPA9QA0lj7piMJp5J03j/gOzMAM9vH78nU+cXRm/rNH6KfDyFVcc34m46Rp5QTiT2pzDvur8AAJDt2n/EbR+Acb8xzgi0cGs+OJLEZ2PyzmPGb7H3/uVNYlIWqQiZKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6XPcsXO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6XPcsXO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIL3B2288618;
	Tue, 30 Jun 2026 16:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vXU3DidQiGyzHYE/9
	ch2T/ZRaHPRlcHfwPGBi3+olgE=; b=P6XPcsXOEP0UGylS7Cf6MQGSY3CztiFc8
	bqgEd0Dh7vzGCKH3P+Xjph4iOgZn/jOZa+zmv/4v5FkZBpHSReMzEzT4IWNemFMu
	N9V1pGOzFMWWL5vWxuezdlK841tK/i0wpc3oN7EbOyHo/GhJBSuF2WuvB5KnmfAm
	iNmiQvzjhtTUz+kbuW9VOzPB0WQp+iweD7Bapzt8MCvhUmwuvg+Xu523M/WNzg0x
	mgVv6BQPnw4WqkSu7QzIJwTWhQoQSX5Dx0HTm7XBMJRJ6OCPu2Wpnwbn39t0QQ7j
	NfxmKXL9ipntmB71DPTDwHLCCGH8H+E0OVUEQo16nw9f55N4mXpIg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe00xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGYe2H006115;
	Tue, 30 Jun 2026 16:48:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqbe6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGmDPf30474860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:48:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1185805B;
	Tue, 30 Jun 2026 16:48:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0818B58059;
	Tue, 30 Jun 2026 16:48:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:48:11 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v21 3/4] PCI: Fail FLR when config space is inaccessible
Date: Tue, 30 Jun 2026 09:48:06 -0700
Message-ID: <20260630164807.643-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630164807.643-1-alifm@linux.ibm.com>
References: <20260630164807.643-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lmy8aqUWJu5gi89E_W4-4tGcl5hfaS4i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX4wOweKlQEU52
 wPFDGMsdHEyiMK+c1QMApTWoVfs4aUaWAl9fNgsBWbD6hR1mgm8ff2+fkHy9ZFCnCc2Lmta5nKs
 ZhEdtWgaXtzbgJDauxmR9t79nohW1/M=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43f34f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfXxeE/L0Zm9nF2
 S3DUUMedoRXhoekf8lD6BgiuBxi6i0sfshOHI34U0VFe50Lxk2JDXiMha+FvprZgQxID/41xnpo
 2a2QDL0aXdJoHw7uRm6tV2R201V12T21bz+ceWkRmuFE9A6vMxamJukcndJpxmdV8EVNUUOPX0i
 eOYxuxfIsaMUXqxAInFMVgkToYb0h2xkzTLo92M1tzMmjkf8QCWzOgIgbaBX5xxLc74rehMAD1c
 2E2lFKh66JkCi9ylwoFIRVmaPKI7MYIr+aZa7zSyd9WKsgtrM2fMK9yiazoZickr45UwMGbdDJe
 gnBiAw+4Q5QKdCnSckRG4LF66bcKmGuIDRwSm7AbyJ/n9vFtGPfGZOBl36dQugbtqgHoZnnJbAH
 pxBzHClAKvdmMBhCWWbsT4XsioIf8ly0Q7rYqG//UG3RbP7BphmQbqVqiTvY8yYVK3j9Rc7UojK
 Wt0TB+DJzpsVtedxqrQ==
X-Proofpoint-ORIG-GUID: Lmy8aqUWJu5gi89E_W4-4tGcl5hfaS4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e8d7de77241a..9a9d021301c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4384,6 +4384,9 @@ int pcie_flr(struct pci_dev *dev)
 {
 	int ret;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
-- 
2.43.0

