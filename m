Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2624501B;
	Thu,  4 Sep 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970208; cv=none; b=PImgXGfIOjHJEECpBWrvpmPLajHEAIrZa5tvKd+W+Q4JyOntjF79HdsFpLVYIWe91HDwBd1kNJjUuLpwQRaPaIkGC+k9y0w3K4P4gXUSMJuyTftPQIV/MSg9bMghrfszAv3PXgjoPNTNBuvlaVIByhnr+rhXUBlTLeUmNk825NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970208; c=relaxed/simple;
	bh=1+RWVcDIIkiRod+TRNgoORvaOZSUBzh3FfCqknTDUbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5VAUejrhD5hXCln0apVIZs3QJrCItdsXMm010X3UzVLdhj363mVbSUC2EfydydvbXgyAblRCkXbKbDe7c1QSZPz0wOFRtBbEzUNt/AEccke/E4oQv5GV/I8DFIhJHpgN9fh9bfZUsxmdcqHaGTVc5oBpEWRu3Y1bLnGXIBDQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F94ROrFE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F94ROrFE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583I06Yt027831;
	Thu, 4 Sep 2025 07:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TS0UBg
	gYq9qgJNvx7S91o1QOtieKgQ4j9xHsjF1SE7w=; b=F94ROrFEux6ZiMlvOFpEgd
	C9VlT6QYPgM62Fpmj6JSPkwKhE3ohAPg+vh5SD6Zn7u23DqyNnnCXqHq8kpjFTFR
	/R0/o0mjJo+NFxa4qfvG6n47tqOBGk3SImILuqtbouJt2MUiZrcJDhs/Q232tP0A
	mdYWNQojPYEtDKs3FqaFCX6RYeOynxMKYtoJ7ZNeVH+znhPdvLqwYuUZj+0tLVqQ
	OzhhyTP9HKR/FXsGvmLguoGN1mVlGU67/b9gzePX9GFIob31jsgllg7XjjHMLXGj
	f9GlTcpBkph8tuv7Lf/zky7uBd0zdo9lqw4RSZ93PS7XGMwGuyXPAK5lNDmvqvhQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg09ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 07:16:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58478GfV013713;
	Thu, 4 Sep 2025 07:16:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usvg09rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 07:16:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5844Avck019404;
	Thu, 4 Sep 2025 07:16:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n35sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 07:16:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5847GRff51184024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 07:16:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB532004B;
	Thu,  4 Sep 2025 07:16:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438CC20043;
	Thu,  4 Sep 2025 07:16:27 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 07:16:27 +0000 (GMT)
Message-ID: <5177c2da-4158-4b12-996d-831ff1ab0708@linux.ibm.com>
Date: Thu, 4 Sep 2025 09:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] s390/ism: Log module load/unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250901145842.1718373-1-wintera@linux.ibm.com>
 <20250901145842.1718373-2-wintera@linux.ibm.com>
 <20250903164233.7b2750e8@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250903164233.7b2750e8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=behrUPPB c=1 sm=1 tr=0 ts=68b93cd0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=meDq6FdmJ0PmnKaK2a0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: E8rj7Yox8s0U02qs8xoMj_gE5Hoiks5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX9scUnzTkVyjc
 HKTTXbno/KVTwMyRgJovelqt5QWoUzUgzA4vVPsOcXAeYThh+TZI6ob0noFLrqU5s8nu/RIzrJ/
 SgeVlEj06oMhyzkec3zvCiYx4SnSDdY2ZaQ6WIRdDT4SumOg/2/lerpdmux1Ho/LcldgqZxmw0j
 9PLz916votBQSa25hBoiv39vSfewI5o3O7NpQUXTv3J6czN+36wuncAtr4/3ZPsXFGS9J9FM4A2
 T8PrAeJ47w9mv0Fonkl5/rVru/v8Nh0MmDizjU76BRgnSU4XMOGL1GF9EQlmzeSv/R9HiL3xtS2
 sdxMl+HHA9aDnCD4xlVU7CuDRMzwwors8rG0oAWwdyuFlfiKvAo6ItA0x7yozaHvQEZ+FY+grUl
 5iGGag15
X-Proofpoint-GUID: CROkHagpF6zv1arebXtvAW35Gh-l6g-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034



On 04.09.25 01:42, Jakub Kicinski wrote:
> On Mon,  1 Sep 2025 16:58:41 +0200 Alexandra Winter wrote:
>> Add log messages to visualize timeline of module loads and unloads.
> 
> How deeply do you care about this patch ? I understand the benefit when
> debugging "interface doesn't exist" issues with just logs at hand.
> OTOH seeing a litany of "hello" messages on every boot from built-in
> drivers, is rather annoying. Perhaps this being an s390 driver makes
> it a bit of a special case..

tl dr: I don't care very deeply

I think s390 users care a lot about debugability and are less concerned
about log size. As you said, many other modules (on s390) have these
'hello' messages, so I kind of expected the ism module to show up as well.
But if you want to reject it, we can live without it ;-)
