Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9409401485;
	Thu, 28 May 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984411; cv=none; b=qnWEtklIfS5OwTABWlPBTy9YoxaBE1VAi4Vc6F8ktUmbV4iTZICoPtEwyLMZOK5KECkV/GDvE74xMS+Y7KmP7cSch0Zf95o7r2Vixy+pxhRJsaA0BBDvEalj8F4BKJab1zKKPXYKuLTOstoftCY+lsxO5taGrQS2CqBTf4rrrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984411; c=relaxed/simple;
	bh=3iyTnzSSZTtgJ2HfhSY0xOjo75mPW/4C2Z9xj+j8lGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jENb4nwKT8HbCO0eo8stlPp6x7Kk+3/5ZhRNqwurE9xFBYs9pF7JRo7wemlkLHqpnCK0lj2yhbYzEzZArNQOXZ/Cj0m6rQe4XDQd5Ub5pOtWe6fIhOdw87dZdt6sTMGB2Wai8U3Uim/L88N7FQEd2uedsHcc1hca8F9sPY3gKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vcsd9W8n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vcsd9W8n"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCQM3I3426445;
	Thu, 28 May 2026 16:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1RG36P
	EC8YnNgTQR4tpfniTvNwAG5MV+u0IITs4pjw0=; b=Vcsd9W8ncccIBPeetdifrw
	PWajpFMxcIemPXg7gbndH12Bv0n4SMQNbEvRly83FuSZH6jxtMvhw0DWG96WnP2w
	r0Ph9u49Hay1ISxDWTL0VAkHRa6TAWV/hqEdbUkTwvFf9pT00n0EcQJASj0U2ju6
	v8nZbhip2GIuTxMwy1SMw/MvQs3qhBWkaSFYymeTogwmRV+nZHeiC2zN4GnIJLFt
	Bx9sTQ+6EvUXBS6AHWoq+JvjvqSb5yRnF1L9Es9qWd83k1L/1BLaltqYLcdVlK6K
	PSa5FYHCiOySC3vAeMnEdbu89Fq7+o/IfUKPn2wdGe0lq7jZagjBF+m6rPvaikWg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884kxtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:06:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFs9du025213;
	Thu, 28 May 2026 16:06:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8vhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:06:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SG6kwD7930620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 16:06:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E49958058;
	Thu, 28 May 2026 16:06:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B70F5805F;
	Thu, 28 May 2026 16:06:45 +0000 (GMT)
Received: from [9.61.144.185] (unknown [9.61.144.185])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 16:06:45 +0000 (GMT)
Message-ID: <47d4ec9f-ed26-4055-a78c-62be53d33d23@linux.ibm.com>
Date: Thu, 28 May 2026 12:06:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260526015323.207343-1-freimuth@linux.ibm.com>
 <20260526015323.207343-4-freimuth@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260526015323.207343-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a186818 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1s4XCebHbYTDuaAw4AUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Qm5H16BK_8YabhLzNFPql1m-1k4V6pii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2MyBTYWx0ZWRfX1oJRnpJgd0qa
 0CufCAaQ0Zd/5MZMmY1GOrH2umAvrWZpOrIPCSPd72aRRu9I9NHRGZFHKzp3ZGXBE9SCaB1byRP
 /rrMW6p36MthotErDkqO5IGAWt/1bpNHnw1homoa9JwYHdmZDS3IZ9ZUlncG65eyjsI4Ideff7d
 ISsW7kGoFvJputu7IgUX5ImTXS/H/PDmQQhzXazEICV9BJTo4e6yYrtdCsaV0RalTrIyoYyerFS
 eeW4PMUXx++t4zvE0iKiq2AwidYO9ffStSlB6x3qDYo6OKq1eRmbB4zAsRQTQIFrbQOWR/vlhBS
 xLzGmd5j7CsYv7OygyE7YZZS7QPbq27g/vpKrb5MUDMF/PlsRcyMOvIcJmPkwemOTctd47U3ed6
 FnYtOTxEYq7e8u3WJUe1irGvxK+xks2r3swPVktHrVIgr2Iod7zg0/4NxihXXfq30ceRZi7Y6uV
 kiZt9mPi9juMZhtj8iQ==
X-Proofpoint-GUID: Qm5H16BK_8YabhLzNFPql1m-1k4V6pii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280163

On 5/25/26 9:53 PM, Douglas Freimuth wrote:
> s390 needs a fast path for irq injection, and along those lines we
> introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
> the global work queue as it does today, this patch provides a fast path for
> irq injection.
> 
> The inatomic fast path cannot lose control since it is running with
> interrupts disabled. This meant making the following changes that exist on
> the slow path today. First, the adapter_indicators page needs to be mapped
> since it is accessed with interrupts disabled, so we added map/unmap
> functions. Second, access to shared resources between the fast and slow
> paths needed to be changed from mutex and semaphores to spin_lock's.
> Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> these enhancements were required to prevent blocking on the fast inject
> path.
> 
> Fencing of Fast Inject in Secure Execution environments is enabled in the
> patch series by not mapping adapter indicator pages. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters have been added to enable analysis of irq injection on
> the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> io_set_adapter_int and io_390_inatomic_adapter_masked_or_coalesced.

That's a mouthful.  And it also doesn't include suppressed interrupts.

How about something like _no_inject to imply that interrupt was
delivered via the adapter interrupt bits without needing to inject the
irq.

[...]

> @@ -2719,25 +2728,41 @@ static int kvm_s390_inject_airq(struct kvm *kvm,
>  		.parm = 0,
>  		.parm64 = isc_to_int_word(adapter->isc),
>  	};
> +	struct kvm_s390_interrupt_info *inti;
> +	unsigned long flags;
> +
>  	int ret = 0;
>  
> -	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible)
> -		return kvm_s390_inject_vm(kvm, &s390int);
> +	inti = kzalloc_obj(*inti, GFP_KERNEL_ACCOUNT);
> +	if (!inti)
> +		return -ENOMEM;
>  
> -	mutex_lock(&fi->ais_lock);
> +	if (!test_kvm_facility(kvm, 72) || !adapter->suppressible) {
> +		ret = kvm_s390_inject_vm(kvm, &s390int, inti);
> +		if (ret)
> +			kfree(inti);
> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&fi->ais_lock, flags);
>  	if (fi->nimm & AIS_MODE_MASK(adapter->isc)) {
>  		trace_kvm_s390_airq_suppressed(adapter->id, adapter->isc);
> -		goto out;
> +		spin_unlock_irqrestore(&fi->ais_lock, flags);
> +		kfree(inti);

I suggested adding this to the same counter as masked and coalesced, and
I still think you should:  so add a _no_inject++ here

Otherwise, LGTM -- please send a v9 with this and the other small things
I mentioned on the other 2 patches.
