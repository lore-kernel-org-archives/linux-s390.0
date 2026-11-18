Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013250;
	b=rTsIAmgDF04F0lnzpWQCEBb691szyaue4AjJLi94N1YYQJEXtzlx2ASVoEWh8yJ3spMN
	 EVnBf2JQZpGELVsC5cFfdxv5WoQFAxxbVKqrfcjsj8GlKsoSN+D4nQCW/szif4WoZFh58
	 Tx/mrfP/tlcAzF/hShTXd8idF1HJKSU3oiYG49Z3Q1qqRWpU2noV3PtD+55GsRs2wDGm1
	 Cc5gsWZfr0TQwgfC5OBLrRjD0ZpE+Hkosu2y0VzATCowBEXyX/lB2Qyipb+uq0W0BHBmP
	 OnofEeWcrgZi1auybNIUwJlFMw9PUlx6cwxkyzW5uU2gDUSg56tmofkf8ZOCB5wzLEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oXrMOycDyjSvpedsSEiuBoE+L7cmFJvv4VimPZ/9uXI=;
	b=0GhaFG82j2T4fJFjBM9S826Ztd76dGUYmhxOWBBs+3u9bnch9tkN9pgvpXuoWfvzT82B
	 hsT8/JsdGn3JSNysg5vRzaDUb1T5H9+hRTo0b0JPzk8xA2w5w5CxqLRinKuTjR2Ri2X57
	 +TRgk2uSixUm3u4XawjTkwuF9XymsElU0CYmdLNFX1vWeYqF4VtP21PYajKYJYhRpD20b
	 VwYWD58Fi2LT0gL7zByP2VcdeDcaMhD45YcoODkDj7RT0u7EOIYPa1X1KcdgxeaPortUP
	 JTAPfT46U5qncYNmqLiiUcuO5u13K9HawLCzGte3sznnfJ+XzuFPMoPawUxxAmWnxDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EW42BV2S;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC961606A330;
	Wed, 18 Nov 2026 14:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC961606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EW42BV2S
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQxK91196576;
	Wed, 18 Nov 2026 14:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oXrMOycDyjSvpedsS
	EiuBoE+L7cmFJvv4VimPZ/9uXI=; b=EW42BV2S6cS8Mp6+IhgMH3SM/Vl1sN3eq
	zh3avk4euCGYxH5zK8VZaRtXd4iPGJ8+6mJk1A1iwhGuaPrU8SyDle6xqmUUsNEa
	o08HeLJttOxg0LiO0QSFPNpNkmuXG1imVQegdK5kfvP31c0jXXY9gKcMrvr4hvX3
	ocfb4Pb7HMJ+OQOiLSN4do6lDeqXNsNwbdYtCTplgQMzclP4GAp+LA71wPaszlhM
	u3vaqAZ1EjJcbvMMVcLGpjWf1QJkyouGaidV1hAdxb66P31vQfFKePAeVsIso1jX
	XxTBPSYRHThdH23LkWj0nZmelZPcFrzoeTVygfv7NHoCfYREbsPLQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wtuxa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYuhm3180127;
	Wed, 18 Nov 2026 14:47:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jugh78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElAEP50659736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5500D20040;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B8122004B;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/8] s390/kfence: Add error handling to arch_kfence_init_pool()
Date: Wed, 18 Nov 2026 15:47:02 +0100
Message-ID: <20261118144709.202520-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: o86HIJMcbVF3yHCbYdMC39VzIKrIVYpS
X-Proofpoint-GUID: o86HIJMcbVF3yHCbYdMC39VzIKrIVYpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX9NasAB48rS0z
 4bz5hiugPi6RUY7sGjLcOPbSPdv8uPHN+01zjOzC/lxvmnzU3rjeGeK5b48c4eYvjjsAU5wAUd8
 KpD2jZ7+v86VxdD501ySC0hfWI21OU1KL2hxt22kHRCbdfYPQIRhgEPiUblEjI1/POEG4jwect9
 ST522VA8S1fMr0vHUYC7HZDr1GCDAsrJUUumeaZyr231J9gLir8+vQ01WxR9YPO6z0OF0clIhut
 3QwPBUgmKkhUXe0CK6PPwW+tA5kvNX3OLN8vqPwvqop3I0zm7Yoim3OfJpH0tixgJbXCrE44/Hl
 egYYmfUWPN+nVwbnUt9Nia2vpahTHajnGgS5BirAtc6AZIA0b+OZIgyXP7o6t3I2K2e/27aNHxQ
 Np3KlY8szk6HwwH9rD4s+aKyEOqVyDtJO3DOlCWMlCDYqytu+jq28EmUNY+cXlTkccvqj9qGSGE
 5oU3gob+hVgsRkVJRcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX+AY2pza9sSEK
 qeFd995AP23oH/o4P4rJQnZhv4nbqk9ejPZSVsyzvZ3LguD3tORsfuSgkTWPXEWs/IEHfZODBSb
 7kPNl8w1VY9+DUFXTi6qa2FTmCbyCKo=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afdba72 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1FhY79ASw4npVgIHW9cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180057

If set_memory_4k() fails, return false from arch_kfence_init_pool()
instead of silently ignoring.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/kfence.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
index e95e35eb8a3f..414c235a91b8 100644
--- a/arch/s390/include/asm/kfence.h
+++ b/arch/s390/include/asm/kfence.h
@@ -15,7 +15,8 @@ static __always_inline bool arch_kfence_init_pool(void)
 #ifdef CONFIG_KFENCE
 	unsigned long pool_pages = KFENCE_POOL_SIZE >> PAGE_SHIFT;
 
-	set_memory_4k((unsigned long)__kfence_pool, pool_pages);
+	if (set_memory_4k((unsigned long)__kfence_pool, pool_pages))
+		return false;
 #endif
 	return true;
 }
-- 
2.56.1

