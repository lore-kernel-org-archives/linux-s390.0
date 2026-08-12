Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E5434E4F;
	Wed, 12 Aug 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534228; cv=none; b=dfwvNj1MMlDRUBr5hZzRoAVeZPawVpj5vcrEmEd6huwZHwoUDjBA9AEqDIq/KkJTceoMD028DbfDSmquOQao5ybUj/i0MzUZzQITg69tWPlzBHWB8A24fZwwZSxUS5ZNX7p5sRduv2SS0fkQmWMoQgm/ExnIHdwXPrq5pdQHzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534228; c=relaxed/simple;
	bh=vH8OPLLMEJcZgwNSmz7PIYpQoLfg9Ipq33UFS6Iu58M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0X6gW4oiunLeNlmdvTHsXVGM4dU0Lys3fI4nLSkSW20MTezYDMzphCBvS7/WGOTu8OnT6OSiGdeq/BmqqhlXrO6H6XIdoEiZrzMuBYOFv4UugMMmEbISJ1bqe0CLDEpLWrhTF/pyubYrrWJbgyYnHrf2I8TaBg4E5Tf8c63ayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EcSkezQ4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EcSkezQ4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3ie21434178;
	Wed, 12 Aug 2026 11:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jhp4XZ
	vfAxwiy/kCaruic7QmFjAvLrFB4jTL/Iw2Sy0=; b=EcSkezQ4kct12rWNwJpogv
	sFHSKa2pwU3UVzFrHjTKiCFqL6D+IHG5xujsYQnWmXlffiI1DyydXTg+PMuG3AK3
	R2Cwvnqpznlcaimkkrv4SCL3uHe1yqQNFr/dn7n3eKZ79iC6D9xMOj83kdMbpL+a
	xtrg0DvQMF3jvcDGz5eVbGm7mf5sTd4DNzX//Pbw+dCM75PNGKMlMcvD6uS6Eezy
	2rw/7BQgohibTlPEHb8/qcKXllqE7PmCJGYgk91hxB/qAers4CU+xV25kAYB8vj6
	sI3OB7S+pk4W39Cj3PmZEX61Z15U3Se01yI02e/cG/Ry9xQCwRqFe4d+zeFZ78Pg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk024fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:30:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBBhdd020521;
	Wed, 12 Aug 2026 11:30:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w5v3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:30:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBUKCL34406886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:30:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B0C02004B;
	Wed, 12 Aug 2026 11:30:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38E4920043;
	Wed, 12 Aug 2026 11:30:20 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Aug 2026 11:30:20 +0000 (GMT)
Date: Wed, 12 Aug 2026 13:30:01 +0200
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
Subject: Re: [PATCH 4/4] KVM: s390: Restore sigset on error path
Message-ID: <20260812133001.0a7031fb@p-imbrenda>
In-Reply-To: <20260811153738.206885-5-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
	<20260811153738.206885-5-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX1W+BlXZVmH9q
 tr8FlZXF12tMsRWtOfik2BSXvR10kPqaiME9i20dbC/Xrtf07OJ/90Z1sYyjHobigyt0fKwyxXf
 FDUBjGgDlw27z53lbFODeVVHViKXLWcFs9Cx/H2Uz0cuq/8fgK8SL+ea1r281aDbFXj+WJ0h2xs
 zfIIhcKvSPaNx0UQdRYiouttM+GMyWLaOcRm/ttQJjaE1lWJwgG11we+3Uvj88AQ3YehUI6TRV4
 raDUrv6QN7gyIw0t72WN5rU2UlBcQZHGIN2b1rQpG7Cv3NgOngGFj4HIN9i3GdDz8LfOyMnQq/Z
 x5RiSU/dUfPEaw4Wtd9TxxkYvWGL2CMwqY3z4eeVDb+xbHMGNa+eoLWuY1vBpZU+V7iMxoyM5FI
 024fS67i1lTb+vQPTQ87eUj4WL3K3U5EF/cpd4M6fLYkJK9geDUF3CTfCPFN68VdFEvQ7ywxiw5
 Xph0nAAz/EbPhNItr1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX6ev7+aO5vX+E
 jgte1O50svx3q/UBmHwX93XNR3rpq9zrecPg2z5tZALrbVDJ0W35bodr/+aFJYA5r92vWJFSv53
 xRwfasUyxNpaB2uabG7NG/ugkAveh4M=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c5950 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=RJqNCiz5LjKHqhFwxMMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bGOjeGhXKOCmyfMgEr49IhbM_w77epdl
X-Proofpoint-ORIG-GUID: bGOjeGhXKOCmyfMgEr49IhbM_w77epdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120089

On Tue, 11 Aug 2026 17:37:38 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> kvm_sigset_activate() installs vcpu->sigset via sigprocmask() and
> stashes the caller's mask in current->real_blocked; only
> kvm_sigset_deactivate() restores it.
> 
> For KVM_RUN on a STOPPED vcpu the error path will not restore the
> userspace mask.  Re-arrange the error handling to also restore the
> signal mask.
> 
> Fixes: 6352e4d2dd9a3 ("KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f3814dd60184..608e40401554 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5071,7 +5071,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  		pr_err_ratelimited("can't run stopped vcpu %d\n",
>  				   vcpu->vcpu_id);
>  		rc = -EINVAL;
> -		goto out;
> +		goto out_sigset;
>  	}
>  
>  	kernel_fpu_begin(&fpu, KERNEL_FPC | KERNEL_VXR);
> @@ -5101,9 +5101,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	store_regs(vcpu);
>  	kernel_fpu_end(&fpu, KERNEL_FPC | KERNEL_VXR);
>  
> +	vcpu->stat.exit_userspace++;
> +
> +out_sigset:
>  	kvm_sigset_deactivate(vcpu);
>  
> -	vcpu->stat.exit_userspace++;
>  out:
>  	vcpu_put(vcpu);
>  	return rc;

