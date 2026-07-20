Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779A39D6F6;
	Mon, 20 Jul 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542548; cv=none; b=podkaDmIm/w3JLrcDY1zJC/5DXb6kuzD1bFx9S0G5y9PN50HcSFcPqhp9P+GctaaiBdPoh9L1OOK3intYSTvaR9wBEDOQYdRaYpAA1VrDo33+0/uIjVlfyzULYc6mglKJZTdAJxm+FRNcfSnczQTnz4x6PHdPzKQoR7X5KE829g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542548; c=relaxed/simple;
	bh=FOR3fURDQm1BcVcm8+tUVq7vXgXXHKqQk3Hv+OxkweM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NONNPw7lPci+RCMT5xxPfa/NMIlvNQCUe6Bk9awkhjps0sCEajjHEGFO5cBhiKmq2ulVHZBNGiU2XM+Obh9fjQu0y6r85e1+oiBIeshaJqHBGw1C7PT0etoLfgLOGSPGsREXErq8WgmseIam1JesYBlifXhW86LwcndvWoBHpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KN4nJmiB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KN4nJmiB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABhDc1811423;
	Mon, 20 Jul 2026 10:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=P8Wk84sfd5H7jsvmD6XPqovjna3hYT
	KPTFm6vChX/kU=; b=KN4nJmiBcClyS+kqYAxGdtnZZ8PpGFunQLXh0HnlNJYx+H
	uU5ENveMpl01/6cNz5I123ndWTvptmQTxj8RTF/cXFQkHUHGzkk2KGWIcjCGqJVs
	+sAXC3ARwGZZtIXt69rOC7NZXCwPiYpHGCCJZ7OOOdqxauZy+FYbs8OCYwYxxNJp
	aswIMCu1uLsHTNPSh2X+nQmw4NmSdtfyN4p5HIVchjx5lUeqCveZNMF6SXpLFOrL
	mJQCqU/kFahJNNR70tprXwiYGxss/Nb4xhZS+CdhCcsxyLIdomoct1Gp/bJb9CcD
	Hd7oR9qriUxTbgvrO/dmM4k6TS7QOKAHSwCNP7Fg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxnjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:15:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KA54CB028241;
	Mon, 20 Jul 2026 10:15:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjn4cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:15:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAFZWj53608902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:15:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE072004B;
	Mon, 20 Jul 2026 10:15:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C3820063;
	Mon, 20 Jul 2026 10:15:35 +0000 (GMT)
Received: from osiris (unknown [9.87.157.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 10:15:35 +0000 (GMT)
Date: Mon, 20 Jul 2026 12:15:33 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
Message-ID: <20260720101533.15865C3b-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-2-hca@linux.ibm.com>
 <30f0084c-5621-4602-8c0a-9082dd9d3d43@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f0084c-5621-4602-8c0a-9082dd9d3d43@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfX4TgDLhUa9KDZ
 auZM4WLyporLjdHZDifQwKZPl/93WfFS7LaDRv6vrbtNxb3OCjLRgbzWFnbr78oW4cGk7JR4o+g
 BlawMs4+VuekZJgTtG9kfqsPKipDut3f5+jlJE0ok9MII3SpYlF7L+ZoxBFCzkFvS5VyieX1wW2
 pUaavtOD/Z/XuG5HKNeDsOP3DI0aseGd6wilmC8rHVzrXL0Tr1ppfq1wVJKgKQMzIbr7u57nTWT
 VzLDw0HpPl4igTOY0x85eji8n6Tc3gRsBrLFuTZrttHvOYFzxVmUh0hKPemFukl0I8isPVTDHO+
 wuDovA068YMEafDIkKWzLo9Cu7yjaBGwPxAzmdaZ0ROb+FmPQIFcHU7YV8ott08pmh0RQJOj78a
 aQY3xrbiIFSzHq1TO4GswKN/nvpXrXehe1ZD3NVh85gmEaeB9M1kOD3esmjSXd0wOqxksTWDHfi
 8TdI42T7JfuSCex00Zw==
X-Proofpoint-GUID: U4bxxssA6o3ct017RiUZdhEKADZuiHJB
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5df54c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=qyst4x9ylzAMb049V6wA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExNCBTYWx0ZWRfXz4YUXoUCm46N
 NmHPnQOMkhkPp/SfeHh4UmEf2fWw3EiJXikmKSDy6eROWt0+NxpH0tXB7Ith5msQE+T2/gTBRmU
 SjCxe6ch7HeABHixPBeF1dCkuSQ7DOA=
X-Proofpoint-ORIG-GUID: U4bxxssA6o3ct017RiUZdhEKADZuiHJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200114

On Mon, Jul 20, 2026 at 11:56:36AM +0200, Christian Borntraeger wrote:
> [..]> +static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
> > +{
> > +	pte_t pte = ptep_get(ptep);
> > +
> > +	if (!pte_present(pte))
> > +		return 0;
> I guess we do not need it today, but it certainly does not hurt?

It is not needed, just a sanity check.
