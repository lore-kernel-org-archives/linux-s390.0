Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB7477E58;
	Thu, 23 Jul 2026 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809092; cv=none; b=JioGd84yi7td6E4oIV32e+BYPE8dUPOauqAU2woXa28XjhYi9wJh5utwngxdVbN3ZbOjPrOhCz1HGgfSn1Aa7q2W5h9IYKJR77oJSn2onw5hYE/AvvRmRRcSE58Kued3phKfSr2+VcuVU+Sk0qqXM4KlziZR9dAwR8saEzLA0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809092; c=relaxed/simple;
	bh=nmgM9AwuZvxISO6Roc5BDhS7Gq3x/xS7/YVV3zh0m3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A67Rm+n83CjBoG1N+v7PXqShOtJGGkXLx18VlAW6XoT46inldfLx/Ga6L/LosXmdtKCKhhjAddP/HFl0h1o4MaWFUETwOeKKbdejg3F3rGtuoaao3O0k1v0Vo9OskwIjEHzM4AhTEmEMpyzVQfsOBu+lqR8+vHh0lCQZaFbm5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VvXejdK4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VvXejdK4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9C9Y4702150;
	Thu, 23 Jul 2026 12:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eo14IG
	kQDu+Gm7WGvmVnStuJGKAY9Mqcjx1ltHmG3dA=; b=VvXejdK4o+Ko9/eHKn+3py
	cZ/9i3Lv8S5JFVRQVn027wNZBCjIMvU//gXt8gR6EPhr9mF+3xyuVrJWuXoSedIM
	tRAwa/ai20xtVmxS1AZf9xV7evueQibWBWGVjeTQFwWKUtiKJJ8REbFsOdvCeD/i
	p2QdkE0KDt4vtHzHIyfiV9mmqY4jkJKQCCibR5Jg/fClrbQPM8VmsgYpuTggooqX
	4qz/h8PN3zakIOxgnXbqe9xa3rYAxlwe+ZGypsh3HJ4gBXUhq5SQDW3uRQCphgA4
	DV/lC+e0hLNWmb3jGKTxWdpV9jmMBbaYkmdUs5qP3kLVZuLGqeTmh14fUUIdawSw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqcsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:18:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NC4fgE010285;
	Thu, 23 Jul 2026 12:18:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4238-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:18:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NCI54e14221600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:18:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F105120095;
	Thu, 23 Jul 2026 12:18:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19EA2004B;
	Thu, 23 Jul 2026 12:18:04 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 12:18:04 +0000 (GMT)
Message-ID: <acc6d323-5897-4539-b84c-c60852fe7144@linux.ibm.com>
Date: Thu, 23 Jul 2026 14:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-6-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k5AOPA2Vjdh3TdCsLzJcLrLJVyF6tFDY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyMCBTYWx0ZWRfXwBWNAfefqPY4
 qBjymveJRCcOkPNflVCfKHeC8637xaBAjvg6rmCxyK8eHEIQgPutoa4JyuItRerQ6wsjdNenFFK
 ozAVuUlp6CF+Fy7WoL2YsJl6tcjq5pg=
X-Proofpoint-GUID: k5AOPA2Vjdh3TdCsLzJcLrLJVyF6tFDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyMCBTYWx0ZWRfX0sATCfQZ2JeW
 JK9RnA9w2zXFnU1u8/27CmMp9zeqr8d6WusHRd4tt7Fn4FkVHIcu1BgSJmwCnHUecoNljWdOvxK
 SLzN5Pe0yHynMHqgwpxybDglqmyBdBcTOuL1su+XZwou0xUdAOr5TvGr6bqZZbPPrRuoMlxeqQr
 z3o3VrRrYCw20zcv3ZL7LBM4H+iQLyYaQTk+8UG6QO0jm5wMYNDN2rdIgVQ1Qa4B6oltFJpYa02
 /zFiaNr9e0zFhj4UD9jHXTkyFvFWEJfwFeAai7m+TUHMcQX15dbhiFtmw397ZCnWkwr7diCNPCr
 VYVr31UOudWAtww49EkB0kgZ9JL9c3cmLkaIoYQxea1dIrqRhkJ/8FqAEy/TVQqduEK7sFpz+AZ
 5qYkLXHBZ1XqHA4q3t4hIRSNf10dNr93bOAMC9RHazhiVVP3R8VPQ3a+eLeeK2vi01R1i8OpUpl
 ias5Fr1qrqpWCHyyQOQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a620682 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3yGVEOXAs9jpI2OcIL8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230120



Am 22.07.26 um 19:06 schrieb Farhan Ali:
> Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
> the error code but doesn't do any resource cleanup thus leaking resources.
> Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
> unpinning any pinned pages.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 231a4236fc3c..d76b2c5484ac 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -341,19 +341,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   	aift->kzdev[zdev->aisb] = zdev->kzdev;
>   	spin_unlock_irq(&aift->gait_lock);
>   
> -	/* Update guest FIB for re-issue */
> -	fib->fmt0.aisbo = zdev->aisb & 63;
> -	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
> -	fib->fmt0.isc = gisc;
> -

This part could benefit from a sentence in the patch description but it seems
correct. But this took a while. I could add something when applying, do
you have a good sentence?

