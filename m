Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E111E378C;
	Tue, 15 Oct 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989687; cv=none; b=jofGPWyOojl2S30BRfYNzkQAMaM3iFhc/J8BPIhDf0GzNP6L1/R7TkBZfapwcTBPDr6EeXnNmfKPBCm/gMZdu7Vor7NA7yEX+T4ERnuN4P3aQy6Ad38iopyxaDbdX48PreGat2go3hPVdFFFtikHsDh07Vd8bFrHk1Sr/3gTKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989687; c=relaxed/simple;
	bh=iguEBDl8q+O3eYgeqHRt+q0bauQl/22Of+lo5GWS9OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a93384tWBN40oM8ok6aTwtH2vL7s1NIyPsEeRIrwkQXjo51GlAhJ2mraAc/smxEItQ5W3VtaKNjBsNhvUWvtqt/l6Q6TW5ec3O+Swv5QSf3o+MIPqtL5AQyHhY5GTdJNrlYydD/OC+STsKmHJeRUzn4aLR6BQ4unTtIlYzGf8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OsaJxjl6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OsaJxjl6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8PIgg023808;
	Tue, 15 Oct 2024 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E+k3UV0GeMDRIFZTg
	pu8BxXs0tZH4a0UJwOSzoCuvas=; b=OsaJxjl6TgWGwQ40rISjiKW/ehRuOGPGx
	hDcVJGNBaBrD8XQlbsDUaW96m8K0GrJRTtNUAGxcBlxiKj2wxCQPAg5WYm/WCuwM
	evyRUOLcuIKpU+3WxlkCbjS7ANAgdXsdcpwseQz9jFx7bYxIMAVCzLF4XhsZR1eT
	5XYyQuTJq5znsi9xvpL15GyvRUg28blY3Km4ypdbbU/k2Le3zPGo8aZZkiJifLIS
	dXVdJwP9bDwj/R2CqVUX2FGw+o7zXwt3lA6fY1UMLz9ScHHpZ6lezvtswVZ/KWim
	bHSNVmoRMjVRtD4RR/9iFCuTd/Wdf4C/6cDWoFmJjPJ3lnMsLpLbg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4rq5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FAsZFM030322;
	Tue, 15 Oct 2024 10:54:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4rq56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7ttcE006757;
	Tue, 15 Oct 2024 10:54:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk380q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FAsTQo17367472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 10:54:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C30672004E;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B230820043;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7BA93E00F4; Tue, 15 Oct 2024 12:54:29 +0200 (CEST)
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
Subject: [PATCH 1/3] s390/time: Add clocksource id to TOD clock
Date: Tue, 15 Oct 2024 12:54:12 +0200
Message-ID: <20241015105414.2825635-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015105414.2825635-1-svens@linux.ibm.com>
References: <20241015105414.2825635-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 83dVGkyupyVH2TH8wrMgXw5uv76eaPb7
X-Proofpoint-ORIG-GUID: JaanYmQTqz_KdxiA30RXjKY8ms631al0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=956
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150072

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

