Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FF3C1D79
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832097; cv=none; b=GX52A3KJe88Ezxt9Di3GaHQhWxBqkjIuX+JSbddi9hpRlURc97agXCLsjY7kjPcCSv60RLgcYZxtnebdPPiWR6hEIaSHD6vor/c43eodmRTPqZPkGNdx/sn97OxtlQWjAvnPec8OICs71pd+VyR7ZgODssVeXlF6/bUnFu5lwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832097; c=relaxed/simple;
	bh=Mb/DqJ8uWmH3II5u5lWb/B7k9f9rD3ewntbeUclFQRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvWdxBA/kCmNj+9M/98qh48zGBs8ujtJRDghAKUzQo/iOAxZ3SGYOT92Qnk6AnCSV6BsmHbfSplMMbAXKQoEITX8h0Pz6oHPEwjLIUm47aBs+0n1LvTqNKO5IwUGkhULepGqDEcroRkqXILdOqWHPY+aT+1tNQtYbFk9K6ZqiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=APydl+CY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="APydl+CY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9Veq12663128
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/QOQBbXtpW4rHMsHt5WIt6gflS7qHR
	llxfj3UVIfRoY=; b=APydl+CYEpe+brSaeBDkjmMiNdXTStvFzZy2zqljqQJw3V
	5ar6wmN8Cn3HzjFTrT1wEXnDcigpvdUlzjIbNa6XFxe1S43KRpzNCgOlLQNT4Odn
	GONAMrvRgExOn+D35J+IMLPqZ4dIIc7sZ6WkVKqcclkumMdhuahn3OfXOdQRIepf
	qMr/purYAXWxyBW7/sE2KefA0vOV7QXGBET13UsLcfhkaQS1fNHvAWOBckALInZV
	lsPoBaAeOzL4GnsV6GGAtYEIwQCBgHXdliOy8BqPIzkgr6pNurqN8gLyJG9dMfuG
	P1jfwi7xF7PFiQ2F5YTdm8u+ud8Gx2VLI+iDKiVA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxmsae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RBuHQK021262
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qg3ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RC1TOH44105990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 12:01:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E51A2004D;
	Thu, 27 Aug 2026 12:01:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1492020043;
	Thu, 27 Aug 2026 12:01:29 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 12:01:29 +0000 (GMT)
Date: Thu, 27 Aug 2026 14:01:28 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 1/3] s390/boot: Fix physical memory search range
Message-ID: <p01-03.g46f7a6bfbc01.ttkffvj@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-03.ttkffvj@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfX5F1GcoqE3vuS
 CJCDfkjF3YUt7IQTumLfuQ59IgCEbQpHVYqkEIxLIG2rqyYBbQeBO/HtLuDZpKiprIglw0CQZV2
 wBWmz+H1asf0KM4y3Uzkcg5rgCthMQk=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a90271e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=xNJPMDAvBXazk1WopQsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OgGRBvN-IIW2PXw9fKA8a4sdzBnnGGrU
X-Proofpoint-GUID: OgGRBvN-IIW2PXw9fKA8a4sdzBnnGGrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfXy9zXba1C2oWy
 OWwTHfnE6/FvvyzCZx6Fj5JcraHXewpF6KWtVgwX/bNjeVMa56clkGPZakpva1wwWQjeKRiVKGO
 TzBnMuyAgaDXaIkoLdcvkBY+t94E98lUPwJlCWHaV0KB1+sQ+3LqYPv6i+21w/BgcU1FujUZEz1
 JiUr42lCQHkM06T3zjNeAC9foUfRihGUKqj57p/6Wz3KJw4DCKB5A8VC0DryvhTY1cfO2lthjm0
 yjs8mIOnk5v6fPYlaq9nWqiy94JAR70h4AeKX+8INFHyQAv+BnG14asisYmqD40OSe8LVp9ZQl8
 UwK5FTru4i/nzjMg/NQiyWSIO0jxmFo8/t7UtBK3zFYI5xJTiTeV7bNszIWx1G54u6r4pHBzJLo
 rv9Cjoim1AWPKAwK3gFybV1InGI5FzdBwrmRWf9OPKrR2mS+xuUrBIbzLIaW5ZJT3QFsdNjyjGo
 LFvSoRF6oCGF+hMI+ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270100

search_mem_end() calculates the number of 1MB blocks with a signed int
literal. CONFIG_MAX_PHYSMEM_BITS values of 51 and above either overflow
the signed int or shift beyond its width. This produces an invalid search
range when the binary-search memory detection fallback is used.

Use an unsigned long literal so the full supported physical address range
is represented.

Fixes: 4d14c2666b6b ("s390/mem_detect: replace tprot loop with binary search")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/physmem_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/physmem_info.c b/arch/s390/boot/physmem_info.c
index 1f2ca5435838..0ebb2174713f 100644
--- a/arch/s390/boot/physmem_info.c
+++ b/arch/s390/boot/physmem_info.c
@@ -141,7 +141,7 @@ static int tprot(unsigned long addr)
 
 static unsigned long search_mem_end(void)
 {
-	unsigned long range = 1 << (MAX_PHYSMEM_BITS - 20); /* in 1MB blocks */
+	unsigned long range = 1UL << (MAX_PHYSMEM_BITS - 20); /* in 1MB blocks */
 	unsigned long offset = 0;
 	unsigned long pivot;
 
-- 
2.53.0

