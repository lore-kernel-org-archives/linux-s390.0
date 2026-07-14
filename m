Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD003F822A;
	Tue, 14 Jul 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018705; cv=none; b=G0O04CbQZzi3rP+ixbNIqkbtqvzQT4pX0sEzyzQ3SnmOjrP1X66y0vx1zlebXXM2wBcgeZVQKdC7yi8Z3v44/fU0MZXCNwo3o8qs8m7Jm3IyFx483qMjcQBN0lR+c2r2pmu9+AmBIdLLgn0WAgCbfALtkmHLz+6PYDPQcdF7gY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018705; c=relaxed/simple;
	bh=xtJvXATLVpOo96Z5w9TpLQQp4beYZGsCl2yQMCKVago=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm92AzzCcCmvsJl++N+Io2Ga1BdC3rw6LV3wpjzF6xTWHLGwyQuKfhldJk0hjymLpEACXS0wd6K97Dp1X9BPc9nEJxEnKG9+wQdCbeBLFSk/i1pNrx7lyvHFo55JpFGb0YOHPel7CsW55LEauGnYOMmPM7JdhE76eGAirr1cq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p9Ww0pKM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p9Ww0pKM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6fvh3547331;
	Tue, 14 Jul 2026 08:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fu8oy/MSKMY83NKDFpT0hU2LxVQFj+
	CVw58Zd+ZHMHc=; b=p9Ww0pKM0EUKwYF6y0Q0HSiS3GueYKQWuJuooUiVfMcnGT
	KDwFjLP6hKd5ZDDVVzqlWbCYJD6mSWOsqtkpGPEDgpOB/MeLqPRuMETlBAfZEM74
	bq8eKqqZCxzg/z289IIdxuoku6yN5hrK7ifJQJKRpdPVmRy8JCSx9BEJY2Sj4Et+
	tQBuC7tby1E4382aT6FsQiGteEDJKmLi4+Of/oN1QA37x2RNLaUh0DogyF43Yt48
	bsj72JoWMpbJ8aruU3T/R894LlVPMJXYuMmNgTTyv29YVQsOVgX1AWgKnXCIBKh3
	yZu8EHJrWIQJG4kDZ5IedzYfGD0bjZsCkYMQzrqg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbmnva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:44:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8YcMZ017063;
	Tue, 14 Jul 2026 08:44:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jst4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:44:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E8ijoq39322028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:44:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B864020043;
	Tue, 14 Jul 2026 08:44:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E3F320040;
	Tue, 14 Jul 2026 08:44:45 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 08:44:45 +0000 (GMT)
Date: Tue, 14 Jul 2026 10:44:44 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v2 2/7] KVM: s390: Return -EFAULT instead of
 PGM_ADDRESSING
Message-ID: <20260714084444.55132-I-seiden@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-3-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713150857.269954-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a55f702 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Ut07lfCzzDaAezmImtMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX9EQCtyd14Y0X
 mbDQsPCFSe5vzbi61E9teVu2GYSXMUuGdz2nmArIpBosTywvOc4EH01zFJ26yWnrVHQqZf4Ypnj
 s0JsL8klL+8/N7CorhoKN9swBVH5P18lJdMh650nMUxXddFVbCEESvvdCZXBCD+VKkxtDbASGzf
 W1N37zzySCLMp9ZuwviJ+ebtw6T0MsSFF+noheUvpeW2Bxyw4yQ7Ky95ZoFzqvgAUqaneKfLFMu
 7wFqCkBPfQ6e4cf/WMRPTID4ho5gRxZACP0A2ImVY1+XcG732t2R31KyG29kc9QeHCLA3BwxJN2
 r+luy/A0dxHfB0GwsLlOcghzqS4FDpUtlqVBrueFAYvAfkIAVW0jwxXMEFf+BDqhA+glIaCVGgY
 Rg5SklrZUcE25vMVTAJkHGvP5rjHvjwHlsCkuKy0hwIsfloDO97SsVhM47N6qrqx/kYqXypgr5R
 HSS3xDmQitcwXIKs4YQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX084txLcyWect
 x8HYMGXIOxltdTaxymgActj2iTq0jpdTk2eP7FlKU0vaThwYlWShTzsgxNXvH7m/X0pQsqvPzru
 0IX+6kODZEo2g9f4GPnwyK8qjNzIS1g=
X-Proofpoint-GUID: Zk6BuJTj3vi8nghNhuT5oznMEmd2wyZw
X-Proofpoint-ORIG-GUID: Zk6BuJTj3vi8nghNhuT5oznMEmd2wyZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140090

On Mon, Jul 13, 2026 at 05:08:52PM +0200, Claudio Imbrenda wrote:
> If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
> memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
> value. Same issue with kvm_s390_{g,s}et_skeys().
> 
> Fix by returning -EFAULT whenever the return value would be > 0, which
> is consistent with the behaviour before the gmap rewrite.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 374dae6dae81..53691aaf6534 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2212,7 +2212,7 @@ static int kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>  	}
>  
>  	kvfree(keys);
> -	return r;
> +	return r <= 0 ? r : -EFAULT;
>  }
>  
>  static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
> @@ -2274,7 +2274,7 @@ static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>  	kvm_s390_free_mmu_cache(mc);
>  out:
>  	kvfree(keys);
> -	return r;
> +	return r <= 0 ? r : -EFAULT;
>  }
>  
>  /*
> @@ -2384,7 +2384,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>  
>  	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
>  
> -	return r;
> +	return r <= 0 ? r : -EFAULT;
>  }

Wouldnt it make more sense to let dat_set_cmma_bits return -EFAULT?
(there the PGM_ADDRESSING might come from)

at least change the documentation of this function that it might return
PGM_ADDRESSING in case of an error.

Similary, dat_{g,s}et_storage_keys may return -EFAULT or at least have
this behaviour documented.


	Steffen
