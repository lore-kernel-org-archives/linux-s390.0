Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA0434E47;
	Wed, 12 Aug 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534224; cv=none; b=e3hn7YATmoVGyuuUsDEvxXeLe0axa3GCKgCSFqAKa2PgBZ7NybcthHkZZ+no13At0DJ6N+Fe0ZINklMQyVVG4TPl4bc3tZ020Pa1v3a24TN2bI30e4yhSR3Ydl8WP2/Aj4jowO2HC/8u3Zqm8RdQULcOj73AGUy3IOmYjPys6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534224; c=relaxed/simple;
	bh=n3laDif5ma81mMLwmFyU/t0TTiGNHJnVbWl3spbcJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAQGQ+eo0qh0qQekNRAuWYFvv1t9bfJ/r15EO3jtDkQmkcoZo06off4zBfecky9NERuHJCm/28GCL+VczA5LOg+HK3sM3Alv0KApXizjPRUjHnjPBuHXU+8foDwQW/86TsBRr/2MTh+u3rT3GG/xmnTvIqxAh/4HjX6A0OwPAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ekOqaUw3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ekOqaUw3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3hSx3258570;
	Wed, 12 Aug 2026 11:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZUVe1s
	Hx0a5TdpDKs3vtMW8KLSAmwFLIgw9ZNmRaUgI=; b=ekOqaUw3aM6e5UmiSsnzKU
	PT5f9LIo296SKLxs7I1GVk+OfGUtyPz2ta2hl/l8aq8/T7EUSHeZabDkgMeyO6K4
	rmQ+l8Fxr7CypLgK55GTsa0ccRE/mWyd5MBGrsSJp4pQP741bXcNRnTkHC+TzdfM
	b6Cuv88gEMMlEFShYeznKFa87PXmEv9Fp73Zn+HJ0sRc+YWiCLlsH8ci7brDtFE7
	Rr0Vr1algOM4wWjCabbRwMaU+sKpMhl3poA5yGGJ+Vvaes6xoeTqZfITRhBzCtiP
	LQlLj/92X98ogQrpgSyFVDdyZ6f8Bxho/ODaTrndWM+IcScsb7u++CNv1AylDnHA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9j3wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:30:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBQYU8012142;
	Wed, 12 Aug 2026 11:30:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5pg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:30:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBUG4r31851210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:30:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B352D20043;
	Wed, 12 Aug 2026 11:30:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8841C20040;
	Wed, 12 Aug 2026 11:30:16 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 11:30:16 +0000 (GMT)
Date: Wed, 12 Aug 2026 13:26:13 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, KVM <kvm@vger.kernel.org>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH 3/4] KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
Message-ID: <20260812132613.17852142@p-imbrenda>
In-Reply-To: <20260811153738.206885-4-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
	<20260811153738.206885-4-borntraeger@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wo_7_thm1lUsQe0ngOWZJfqlD6weArao
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c594d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=az6OFgTI84B_PRvU38EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX/S5XhlasLGcJ
 JXIqG1lNg0aC6/r1n6KrYd9TPNhrnFcGaQKYjI9ZykuDbeZWumY4XKZjoqJlNegupqc5dLkYDkr
 0IzShi8H9yUe217fnZSeizq9FQEY1I6LyNderadOFCQrgOevsJGmlEUXlGYfhHtKFabcP0wXZlT
 yFzyqQhXBlU+7XQEt9rhCtvAnp3ep4tURtwasNB+EcMVKIk7cWNO8DZAuyGZYNkWUZ+3L49+gST
 aAeDNedjGuNV+P5BVVJZ2zKoiovaHGWnxjz9M7WWnv131AjzuO3LHK98k6eK3fdCKXd6b+KcPS+
 t2uGUcWvlTYZPA1AGuXNM9TDJ7Hrgclx6Omf3H8Vz6nH0JSkbwWk8+bO0owDt+3IQspZzfHicS/
 nZDfw6E1h+sCYcL2nYYE1hradFe7JIeIeUhRa9MxxObxCRBHtEYyObkJLqpj2IiRxOMSJaAAtcU
 keFT/uISrAZs0Ru5UIg==
X-Proofpoint-ORIG-GUID: wo_7_thm1lUsQe0ngOWZJfqlD6weArao
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX+EVjBKe75WAv
 fHkcW/xvwgFrhNAdpttXrs7F71+LQPJrzynR+DeeIBAPFZiO4Se+GgbWy+LjYfKj3QU02CvqB5R
 6DI9lnIkqkTlwyJM1JiZ4Ara+nG/IBw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120089

On Tue, 11 Aug 2026 17:37:37 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> The rc/rrc value is copied to the cmd location of the cmd in the kvm_pv_cmd
> structure. Fix the offset.
> 
> Fixes: 8aba09588d2a ("KVM: s390: Add CPU dump functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

the documentation for KVM_S390_PV_CPU_COMMAND looks wrong, we should
fix that at some point.

> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ea9bfb32d0f2..f3814dd60184 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5734,7 +5734,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_s390_handle_pv_vcpu_dump(vcpu, &cmd);
>  
>  		/* Always copy over UV rc / rrc data */
> -		if (copy_to_user((__u8 __user *)argp, &cmd.rc,
> +		if (copy_to_user(argp + offsetof(struct kvm_pv_cmd, rc), &cmd.rc,
>  				 sizeof(cmd.rc) + sizeof(cmd.rrc)))
>  			r = -EFAULT;
>  		break;

