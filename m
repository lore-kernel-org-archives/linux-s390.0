Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091D3DC4AB;
	Thu, 23 Jul 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807846; cv=none; b=HCebKX8Mav2J6xtntOzA4UZGTtd1km30xS3tU84t9lZkScZ8DKslV9hZxZhv9afaBlnuTmapXnX47L9TzJ6UlVfjyQOfUSbFtmOSR2VMQs5CJ4ArTkvCpQLIlbQEb/HRNvhGMPqruAagEUX8WZplLOJ7EXULvX8vHU9/KixZD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807846; c=relaxed/simple;
	bh=E2lYhaOZp9UunOTV3YbpFd3wifLqMr5WpHen4yfZzcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkvVnrG3Oz6GOxUvaR8tQrlc9lODks61JLudFZPxFC4gPKZZSntTOhkVWZxwIvWxMPleXvFyjhjaf/PqisMUOh+gbNEJ4XjaqBdzs42Tu2xazKtpsjHeeL7F7DLaAd1DSUyUPFjwSIKVK5iSHZZIht8/nXXa+1/eYmAbY+kqu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KchdxNS+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KchdxNS+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Buuf2586099;
	Thu, 23 Jul 2026 11:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3SCAOv
	M4+6tjkwbFq3Qog6u+62pDlraHEVtS0Sc+ZzI=; b=KchdxNS+1bUDXhEEn4c0ii
	eGsa7EXF2LeywmkqCvVpBFqQ1v3ySAr5t1c4Ln5gB83HUorX3wCktc/1yZLZR+MX
	o9xJdxQhNDxpteJLSB9d4KsAiI7yZyVcJkCSfI0TjVgDcEzTlIt8sUISXkr/M9wZ
	8DLaYxCYHsOjkNsjTCEVDY7ijgOCJ7I8QeaZ/+7DbDbIuXTiBASSat4/0jeYRodH
	3TUB90Adn3eBV+CJmXEebv8BBmYCy73YGEdnn+Xursh+yCe6XP0jbidwU3obptil
	01FRjiUqkHeQdyzgF5cg/phV67kCYR1nU/HjdL7+Nh61u33VSTQq5qkv9LUX3bGA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahepry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 11:57:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NBndjY020392;
	Thu, 23 Jul 2026 11:57:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahbwyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 11:57:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NBvJRn15008082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 11:57:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35F182004D;
	Thu, 23 Jul 2026 11:57:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A45F20043;
	Thu, 23 Jul 2026 11:57:19 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 11:57:18 +0000 (GMT)
Message-ID: <4219916e-4f28-44d2-80e1-b8422555d200@linux.ibm.com>
Date: Thu, 23 Jul 2026 13:57:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
To: sashiko-reviews@lists.linux.dev, Farhan Ali <alifm@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-7-alifm@linux.ibm.com>
 <20260722172651.848261F000E9@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722172651.848261F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hkbLzpCbLZF4D8PoPQGhteMqbTRQtZ3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExNSBTYWx0ZWRfX2yYlO1mii2Q2
 FZGfNy1obbhis9N1G1qeOL9k3+f6CboPPMZ6gbiwmi66TfSwABKM3V1IDV36QZO3m7JqtHpR5gh
 1ttA+Vdr7tZZjVFZI4vP313fGYxqZbWcgxluI09KSpP3K0718L2Ur3wLHQDZLA8bD5dhNigOFcc
 wkgi21KwaL4I3ZTngn/RM2IXKPqdJQy8ie5jB8SqI2Ut1aNuJr2/AalJdiYsDYmqMHZfVITRNVL
 gMH2keyDSbxCWb9WdsCXs3zywUiGEjJXj93UEpolDqqaFPBuVFKTjL9XLCOgvQ0v0eiGOWbFb9q
 nuXAKg6DZ3Pw3FOO22FgKDbNVZ6aWzuX7ww8bAny0isTxQy4Lb07SJLswNfqhxNOis5Bzc5SKQt
 sURjh/8j34NvfFRHrEegKCFdrJP4AhO3x3+5/KpHAekGSpOd7zsgFY3WGhE5Tby4ilXCIaspANb
 UQvWbTEsKCXb1ZdIX6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExNSBTYWx0ZWRfXwdhntdjbpiNB
 pM27d1ykWmIjMYfkYzmoQR1LDhaMxDNsDb2hm+8WoRry+7guC6VugFauKs6DzBuaAO45MSkAUxE
 Ivi2cHVW6CBrfJgQN480zgUw/BI+SpU=
X-Proofpoint-GUID: hkbLzpCbLZF4D8PoPQGhteMqbTRQtZ3q
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6201a4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=mSySj7CsLd0aOw3pIZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230115



Am 22.07.26 um 19:26 schrieb sashiko-bot@kernel.org:
> oes this size calculation artificially inflate the required AIBV memory space
> and falsely reject valid guest configurations?
> 
> If a guest places a 1-MSI vector AIBV near the end of a physical page, such
> as at page offset 4088, the size formula calculates at least 9 bytes (8
> bytes from BITS_TO_LONGS(1) plus 1 arbitrary byte).

Farhan, I think this is indeed a problem.
Would
-    size += (fib->fmt0.aibvo / 8) + 1;                                                                                                                                                │
+    size += (fib->fmt0.aibvo / 8);

be the correct solution? BITS_TO_LONGS already rounds up I think.
