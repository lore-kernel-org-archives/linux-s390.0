Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987DA12D75C;
	Tue, 22 Oct 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589125; cv=none; b=awFuSns2za6gkXycGiIlVIEAsnmtzQwISp342qsc1PE6Nc5K5ycpVBo+LSpY8EogUE+K7qjtAFxML+FcFnpYC2m/KLTbDAz8BCSStHgA2UY0JWaQfQ0j2t5XGFFclWa1m5r4lUoLlfq6PJnXXwegggY5p51m4kdD7Ljzi+bDiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589125; c=relaxed/simple;
	bh=iguEBDl8q+O3eYgeqHRt+q0bauQl/22Of+lo5GWS9OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNAAWkpaF6yPvVIQms7/ZTGu44i1sy4FbOKqXdDZ/NdHiff9jH5a+oBLWAksw/rjvjZL42mda4EzNM7axTA6Q7BibbGEnBx7V2gaSnafZYVWAI4Sbu1PNB1qnjWBcuzc44O41zTrO9Ngnxd7PXODZURwTrjdFLzAxcM/m/Jbfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X58IzZeZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X58IzZeZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2H9Kl005096;
	Tue, 22 Oct 2024 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E+k3UV0GeMDRIFZTg
	pu8BxXs0tZH4a0UJwOSzoCuvas=; b=X58IzZeZ0y92WHox6BhswaUL+fyJdn8vp
	Jlrl9V6B9QrFkmz4J3l03EAMG/hZg3exZA5ZcKaHKU8qyhNFKoPo2Q0tlzIDnmMg
	4oboeTIptvTUZxN2DDod9bzcIw0jqN5boj4WIwdVPikPWYCcjFVoo2NJx/kwwkzd
	relTUFhDUJ/KPp+E7uGKKwQpxaakwip7z7ul0NEOIjgOhBQFLcq1DSppALlOXebi
	DtyQLigkM95wXh40ZFkhJ/zj3i+A8k36gaXdDGTXRcAkH9u7iNJp+aWyTA3pjBr2
	Z8moQhJhI+C4EKE+DVjdUkvR7gyAn56SBq88G90Ittj4pe5tyemNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcn3rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49M9PBko016724;
	Tue, 22 Oct 2024 09:25:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcn3ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8GDVk026443;
	Tue, 22 Oct 2024 09:25:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3saqns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49M9P7pm13435150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 09:25:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 073242004B;
	Tue, 22 Oct 2024 09:25:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7DD820040;
	Tue, 22 Oct 2024 09:25:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Oct 2024 09:25:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7FAE5E0748; Tue, 22 Oct 2024 11:25:06 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/2] s390/time: Add clocksource id to TOD clock
Date: Tue, 22 Oct 2024 11:24:57 +0200
Message-ID: <20241022092458.2793331-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022092458.2793331-1-svens@linux.ibm.com>
References: <20241022092458.2793331-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OSAw0Ox2aY_KTfrQED9VpsLx8BdUfFZn
X-Proofpoint-GUID: safCuDfN-R83nohHHxanAoPtMicEvqRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220057

To allow specifying the clock source in the upcoming PtP driver,
add a clocksource ID to the s390 TOD clock.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/time.c         | 1 +
 include/linux/clocksource_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713effe0579..4214901c3ab0 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -255,6 +255,7 @@ static struct clocksource clocksource_tod = {
 	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.vdso_clock_mode = VDSO_CLOCKMODE_TOD,
+	.id		= CSID_S390_TOD,
 };
 
 struct clocksource * __init clocksource_default_clock(void)
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 2bb4d8c2f1b0..c4ef4ae2eded 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,7 @@
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_S390_TOD,
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
-- 
2.43.0

