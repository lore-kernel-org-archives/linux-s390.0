Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A03F5BFD;
	Fri, 25 Sep 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325374; cv=none; b=dYQ2yeK5+f286CbnLJnmru2fJQ16z9W8W3YaZfqRg3x/vsbB2+qzp+vzCbpDgq9pK9B9UREmrs7Hcn+tPMi2GVcuK8kZMgOeo//0dYRDa98fwq/ca3X7vCNuH9BrDfbvyvLkc8GB3rHNJzvE8vK68Rtr77pbb6GlayomJni0ono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325374; c=relaxed/simple;
	bh=q38HZDtXBQR6+LcsOcr0u1Y8Nr0fkxsZgaryU9ptpJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwkHuqo29SLJTNr1POCC3yf+7AM5exCsQutOVAc52Tn1b04rKotUk7LM6I0paUeWkxEm6H+CL8cV6rED1sHLuIQe5ILybBIGCiFeRzSo7RYUxPXN1Uen1iZORmMr/eHJ37AN5P7NGkR5h07HSAOsCnJYyEZ8NbF7zjHz+EhWjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tBr1oY3z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tBr1oY3z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aGlN2393664;
	Fri, 25 Sep 2026 08:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ROI5Lo
	1UtYCwErLwZGAoESCWapLC853KN1OIq/t6+MA=; b=tBr1oY3zkmAysnrgZw70VI
	LSLMED6EJ4b9MUsxjPZviBSVELW3rVFxv1MiTNuy4Bpcr21hJ11feYFySyrqV0+5
	dWZ7nuST0MW+xmFXTQy/xSWI+6oL6r7EiDLzfEsMHL8lR2ADvsqw/IHz0ys8SODp
	0GkEE7NdAyux6XZlhruLQXZrNoSMj89V60pPWQ6gsQtjrwB3a6wTZX0cYU3bLng2
	0vU67c+B51ER+rML8D10MSkeNfSPBfZaykpjZewhFFkPwFYeNAnERJTvfRK/nVda
	6WBKsmVwhh1CSxPvLo+AzmWmg80PZGpYvlJMFMEajDdikKzi4nKDut7WrSMi/5vQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske261wj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 08:36:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4m3FS3245755;
	Fri, 25 Sep 2026 08:36:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu91kjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 08:36:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P8ZuM216515336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 08:35:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1744C20043;
	Fri, 25 Sep 2026 08:35:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78CA320040;
	Fri, 25 Sep 2026 08:35:55 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 08:35:55 +0000 (GMT)
Message-ID: <d8effe42-e212-4085-a302-250c60b2b5eb@linux.ibm.com>
Date: Fri, 25 Sep 2026 10:35:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] KVM: x86: Use file_to_kvm_x86() in SEV
To: Steffen Eiden <seiden@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-3-4a294307797b@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-3-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dGLi6l1XwBUL2jtDNSsfS9a8tbBneTAU
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab63271 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=BVHj57hEX9ARhV-8c34A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNCBTYWx0ZWRfX5KlXifLkL5s6
 fWzBMBcxygyW0HR51M60cjkJy6nnnnxtde9LsNRlPP8m9GqLdP8x14FQRAX3FW/t68N9dmeYC15
 ddl9quuIxlx9jRf916BQ6NmVjLYsfdY=
X-Proofpoint-GUID: HgNqGNeJzdBcmINb9MGCQLFdP4cmQEDe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNCBTYWx0ZWRfX6jcwhksNGR6B
 aEhNUVTAg1vkowSW/l8f+tLii66BFgrqk/ySnKOdx6GRFice6lz9M8MXuHZQBl1TQNqA+wonLPR
 4x1jaDq/tX/Qn/hN0+LU3n/9Lxq6395QM/IixlTA5MWgYtb4o7JTtz+eJ2ObYZDMIR9qXHMaObl
 0si+4SxJ8PA0YM1jWtWPViKQ8LsjLFHSU6rSWyimhZqIr/DQ+Z1elEDOjWViizTrZYOuw+p7JUw
 +UP8ECkaLumAFpBkhcVhpeukrolY+zB3B9tm70amf+doa9xQrcaPYIs8yQOrqqrIlpmsqo6Lboe
 J0VFB5YoOR0y91HF1eezkiMpUJTAsPaJYGEFOmLgXE4qW2I9ZNHeNajnZVd3m0HWPkKejG2em5d
 T5grEw8b1ZHrrjKGMQg8KdjEJzWMPr6Oh4qL6sq2Sdp0yKHRFWliec9MyWAmJrDdCziNNNd9DZb
 bvK9r1qCPDNYC5OOUJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250034



Am 24.09.26 um 10:58 schrieb Steffen Eiden:
> Use the new arch-namespaced helper  instead of open-coding the file
                                     ^ double space> check and private_data cast separately.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/x86/kvm/svm/sev.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5705723f1f41..6b0eacde4f06 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2145,10 +2145,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>   	if (fd_empty(f))
>   		return -EBADF;
>   
> -	if (!file_is_kvm(fd_file(f)))
> +	source_kvm = file_to_kvm_x86(fd_file(f));
> +	if (!source_kvm)
>   		return -EBADF;
>   
> -	source_kvm = fd_file(f)->private_data;
>   	ret = sev_lock_two_vms(kvm, source_kvm);
>   	if (ret)
>   		return ret;
> @@ -2866,10 +2866,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>   	if (fd_empty(f))
>   		return -EBADF;
>   
> -	if (!file_is_kvm(fd_file(f)))
> +	source_kvm = file_to_kvm_x86(fd_file(f));
> +	if (!source_kvm)
>   		return -EBADF;
>   
> -	source_kvm = fd_file(f)->private_data;
>   	ret = sev_lock_two_vms(kvm, source_kvm);
>   	if (ret)
>   		return ret;
> 

There are no remaining callers of file_is_kvm(), correct?

We could remove the declaration in include/linux/kvm_host.h and the
definition plus EXPORT_SYMBOL_FOR_KVM_INTERNAL in virt/kvm/kvm_main.c
here or in an add-on patch if we want.


