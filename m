Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531489;
	b=E+aeXLddXxF1Pjex7b3wlRfLMPb1ZMGmpYgby9Lp7tORp63BPtTwu4+ZtmJEofrzygsr
	 rLgsMuJFj2TSboZMzsophyRkoxxhmSDbBkVnL6Wtsfu8pUKcglqUW0+5fIHo/eoT+TZBY
	 3+dxhpz6mC7EfgU1efu/QjGHgoiuD3hDek+yh07cU58bEZvkQ9NIC+k9encMqCsqmMnwu
	 45+8rRLA6qXNU1FQTcwdBflw8lRBU2A6uWLc0Zh872SQBHyRITWX4myJFd1Ndg9wih/9M
	 BjmkU+AogfUexoiKP2PzuOsJR30MLScvP1BdQ21v2uTHjrz+A9xj40TSr3tWoPvHtEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OUWMy+XbAUA2VrmHXrftt4lI9ZD8Z2+9c0Al6+iPGZ4=;
	b=BepW0QnxRHIgoh123nMdP0leu7OtVRNVOzHZJq0WyB7K9TZQbMvUXvLLez0HebqwZFO3
	 DE5zxIlg6Y+G8ujreJ1aZwuPHBUrMhXvZp1wwnpYZOV/COjAlKKHDMOZ2CAEErXkOgVgG
	 uwIWmEI+y47V8C4J71AHjE7Jg4gTqpVH/PZSuMdKXpAR2knniJWt/2EZ2GpCzumFdvsdu
	 UsmkbdTzAaBENP82FAQwWTWTOYydfyR6pMuLRCtjpJCRBJM1pTID7KsNRN9QTL0scNIZW
	 M819noGfxt5fHVGaUUT+i+kHta8TA2hOcPpzAkmFp2A8grCiEs6fA/U57sWWded+05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NwY2GhXw;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C7606A32E;
	Tue, 20 Oct 2026 21:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826C7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NwY2GhXw
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLEDC03671642;
	Tue, 20 Oct 2026 21:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OUWMy+XbAUA2VrmHX
	rftt4lI9ZD8Z2+9c0Al6+iPGZ4=; b=NwY2GhXw6PR7TznYKlnFk2V3q5JQjOqm7
	KdN5Df45AqVp8okusC3EqaIXXhs/0wDpq+TzSGlQK79luvbzgU4IR7O6GGu9M73x
	nA3JX1WoJSQS2CtCE0ET38zrqU+sBw5pzHoMos7CJwM2J9v18R3YdTq+TOkFeMof
	p+VVZgk160NrRi/hf5mOKF76JzP6qHiM3/aC7/H7bBrj+NTU5w1mhdo62IrpyhhW
	Qk1vBpgFwAWpbl3Ba3KOhSxrflzauQPeX3/X3GHXv7kvee3ZwEndjqAMexivQmXm
	Mde/Qbn+ES3nwx5P57PAQ/f0s98LOQwafXuEua674H/8qTCtGdAFA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58ngqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLK8fx2072233;
	Tue, 20 Oct 2026 21:24:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvm7jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KLOglo47841718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 21:24:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12BFF58061;
	Tue, 20 Oct 2026 21:24:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98E6F58060;
	Tue, 20 Oct 2026 21:24:40 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.182])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 21:24:40 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v10 2/5] s390/pci: Reuse FMB buffer across enable and disable cycles
