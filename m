Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506F385D8F
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037180; cv=none; b=dg6sC2Suh95Z2KZ8aPke7/INfzkR6yGuddu9BEqTtN0mr9wVnbN/io6HhILNzAE+nGF7WEmuixBVZZAE5wzCqbgYLcyhIdUsUmU/ZnYNo7iScc/eUdh+aVSzo4cKJmQM+xL6JzPL/pQSUe3SmZORuKyAKa5aksdx7/kdpnnSfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037180; c=relaxed/simple;
	bh=BDP4j0pk3O7cHQozemC1rz7ItHCbt0t91sAVOoSq6qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJ3238Oii4KS3lq7KoEfnDhInbF8zFJBGULEZobI+Afn87HfsTuw/OggmD3WP2Kjw3RM+WP/52PsYr2hWMNximUr/zFsWvmYBJA8Izbo/P7OYFqbRyQ8PKC0gZHT86Kk1Sx8avvdeJs2XAZt8SMmX4R4iGR8EH9aIKmw4ZPyi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tStjrKf5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tStjrKf5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HHi7V3290607
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 17:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RUej/N
	fxugrtkb/LaU829aahTIWhLGzmrGGp9liN/Y0=; b=tStjrKf5a/IZOf2OCcMXyc
	R5k1LDRCdW8+xsKpQJ1EfF5jn+nP7OHSow5f6BK94SSONHOSX9Qb6G7Igcw9s7q0
	HhJEszzdfw0mVMPqDDg7u5XSnB+qQtXZPRD8FKzIMy+RfpvDTQqFeecxDg7nLVOd
	gyB+7ZLHBFQmTSObTCOurdiG35vlQa+WnoADkisO+ak1KQgu6x/e2ys9z18XLjyl
	jD5Q9a+mHibmKGCBKrfpewz39KuvVFA8Kan0IOMQynCXmnLyf2FEMMVXv/FkuBsn
	fyXJrsfA6b6GLv+5UxkP1kijCu6/oe2nBCjsHg15TMT4onm8+2r3Deo3ucGJm0SA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59khe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 17:26:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HBEQn023316
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 17:26:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyuyge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 17:26:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HQGOM27722278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:26:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC4375805C;
	Thu,  6 Aug 2026 17:26:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 469B45805A;
	Thu,  6 Aug 2026 17:26:15 +0000 (GMT)
Received: from [9.61.13.162] (unknown [9.61.13.162])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:26:15 +0000 (GMT)
Message-ID: <28b6cd3d-6e28-4f76-bbf6-ed47d26c912b@linux.ibm.com>
Date: Thu, 6 Aug 2026 13:26:14 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
To: Heiko Carstens <hca@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
 <20260806155223.BD6B21F00A3A@smtp.kernel.org>
 <20260806160247.15764F95-hca@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260806160247.15764F95-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX2bywtTL1Imav
 l9+tGsQ5vDNLjr6ZHzY1cWpK4TuL640OIMEMZfzLFqnCPw1uOeV+gTqe+XXJtz2X3ILMLviIn2I
 yCxRTPMbgHTl0QfO/BcnXa0oIEmISl8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX7fDDZdkQp8Pd
 XcUALVI8zR4J5Qyym5TEr33IHfl4CbGVDsSapoK+ZIayG1uS6L4lIdE8Uy5k1hqjUGGwRTzUtim
 6oW/3VBrkfI6MNUf/2CzpoSfin5/7uQKCk7nWWOxSybD6ZwUZVAeobEj24zkRUWfz2AuV071BWO
 3dUhrhF9gYEO7PaGhchzyWZyhYapcbAV9xNzJBnruVOIsVI2EyAjYxLJYzVksDG+tIXsbfbksEI
 +psayfUPQJjZh1EE9JUuVC3cwh/wqQsH1fYz4oj3P8STY9Hj0MlEp1ElYa+vO4APFHSE1+KqiCF
 fTGJLZUYxcGWZFAUsX1OxBegMHtPbMRE8yLnAqeFspmS90mciK2MPL79LdrSOinmVSS45nXHht+
 OOwpwoacrKTAetRx7qL6G5AYZ3o+hyp4OXnI0jlvxpipI14d3Qk0LCXn/MMdnmC2iUXeslpV5OI
 WSTRVOJPomyf22D2eyA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74c3b9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mTY-g6cdDfdv2rJ3GP4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JcF2vl6cQHNTPQCY62rO2fsUy0piRuUi
X-Proofpoint-GUID: JcF2vl6cQHNTPQCY62rO2fsUy0piRuUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060135

On 8/6/26 12:02 PM, Heiko Carstens wrote:
> Eric, Matthew,
> 
> not sure if you are aware of the below (nothing I would address). Please handle :)
> 

Thanks.  At least some of these are handled by fixes in the following
kvm PR which hasn't landed in master yet:

https://lore.kernel.org/linux-s390/20260803160924.236807-1-imbrenda@linux.ibm.com/

But anyway: ACK - will check w/ Eric, if any of these aren't already
addressed we will follow up on them independent of this series.

Thanks,
Matt
