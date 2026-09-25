Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE79478E57;
	Fri, 25 Sep 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331107; cv=none; b=en8ajpxQPKI+HYCjFKf0qGQbuk5kmPJSKpmMVCZcLkk/juOC/l9cOQ0hitP5/uo97vd/kJ34PnSjvReGvilvWOqnlePSq2uEhbfzLF03xyfRU+giKeQN9X4E+Lj6YbvL5b5/Ea42zyf4jdAp+wCa9SZ6YvW87g2uQSC0bezFbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331107; c=relaxed/simple;
	bh=iB7NCgqwaTX/yw2yl8Vy2ZIHDibfj7S5i9/LYG9j/UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYZ6Kkyroy2b7l4FYw/uRYS+2+JdJnVVaGtgpxPV5x/J+9Sz8aAlAeci+da4+Y1fIT5T9/nSiynosb43WeruSI9Qyv50zpK/V6lMS4yVzl6qSl8339Si1ZGySeA+9Czy0n2zkmXIu5xzjwb3IjS9rV4m5LXu+wCobyj2PeC4jMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bG0nU4TY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bG0nU4TY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aXVt102845;
	Fri, 25 Sep 2026 10:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N55JED
	qJa1TqYQpogc6rhq/qUggInOxax3YJay3sC8Q=; b=bG0nU4TYEGzzwHoy697e88
	F8UGf+wCYpG8Y1EUx6+WvL49+rRFOs/b0U1r7Pug8DVL21XaZhKsLZEzBGvMs7uP
	DtyQXG+O2cF+DhxZsPcvQ9oZER/VVpBQB7dkGDBjRtXiBWtcMVl+tH7SWrT5SWtP
	VY92Wnvkvjv5GLR8HWy0hpXyrv0fBNc6AEGb30Y63XbOXyYaELYZbHb2007pz/Ji
	eJXLdolj8g5e6+eWG3SUfe2ZD2RmZpYj4Ls4RcgZwDhnamaq87EBiPXmTgH4hn/p
	hcgTIdXWMCtHIsSycWSy5nl2tx9nvIStgyr1I4/UdzEnwt1fqAzc8lEicyCnZt2Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvnfat-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:11:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA1Anw1960465;
	Fri, 25 Sep 2026 10:11:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ee6f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 10:11:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PABemT56230150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 10:11:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 382B720040;
	Fri, 25 Sep 2026 10:11:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7702004B;
	Fri, 25 Sep 2026 10:11:39 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 10:11:39 +0000 (GMT)
Message-ID: <7d80b6c3-ff7e-4be7-8bee-899fe08c98a7@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:11:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] KVM: s390: Kick PV cpus at the right time for
 service irqs
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-3-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260820121546.24694-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jd7iW_rRxkUAmkyQG4iAK9LHm_3I4Ux8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfX/ij4Ezctj1d7
 6aZRTbjV/XFP6fABSimGrLgK9PUo0hj7kRFlbvdr1/vaAeEJgqaw90yIwmNOAjntAmhcBaD8d3R
 SE0fSzOy3s/zSBaBnnF50RgLMTkq9Ac=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab648e0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=W3Q_srcwFkJ-giImEy0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jd7iW_rRxkUAmkyQG4iAK9LHm_3I4Ux8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfX7o886gqB+0gX
 tkI/7t+WqtkvD7w8yq0suDd0B5NifYwsHyxNND09e6fhKcBe6KGPouz2nsKe+pSqEdE5ZA7BS4V
 lydB/mlkDWG2uiXkyRfNXG4d9Om52JPxMQv3qAOOQQd/0sdbc6z4C7zqSN3NGy1qUb4PmD6/hSu
 /EjrZ4dYTQW2Qu0TG246GbEfqUU7JEBfLlIWNhbhC2JzNvb9uogjVnrSjzmVKjbO91+ZhT0+nuR
 r3Uk5oKRZD4XXccFF/dnWwumDKH0KIZswiHK0fipPUP/6MxON+LWm3LZ4Q7HBwmx96cwrTw7ts5
 p5VjwWPvC/22LijhW7vyBMjV3CQG/sV9vHqw81XheipeEkuXN01TedrysyZGOHJoyxjj2UE1vkS
 YFKRxR3YzUS+nfVM5QY8XZJvl6K0+64jdNuEvxNzcw/qchOGaywav4hpu9F7PHmucWum+UAU1v4
 GpbYxlQb5snHFDDiEFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250040



Am 20.08.26 um 14:12 schrieb Janosch Frank:

> +void kvm_s390_pv_sclp_kick(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * The cpu that called sclp likely will also take the IRQ, no
> +	 * need to kick anyone.
> +	 */
> +	if (likely(deliverable_irqs(vcpu) & BIT(IRQ_PEND_EXT_SERVICE)))
> +		return;

Get rid of likely please (unless you have verified this).

IIRC, the Linux kernel calls servc with interrupts disabled in most places.

