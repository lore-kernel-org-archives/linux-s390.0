Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFD45DF42;
	Thu, 23 Jul 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811371; cv=none; b=G26pP4/Mc/5GQWVbn5sVAF/L7nTKVwWAWrfw1hoyjXrtofhrFyfb+QI85DzrvbYgkhnrc/Y+DuYeyM8l4yuyUxAt/T9/vGmx0rQNY+vWVM2QcZ/b3bofWHg0rSgzngwWdL6ufzMrKIS0jP+gRcCZvBCL8Fck9oyiYktCiu1e9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811371; c=relaxed/simple;
	bh=bPNgILWcVVm5+M5LyfGoYM2GAfHnz6TIHvqUd9tdJko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf8oH+u1xGbmXKT5HwjLDnXd/bJBmpKP9CFtrq+TzjX+F9iCtPczfy5LDv9CfsHzRd8W/0p5ZAD495sfqnr0/4pP2CYnIlrlvM797E54+55ENJzWvDGXfWIkY2rFKz1rCobU7EeOPmUJWTZpW1Jcg+oF6DV4dnzmAsz8KZr+8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gtRLWC0V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gtRLWC0V"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BnLV2593650;
	Thu, 23 Jul 2026 12:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aABlAU
	6AgKvr71w/yfvj1unG9U7ehx/fcV3KPThj+5Y=; b=gtRLWC0VZmtjXq9FazeOnW
	+pt2E6GuiPUyC8XK79FKA6UzeLMQ3Zcx0v6RcGtBq2t+M7yx/omgkNQuXGB1+ZZP
	1VvjeLtGEmVFhjn7lm+LhpfG95+H0HZIIj6wU7DnMbIWAri70ioauykVzIAaw1ar
	QbG8H1pjF+TPMHnAfvo2lzarZtaQ71RAxA0h4FxHqtzo+QgCQyPss+V/L76Odn5F
	6RxZfrSESEGUoWF8R9Ow/1GfOp3kypyewGf6ESMh0fZegKYrh0wNfaVHeXFP6JzO
	lOv8HBKl7sgq4dXbxiw+xuGu9yWyYGV93MegyM7dIZJmBTFarKE/uB1DonkXRf+Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7917jf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:55:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NCnh4Y031797;
	Thu, 23 Jul 2026 12:55:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wc973-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:55:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NCtQDm38339050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:55:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B39FD2004E;
	Thu, 23 Jul 2026 12:55:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C52C20043;
	Thu, 23 Jul 2026 12:55:26 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 12:55:26 +0000 (GMT)
Message-ID: <8703798a-ac03-4fb9-aa0d-4d9549e310d4@linux.ibm.com>
Date: Thu, 23 Jul 2026 14:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/27] KVM: s390: Introduce arm64 KVM
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 64tLpuikP21pA_DvTyWJqLJUNsEfapWn
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a620f47 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=CPxsEd0Gt-L8NNlc6woA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX0qSI/yMXVsuz
 xMq/LSxZDtTMddhl7DN1psJ+AcAh+WqPAbbZwtK8MJlerH7F490CrUyP/3W5gzNef67qarCy+UT
 7hJ7bVLd5A/fU7XHhk6v2aKi1h+t43w=
X-Proofpoint-GUID: 64tLpuikP21pA_DvTyWJqLJUNsEfapWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX6dn6+/3PTIrx
 TtZocT5pUUlNA17Ttj6BWgf5nD54egU2uBzawZrao1RPEnPrHkOQ6DriKy8WpGcsjS5t66gEB9p
 z7OKjbpA74OJfrQ8Q/+OSOGrukBnA/tRxfqCOo2p8+9oDQ3ylmgj3lVq9B00/88ksrUc+5JuqMT
 74v9gUQQSBmvgxQ4xZT4bHHcJji+fWmk1A4/j5x+0pOSjIH/ebs9EJHciKFeURlToymALQaQnNc
 otZrVmPDIJXhu/llnmqRTyuuVR11on7YK13hLif1miFNh6Ae8K4jRCWiYPvem+Gc0jgSHO0PWE2
 TxZpRWajFvjlJAYWC9cbfi5SqZ9wl0MuZz9IztJ8iuPMVpXMBdyMA0gsm4Xl0Lg5ov3Dj/39UQQ
 rtQVoA3ojSW8hEN+VmGPQfj0nO3ugg5/HSQcmKaD9PZSFIOi7rUTy8HZTRmHkzkHG//178R+sRn
 0a4v4+pJzVVxdPkciwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230125

Am 06.07.26 um 10:52 schrieb Steffen Eiden:

> KVM/s390 reorganization (patches 12-17):
>    Prepare s390 for a second KVM module. Move existing s390 KVM code into
>    dedicated s390 and gmap subdirectories to make room for a second KVM
>    implementation. Refactor gmap to better integrate with the second KVM
>    implementation.
In the interest of making this patch set smaller, I would be willing to take
these mechanical things in kvms390->next. Needs some review and polish but
should be straighforward enough.
