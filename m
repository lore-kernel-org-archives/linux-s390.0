Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938744BC032;
	Tue,  4 Aug 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873819; cv=none; b=ArsruaNWR75Nv1MQjGkyGiOreKGzs3t/9pNY2gr0s9heFoi+ax7YgdDyyN04tv1H4TljzhRVIFqI33EZz1vAyCR0T3JC+Kh5PCMi6SzOYCzIZ5CfLkMGybmw2a0/aWRFT3yC2n8MOl/6Jb23XnLySR+XHwamjPjYvhwjy4w79Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873819; c=relaxed/simple;
	bh=9XA8XXE7KJbrVJFdjBJ9tvLZLfG33uEeW/L/jlr0cbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDIN9AsRoFYp/Uiju9Ag6cwUmR4E/a9ZJqX4RFGbxFpzVEVXvD1KLXbTBwRcdN45ev3Rnu4C6WV3G23DkzOz54eW81pMbehJ92VKQc+OqOU43lPHJynxpcNHJVwqxAXe4vDP7IYkyQO3WGQiOr8EBRCkLhJaBUb4AaNbOyge1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bUDc+RRu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bUDc+RRu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JmxPH4117002;
	Tue, 4 Aug 2026 20:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zHvqnC
	QKRqZ2Sl8eeDO/UCMiuGkLTWRU69qStaN1YsA=; b=bUDc+RRuXfRf8wpwExyOrB
	etnbU5YTnrm0ybKrIGac8Q6ml7bgWa0bBa7sFQqQzjw15cB586liDrsDgMEgjZYA
	zw9+wVS5jPudS+tg2APrmtuz4hlOl7PhAHtjQyuM1BaNQ7lC8L31jAWX/oA/xbEG
	HnhWhh9HLJp4EKPhpM01yP2hh/iDpwSUHH/mRm9m5wI25wltDZ8BaHEQSDAz5ITi
	caVTtl0UDjwUYsFeiosl6nWGrbnL42Rz5+BVfOUn/QU+z6xWjgZP3eSB2NaTyD4j
	M+7nEOByYzvqzfgK9VOKL8d5I7hUWiaCB2HvrqCaGX/19i7bfRUCRMwUSUMWjTXA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqqpgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 20:03:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674JupNo005354;
	Tue, 4 Aug 2026 20:03:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw3nds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 20:03:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674K3QWb25821752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 20:03:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B65E5805A;
	Tue,  4 Aug 2026 20:03:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2557E58054;
	Tue,  4 Aug 2026 20:03:25 +0000 (GMT)
Received: from [9.61.23.247] (unknown [9.61.23.247])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 20:03:25 +0000 (GMT)
Message-ID: <c77e23b2-c64a-45f3-a4db-eba32a592401@linux.ibm.com>
Date: Tue, 4 Aug 2026 16:03:24 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] KVM: s390: Free guest debug data on vcpu destroy
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-8-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260804162435.28617-8-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S4ovw_IRBrVWIa_C4O1DTvuUJiH6JlXY
X-Proofpoint-ORIG-GUID: S4ovw_IRBrVWIa_C4O1DTvuUJiH6JlXY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfX8IzuVToxzGdH
 hoXONZsSVrIYLprw99LncZ9WovikgqZhMadL2rbtZBf1ab3mA8VFDeKBv6RBOAsgPNOOiUcYpI4
 r4zjSQZGCj6B/rA2ZROlVqQQh8ND8m4=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a724590 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JkL-GdB9cJYJhCIZ8WwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MCBTYWx0ZWRfXxZtw7pvkVOJg
 aq8UE3TWdOtzYeFsfFlwWf3l/YVc4F/jYf5tZ0cTbVS6//pZiZ5gFfZFK+YrUK4dZRSiv/K5uT5
 3ddzBbxUVhD33BF4XnS7SOSid8O6vknpHYC+A3P0BaVQ8K9+hahE+deYeOxiLfYXYqRl3oJSuwo
 m5C9ZxmfI7WzHXgPZ6ke5Z7c+orj1O2vKQh80dwo34eEQxOLZEoY+BDuNuEyyx9rPmZQ0GJo+8c
 ERzUeXQ2+YsRpywqzl4oNVvWU2DqXfj/wKKzRqwafvslM76lXd4cV16Yn3MG1ywUsklGsPB0ThV
 g3yeowF13UfE2sRLbQjese7o5ehvaZwzLeWRTXfZtdatqIz1JsR4XY2MkBQkVvLkLysYtx9dAbL
 vIXnloVkj+BuJFUPfu5OI1qDZwlKaqDFK/Uv6Mei+DX1iCvIfSgDCVEFWWUzmXOdTayXHTM/JMH
 jvpS0S0XLqtoeqkX3Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040160

On 8/4/26 12:24 PM, Christian Borntraeger wrote:
> kvm_s390_clear_bp_data() is only called from
> kvm_arch_vcpu_ioctl_set_guest_debug(), i.e. when user space changes or
> disables debugging. A vCPU that is destroyed while hardware breakpoints
> are still armed - the normal case when the VMM just exits or crashes -
> leaks hw_bp_info, hw_wp_info and all old_data buffers, since generic KVM
> frees the vCPU right after kvm_arch_vcpu_destroy().
> 
> That is bounded by MAX_BP_COUNT entries, so roughly 8 KiB per vCPU, but
> it is unbounded over VM lifetimes. The allocations are
> GFP_KERNEL_ACCOUNT, so the charge also outlives the exiting process and
> pins dying memcgs.
> 
> Fix by clearing the debug data on vCPU destruction. Calling it
> unconditionally is fine: struct kvm_vcpu is zero allocated, so for a vCPU
> that never enabled debugging the counters are 0 and the pointers NULL.
> 
> Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e0548926dc49..ccbdb109e22c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3409,6 +3409,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
>  	kvm_s390_clear_local_irqs(vcpu);
>  	kvm_clear_async_pf_completion_queue(vcpu);
> +	kvm_s390_clear_bp_data(vcpu);
>  	if (!kvm_is_ucontrol(vcpu->kvm))
>  		sca_del_vcpu(vcpu);
>  	kvm_s390_update_topology_change_report(vcpu->kvm, 1);

