Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798890;
	b=ogtFBxX4mzgUYRcMIepbWFwLhLAc/++p7bLANZqw5oUaBsGf5wHBRPWXLVz1d9RPoIVw
	 lT+Mbuu16fhwZKAxiCYpm9wLObIhHUl0WtbhuMkH3wkt0ykCSu4fDYLg5OjD7GLGFjLh/
	 C+S/AtOi+lsWc9WrNxVLJ8g5Q4SXdEi5G8G9ePhD21Xamq2QqqR6540rB4qsfeyvpo9W6
	 PRlN/pVJ5YBT+n2K7Spv+4+zmL1erSwFsNp3bxMzN5cccRXvzcTy0CNSdXVm5tghQ/1Lx
	 /ELNI31P/XaCV6KM/JPvfPvJOnztiGmNUc67BcFnAasvDs6NhO7P9vNwhi/WhLmIkBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=g/zlCVOwifzRlWxKp6rHX3keLHntQyiVpiPkcK9RpDw=;
	b=C7BEQPfQIQilkMWKa3RhDGg4N/ZlHzDzjm3d4f9KqBks1Nf433USO6O5dJfvYd9FvSV0
	 JPQ0QPREEI1O8Baoqal+mVIo4kYaO1ZH7hVviceqQnipi5U6nQ7xxfJV8Q7UDVFi3UOA2
	 leRPctQxftzJAWc89sDYxhknU6ZInxjm2oAN4KWckFQctVJsUYrdFTMgYf/wPo6s/FvLB
	 dpj4Pok6nsUsPlNxTpouorMHnP7ZYafDhNoySCfjnWWRUUyQgu0KdsZlju2416XOJPofn
	 CK28mzJ1hX0zD9cTwI2K73rhAYsXYT4qEJlRin0P+/J53jeJiaMKmcikr93LzrD0vhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IgTfe2sb;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B8606A326;
	Wed,  4 Nov 2026 13:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IgTfe2sb
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bi3k53025961;
	Wed, 4 Nov 2026 13:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g/zlCV
	OwifzRlWxKp6rHX3keLHntQyiVpiPkcK9RpDw=; b=IgTfe2sbDsnNqAr+Kmh48y
	WjZkm7gdVXgdctovJr8Gul/AK50CtXyn5Ulu3p2PBLa1j6bVDRSHKGlp1vhC75/5
	uAZ870e3i14o1Tkn2PuUUkRbnmX+UNPqRBAwZtYeu7JyAduFq44rGniLX6Trdg5q
	rsoiwb35IKMqTLq9TvO1tXdlyDCzHORBKVHaDtW2K0ew5PKHaxNzHhNrkt1cG4f3
	3Vhzwtk/mbxP0M4unz4xNGx+HHtKoVbwL/3Ym2udiQQfZbAUiSR16I3PihrmPE6a
	VIvU4RDfoAH9w2he1AWb7LQlX2Gkh1XTf0lYjAbjVncYj2aBu6G53ESlcjc+u4hQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sv0tt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:28:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bah7k3997445;
	Wed, 4 Nov 2026 13:28:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrce908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:28:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4DS2iK47710636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 13:28:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF872004B;
	Wed,  4 Nov 2026 13:28:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69CE520040;
	Wed,  4 Nov 2026 13:28:02 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 13:28:02 +0000 (GMT)
Message-ID: <4fe568ee-bc18-4899-8ced-853046949bd2@de.ibm.com>
Date: Wed, 4 Nov 2026 14:28:02 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] KVM: s390: Allocate page tables when CMMA is used
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-8-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261028185422.272146-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2eiNjAEWLkMKf74RdSr2KdBPEwULsaKj
X-Proofpoint-ORIG-GUID: 2eiNjAEWLkMKf74RdSr2KdBPEwULsaKj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfX9kH5Rk4Iyp3b
 z7ccENV+DkLxfiAzF5iLIB0MSHDVT/3IfEf+GsuPxreOscDAAbQg8DQFBrEyXbVg/5DhtXXCWms
 1IYNXA1kwTSSAJCYCxp1w6Wox6s6g3RVvWZsJx7dC5/PfwYsHzqEPVgaHK1exO8oINJjorOZLyG
 LqbkcJvIVXsdRks7OQdVWwUBeGIbBhoxrKWUevXum78DBI/R5rXLXvOn3ZsBPqsaN4ZCsmEJJ5A
 VrwVdwk624MUB48lwJCrDVGv/Z2ogJeZvoBxI9RSqnznD31MHRCi43D8ABZlivU+ij7oy1AYdG3
 A3Pg1r2VKEv0WjA/uY8Ht/l1SX7tAiwx/uLRZBDWRVhfRaGu3ltRqOdO0f31r+U20cJcMKtR6c/
 iIxZnN1e/S++ZqEcq8fpcTtBbR1h1h62Ssh2W7Grqq69raJ22qDtNR7dLzboH9z3to4dDCArMoz
 ceF7nwdwadf15tX72rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfX0ngcZ8Z3I/rJ
 OqdYKIGVe1s3wHr1bUNLXO6CoHwGNuPEcsRO4m61z8Qp0Ovl2C2K8ve0GSp1iZa+wW2yhMtHAUi
 5cR/R0YD5OigIkBsj9A2HaqRhlEwwZY=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aeb32e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Bnqi0l9f2dhktuq4ducA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040052

Am 28.10.26 um 19:54 schrieb Claudio Imbrenda:
> When ESSA is executed in the guest for the first time, allocate all
> page tables and split all existing large page mappings, regardless of
> the hpage parameter.
> 
> With the page tables present (even if all the entries within are not
> present), ESSA will not cause page faults.
> 
> Without this fix, ESSA will cause a fault on the first page of each
> segment (1M block). If userspace is backing the guest with huge pages
> (hugetlbfs or THP), the page fault will be resolved by faulting in the
> whole huge page. The result is that at startup the whole guest memory
> is faulted in, since the guest will mark all of its memory at boot.
> 
> With this fix, no extra guest memory is allocated. This will also
> prevent the first page in each segment from being faulted in, regardless
> of hugepages.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Will that prevent THP?


> ---
>   arch/s390/kvm/s390/priv.c | 5 ++++-
>   arch/s390/kvm/s390/s390.c | 5 ++++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
> index 856939acf012..4f0dd3173ab9 100644
> --- a/arch/s390/kvm/s390/priv.c
> +++ b/arch/s390/kvm/s390/priv.c
> @@ -1248,7 +1248,10 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>   		 * value really needs to be written to; if the value is
>   		 * already correct, we do nothing and avoid the lock.
>   		 */
> -		set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> +		if (!uses_cmm(vcpu->arch.gmap)) {
> +			set_bit(GMAP_FLAG_USES_CMM, &vcpu->arch.gmap->flags);
> +			gmap_allocate_all_page_tables_best_effort(vcpu->arch.gmap);
> +		}
>   		/*
>   		 * If we are here, we are supposed to have CMMA enabled in
>   		 * the SIE block. Enabling CMMA works on a per-CPU basis,
> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 18fb200f854a..739e8c23c3ae 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -2359,7 +2359,10 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>   		}
>   	} while (r == -ENOMEM);
>   
> -	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> +	if (!uses_cmm(kvm->arch.gmap)) {
> +		set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> +		gmap_allocate_all_page_tables_best_effort(kvm->arch.gmap);
> +	}
>   
>   	return r <= 0 ? r : -EFAULT;
>   }

