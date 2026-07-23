Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628626A0A7;
	Thu, 23 Jul 2026 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816451; cv=none; b=uzlechXk0phIAiCtHLrG9FbKBDnECVPMIrRDbQ0lTh/QIXmsd2nbd2h+Wa4fM9uWcEHyhTZZTe8QO6JKEFkQ0SrNRq0UxcX/sjagevhAS1Me6kZZyJ8b03rdmdO0+62VtvKHiGtBTUOA2URap0N+ZVNTS83fS4n1fok7fl52eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816451; c=relaxed/simple;
	bh=WTkX9YCsopdjX51a0UPZUm9WdPr8OVzsVHgxPpVtSkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQuR1CCtJnO1dllHcwsQ9TC6xsTMVHkhABc6dW+7Evnp/dt1TPOQu9826GVisVIcCNqMDu4/rk4pDAH2M4Vy67W/f6KOTkOTt1lQiupSJzwYfw3bwItDX9ks5gms1FqqSqPBUZzYFaKcLr+2aSaNTXARotWrT/un0az13rs1rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OkCo6+EU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OkCo6+EU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBtWQ3090105;
	Thu, 23 Jul 2026 14:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JwT6Sw
	7ZZecd3S9A5MiOyrIjeSUfviSSoRMT0HS6pfo=; b=OkCo6+EUiYCd+ANr2hYty6
	O6m+5RHPvp3TFbUpmUoRjX+0MNrWXuVp1NmU51Kow2ZkgJLGJiqEga+/N2bdLa/m
	kvAA/gqJarQJY+Qs7QFZ7yZQn+yhgYq1wYe572sHN9rcBNhDThPQJKCevxwhWA8e
	rZbIzuTom5UuUJWDnHWuhqE++5kRhx/nst/DXiAWXNh2FCQEc94fkNmKJs0q/EBb
	sj8ONEE8m5pPJ+VfmkgFxczaGUdpOMFNEtKPy7c0f6HM3NAqH7RdaecKXAjrmaJ/
	iWEfzM+5HOt9TGA+8HE2+IRrv2VECHVz/0x81S3PtWmKqQAJHUr+d6EJEKJ5cchA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abr19b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:20:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NEJZ69016478;
	Thu, 23 Jul 2026 14:20:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wcne8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:20:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NEKkEF26673890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:20:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9402A58053;
	Thu, 23 Jul 2026 14:20:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EDB358043;
	Thu, 23 Jul 2026 14:20:45 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:20:45 +0000 (GMT)
Message-ID: <56e107e2-ce4b-4215-9e8f-152cedc4a6f9@linux.ibm.com>
Date: Thu, 23 Jul 2026 10:20:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-5-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260722170621.1686-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfX1cFLcLor4lZl
 Gykg0RfgUdStstFlkNLRfNPm4yRvJh6vtE1tyMz0ntdoRtpXct/e3Q46cRo/k/ryy+46fM+ZcHd
 1JZzwEY4Udclo29toxvbDmz1Gq2SAGjMJ2sX2X3tM0MXOx6S79VzxcisD7uP5Nw2iOlMhYCXZrT
 jbog9eDbe1Vdj52mOFCD1/PtgwnfC9ImGmdEJIn9tFGOqnHaKjYMu37QgHrt/2Gpejny5vY+yVt
 6zwYtm5IzygqV0ffbrk8Ko2WTGXVTAGiLUEchPLj1rv+J9qp3slWKWY2UsNVR4FsgPmKYM6UhZK
 MzeZupDqj4oDaf+PjU2umYV8Z9UsuOTx7Rk8NJ0yoDBBES+YagzZlMgdnkJqMu10R9MMGE6OzIz
 U69etrpiOjfVQFGihe6m7oU4jo7ZqyLaiGUnoVoiMl5pIyuahClkf9CezvXLQR8XvcruAMPaw4e
 Xb8WyqkeogSbL53/rog==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a622341 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=0uN4P6T7698b68kMdxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: De3dfhHHJMMatxJ8q9o3GBAEmEaj-ASe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0MCBTYWx0ZWRfX6z7JfQWPlp+I
 Y9J89OAQn01brjMJelf208Isar0AbHOgqoAEym9NeoVoswhk7VzJtU4fMiipVQX5fdY/x2/xyYN
 eMNwTV/uKwkkAXFFRrkDQ8iuVCEhsyg=
X-Proofpoint-GUID: De3dfhHHJMMatxJ8q9o3GBAEmEaj-ASe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230140

On 7/22/26 1:06 PM, Farhan Ali wrote:
> The airq_iv_create() can return NULL on failure, but the return value was
> never checked. If it fails, zdev->aibv will be NULL and fail when
> derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previously

Nit: s/derefenced/dereferenced/


> allocated AISB bit and zdev->aisb on failure.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 33abc15aa685..231a4236fc3c 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -314,6 +314,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  				    AIRQ_IV_GUESTVEC,
>  				    phys_to_virt(fib->fmt0.aibv));
>  
> +	if (!zdev->aibv) {
> +		rc = -ENOMEM;
> +		goto free_aisb;
> +	}
> +
>  	spin_lock_irq(&aift->gait_lock);
>  	gaite = aift->gait + zdev->aisb;
>  
> @@ -350,6 +355,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	rc = kvm_zpci_set_airq(zdev);
>  	return rc;
>  
> +free_aisb:
> +	airq_iv_free_bit(aift->sbv, zdev->aisb);
> +	zdev->aisb = 0;
>  unlock:
>  	if (pcount > 0)
>  		unaccount_mem(zdev->kzdev, pcount);

