Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426898;
	b=bf/wQH94ksBqfGf0vU6f7ubng7dcPO6vO3R99WNU3Y+7a1j7xftuOzjU4NvonoAill+W
	 9iTh3WPkImoO/SHd34MgHJUX9F8Fc3eAmGphjIKnNKuN4eJ8MGTpox8O+aAEStL2x4sNg
	 W+9TnLT0gCWG1tkKplUUrKVWI21dGNSsOCZ9KPs+3l0AvMJh+1vcK0Nx6pQ6i+M3HggML
	 lJFp2Auvg3bV5Cz7sizMtW0hTyazvgN8lYqGZWzoFJFDJlYNuYjWTNG+z57QZ4aUFq+K0
	 QBjF/hB196lGwAMO9hTvc3aWtswkiaKEU5wpMqNr6Plo/pVsqihzLC+2qX5njnzyD9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426898;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pRExidkVkZnEqiYK5Gjfqu4IDZXTVVeb+I6QW5ZL6uQ=;
	b=XPUSU2DndkfN/ueLk9Ue3zca7dTgr64ACexXiCu7+xdLclm6NjgwzZvPAlFYobmtITYU
	 Z+RzT0O+JR+pv9u74xwrEDCLzRmbl1NQFjjCGB0VC8zcffhFmujh/mMKHNmrZmvJWkMIb
	 +2p/qtDaxmKakamTUuZziEbtGMczUS/8ve6my8SKJqrMqK1fuxsS5E0jK+/bD2PZhqAqN
	 q6GzdPba4kAthD6LQRPiXLd3yxZz6FYY6Ne04wtuwUI3zZfoPAJWjZxQeOkibGm23wI97
	 zlq3L/bGQcbKXtlQaK/ql3zk0VH3rG3zbE5MK7sTiMxWsxF5tu9Xm7zodZKpNgGcYZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BEyIQART;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B9606A31A;
	Mon, 23 Nov 2026 09:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D22B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BEyIQART
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9YTw51601550;
	Mon, 23 Nov 2026 09:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pRExid
	kVkZnEqiYK5Gjfqu4IDZXTVVeb+I6QW5ZL6uQ=; b=BEyIQART8dkCV+0FOmy/mw
	9BGrYKeTbYmTBeiovyzYzRAmWM10NVYGGyEmakVzrUjmuzzgxAPd3JDD4CwxU5io
	1UkcTo829UXW5Dopm1s6r1kD1DFXlEUKLUwz3JAusC2sC46PzAy5M/Cmn2NAv2X3
	xBpy56eJw824KyE4GmcU6j/9W58rS84N5pST3fLCSAumvu7TVLsNLISGtqGuwA2g
	UxZosxbb5uItrQhSPBzhm0m7nKHrlOOWTif0xi8lLawrUPKG8ghXKQ+tAD0dYogb
	PlsAbAYHId82KmtNRcASoJqoFUDt7kNXLkp+4T7A6V2IRBfd0Keapym+wotx7R3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g32f3g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 09:41:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JNLf956277;
	Mon, 23 Nov 2026 09:41:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0ve9fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 09:41:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN9fElV48693632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 09:41:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 228302004E;
	Mon, 23 Nov 2026 09:41:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB82120040;
	Mon, 23 Nov 2026 09:41:13 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 09:41:13 +0000 (GMT)
Message-ID: <d2e2ffaa-70ad-460f-bd85-0834a354f232@linux.ibm.com>
Date: Mon, 23 Nov 2026 10:41:13 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: s390: Don't use %pK through debug printing
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250217-restricted-pointers-s390-v1-0-0e4ace75d8aa@linutronix.de>
 <20250217-restricted-pointers-s390-v1-2-0e4ace75d8aa@linutronix.de>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20250217-restricted-pointers-s390-v1-2-0e4ace75d8aa@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b040a3f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=kX4y4rNH7BZqjoY-yxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzOCBTYWx0ZWRfX6bGa+ZVkh0Ei
 470XWYDJhPtzwFN5NmrBol8BJ6OeZVMRPWCwGo5O0zG7tszY54eZTVNqR16AAHLj4JDvws5ZiMq
 IM+OVYCBdmYJZ/jboEOvO6hOtCiRg2g=
X-Proofpoint-ORIG-GUID: PB7IEGtik7gGSTVF3yaJ0dpPAaRAuUc1
X-Proofpoint-GUID: PB7IEGtik7gGSTVF3yaJ0dpPAaRAuUc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzOCBTYWx0ZWRfX4vDogcpnTR1V
 26hAj/jzWj1MGZuUl/717QEwkYwJIZlzVH6QXxvL1/+hZaJnLAPvp1ztyY6HQHIdgPcwowxdxNO
 8lIpFwERmE0Xj5VXfYL38UdFn1FrLmfmckkxnUDJioGkvRE9V+gOF2MB0osIl4gWiXC4XiyLByc
 BqUMZWppyxF6MiIHG2lN5Nj18rwf+NBZCSJv9a46Y4v7aKzjPUAjeRohQqsZFrZm7SB83iOAalM
 zMWi8YNIZ8RiQ0QbdyiF+0q11g/R4k0U7Q0Fe+mcQ2ts9/oiUd51zHqPc5rFrT6mUgLVrkPq9Rq
 xq5iVCicNkkk8xY6QxR3OsyGvLQERhyA23UGgJ1HJYYE6V96N9R19smg/QyIFpDhsC4oUofd1L9
 B+0hU4vP5ZvbdOBhzDp4TpeAfQsUnivi9LkNeRqPkL9ESkrQbQrftlvKXgtahc/3hJ3mQse1DDf
 s8Ts4waL7qUNgRypAXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230038

