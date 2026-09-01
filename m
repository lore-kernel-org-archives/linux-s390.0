Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0A34A3BF
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276647; cv=none; b=RSUZrCD4/aE1BRCIxCepRQTK6+26JH4LQo+KP0lcg7R4swA7PbtUb3d3pIXgLqJXCWyR1r1s5hiVrqamKyLrwvWohQcPYy7spQoIP7j2LsIFk+Bacu4n+/GY9D6+OJP0i50UC2devfFrszgl6KIEOWqheJbAlFzXpN0+UUCBHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276647; c=relaxed/simple;
	bh=DICtfJA4KpyZe/66qXsbU/kgGHleIoZYIAH3ZgbUQV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2jEIX12gtSNeZBSjfDX82An8xDTBSwc9svXcjTaZ2fyCcvr8GEvQwlokOWsN8Z13EgTufPo2pkCbdbvQDwtxtuFuA6bfk0ZSQhUoYLDuBQEv2mxzvWQX/YcHW9T2hmI3m+IduefmsH+6kk++64/d4NK1UpCHJoH1ejDptZG4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PaBaXYb4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PaBaXYb4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EVft41340874
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 15:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fMSCpDuhpF1DoOwsvRjmXZJmHl8I7o
	eerDhO+RRfaJE=; b=PaBaXYb4y3FM1Xl6DdZMdqrYqXocrRQ873+5DARlSjTGq6
	vuRZPTIpkM0/bAV3pEGlvqfo5OAo09zVv0qks3O8rjvc7kSSxEHEtcqXpqZ5eAuP
	fsMHmr4f7iuKWx9vvzjlaWNGP3kFWmAAjv0tZ7pggr4aa/WeySIQ8hMTwjV7uzyk
	l15VY8YW7MqAZvzUl76Pnpu0hh6Hv/q4KKqhALF5zK62Ij6YCSyCSk/ESpzeF+Ho
	JbL8MNNqugG230iRm+IW0omozEZooWFMBWnWhyYw0lLoApZVI4eIfcrez9U/m/6g
	8ARowZgVVq9y+Muo75HW86h6rfLmmT2eanPb5RkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhrsgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 15:30:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681FQKiK007457
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 15:30:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4w4h9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 15:30:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681FUdt650594074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 15:30:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB2DF2004F;
	Tue,  1 Sep 2026 15:30:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89C372004E;
	Tue,  1 Sep 2026 15:30:39 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 15:30:39 +0000 (GMT)
Date: Tue, 1 Sep 2026 17:30:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/topology: Enable ASYM_PACKING to establish cpu
 priority
Message-ID: <20260901153038.152550B9b-hca@linux.ibm.com>
References: <20260901-s390_sd_flags-v1-1-6755ba191d5a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-s390_sd_flags-v1-1-6755ba191d5a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MMqcw0zE_LL6qiiKYnl4a2xrOzsZyDI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzMyBTYWx0ZWRfX9rfjqiBRodlP
 zUS5lNGkOb0FnKn2RI4vRko8wGlBEEQqKfjtqdtqMKuT8+/xC09mjm90Dq/oN5fWdDoKyw9po4y
 IH6pdRmH8qoYUPXxUgdPCoVbvZoLiuiD2goBqLiWKxWsjegFfvgtW2xwKvaRIZZyk+fpnXX9S55
 hUNgbgm7OC1PjXeTUhp+GruWUCiOaXEv0HiB4hUBA07ZzsTQTWHzoyQ94uNYGw6hnyZhmbhYeqT
 F84/0mcr62vjN7tdMefGe1Ue3GKBQWa28bDwIzOvEbQtp1RdLkY2m4cjneafCnNMTdadHVXguZ/
 KPGW/Oe9OpGYJNNlNsclghiyrtFuakd9EXLHXwqMhBSYxeniaPWlKDdSi4uwDBaYYbfDRtJEUCM
 yyOb7OWnFBylzdTpJ5DAmJzJUdNCdkDxnbjY1CF6JdTHcQ1fuaMVY+5S5UWBYeAPXgJ2Oe7z07+
 Q0FK6XwXJ03AgoMwtbg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96efa4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SobATKYv8Q94nUhh9LkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzMyBTYWx0ZWRfX8gV88XzaiS5u
 rwk27QKcMkVY5V2Oa1jKMIaHy+ac0S7Xielcxvpq5Ujxsz2UED85gctGz3zrw94MrFzOLvPLOxd
 p+DYwy9KYrXqOtrghgkDTwrjpRFONME=
X-Proofpoint-ORIG-GUID: MMqcw0zE_LL6qiiKYnl4a2xrOzsZyDI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010133

On Tue, Sep 01, 2026 at 04:40:26PM +0200, Mete Durlu wrote:
> On s390 LPARs the hypervisor assigns varying CPU runtime capacities
> under vertical polarization, making CPUs unequal. Add SD_ASYM_PACKING
> into topology level flag callbacks so the scheduler keeps busier
> scheduling groups packed onto higher-capacity CPUs.
> Implement arch_asym_cpu_priority() using smp_cpu_get_capacity() as
> the decision factor.

...
> Subtract the CPU number so that the CPUs with lower ids are prioritized.

Why?

> Only enabled on LPAR level as other guest levels either do not have
> vertical polarization (which causes asymmetric CPUs), or machine backed
> topology.

...

> +static int s390_core_flags(void)
> +{
> +	int flags = cpu_core_flags();
> +
> +	if (machine_is_lpar())
> +		flags |= SD_ASYM_PACKING;
> +	return flags;
> +}

Why is this machine_is_lpar()? This should actually test if cpu
polarization is available to make this independent of some random
environment test.

Furthermore to me this reads like the above only makes sense in case of
vertical polarization. What happens in case of horizontal polarization?
Does SD_ASYM_PACKING have any negative impact for that case?

> +int arch_asym_cpu_priority(int cpu)
> +{
> +	return smp_cpu_get_capacity(cpu) - cpu;
> +}

As commented above. The rationale for this needs to documented.
Does this make sense for horizontal polarization?