Date: Tue, 20 Oct 2026 17:24:24 -0400
Message-ID: <20261020212427.2561-3-oelghoul@linux.ibm.com>
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
X-Proofpoint-GUID: jipITal45NctRoo3NuqSrr6r83bkjZUW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfXzB8BmhCSVFjp
 Xbe5C0H0Qq5KrPqj1zbLxf0DfwVw1g1xZZtLl53sNS1LPs3W+yHdumvr+AFcIRW+qGvd40tExUl
 tSYyqXwWUEgA6wNWdCDGw2eXP6NBgdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfXxbV1odad7aqI
 oZx+tPADD74PHBd52WxQAevF/YbdZ3KgOhvmrq6LtxShh76lXBlx7WtymlTE/Svp4sAZkioANbh
 QTz2pCU/a27MJqZchQwueWQb+AKuKIOtRzI0+2752PU47fl3YX6TRMOL4kaF7oKYBkWWiNhlhhr
 HRDj+PGFrleW7vPBQZ6e7hKYPZ6HKYEsFklfySbgTZyfyKVC7ymsFh1zkNZ3otbc14VRxH9UPDi
 5MEvB3z3piT5JYWs564JffgxtiB5I/rs1GTWaia7dpqADMSbjHKtIrJ6QAoYUzPieP7l3NR0xmk
 g49j5cg248qTieJTaRp3Ys43Aj1YisYsVLItABwvWcVzePI4cRwFUegqzjlsTqyQTUBGJNUVmQl
 Yo3n1wCQqYHiImrRnfMivHWn1hsm1syEkJH977fCuI5R0gDq0+vgIkIx+kvv65+LwtvrkB+xn2l
 XMuea75TRSDro4ElCJw==
X-Proofpoint-ORIG-GUID: jipITal45NctRoo3NuqSrr6r83bkjZUW
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad7dc1e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=OGhkjCSG-GKYbJpDGVkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200084

Allocate the FMB once upon first enable and keep it for the lifetime of
the zdev instead of freeing it on every disable. Track the enablement
state in the new statistics_on bool, since a non-null FMB no longer
implies that measurement is enabled. Defer freeing the buffer until
device teardown in zpci_release_device().

Drop the alignment warning after allocating the FMB buffer due to it
already being guaranteed by the kmem_cache.

Audit the only consumer of the FMB (pci_perf_show) and update its
liveness check to be aware of this change.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  1 +
 arch/s390/pci/pci.c         | 41 ++++++++++++++++++++++---------------
 arch/s390/pci/pci_debug.c   |  2 +-
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 88a125b92bdd..f4fea1c34746 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,7 @@ struct zpci_dev {
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
+	bool		statistics_on;
 
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index c055a9ad0972..2a7e1ca0fa12 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -175,13 +175,17 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
+	if (zdev->statistics_on || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
-	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
-	if (!zdev->fmb)
-		return -ENOMEM;
-	WARN_ON((u64) zdev->fmb & 0xf);
+	if (!zdev->fmb) {
+		zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
+		if (!zdev->fmb)
+			return -ENOMEM;
+	} else {
+		/* reuse the same FMB buffer for as long as the zdev lives */
+		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
+	}
 
 	/* reset software counters */
 	spin_lock_irqsave(&zdev->dom_lock, flags);
@@ -199,11 +203,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, &status);
-	if (cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+	if (cc)
+		return -EIO;
+
+	zdev->statistics_on = true;
+	return 0;
 }
 
 /* Modify PCI: Disable PCI function measurement */
@@ -215,7 +219,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->fmb_lock);
 
-	if (!zdev->fmb)
+	if (!zdev->statistics_on)
 		return -EINVAL;
 
 	fib.gd = zdev->gisa;
@@ -224,12 +228,11 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	cc = zpci_mod_fc(req, &fib, &status);
 	if (cc == 3) /* Function already gone. */
 		cc = 0;
+	if (cc)
+		return -EIO;
 
-	if (!cc) {
-		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
-		zdev->fmb = NULL;
-	}
-	return cc ? -EIO : 0;
+	zdev->statistics_on = false;
+	return 0;
 }
 
 static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
@@ -1003,6 +1006,12 @@ void zpci_release_device(struct kref *kref)
 	if (zdev->has_resources)
 		zpci_cleanup_bus_resources(zdev);
 
+	if (zdev->fmb) {
+		zdev->statistics_on = false;
+		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
+		zdev->fmb = NULL;
+	}
+
 	zpci_bus_device_unregister(zdev);
 	zpci_destroy_iommu(zdev);
 	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..419c6a9200a2 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
 		return 0;
 
 	mutex_lock(&zdev->fmb_lock);
-	if (!zdev->fmb) {
+	if (!zdev->statistics_on || !zdev->fmb) {
 		mutex_unlock(&zdev->fmb_lock);
 		seq_puts(m, "FMB statistics disabled\n");
 		return 0;
-- 
2.56.0

