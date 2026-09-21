Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769C49362E
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988323; cv=none; b=DgN70OIsP45WDisCr7wqqgb3kxl8EiYFw3It6alX5y6gHZ9uZavDWRcxrOXCR/aq87UUQXB98hd0dvzmfvaSQW2UEz3e00c6/wBHxnTwnuRiJTIQbZaxRYCW1cvIYg324qmkv3oz+z/hyEvlUMB+BBAnJUckU+ykCHoyM1I+BnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988323; c=relaxed/simple;
	bh=aQZ2j2QPlQss4+ZXHrPoGGKBeiI2TLkdHGPXbqLatRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufJGiMgtLndBZdKDyhUDlttj2jGcaK+8ecQHnayNXtll4WDDurFBaopEoLyv8LrprXqJKvQc9SEAu4L6xHfGa5Bqt8jfj0RM/prOuDF5RLY4gz3hIK2FaxXtREmo/qg7aUiyPuN6O/M8YjDN2+bM5pWF6WCJfeQCwLaygkqU7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=om67bOzQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="om67bOzQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZO5E818866
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 10:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MAjueH
	3+KjfihNT+xsFE74KYm2p6n22DhzJX9LQbgUw=; b=om67bOzQN9nEkaCnsPb+qe
	LzKcEpX98ZP+/tgIi8dz2YcL+TlHce67qei0kL3q8D3SmIMDMbS8epEtfxSHa9RZ
	SNHw564U7uzbNC8Iy1ExVrStPThSXlT9/pDrDzqx0OsvM/JCa8Kl3snHJKrSAal3
	BORWFtW6f0HjxcorxAiTZ8JpFurkEqtq7hc4gOMYFeBfJwCv/eLS0jlUIHa+eoX1
	q/nMkq4vmj0R4cSXT90iYg8ZO5Xj/n7u9JNBmJqq0/zFNbwKy39xCK+6L/e/4Lmf
	+BbcYUdAco1OxqNMkcPTGfQkuGmQeqQKQgdDTbE4sHvFDGBta0P4St3ScoRbwvog
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg283e6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 10:58:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlkPl1072449
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 10:58:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjmwgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 10:58:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LAvtl314484090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 10:57:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E702958055;
	Mon, 21 Sep 2026 10:58:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6BC35803F;
	Mon, 21 Sep 2026 10:58:37 +0000 (GMT)
Received: from [9.111.128.252] (unknown [9.111.128.252])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 10:58:37 +0000 (GMT)
Message-ID: <2701aca4-eef8-4f61-bb29-fe032b960c04@linux.ibm.com>
Date: Mon, 21 Sep 2026 12:58:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cmf: Fix virtual vs physical address confusion
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260918161207.1756809-1-oberpar@linux.ibm.com>
 <20260920161513.18515A31-hca@linux.ibm.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260920161513.18515A31-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1gQUfyyobLqU70IkiRkPHXLjcxIBS88n
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab10de1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=AVkzcaN9OSW0zxLk4y0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1MyBTYWx0ZWRfX+I9Qk6ls7m5+
 hBaVmhCNrGpEGEoTQmO6nRZLWrEexJ0U3+fYBf2K92B2P5/ivJZi8RycGY1UrR45fTyolDpK4Nb
 dxxRM4SnzoGznPWPyApZCa2CmLyuLn3Nf94r8dHjGsvNL/U3natWpv5ziJ3MqqXrBucPjEu48lR
 oNtCcvwKD56CGRXiCU1XMOY6U/qKxQvrpCi1uh2Cuzfkm0Cavdy8LpJPwUJPPtERXH8qEefIoWY
 qe44DiBWDJSLRy5PudYRHUifWd3JUznF6awJJHM2nQDqbDJON/2PubWTNFZ8EaOscNgdx6zdEkK
 V5hBnYlR07YitFR0szMY0g2GZub95sMS9NkU/zBWgwwm6cIJbXIIhRRimCAQMbgwdJ4gH8W9UHm
 vUX6KVhowcOwuBpG0+3e3ociFeUvDmUILVl+6of2qgnSAm03VXkDRCVGMVuTgrxyl4afycfYbRD
 gRt/834s6NM6H454mxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1MyBTYWx0ZWRfX8l1+Czi+JGbo
 CRVlnh0IMF2hjSvzy9e9hqEYvueueCrsmcx0TveX2tOo7P2thfy/QSoiFecRIuaOK0Rtkkt0bsf
 s0QeXOACytt9usezqxIgkkeSPbl/8EI=
X-Proofpoint-GUID: 1gQUfyyobLqU70IkiRkPHXLjcxIBS88n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210153

On 20.09.2026 18:15, Heiko Carstens wrote:
> On Fri, Sep 18, 2026 at 06:12:07PM +0200, Peter Oberparleiter wrote:
>> The measurement block address is an absolute address; therefore add a
>> missing virt_to_phys() translation.
>>
>> Without this fix, a wrong address will be used by firmware when storing
>> extended format channel measurement data on kernels built with
>> CONFIG_RANDOMIZE_IDENTITY_BASE=y.
>>
>> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>> ---
>>  drivers/s390/cio/cmf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
>> index 92ab3d546fe4..5f57a12762d2 100644
>> --- a/drivers/s390/cio/cmf.c
>> +++ b/drivers/s390/cio/cmf.c
>> @@ -183,7 +183,7 @@ static int set_schib(struct ccw_device *cdev, u32 mme, int mbfc,
>>  	sch->config.mbfc = mbfc;
>>  	/* address can be either a block address or a block index */
>>  	if (mbfc)
>> -		sch->config.mba = address;
>> +		sch->config.mba = address ? virt_to_phys((void *)address) : 0;
> 
> Would it make sense to change the type of the mba member in struct
> schib_config and struct schib to dma64_t, and use virt_to_dma64()
> instead of virt_to_phys() here?
> 
> That would add sparse type checking and would catch similar future bugs.

Sounds good - I'll prepare a v2.


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
