Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA0284B48
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420894; cv=none; b=tOL+WrrobO2HQsJ27CXx5pcXgmkLCwDZdypX+t5Gkl63zFiut4Ed2J+L1IiCW3yQ15rk5t6YzVrTWUWa6p+ICQVE5lh0B/UbGDIVMlBsp3Btj7cggb2flYT0dAKV50gPzcRoegTgGe7EfxjduZtrpVZATaIvCYxpHhQr7t9uxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420894; c=relaxed/simple;
	bh=fFeBY9pBnkT7MGCvbvBBxJthw3qMYSJ8wJ3nHJc/XB8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qe0lkYIJqi3pvsbGdZ7D++kPvOTjpjTny9YU9gCgABEw//0DjJkr0zyRSNPdFGN4ooK9fpPMfBnLh8mmHxDbtw3QALSvE/3QsWZ4jeKMyUM9SG5d6sgCpkl28FigiT/n9TcYFN/pet1Sb16BXjCWsb114cxrHmBdBQLCW7EJGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UWDnuF67; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UWDnuF67"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAemce010703;
	Wed, 23 Apr 2025 15:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=EFUQNNmN4HpSlLllvW1O5fULyYsGw8w4nzE4Q9vEXVg=; b=UWDnuF67d5mh
	21DPyUj4IJr+x8xhkB7WXh+g+ZT/FCpY/LAfPrU0FhWhJ3WFe02zBsPCGJOmGE4y
	sQdqT84Tc4pXpRrGmlBPYSTRFARxwmrDHil/G7tvlj7LpWOgs59btQcLMz7fyEOX
	nwH9pwsIxxoLvpKpZBWtMf/53zmt026aCXn3p1eCEF1jx+c3DVSP19miS4WFLRTd
	ql3/YFWRX7Ikn8URRKDO9196yxGPp80UXZu9SDNjwXoy2rc9ynOVojXiZFrYTMwE
	WXtH+Y9FbCRif2YYBI044YxW2EZzBhpdijT2UuAN0CkZWDBT91BU+XZdzbAT+4NZ
	W3SJ6lEijA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466xns17dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 15:08:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEnRZc001287;
	Wed, 23 Apr 2025 15:07:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxujm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 15:07:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NF7qBK30081782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 15:07:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C33C558056;
	Wed, 23 Apr 2025 15:07:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B2AB5803F;
	Wed, 23 Apr 2025 15:07:52 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 15:07:52 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 17:07:52 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: dengler@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v7 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20250423104045.8056D38-hca@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
 <20250423104045.8056D38-hca@linux.ibm.com>
Message-ID: <774884ded8d56683d65e5978fbea1dc7@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KplN2XWN c=1 sm=1 tr=0 ts=68090256 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=8ViiqDr-fcFqPJyek-QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwNiBTYWx0ZWRfX7nicDITYbybu F1IROALegKvZea3tuwBUPtVfwRK5vK9iSjJbdYKzivPlfQoIEJjucSliQkMKoBy8BnrFXmxDYU7 45k+FeL2NInly3fY96xH/rTUf1J16Y1eKWLvKCIS+fpacBZzMEGDbCgYl2vi3K0teAVIweV1PfY
 OtlkRGHng/o0Dl2NQ9VtqSErnn4ltURutBdw1w9f+vDCdismIsaG6PgSS+S028II7U7ZkCe0UKn VAqLTJnFADyNI5MOiijjw0OJqL6f4aR1vs8XNyH0Ve95KyUf87865PU9U4YMCQqNuKxWYBs6giF UniCE2R5eQZ0EuqsVvDBoJ0xxLh4DHzv7evMB9DRwUUuyMvOasQa4YK1H1pYSQmkEQJfcEbk9Qk
 Hp3iS0aDqrGYQt/VMWnlUWVaxVG+f0l0L2fXUFInAZLV2t+NHR4Ywjlwzwo0WP3XCKPJRbcW
X-Proofpoint-ORIG-GUID: Q4-taeLUkoNdWqO4NpKWHOBjJg-WMTJR
X-Proofpoint-GUID: Q4-taeLUkoNdWqO4NpKWHOBjJg-WMTJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_09,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=979 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230106

On 2025-04-23 12:40, Heiko Carstens wrote:
> Hi Harald,
> 
> On Wed, Apr 23, 2025 at 12:15:09PM +0200, Harald Freudenberger wrote:
>> The patch series starts bottom (AP bus) and goes up the call
>> chain (PKEY). At any time in the patch stack it should compile.
>> For easier review I tried to have one logic code change by
>> each patch and thus keep the patches "small". For the upstream
>> version I intend to fold them together into only a few commits.
> 
> What about the statement about "only a few commits"? I asked the same 
> question
> also for the previous series, but didn't get an answer, instead v7 
> appeared.

I talked with Holger about this last week and he thinks this should
go as is - so everybody can see how this patch series is constructed.
You know when in 10 years someone wants to know the details ... :-)
