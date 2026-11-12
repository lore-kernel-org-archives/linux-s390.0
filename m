Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482486;
	b=s6gQzb6PQ2Nqpujgv9VrTB+CGgBUGjcRjW/fTG4TfoqllD/L4yOoJHustmPA/WHs/1bu
	 GfdU056GxaQ6KCBuzXgMzeSU3o3u02quo/SCsVDP95c/PDH0b5syxE56QqUMtFBZn7iXi
	 aGf+pEY7vwNomfsZMBZgUK0ZcHA0azOLKK8E8A9h31iSCUGqbaOqDQITzD+7HTclOU7Lo
	 lAxu6Qqw3jqHe7XM4NyEVDVgOFlTqj35FdI0olE0YK+pFyrAChHUjop04udx4cfSWw7WS
	 grFuHKwb+PVe2ldQxT3DUb6KUJ7yiJI3iEPilLMoZ59YjlMWU9JQoeOMv17NrhIqBOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482486;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lC+9K7m31nV3/2QQkVjAe/TtZtgo2BwTPtLYsIKTfLw=;
	b=BNWMj8DazbXLHGrXy3RnerBQgb0lXOhCUgWvFJObT1s9xTBzTJ14D/3M4VmwgBOdykeI
	 ZxGPbghpW0RY5YcB4727KNHUIJUpVT2AVrF3TL0AJ9R3w258QPSayZ+RtWITFTKgCyeOO
	 1DnFFatBsb5NUIoRv3Dv0rgV47eSRr/3MDzMqKebgHCrkO28fuZEco6C+Mz03UxbFIVyq
	 Dz6/FrTN8nf50yWXMkad8dC5MJGh7yq6F93+BtkiNKarckyk8aG+KE3LeBpibD3K/6PV9
	 jpKazaQhglaIlO/NRKOypagf2xV1c0WS2/HJUSxmUs689Gnzs6iqVwQ5C+qMId/JZBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mXVofjlO;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C015606E757;
	Thu, 12 Nov 2026 11:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C015606E757
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mXVofjlO
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iX6W1214888;
	Thu, 12 Nov 2026 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lC+9K7m31nV3/2QQk
	VjAe/TtZtgo2BwTPtLYsIKTfLw=; b=mXVofjlO9pd4fRh4AsqKB4coQxcqBxjwm
	nyd9hjER9E9nKDEwfCD4YChC8wQ8nAgto3rbqKEu00V5NIzq+CTsNgLRdwSjZibc
	1ju/rhLxuwUzC0vo+8oQWvutaGEnFWkG8Hp/xemIJt8yOMW58uxrDLthFRq7k3UK
	b3/9AQrGlUmobneegzK+6CfTB+qA0oOVizeMwRS/DZXOHsHI5z1Dbet7eJCZrO4R
	zDZDtDlZRfl1QbAXGGfgR8ud7wAxy30lHaL8AI/pgVaWi3H42Y3a5n3g7EMeOqxc
	u3PEYB9Yt79oittT3NbqEqockfYtper71F558VpLr8ZtEj2HlZc8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntf68m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8Mj2O016699;
	Thu, 12 Nov 2026 11:21:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3328hhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL5aN31392250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D299320043;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A532B2004B;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/8] s390/kdump: Reserve crashkernel CMA memory
Date: Thu, 12 Nov 2026 12:20:59 +0100
Message-ID: <20261112112105.1169118-3-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX0I71AEaRk7iv
 1usCxmc6Z4jZ5ETjnbi1GqGR5QI0lBgMmhTtH78HqGhRnnNYC/UM16aStPctUoWjiItgtdk8V6J
 WMBuq1ShVEKltHWIrCV0HtMTg2Y584v7Z4SdltTw+R4eL32zjwoR1D9YRzscXaJ7L8LDbWUORDa
 KGXnBCGNaQzJ/GbQMxQVW1mmnfPAhZ5k4C3Yneo4buIwvFSF6utShQrPb/Si29lPND4fabr13uL
 Oskntzvqm7h6j2ytYvrzDzXZfUm1XGMcmzPJR8/kkvAH4loXFzEQhMvz30eWGm5yIAxOs1gHhep
 ZAmjDfwL+V8ZQW3jWEpOgP5cSEjqLf8aeD5oC97ZUFxmdZAbobm0ixEHxGFAe2b8Wmf+uxmdJ9z
 o3ycPBcvbRtj+IcUK9cI293lBTmdlRpzUH3Ed3BscurBjv89NpfCJe2nvt8h5FhmkCLfgcgCgsK
 Tld3RMCRgqooLZw+ivw==
X-Proofpoint-ORIG-GUID: m09EYvVI8TTqkItO4SPbC1RNX4B1OaU6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX823UQbcbuL29
 I6XVyfok2u4U5/WXyuuymlDmGd4SFAnASGs5Cix08EG9aPVE8VNueYTLU5hXalsFi6WEXwelQW8
 4Q4a84kReLf+8RJvxsHvoxP8eyMn1c4=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5a126 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=J6rJnp0CUSF8FWxXyooA:9
X-Proofpoint-GUID: m09EYvVI8TTqkItO4SPbC1RNX4B1OaU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

Parse the ",cma" suffix of crashkernel= and reserve the CMA memory with
reserve_crashkernel_cma(). A kdump kernel does not reserve any, it uses
the CMA memory of the crashed kernel instead.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/kernel/setup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b60284328fe3..0251bd35954a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -598,12 +598,12 @@ static void __init reserve_pgtables(void)
 static void __init reserve_crashkernel(void)
 {
 #ifdef CONFIG_CRASH_DUMP
-	unsigned long long crash_base, crash_size;
+	unsigned long long crash_base, crash_size, cma_size = 0;
 	phys_addr_t low, high;
 	int rc;
 
 	rc = parse_crashkernel(boot_command_line, ident_map_size,
-			       &crash_size, &crash_base, NULL, NULL, NULL);
+			       &crash_size, &crash_base, NULL, &cma_size, NULL);
 
 	crash_base = ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
 	crash_size = ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
@@ -658,6 +658,13 @@ static void __init reserve_crashkernel(void)
 		crash_size >> 20, crash_base >> 20,
 		(unsigned long)memblock.memory.total_size >> 20);
 	os_info_crashkernel_add(crash_base, crash_size);
+
+	/*
+	 * A kdump kernel is handed the CMA ranges of the crashed kernel
+	 * instead of reserving its own.
+	 */
+	if (!oldmem_data.start)
+		reserve_crashkernel_cma(cma_size);
 #endif
 }
 
-- 
2.55.0

