Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A6369D57
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864891; cv=none; b=mgiZN2fzvFBCTcHAaDrO9wxiizOlLqjn6HcWexMkY+ecdUYMtkO5uH2MWo19r+BAlmK909V21Nahlp3HnGzgUuLSUJg4T0EXQ0QwLHdieaoRBTlrIwP5SZTGpnaEw18+0bSQOmcAGp9pECDyROkUEqUJ2wJEfFyIdipnw32eVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864891; c=relaxed/simple;
	bh=AZRpshjdLvX1cYstT/+QIGS1TQRnqqXBqsIOvBpU6N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fYxWSGBaX1l9E7F6reznp3VDtsz54u/Y1poqZ1LYtFKzLrsTdcfZKrNPcnqt4vtljCUYsLWRkrplL27++7G84zL1QRWqaNd/UccBhbXMVxUmdBJ3cLdZngDDQt/Bc0v+cbhnAfnSitYso2ijFmTBii2t+5iU3s7ktvS9w3XWfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Invg4i6h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Invg4i6h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mEiu1711573
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y+L4dx
	t930c5wty+iFIdJxhHttAFe1uIW4xRxNgMniE=; b=Invg4i6hiELvIYvCP/me6G
	xx2SqJhzlwtfVb71J23f1PPdxYvWlAk57ULGSg5jiryxNE99fGapxqbforjPhRfP
	16xbAvh1qOV690SAJUKyt2OOwbKSQ6VCE4Tl5o5u0jXVrhQ66CFPtThhOAazi9Oc
	cgNC/pqy8+vzG8IPApr6Srii/6oTHIkJJgaNYo9K1aJqJ+QGfEhCDw9U5MJS6vSD
	EK16rSAd4XjVDutJYwzJUYnxsE4V+ITNSzRBRx3rNBizVUzPKGfS/gXp74zeBKfQ
	F+LcaicjS5kbqck+qqQ9fpJnBzwuhq+BtgGPaXOUmLbE/10TU74x6VImZmDbfWDQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtw3a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:28:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JAJgYS029295
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:28:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172gbg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:28:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JARvKg48562620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 10:27:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6049D20071;
	Fri, 19 Jun 2026 10:27:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7DF72006C;
	Fri, 19 Jun 2026 10:27:56 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 10:27:56 +0000 (GMT)
Message-ID: <5811d93c-0f04-46ce-9578-9845db4399d1@linux.ibm.com>
Date: Fri, 19 Jun 2026 12:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/kvm: Refactor __diag_time_slice_end_directed for
 single exit point
To: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260619101349.162430-1-ciunas@linux.ibm.com>
 <20260619101349.162430-2-ciunas@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260619101349.162430-2-ciunas@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jHgqrgGA-Y7ywg9an0kIqZPwhayaL8fo
X-Proofpoint-GUID: jHgqrgGA-Y7ywg9an0kIqZPwhayaL8fo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5NiBTYWx0ZWRfXx3Y/Crlq87Ly
 m+8KPxvE1jBfrauyG6KAOmwCOYKuvNYE2QUItw4xIAL0YdY4eU8gDQ0O+NuKDGfj6oIIvDz3+dr
 b0pfh6xV05WBRfmwgyPwRiOExD16rXIoMACHJXshPyrcu6EFRteSi8JltQWdFY4Y5YMMwcSchzG
 XpfbF4w9fVbacVzkHFn0MdOSHcmk1nHd76pmoRiq525JZ3POl09ph/umav/obmq73tiyDZgkfWF
 btv0eUJT3vKG9ko+mlnWTjc5uVr+Rg6nfrBFKXkjwgVvpvtAUMFBhjxt1yI0QF6f8cdomW7XfMN
 rZjcow4VPaSI3uxfDlCmWcnuxzhz50+MIhLiqFzoP0mR2WWW4/Z5pacwgceQxY1vG5cKCfkm2qs
 QovLBR9ZlOhruXE/l7oW7JdOsWa/hVCHJpTnFGZGzf9nTjmV+oVgdzBQZh/x/3FR5QNpkTHFkIz
 7IB4sOw/QcXOttrf1WA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5NiBTYWx0ZWRfX4K+dYBeKE7AV
 el4GpwNEqkQTiJbASeBAlYdh8ddZMX+LLfxJUE2ebmAsZ5jRR8DOuiwxcc3Q5tIgVX2H0GTNu1I
 KY57ypiZl4HdY+1RAyRN8SFsGNCdOZY=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a3519b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uzxnxIlgG1-5XWEOJ2kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190096



Am 19.06.26 um 12:13 schrieb Ciunas Bennett:
> Refactor the DIAG 9c (directed yield) handler to use a unified exit path,
> improving code maintainability and reducing duplication.
> Changes:
>   - Consolidate all exit paths to use a single 'out' label
>   - Replace multiple VCPU_EVENT logging calls with one unified call
>   - Introduce 'result' string variable to track operation outcome
>   - Initialize tcpu_cpu to -1 for safe handling across all code paths
>   - Ensure statistics updates occur before the common exit point
> 
> This refactoring maintains identical functionality while making the control
> flow clearer and easier to maintain. All three possible outcomes (yield
> forwarded, done, ignored) now converge at a single logging point
> 
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
> ---
>   arch/s390/kvm/diag.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index d89d1c381522..85c84421b510 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -186,7 +186,8 @@ static int diag9c_forwarding_overrun(void)
>   static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_vcpu *tcpu;
> -	int tcpu_cpu;
> +	const char *result;
> +	int tcpu_cpu = -1;
>   	int tid;
>   
>   	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
> @@ -211,21 +212,22 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   		if (!vcpu_is_preempted(tcpu_cpu))
>   			goto no_yield;
>   		smp_yield_cpu(tcpu_cpu);
> -		VCPU_EVENT(vcpu, 5,
> -			   "diag time slice end directed to %d: yield forwarded",
> -			   tid);
>   		vcpu->stat.diag_9c_forward++;
> -		return 0;
> +		result = "yield forwarded";
> +		goto out;
>   	}
>   
>   	if (kvm_vcpu_yield_to(tcpu) <= 0)
>   		goto no_yield;
>   
> -	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: done", tid);
> -	return 0;
> +	result = "done";
> +	goto out;
>   no_yield:
> -	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: ignored", tid);
>   	vcpu->stat.diag_9c_ignored++;
> +	result = "ignored";
> +out:
> +	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
> +		   result);

result is a local variable that will go out of scope. You can not reference those
in the s390dbf feature as it will only store the string pointer and it will not
resolve the %s. So this wont work.

When sending a patch, please cc maintainers according to scripts/get_maintainers.pl
