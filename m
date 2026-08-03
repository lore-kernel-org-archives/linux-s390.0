Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07182E7365;
	Mon,  3 Aug 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766112; cv=none; b=Zpkho1qIx9RkNmocSe4imMZn9TZqm1ZqSWqwyA2g42GGqD0p7hpPzcfjXEl3GyCnLoQbvuiagKK7QMjgiQOJyURQwaPt6AYfilJhmq+CUmGWPjOKYDNIQmIRRS+LdoQAjQbvx9JDjDwnS3SfDXcKL3Flrqh4DT2FJ3Bqv5mHXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766112; c=relaxed/simple;
	bh=L8/fdCorWeJNAHphY2bA84IhAj9ziQdgK1NlLSQHFkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4i8CVDdTy/auwKF2AE9yisGAysI1tHE34s0EytGcjKCshueNLNN9gnpNk9vBdJBtOBZrhVByEZ6geuagCQ6TcvOvvN2U/kfXbMxrN1Pux/V2Lhz7H+k4KsSAwGJ1QzHGv4CAq6+eOo+fAwmrr13GULZyiVR0msxld83fwDTgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U+5ERiZ6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U+5ERiZ6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673Dlg052194645;
	Mon, 3 Aug 2026 14:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oKSiox
	KGi33/OZpp6NIG9X1mKxupjKgxJWpLRZUGk4w=; b=U+5ERiZ6Uym+prs9N2CatU
	328Fm8r+gVCBZasHAj/dAeAT6eoKYMXfYiRk2VROdZjsRC0ZABMstEtyn46IeAq1
	on5g7SLdVfLtNy5pfFEpwKYwDHOh/RM8/hYyrv46i7tFAT1auTUkyggShw7Pz4T6
	f/ptwepUxJjmSTL7Z5VwLarkCDA3r0RCZ+DlibocL55VzgWwWoaULUJdRDVtcZJW
	h29vzRTBNkWBCH1VJWG/Z+63S5ftgEhOATHbyxrmx6Lbc4CKIPvLGdNnjSCBdlm2
	/G/kHcBC5lQ6ElT70Iyg3IGC30T4ZThWe0cRx3AvsaKxJfsuXIOQClsVwznTKF1A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3s6ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:08:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DuHI8008282;
	Mon, 3 Aug 2026 14:08:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jwq2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:08:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673E8N2I32440716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:08:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A4420049;
	Mon,  3 Aug 2026 14:08:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09B220040;
	Mon,  3 Aug 2026 14:08:22 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:08:22 +0000 (GMT)
Message-ID: <09e79918-6f3d-4990-a8ac-3f4a5e9447d6@de.ibm.com>
Date: Mon, 3 Aug 2026 16:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/13] KVM: s390: Do not free SCA if it was not
 allocated
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-3-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260803124040.126471-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a70a0dc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=M5uM2SGDJJfKum1V:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=2HitSDPJqUxGu8htRZYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qoiKzP9xAXQ36osAhgydZUOoxnL9gM_q
X-Proofpoint-GUID: qoiKzP9xAXQ36osAhgydZUOoxnL9gM_q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyNCBTYWx0ZWRfXwEXZtk5kfs2+
 4aOtBJnch0T7RZbyZl8CGQAmlOVHIPI6/JD4x8l9Og0zeoM94KvMjdDwrccLtnzvWdzUthbEPFT
 xtllgwxTPgZZdWr00cq7xv2yZyc05GA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyNCBTYWx0ZWRfX76IPY8F7xvC9
 kaATVcpwG4DW1QS2IyVtSQW+IjSTX1BaAuhttATD1ruD3zUHTI8Zn4pUvZf+Rq5uKgUhL2xCi8R
 OHfZhrEaLAGBdfdRYvlA3q1QuW6sCFD1O7LXEMiSFfhrI5Y8lzTnvlbwtythrH+54shqABQxT23
 qPAfe7ZOphYVh7rSICA5jYmGN0Pn3zK42/Q8+2X7UGwSnfLo/EhcvS48086wMKBTgMtJh/OjDUB
 uJf1PJlawUitmK4Xpdd5R+68u1ueWv+QJnzB2fFJVOIdW0vEh6BHS6Uk1xO9DjH5lT6Jlxo/Ap/
 d8mLsT8lSOZdaXJKk3Pz9UtemLjPO6qr0O9pNQxAa4vGF68mVrkzTMszs5U9u+nWhVY06b5ezxv
 DIeNtmX6pyRV+JJpa00bbc7lRBFGYNFT3yZVcqgnIfozIIb0pcGwIedIhaJoF6JzAgwGupPFL3i
 QGdhvCKjxHeqd6PoCHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030124



Am 03.08.26 um 14:40 schrieb Claudio Imbrenda:
> If VM creation fails early in kvm_arch_init_vm(), the cleanup code
> tries to free up the SCA, even though the address is 0. Due to using
> free_pages_exact(), only the first page is skipped, accidentally
> freeing pages 1, 2, and 3.
> 
> Fix by checking whether the pointer is NULL before attempting to free
> the SCA in sca_dispose().
> 
> Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/kvm-s390.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f86b4b0b356f..1b3290a5ad1a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3247,7 +3247,8 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
>   
>   static void sca_dispose(struct kvm *kvm)
>   {
> -	free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
> +	if (kvm->arch.sca)
> +		free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
>   	kvm->arch.sca = NULL;
>   }
>   