Am 17.02.25 um 14:13 schrieb Thomas Weißschuh:
> Restricted pointers ("%pK") are only meant to be used when directly
> printing to a file from task context.
> Otherwise it can unintentionally expose security sensitive,
> raw pointer values.
> 
> Use regular pointer formatting instead.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Just realized that will debugging something, but this change was wrong.
The VM_EVENT, KVM_EVENT are not printks, it will rather populate output
in debugfs files and this output is populated at read time as the debug
feature stores the format string and the value. So %pK was actually the
right thing - I think.


> ---
>   arch/s390/kvm/intercept.c |  2 +-
>   arch/s390/kvm/interrupt.c |  8 ++++----
>   arch/s390/kvm/kvm-s390.c  | 10 +++++-----
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 610dd44a948b22945b0a35b760ded64bd44ef7cb..a06a000f196ce0066bfd21b0d914492a1796819a 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -95,7 +95,7 @@ static int handle_validity(struct kvm_vcpu *vcpu)
>   
>   	vcpu->stat.exit_validity++;
>   	trace_kvm_s390_intercept_validity(vcpu, viwhy);
> -	KVM_EVENT(3, "validity intercept 0x%x for pid %u (kvm 0x%pK)", viwhy,
> +	KVM_EVENT(3, "validity intercept 0x%x for pid %u (kvm 0x%p)", viwhy,
>   		  current->pid, vcpu->kvm);
>   
>   	/* do not warn on invalid runtime instrumentation mode */
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 07ff0e10cb7f5c0294bf85f1d65d1eb124698705..c0558f05400732b2fe6911c1ef58f86b62364770 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3161,7 +3161,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>   	if (!gi->origin)
>   		return;
>   	gisa_clear_ipm(gi->origin);
> -	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
> +	VM_EVENT(kvm, 3, "gisa 0x%p cleared", gi->origin);
>   }
>   
>   void kvm_s390_gisa_init(struct kvm *kvm)
> @@ -3178,7 +3178,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>   	gi->timer.function = gisa_vcpu_kicker;
>   	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>   	gi->origin->next_alert = (u32)virt_to_phys(gi->origin);
> -	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
> +	VM_EVENT(kvm, 3, "gisa 0x%p initialized", gi->origin);
>   }
>   
>   void kvm_s390_gisa_enable(struct kvm *kvm)
> @@ -3219,7 +3219,7 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
>   		process_gib_alert_list();
>   	hrtimer_cancel(&gi->timer);
>   	gi->origin = NULL;
> -	VM_EVENT(kvm, 3, "gisa 0x%pK destroyed", gisa);
> +	VM_EVENT(kvm, 3, "gisa 0x%p destroyed", gisa);
>   }
>   
>   void kvm_s390_gisa_disable(struct kvm *kvm)
> @@ -3468,7 +3468,7 @@ int __init kvm_s390_gib_init(u8 nisc)
>   		}
>   	}
>   
> -	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
> +	KVM_EVENT(3, "gib 0x%p (nisc=%d) initialized", gib, gib->nisc);
>   	goto out;
>   
>   out_unreg_gal:
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ebecb96bacce7d75563bd3a130a7cc31869dc254..9e427ba3aed42edf617d6625b5bcaba8f43dc464 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1020,7 +1020,7 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>   		}
>   		mutex_unlock(&kvm->lock);
>   		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
> -		VM_EVENT(kvm, 3, "New guest asce: 0x%pK",
> +		VM_EVENT(kvm, 3, "New guest asce: 0x%p",
>   			 (void *) kvm->arch.gmap->asce);
>   		break;
>   	}
> @@ -3464,7 +3464,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   		kvm_s390_gisa_init(kvm);
>   	INIT_LIST_HEAD(&kvm->arch.pv.need_cleanup);
>   	kvm->arch.pv.set_aside = NULL;
> -	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
> +	KVM_EVENT(3, "vm 0x%p created by pid %u", kvm, current->pid);
>   
>   	return 0;
>   out_err:
> @@ -3527,7 +3527,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>   	kvm_s390_destroy_adapters(kvm);
>   	kvm_s390_clear_float_irqs(kvm);
>   	kvm_s390_vsie_destroy(kvm);
> -	KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
> +	KVM_EVENT(3, "vm 0x%p destroyed", kvm);
>   }
>   
>   /* Section: vcpu related */
> @@ -3648,7 +3648,7 @@ static int sca_switch_to_extended(struct kvm *kvm)
>   
>   	free_page((unsigned long)old_sca);
>   
> -	VM_EVENT(kvm, 2, "Switched to ESCA (0x%pK -> 0x%pK)",
> +	VM_EVENT(kvm, 2, "Switched to ESCA (0x%p -> 0x%p)",
>   		 old_sca, kvm->arch.sca);
>   	return 0;
>   }
> @@ -4025,7 +4025,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>   			goto out_free_sie_block;
>   	}
>   
> -	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%pK, sie block at 0x%pK",
> +	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sie block at 0x%p",
>   		 vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
>   	trace_kvm_s390_create_vcpu(vcpu->vcpu_id, vcpu, vcpu->arch.sie_block);
>   
> 

