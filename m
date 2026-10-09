Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105681ACD;
	Fri,  9 Oct 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557588; cv=none; b=kK2FI/lC7EHnW7erGVlt73eInXKm3iz1Zmluj+oiH0TTAN4exk8frR40fSTX+Z6BMS15QVDsVyHZou5ZH6FgoaUAe/fG6pfUf1qkngA9pUHrSgNEV8WbWR3gJCeq5EL8wwFA1b8/EIC0xoSH8ZpmXI5/7sRZvBu/SKRB14m4X6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557588; c=relaxed/simple;
	bh=xXiZJI19t2BA0FYSWVIyLlTrY8NqL1Ai0Csb6G7N9o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF4bmfRNjAdbJGUOiD/3v4ZAd6cca+fR1nwg1IoWWTozlqqyKjf8Nrep7irn+5uYTmpYCDr8bSEcWFO2suUnbAZl89rGCewljYeAXi/fOode1fHhiLqAQEbpjTCgfDfYZvKxsBj+Q5TZc6Smf6Kp0zoprRf3cFRfGnDTye+/VV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtiF1Cj9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtiF1Cj9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZNax197757;
	Fri, 9 Oct 2026 14:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q2dHoc
	oKIIizrqreF9TIj1rRfwKC7TlQb28MXruAj0E=; b=qtiF1Cj9p2DvC74S6rcX77
	JsBL8xf5ktcb/LVEwR+GRRI5B3xoeHDg4Jx/F1zi7Ob42KkDxlheDrWLJMzrzzjR
	4+yWzU+0HOpT5qEqLEY4SAyTPem/tai7DI23N9qIL7A9Rh3uUQ+nORCysZiUl6wg
	mQcyKYV0ysRPfZJR49Sjs7DJUYCyImZuFlBQyzh45wBlnDzOVcvDQjMHCxyaZCbT
	L3Eduh19lrFe7exSkUJDny225iZ9xmsDTk1tmC7Pu90t9R7x8Pz3Fomih04PhRYF
	gfymaz6fSBYkLKksjTAy1hNGLGq2Sm7qgMse8xOM36V1J+dISjpVh+IPA3clS9cg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvkbqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:53:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWTsu924007;
	Fri, 9 Oct 2026 14:53:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76sbut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:53:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699Er2JK52429248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:53:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F5C2004B;
	Fri,  9 Oct 2026 14:53:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F12920040;
	Fri,  9 Oct 2026 14:53:02 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:53:02 +0000 (GMT)
Message-ID: <95c55fab-cd04-497f-9266-6c30353d73e4@linux.ibm.com>
Date: Fri, 9 Oct 2026 16:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 3/6] KVM: x86: Use file_to_kvm_x86() in SEV
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-4-borntraeger@linux.ibm.com>
 <sashiko-outbox-165722@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <sashiko-outbox-165722@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: btnWzFcfH2OKsHQMuq3zJvSqtowcfbkt
X-Proofpoint-ORIG-GUID: btnWzFcfH2OKsHQMuq3zJvSqtowcfbkt
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac8ffd2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FcIQ4akS4mhgl6oufq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfXxqiL2kNn+X6b
 gBT56dSwzfyD7YvQNUNW9IyzQ4X2Bci3ZHspUi8H3ABlSKaj1ub36EViw3ol6HbzZSZv2ylyyi1
 thax9pbzGntUcYoNcvKh57Wjkja3fDNE6DsHPnQB50mgxAbx4n7ZtIHw0SA4TiMUyIutA72wBBi
 VzLIPWIrVeD27Ns7AZDOjwMgnykqsInk5yO0ayvytvcFxOgVIw57Xxw5nIgJH/ik3+mFkMKyszy
 C9iy7LzIQj+uJuE7l1HrQTPQQJplj8BZPBPh2brQcbLysFQCXpYydA/6MhvXPXjD7Dcy9LNa5Di
 BrNQ8+TmGkXdH7GxiTl0cgJC9sOcnSjfo5JADoQ+ZS5TE8UANEL4I3/RBLSibvXa3+gVNiIpPVy
 FR97Ma/PuS324yhuYxjLBu2I8P7yDv17nSOyHa4/UrS+nf3ob3GpEiH1OcYMnfoYm5LUEjQskmZ
 MpOr9eLlWkKf8fkbzGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX/D9TGLLz9fwX
 O/Kr5CqEUv9tjFcvRcFB8bygOCCKUKwDZkVxgGUkFswDNBQfDIH52mJTqi0Gr1xhsP/DisrJ9HU
 v4ihnA2XY+qv8cjcZCwCI2RbsppkyIo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090058



Am 09.10.26 um 16:36 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] kvm: build failure due to missing definition of file_to_kvm_x86()
> --
> 
> commit 10a7cd7a1613201c02ffd0500ecb15453fab9d30
> Author: Steffen Eiden <seiden@linux.ibm.com>
> 
> KVM: x86: Use file_to_kvm_x86() in SEV
> 
> This commit replaces the open-coded file check and private_data cast
> with a new arch-namespaced helper file_to_kvm_x86().
> 
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 944aaea6501f2..2787b832c9e0f 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2121,10 +2121,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>>   	if (fd_empty(f))
>>   		return -EBADF;
>>   
>> -	if (!file_is_kvm(fd_file(f)))
>> +	source_kvm = file_to_kvm_x86(fd_file(f));
> 
> [Severity: Low]
> Is file_to_kvm_x86() defined anywhere in the kernel source tree at this
> commit? It appears to be missing, which will cause an implicit
> declaration compiler error here in sev_vm_move_enc_context_from().
> Could it be that the patch introducing this helper was omitted from the
> series or ordered after this patch?

false positive, see patch1.


