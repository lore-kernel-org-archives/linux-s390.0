Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49578390200;
	Mon, 16 Mar 2026 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664573; cv=none; b=eGCORZtfOzmDl/zXmsXWBILuTYBR7EcA3MCLl2TaXtbimBhVA792LG6Aiih1CZkpC520i49OvQnjkVKVXj5VA+hmKMtTkoNF9YKaNJaygv2o0HoW1dN7KpBnHFLrliFxfzIGwW5hMUnOZrfs82CYrAdy9AL7v2krtwPNT7iY8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664573; c=relaxed/simple;
	bh=jNfdmdSeoczBOMS60gJh1UqQDIWZuzfuiwr6hXzDaoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv7uiYCpwAiWE82J2N5GqiipoD9ynitBYSxD8u6FPnmDOgR086FhX984jhZInR/IxZfh1yjcJDEh0idQvS63GmTsRd/Ry+I7ph2TAZXcMvFaPWCyCXu3va7lDgQUUefhU5T81llppYzE94U7TnRFqSuzSneb8M5Bk3mA70CJkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kpS42m0C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kpS42m0C"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FJurAj544589;
	Mon, 16 Mar 2026 12:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lztcP7
	Vq1efPnpZA09wboAlEbDV3y2fRwNnnfDw7yf4=; b=kpS42m0CwCKCkERqSyzHb3
	bFZvVthU5fSqqCSGUDYPKlt+WhYHHpvJ2bVjzXAJehpaTwZ74TMIRXIWFN3LS3js
	o5ZTz0a9KhDRA+MfguFTJ1+e2wcgZtjZde28HtTgjRF1SyquM32pSnAKiAa4ssDC
	ws3YaBkCT5n7GqW8Ykdn2NPRPID1kbCm+zKsInbbzjv5eW9BZqpT75lNW8lHCQBE
	Rb35Qweav4LKpCcVTWLjOu5uBZUeNJJ5bfUZWeeXylahSI17btPIkBbgvTHMPFIX
	wxmzeZ+vDjILSCYqt+UJTyvgY0yJz5ahngv4GVt8A13VTlriSJr40sRN3aBtRP0Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cqhf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:36:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GA73FH013996;
	Mon, 16 Mar 2026 12:36:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxvvb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:36:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GCa0UX12255606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 12:36:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED5572004E;
	Mon, 16 Mar 2026 12:35:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A6A22004B;
	Mon, 16 Mar 2026 12:35:59 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 12:35:59 +0000 (GMT)
Message-ID: <d291035f-8bf1-493c-a629-5852a1e65caa@linux.ibm.com>
Date: Mon, 16 Mar 2026 13:35:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: vsie: Avoid injecting machine check on
 signal
To: KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260316122546.11573-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260316122546.11573-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b7f934 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=fFiRasqioUBZiXrltOYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfX40cPPvefKj9e
 L0eeb3WK9flAD7okPJ1vd3laIySXJs89DUZ3Fo6Gho0Nb+lR0OTfcvfXMHIdfNQDjja6ihBkwSD
 uGwSZgl+xJ186gVQgbSFeqyxKTY6lz6f8Zqd24/afkCScIttguurtQEoyX0+JaHh/CRxcvmRsG0
 XaP11x9C7tom822XgxkT7uFV41CF89wqA00IgLDzWvx6mj8th/H13KxYLBTmCMBmNr7RahnQ/TE
 y2J7u+MEg6Ou4jUSr/VdzaTVAb8UD53DmqNCjTbwHZWcyPSNHYVOcdyspF5iiDCWN8vXIX1jX7H
 jfaj8cjgvAPIEAQcNU+4MWD3zS+t5L/Z6T7B5VdRX+EJD0XvGuh3lhLmZTQ+ZFkqu/LwEUpQQCG
 NkCgLETjQgIdmulfIdEYqPOuyNvg9eE0WfL5+Il3TUTJeVAVIHrfGgZPWZM4HInQCgMS1HOVHBE
 I6PUmhMPScuAw2mfZsg==
X-Proofpoint-GUID: WWlMokYBPf25RPZbKm1S27Zec9MPTHbr
X-Proofpoint-ORIG-GUID: WWlMokYBPf25RPZbKm1S27Zec9MPTHbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160093

Am 16.03.26 um 13:25 schrieb Christian Borntraeger:
> The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
> vsie code would interpret a signal during work as a machine check during
> SIE as both use the EINTR return code.
> The exit_reason of the sie64a function has nothing to do with the
> kvm_run exit_reason. Rename it and define a specific code for machine
> checks instead of abusing -EINTR.
> rename exit_reason into sie_return to avoid the naming conflict.
> 
> Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
> v1->v2:
> instead of a band-aid, make the machine check more direct
> 
>   arch/s390/include/asm/kvm_host.h   |  3 +++
>   arch/s390/include/asm/stacktrace.h |  2 +-
>   arch/s390/kernel/asm-offsets.c     |  2 +-
>   arch/s390/kernel/entry.S           |  4 ++--
>   arch/s390/kernel/nmi.c             |  4 ++--
>   arch/s390/kvm/kvm-s390.c           | 15 ++++++++-------
>   arch/s390/kvm/vsie.c               |  4 +++-
>   7 files changed, 20 insertions(+), 14 deletions(-)

I guess we should still add something like

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1123,6 +1123,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
         struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
         struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
         int guest_bp_isolation;
+       int sie_return = SIE64_RETURN_OK;
         int rc = 0;
  
         handle_last_fault(vcpu, vsie_page, sg);
@@ -1163,7 +1164,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
                         goto xfer_to_guest_mode_check;
                 }
                 guest_timing_enter_irqoff();
-               rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
+               sie_return = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
                 guest_timing_exit_irqoff();
                 local_irq_enable();
         }
@@ -1178,7 +1179,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
  
         kvm_vcpu_srcu_read_lock(vcpu);
  
-       if (rc == SIE64_RETURN_MCCK) {
+       if (sie_return == SIE64_RETURN_MCCK) {
                 kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
                 return 0;
         }

