Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63522D3225;
	Mon, 22 Jun 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128655; cv=none; b=Xblq3wDBN4pao3fe8DQiFaLkBj+8VI+4+XnjtkZxo0iyb+IXQ/8z6pdA/iVPQ7joVjv8l08aRMa5CGNuDckeCyUQDQ+Ram9dLpSIXXsmn5JaMHmWdl7RxvaXwT5IAFzTvYmph5un/3xglb8s31cDKr5YCUYmZP9qvVzwuPR0m9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128655; c=relaxed/simple;
	bh=TEXR9dgbVOnuVzbmM6cWss+wRzYrZboOvJjz4RrMRRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PF6eHSfgwm5lGw29h4FvWsSo4FvddVdzyO8lnxLeQMlQjPJvhwysZFW7716K+d/uYcLTxUrV7ooIYZCFYSHn+96rJKtFiAn9lwn0XA2noHqU5QjNtokfj9aTzKR68Rbdf3G7Owsvom/X0dImJ6+v9HnzsSzmyrkvZ+f20f8ToRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B/fjOlWp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B/fjOlWp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MArYq12513846;
	Mon, 22 Jun 2026 11:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bU+fNw
	peZhJOOImWRQobM3NI42qhoKA/9k5mrsS/KM4=; b=B/fjOlWpvAWdulXAoF9h6U
	hAf+zewo1lQaeDRWa9HIja95WJvxxA4TSJ9LbTXRPBbTmysOPQxPXN0VxFOVWiQr
	OVpwF+MQFojiWJYX7C26Wp0A56NGtUBlQvmz05S0YcincnjRP5oWahF9sQA7xwpM
	PH+HBKjVuYRBy3TefO41yX74JGA4ESuA1PO0CLwW4DX7NGM2eycim6obUjflPdw/
	t7XfTG9EpB8AYXvgmqwUZhWnEGMpPz2+exbQv0WeqF0dThfbrf30EcUiTPE307pD
	+wC7TAlkw8Qi9gWfp5i/WhAWISuvLjOKaJCayRCZoW9NZtEBQvQuekz+6nRr3TSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9g8xyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 11:44:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MBYcdJ005112;
	Mon, 22 Jun 2026 11:44:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vydnq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 11:44:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MBi6Zb56230170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 11:44:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2012C20049;
	Mon, 22 Jun 2026 11:44:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8753620040;
	Mon, 22 Jun 2026 11:44:05 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 11:44:05 +0000 (GMT)
Message-ID: <81a58478-6a39-4bdf-84a0-5da4d29b6407@de.ibm.com>
Date: Mon, 22 Jun 2026 13:44:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] KVM: s390: Fix handle_{sske,pfmf} under memory
 pressure
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, hca@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
 <20260619155154.307572-6-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260619155154.307572-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aOTrwq3OLybzbqoDIx9AEz7FtJfv2KAF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfXy4ZARlW6+85r
 wiDexrlGK7z3zKOnffTenw3OEPCZB/vEYNxi2uC3IwYRU8R1Ztp4zhLwKYftK+pP6EtzPOaRHbg
 G4UX+7U5uwaoLRKz9KyBqyb1u/wcujc=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a39200a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=eumESayLdrPmyjtxqS8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX5xerWm36llp/
 KqlY5F19TqA75hhUYN7UhR+bY2zizs8sWz84+8M1jt1YQnPScAOTyHFfINb6dBvXgW6S8fJ4e9t
 y60+XCUs0//h6807Pd30aFYGNVtHiE98Yx8NrPU7usHG54xCgdt7wH3X5PvMDvWeEs6anlVE+Vg
 qlO9wXHK+1abc0cRb9SFpyGd1pXoE6LktiPvx4GJjlqk7EUl/Q6e/t5I9G5qtp0a0jFJPGspIpg
 0tpxUUfpnNYFQkXkULzY9tEe2YRDwX7FU9D+tTu68hj0EJHBbADj/Edaf7+YecbSLy4DD620Sxh
 3yxzITiww/EdfldE5+Ypu7eLRSyBi2ZU/yNbvprGUk+Dl/rsF3UByrhzE1vk8m2yJx4Tp1P/nSa
 UpmdoSeOkShpKU9+HJohC3tyl5UgKGjysenhq8bqQMDoIdl1RcRNn9/cEW7Hy5Fdc7u3Pyc2oAF
 Y/jVG0DJRp3STYI4NLA==
X-Proofpoint-ORIG-GUID: aOTrwq3OLybzbqoDIx9AEz7FtJfv2KAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220112

Am 19.06.26 um 17:51 schrieb Claudio Imbrenda:
> Under heavy memory pressure, handle_sske() and handle_pfmf() might
> cause an endless loop if the mmu cache runs empty, the atomic
> allocations fail, and the top-up function also fails. While quite
> unlikely, that scenario is not impossible.
> 
> Fix the issue by not ignoring the return value of
> kvm_s390_mmu_cache_topup(), and appropriately returning an error code
> in case of failure.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/priv.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 447ec7ed423d..9bc6fd02ff77 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -366,7 +366,9 @@ static int handle_sske(struct kvm_vcpu *vcpu)
>   		if (rc > 1)
>   			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>   		if (rc == -ENOMEM) {
> -			kvm_s390_mmu_cache_topup(vcpu->arch.mc);
> +			rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
> +			if (rc)
> +				return rc;
>   			continue;
>   		}
>   		if (rc < 0)
> @@ -1122,7 +1124,9 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
>   			if (rc > 1)
>   				return kvm_s390_inject_program_int(vcpu, rc);
>   			if (rc == -ENOMEM) {
> -				kvm_s390_mmu_cache_topup(vcpu->arch.mc);
> +				rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
> +				if (rc)
> +					return rc;
>   				continue;
>   			}
>   			if (rc < 0)

