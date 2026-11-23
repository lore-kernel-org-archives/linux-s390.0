Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437565;
	b=uR4gYBBWKO9zGQzIOEXToGDt022YEtaDU+ziSogQpfMYBWhiuoAq9Z1GfNZKe+ZlXJXs
	 ANYbnvOgQz15130YteGSWQrmTZVfJaLAZSOdbYH3PvrKiHN501TRvgDYruxhLwRpAIumT
	 LXo7y7UkpWvTGfbnPcifUig7C21yT5ebvP1ApDb6wdW9jPdCUlFbVrG8AXHsuqlGQ7Rk5
	 gIw7eG1htFz7xbTIIsrNUFHFqcpgDTF1AjG4fCRnu8IAxm09KeqcegNIrSTrx8zDNiamQ
	 mzMZyUTZlYNXHv294rEWT8/RmrStx5UhMGI17jYIkoVCTE1VqcyJe7jHoVniLXOlfjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437565;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kQBqYCwf9S2wKWqSXTTi29m0C2tNyGGu5EalsVstefI=;
	b=DUs6VLiAdcroZYCIS4DJXeVtuAHKB5l1FZ6gnjGPUnl/SlbDPtWLEgpcqVMrTnvPBxho
	 u3OkSeGvt/ADEBcY26BnyhtMrxp1qK4eTsMLaXz19sSIsIO1yMnNJ6VKbzquU3tXarxZT
	 5vXLs3KWmd3KYzbPTrs93CLASSIfppEi9KiFg8F9SL9YHAqJ6Ps6BMXolQK92X2IDBhcp
	 SHH/EGBBm4E+jn31Qz6PKBn06oaVUSdVTIdbsT9Lj9sn2wXdxd3LJGaHsGw+SK1MYUIlJ
	 r+3r7uJbuNHZypfMjhPaLT+YUgasLOv4YAQeqyuMg4ASA1U9Bme7aW0y9GDUmFpqq3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PlfRJSsZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1857606A31A;
	Mon, 23 Nov 2026 12:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1857606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PlfRJSsZ
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCZDuV3621772;
	Mon, 23 Nov 2026 12:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kQBqYC
	wf9S2wKWqSXTTi29m0C2tNyGGu5EalsVstefI=; b=PlfRJSsZtUhVsuZbCasMds
	u41MvRcVV2ycj7SlgNF97/TWxW5XhywEXt2e/QJldvP7yj0aLn2Q1k1MKOQJKnrJ
	8WzimtH2CPpZMlxysCbhB6d/bXc3SR2+xFgGBuO9zE2FKa6WC53IQga2e0U87Re+
	zspGE1WFNqoakIj0eBmdNPFaeC+CCAuq0STB7g18nuVUIrgI47KYAYuxStuDdNsL
	3Wzr3/aaK5mdU93/aq/C1S60H49yfXHUr2qbf2PjHDcLRQVAHuNwrPcn801Bb33P
	v3YEa04BKZHdLuZigCZ7557D9ZVKpQJtPZWjTTvlRyTw4SB8pNWFTUvyzE3UvwYw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkb5xw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:39:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJeqq1912199;
	Mon, 23 Nov 2026 12:39:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayeg5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:39:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANCd6hk31916702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 12:39:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 275892004F;
	Mon, 23 Nov 2026 12:39:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6A7120040;
	Mon, 23 Nov 2026 12:39:05 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 12:39:05 +0000 (GMT)
Message-ID: <1055394b-aa87-4474-883f-b489298d4a1f@linux.ibm.com>
Date: Mon, 23 Nov 2026 13:39:05 +0100
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
Subject: Re: [PATCH v2 1/6] s390/smp: Export arch_smp_send_reschedule() for
 KVM
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satish Kharat <satishkh@cisco.com>,
        Sashiko Bot <sashiko-bot@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
References: <20261119235656.70315-1-seanjc@google.com>
 <20261119235656.70315-2-seanjc@google.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261119235656.70315-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX1DqLe5478UpH
 WRfGvv5W0Q66aqZIXcbGvCjuEkj6dtAbvc9ivJmYnFveP2tbZfKHSzZuGztUDwV8PbrgywECrv/
 W09VhypNqiqfwmjTzB8OyRguYMcRUxk8Uzpgnv61y7Ec0pA3jUQUJDqdyKVfeFKDr6mymr0tLRD
 EcO+wk9nGU/8/VvvMsozdNj5Oq3IDegfzR6c1HcE+NBBKToCe0jGPVRDpR58HEb1Y0uCDYq5j4I
 qy8Yz8gAieXdPx7U/kpkD7WjJPBZDsc+B+kOMWj/bl9IoSKyRgciE5b7+9uTYCKXFWUmLqKaisg
 4NRd/6/HsGBVAH+07XPeIKOLxdz6UxQNss77Q4m74rghgXvh8pJXgu+b0UzYEeJc3LaT6gAhCK7
 CwJjXu1UvpOy4zl25d1gbGKVfgVPQ/uxkrJNaK/fNqd8hwORybGyS9hk6X+VvHOQqalkysk2WRL
 YkXZCt6HCwrBZkrWe4w==
X-Proofpoint-ORIG-GUID: NKAYPwZMZL993F7nte_6XosNhNLC9quw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX2EVVFZjiynQg
 SY6a5x+DiW/BrFsFo1H4E+T2I5zDpsnS14e5nGOlo1iIHS+qFb889OOknnqrRDGlJDk3AyrwRUL
 2m7yCNAH37YmXaZ3OH76c4EvgpYL1q0=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0433ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=4WT1KQsdlCIwYG2GvGEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JTvesJqtQU-nzvdge1ZWT3QuPbyhM-s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050


Am 20.11.26 um 00:56 schrieb Sean Christopherson:
> Export arch_smp_send_reschedule() so that KVM can use smp_send_reschedule()
> in common "kick vCPU" code without running afoul of build issues on s390.
> KVM currently uses smp_call_function_many() when kicking multiple vCPUs,
> but several KVM architectures (at least arm64 and x86) kick vCPUs with IRQs
> disabled.  Using SMP function calls with IRQs disabled is unsafe as it can
> lead to two CPUs waiting for each other to respond to the function call,
> i.e. KVM needs to use smp_send_reschedule() to avoid potential deadlock on
> other architectures.
> 
> Alternatively, KVM could go out of its way to avoid smp_send_reschedule()
> on s390, as KVM does when kicking a single vCPU, but given that all modules
> can reach smp_send_reschedule() via kick_process(), forcing KVM to dance
> around s390 adds no practical value and would add non-trivial complexity to
> KVM.
> 
> Note, thanks to s390 now building kvm.ko and kvm-arm64.ko, using
> EXPORT_SYMBOL_FOR_KVM doesn't Just Work.  Exporting the symbol just for KVM
> would also complicate backporting the upcoming fixes to older kernels.  For
> now, keep it simple.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Adding linux-s390

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kernel/smp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 32499cad86f0..39318aa7ab7f 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -531,6 +531,7 @@ void arch_smp_send_reschedule(int cpu)
>   {
>   	pcpu_ec_call(per_cpu_ptr(&pcpu_devices, cpu), ec_schedule);
>   }
> +EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
>   
>   #ifdef CONFIG_IRQ_WORK
>   void arch_irq_work_raise(void)

