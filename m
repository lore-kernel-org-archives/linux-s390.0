Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3E3FCB3D;
	Fri, 18 Sep 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725220; cv=none; b=iyvipkSZDloDH26826nV9rnCgedhi1EHZp0XjDGcwiaDxWEqplYaWN697lQe4kdP1DyuBIp/ptTTYCZn4bacj2i6HZjsZXbJEZtqzZudexEHSGTCagvw9MkTp1NtT+ca7u1CdymLu87dTgPUZJlIvqpX9sbwyhYkEpMn2cTdQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725220; c=relaxed/simple;
	bh=PXo58cPQdVMI15aEcgOn4rx1iY+tB75MZFCf4ZqiuGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRhACiHFcuT1gpdnV2EGdsFEOFVrG5F+fTYgPiCMFs/cMooj+mLb65Pp5JRHKf8CTBVDNuiIKE8eWcpigPHWoQKIeJfgSfqFhwiKXkaRyRaiIKaTSnsaxDh2rpM2dCnN2jHAF6UGO7NfdDFyUx91UCnK6m+q4DM2P8jncwzYE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BXnJY+Kw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BXnJY+Kw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61mAY457514;
	Fri, 18 Sep 2026 09:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=StVNTW7sQrE7aMJQyiQZ/VjGsw4C5c
	2kstKvovWi+b8=; b=BXnJY+Kw4DjINLSUZQc7L1q6QutdAUPpHY9H0KB7M/581f
	j2C14gq6Ou1gg4/tD+26aKvn44VqG7HiOW3Imxm5z+ybimkz1pDiMgtlDbGP08d9
	6HJC9HHhurJT2/StjyVS2MKUCqnhhw2Fc32woCgRvS+/vdmW7n5sMnX4MLs1fvdA
	nBm3ATZaB/KLWOOZkV2Ino8Sd2EDdGtW5uRxU3n0VTPMRWJ0tpNAzRHS1kWSL0sI
	LM/nLswldk+qe19U0mvUxOc49MvVWFkapLa2M0kNBcRLalCcP5paepdriY62GgLS
	zLBc8lq+nlT/mdUK52mfTJyxpQJZZ+1f18OU9uRA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx847d99-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:53:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9o4b0466611;
	Fri, 18 Sep 2026 09:53:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6p4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:53:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I9rNmj51446168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 09:53:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7305D2004D;
	Fri, 18 Sep 2026 09:53:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A89A20040;
	Fri, 18 Sep 2026 09:53:23 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 09:53:22 +0000 (GMT)
Date: Fri, 18 Sep 2026 11:53:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 12/12] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Message-ID: <20260918095321.20386Ad2-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-13-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918084842.2333237-13-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzMiBTYWx0ZWRfX5W5DOAYiz45z
 HDgcVI04FVkmwnD/0u7hxxzSXnpvST78sX7n2TUw38MKx+DCeyzv6BG2gg8iIG9Jv2DKJ5JabkG
 MaH0PR0lM7LTcXATRIi+Ndk2VNZZJvUveMDwIVoYwl+EqRHDwhqLyTemJeJFsRSsCM7MFBQj5E3
 xo6UHRcyEPiClWho7dLVavHizeZSxyaSgX5NWLiCCT+NeIYXVyB7EFPmAUVInjp857n0Nf3IxnF
 HYUtFNcwVUFFvFJqIBO1Y3ttqRW90oukQUXc8c852GlQyNQcO/MKpN7+cbuejwBB3rzfNeDSmaS
 t1pGL6cNIUPD3hD27MDiM+PCYQdp9qagaccXFDnqejOsgfrtiUGorU/hERorf8mpsEUxx2mol8D
 l9cZEvuZ6rCsao+ikR5iVKqRTLnASljzDVdgwIdkdAkl+ohbvJvsnTODR21THTn458UDjZH/LvO
 1uvD33D59q6JERbW4KQ==
X-Proofpoint-ORIG-GUID: cgre2q3CAEt0lqF25r9Bv6lY0dShOcWs
X-Proofpoint-GUID: cgre2q3CAEt0lqF25r9Bv6lY0dShOcWs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzMiBTYWx0ZWRfX9dNANkoe3Yj1
 XBaFzNGEC6vNwxuxIblmWIT28VJzgqL4mI24QhLLDyEsqKFSl5oXei09y1DT97fAO6qWTdowMhP
 wcMmEccIC2XT1N7+cAkIpfwLS8eOf9A=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad0a18 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1QE0VkzyRqUCxVgU6bQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180132

On Fri, Sep 18, 2026 at 10:48:42AM +0200, Heiko Carstens wrote:
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index 6411e3584283..5102d851b84b 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -132,7 +132,7 @@ struct pt_regs {
>  	};
>  	unsigned long flags;
>  	unsigned long last_break;
> -	unsigned int cpu;
> +	unsigned int cpu

Looks like I forgot to amend a compile fix (missing semicolon) before
sending. I'm not going to send a new version for just this.
