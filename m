Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5813546C9;
	Wed, 12 Aug 2026 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519382; cv=none; b=IO5fdZEaSoLABkb3o4nF4Y0OXwhUbG2G6zq40UMVEVonkjNpDEaLfZazgBzHEooaiOlXcy8vBI1ZmZ5h397owPBVRfK6QVvBjL4KR9GHbWVXmYzhW+l+QJyV+/I6ulDJOk3i/JrZV4BkJph2lIKeDruL7i619UdbtfG0OMQhZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519382; c=relaxed/simple;
	bh=tIDOgrfuWgVeLWalaknhV7rILDUTACYfLkx5XC2ZLY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPiBbHiVM7IeT+2eMIHo6EDbsn6DVXgSZ7jh6z6Qx15C7G+pMLNMHOczkQ7APZeUmPqoEIJw0izb0HcR0Iueomp7sWkKnq+3P0ZKql0KE3Dhb08/Mmg7BCpRM1ZgH410rBQNJDm+TAU4EUljkvWqiNgEyPhjeT2miyYAiroy2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFKJT9OH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFKJT9OH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62N6B2678430;
	Wed, 12 Aug 2026 07:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lLxc04
	fBesdS5R7r0fnKGr/g2HwoqoXLMohUkng7Aqc=; b=HFKJT9OHbIqaT4S7iJ9j48
	VqyPaI2mBBrj2dUQU9SA41fR4A5/E3orOMiMLmWw4RpgHNX2LW4X4lVfM+uQPdnj
	qPBIroDodvEBgLERrxFrJSbIdG64aFHzF+hjMkK9hxWsBxCXMlbtYl9siipnZibW
	sd7WFRm4/jEji/rWjd0bLjA+2XBwFrHsX/4gaUCFmQsUCqPl2GVZ/nTKN0BtQlzt
	JNC7vCcRqMG7RJibSFjObACwuVH097kr1rnYkAOEwBhl+2n4f/9C+fZe7j8oV1MX
	X3wo7ieHA8de6RgrUiJD/2/JU3Mami/g3j1ccVZKji1FKMkcnCJa4xLLdh4nSI7w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9sbng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:22:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7BKTm032681;
	Wed, 12 Aug 2026 07:22:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq55eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:22:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C7MsC340763902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 07:22:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 012AC2004B;
	Wed, 12 Aug 2026 07:22:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C195E20043;
	Wed, 12 Aug 2026 07:22:53 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 07:22:53 +0000 (GMT)
Message-ID: <7cca8c17-c849-42a8-a844-5db4c222d313@de.ibm.com>
Date: Wed, 12 Aug 2026 09:22:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] KVM: s390: Fix kvm_s390_clear_pv_state()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-10-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX6dv8bJMkqDup
 M79/b3/tReRie2PMdeuNRgNZX+2zrJh+yjAL7xHZnf3EuXlK0GZjZ2ab8vLILLx6AZCnGCXlpy0
 O3F8Bct97odk/AEdQ9aMNVm8H7eFO5ibHtCMJV6RvA3LnsZaiZrw1thTj2a0yWjkse2ZgjW2HNQ
 +r/umgqcF+Si4nEDBNbv7tx5AlKHGXRo03PRehH9rUkU3BZXelSfHwJJ6Eon90LYD7ynja7NIGu
 8zlS7QvFAozK8EkPSV/vjKxBu/KDkD/E7Cpr8waY5ka+yDtSr6wjKYaKVYMv/PC2M6PHb1ThU1V
 wsP6/TvXTzpjVksJhADsbTI8Y4xfd26Nm78bXT0UKDS5WpIitOcs/MIugZ9tO3FN3um+1SVYfUV
 vzzjHzaygW6qiZiTw4WRsrzozngX8TlHiYYPHgjCgESbQYYZAv7CEbpoAFqWMbAbJSRLmP0RK2V
 NxAP22Zg0lTOQu1X6mw==
X-Proofpoint-ORIG-GUID: e9pD7Rf5kjBWfijdTqSpcUgArSAMuc51
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX0qQb97uuCxuq
 Gqw1C0HYGZeOrbEaJk1sjP2emGAvt+tRpk3fvSNYgGp7ymej2sapmTftLR/2PeDQr9VW84cugE1
 hgSMvtUKKhaiYGNZx64EZcS6vvtBZ54=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c1f52 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=z9yk2LTjqm7JGs_eJUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: e9pD7Rf5kjBWfijdTqSpcUgArSAMuc51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054



Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> kvm_s390_clear_pv_state() needs to also clear the dumping flag, to
> allow the protected VM to be started again (as non-protected, with all
> protected state safely destroyed) after a forced reboot while a
> protected dump was ongoing and not completed.
> 
> Fixes: e40df9efd68a ("KVM: s390: pv: clear the state without memset")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kvm/pv.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index b02e0159d3cd..98a9a57f71b9 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -242,6 +242,10 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
>   	kvm->arch.pv.guest_len = 0;
>   	kvm->arch.pv.stor_base = 0;
>   	kvm->arch.pv.stor_var = NULL;
> +	if (kvm->arch.pv.dumping) {
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		kvm->arch.pv.dumping = false;
> +	}
>   }
>   
>   static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_stor_base)

