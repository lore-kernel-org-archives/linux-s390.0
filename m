Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B53DA7DF;
	Mon, 16 Mar 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686972; cv=none; b=so5N7Fa6zrGQBP3QemBxGk11RlymhP89i7Fj4Sdi5S4egD93Mu6utts9jQq73Uafs00xD1OENz+r0ef3kSMxcG5pZL2Dt5ET1PR4Tq58Y/5hWxBBBOhgzFOjSqFbeivAW68A4onfWY/VnIXPEVMq+5yLAptqz6Fab9vrs/S/qic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686972; c=relaxed/simple;
	bh=zJce4PuNdDkBUyInsA4DhVyn85zuHEZqhrIcb8o7zuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxDDJWCc8DKP4DuCyrKMdEBp2Os7uBoaWhDeJ7wb/ate2p4BJ5qdG/tZNMUHBFBgZpSK+2nV8IIjjw797vDvSkvdXDnCiE5Hkv8Z6ez6rpR5j97M2iyGW9Aay1jSSQQ48JjMfsRnZp90bMXAzQ15yPuYpu+6MvXVHqpmFnmMx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJR3wPiy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJR3wPiy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GHHH1H1474421;
	Mon, 16 Mar 2026 18:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D/Vi80
	p2nnOXwIuPZ8PriqddcgMy208romrWS6Yk1UA=; b=UJR3wPiy+IvPKsFmUlS1AO
	XZ8t/20xwfXoDLZ408nmNXD5Sld+QCLHOWCyuWjJrXs4QB39b6xXQDivwl8zaG4i
	ouGRjLkEgORhUxv2utlXFBViPgNKWU4GJLYNdi4OdyPa+XPd8zig6fv8wswu1p2f
	4n/lLA8ZHOoeVX/5+Z6wYfiMIjNaGeJ3trIZtCn1uP1jtoOesvV9EEqcCgEXEwXA
	hpOOb+KhUZs82p50GZ7irNS5K/0RrqjHjQFbVGm1W6UiaIiqDdvMjL6AiM4FSKJD
	SWD7gybhlbOCGou6NrHv7vz6xNEjlZ+vos5yi5KHIeHxYRE2CTvNIrPYAuYERnBA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hs4jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:49:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GGOcC7028465;
	Mon, 16 Mar 2026 18:49:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq15r1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:49:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GInPXY22020622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:49:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9A6A20043;
	Mon, 16 Mar 2026 18:49:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9236220040;
	Mon, 16 Mar 2026 18:49:25 +0000 (GMT)
Received: from [9.87.135.243] (unknown [9.87.135.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:49:25 +0000 (GMT)
Message-ID: <b80c31da-293c-429b-8828-4c72f4aafe77@linux.ibm.com>
Date: Mon, 16 Mar 2026 19:49:25 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/10] KVM: s390: Convert shifts to gpa_to_gfn()
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, akrowiak@linux.ibm.com
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-4-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260316180310.17765-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AitscEMC-dL_ljyxocTb23wKHX-D2uic
X-Proofpoint-ORIG-GUID: AitscEMC-dL_ljyxocTb23wKHX-D2uic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0OCBTYWx0ZWRfXy8XQyWGlb7Hk
 WL1f350lVVihRsMElszvsHMCjHj/8MvoyOHjESiZEQrdfDomTMZUb36+CMgwHIYs7D8Wss0QblW
 G4edEJWnv+5+iHNvCQI5QD6cWr3bROAwX/WlIxzK2ew5J0CoYlvgtFYnhDBoTGqB6c/55+c3eWB
 nAxAtYKFoPSsZ+uggx5hM+nLqFFwjLAozoscC7oFNAFNBq665cNHkh1PfTAiSfEP2Cczdt4+7Rz
 aq98QdFfs3N2UjxukAId9F11TI4xvjWaZgNq7H0JTRmviaNI6NaA6BvisxccQdgpwbo+jdHuRBm
 xIaSdBynb1Oju46HYa4Ge8EHmkpZsp1mFdLQ2/mkii3cQSRvhyXndcmv0o/HTw0iUKII0h8NjVG
 4ZtWua/E71ja7A1Sj76oQZEi5fIAuteQA3peBZQyuyS6vmlO8LfTInGyxJpehaVvlA393MX458t
 9O26oMf57NMC/4fKwtQ==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b850ba cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-yrtnzFoinabFxpHE94A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160148



Am 16.03.26 um 17:23 schrieb Janosch Frank:
> Not only do we get rid of the ugly shift but we have more chances to
> do static analysis type checking since gpa_to_gfn() returns gfn_t.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

