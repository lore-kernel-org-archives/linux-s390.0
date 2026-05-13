Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A84A1384;
	Wed, 13 May 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688905; cv=none; b=B+PSiAAAqxJ+B5lK3HDxMCY5/bMLkfd6DQToi3Y0r5OIJdEWwXmUffYHTDi37HmgwQIVjF8OsXwRpTjXCNaOhvhhTRe6e7bZ38l8tGyx9/pSyOUQbbjQ6dsngPpCCflbZOnVda/Z3iXt1fuhJpe8OMHLCFuksPAZOE7lhC14Ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688905; c=relaxed/simple;
	bh=EjwvYCOGtvIhYVTJdLu0GalrkGSU1e/GgxRGmcWO4mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bJkxu/6CVYL/UCzWIwBtGaNiDst/xBAg7xY3U0DmGMDf5qzUSIc/+patpnOGvHenAia/ADe31KddmKTQivKmiFEpha1iWtPtRO+C+3phVcPCjz87tyW0mGWeL4H01fbr6/dLRKgBE/NVgI5DZVdrEwK1Xr5GQ8KyQEnammHbYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P5BDJTvu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P5BDJTvu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DFDLXs2760511;
	Wed, 13 May 2026 16:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=801QnM
	G2r9y3ZrPLI/5ElUWgWEQFBFQO2iRMyeehygo=; b=P5BDJTvuL83hDNp/kknSxG
	ZcjHz36dqKK0tJydczzdVm5UL8NGEA0jtuKAf06TMd3KLsrbHbfK5WYi/dIkHCg7
	kNvOIs935YqdY6u3Qbu1vsMQPyKzNFZ5/CakrutUk6+KeMS5kmv7NsrQtRgPJGAO
	cA/iMsPSpreSPChzBtgIjH7CjBYrmGWMmcE/M0fX4cgPEz4oebOMgnlDpSQucDbF
	KbQwTi90UrLqy8m3/7+dDN3L4Qr4b1rVdSb1u0XBG6vd/fOcf5Uv/W/NpWEjWPlh
	MJixdZoiVovFgq0W/4wDS+xL5JMoE+dB3Rh4OX2YeGg8F8qTvgXwRrP2JppInhMg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6r834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 16:15:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DG9lC1028252;
	Wed, 13 May 2026 16:15:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfggj4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 16:15:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DGEwWV28115586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 16:14:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A2D45805C;
	Wed, 13 May 2026 16:14:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BEEF58059;
	Wed, 13 May 2026 16:14:57 +0000 (GMT)
Received: from [9.61.44.159] (unknown [9.61.44.159])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 16:14:56 +0000 (GMT)
Message-ID: <5df7c185-67eb-4125-a990-62dcda992ad9@linux.ibm.com>
Date: Wed, 13 May 2026 12:14:56 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260511161451.209464-1-freimuth@linux.ibm.com>
 <20260511161451.209464-2-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260511161451.209464-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w52kgR34UM5CZgzRNSprXXi0codNDpzk
X-Proofpoint-GUID: w52kgR34UM5CZgzRNSprXXi0codNDpzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2NCBTYWx0ZWRfX+TLa81ByYC6C
 tYkTv7oLLQWTZ4/pXjy+9z3ZDzI5rgsPevZlMWUU5a2lOcuzQCz2aUMWLwobeCjOuqczirRQ9nl
 JIccVCKimvuB0pwYVFBkI0slSqcQ2YF0Jq2wC54sM7uWUePAGBV6uAbbGY96UPeOJnQU52E11C7
 NbLeLPYNMok5PddTu42Hl+SD43t6OfjWiDF0a7TO23x6jTxyNRUKmQQ8ZGJqZh2q27qFw67lCT1
 +DKk6eFH0mz6D/VNPgVfEGaXr5wXFaDbGNup0P2Ps/36NsZ5rHec6QOVFBeNZ9Uj0mCbAEJzJ0k
 xTlf2XNR2XU60fAhwOKqtXvN5BPpnoCeAB6s34BPst/Wy86Ip9fsDuElxzwdZjnNC9Gzun1DiaK
 XznY9M5kl6B1cx+O3jKbCICrSBJF7oI+Zv5ssJLKoPm2tJ0splS9I9UYHnpzPX6O0REQoJ3SiwL
 910cY08LzSI8ZI2N2HQ==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a04a384 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=u7lrdR0K_PfGbT1JAWwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130164

On 5/11/26 12:14 PM, Douglas Freimuth wrote:
> S390 needs map/unmap ioctls, which map the adapter set
> indicator pages, so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> 
> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
> in Secure Execution environments. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters to count map/unmap functions for adapter indicator
> pages are added. The counters can be used to analyze
> map/unmap functions in non-Secure Execution environments and similarly
> can be used to analyze Secure Execution environments where the counters
> will not be incremented as the adapter indicator pages are not mapped.

I think it's worth mentioning that this patch also converts to
pin_user_pages_remote for both the ioctl as well as the pin-on-demand
logic in adapter_indicators_set()

[...]

> +
> +void kvm_s390_unmap_all_adapters(struct kvm *kvm)
> +{
> +	struct s390_map_info *map, *tmp;
> +	unsigned long flags;
> +	int i, idx;

Sashiko makes a valid point here:
the ioctl is doing unmaps with the kvm->lock held.
the kvm_s390_unmap_all_adapters_pv() path is also.
But the registration of adapters is not, nor is the direct call to 
kvm_s390_unmap_all_adapter() from kvm_s390_destroy_adapters(), the
latter of which is not too big of a deal since vcpus are already gone.

The goal here is to protect the contents of kvm->arch.adapters[] from
changing while you're running the list here.  

Can you look at acquiring the kvm->lock over register_io_adapter() as
part of this patch?  AFAICT it should be fine to do so.  There are
other flic operations like kvm_s390_clear_float_irqs() which do so.

> +
> +	for (i = 0; i < MAX_S390_IO_ADAPTERS; i++) {
> +		struct s390_io_adapter *adapter = kvm->arch.adapters[i];
> +		LIST_HEAD(local_list);
> +
> +		if (!adapter)
> +			continue;
> +
> +		raw_spin_lock_irqsave(&adapter->maps_lock, flags);
> +		list_splice_init(&adapter->maps, &local_list);
> +		adapter->nr_maps = 0;
> +		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +
> +		list_for_each_entry_safe(map, tmp, &local_list, list) {
> +			list_del(&map->list);
> +			idx = srcu_read_lock(&kvm->srcu);
> +			mark_page_dirty(kvm, map->guest_addr >> PAGE_SHIFT);
> +			set_page_dirty_lock(map->page);
> +			srcu_read_unlock(&kvm->srcu, idx);
> +			unpin_user_page(map->page);
> +			kfree(map);
> +		}
> +	}
> +}

[...]

> +static void kvm_s390_unmap_all_adapters_pv(struct kvm *kvm)
> +{
> +	kvm_s390_unmap_all_adapters(kvm);
> +}

Just get rid of kvm_s390_unmap_all_adapters_pv() and call
kvm_s390_unmap_all_adapters() directly in kvm_s390_handle_pv()?

Otherwise this patch looks good to me.

Thanks,
Matt
