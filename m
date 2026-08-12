Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E3417D7A;
	Wed, 12 Aug 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532629; cv=none; b=cs6xVVZ+goYMw2FW/v9E2+BY9jK8U65sNJO/lyNENh2mqCkk7rOAeMAw7v5vvGvNc2WmLu6GBudV4Lrb3/CVX+fy4B6PB+RW8wZrhPcSOawEUQzFGhc1DqFAk12/mKl7941XkESMO3fLNItB2jciQXATHW7GHfor0JdNQiIymJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532629; c=relaxed/simple;
	bh=gJJjNFsw+5rjxq6tJp+GEvy26KZat+p00I/ukg27dus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHDbn8sgQsGz8qDj7+4q4xMj46tZqxtpL+mvYH59toxJ5V62w+UGVlQxamcV4QgtVE6HZXdq+6BzR8A4biNaYdazBm9NkZ7mDY+p0uGPYUWO3aXLP1Qly88a7wcMvA1E3UVqbFyBQwwY0LekAEBFdV/hWc4H+C6jZ9OcGeOQHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dhfYr76Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dhfYr76Y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3icN1434178;
	Wed, 12 Aug 2026 11:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uP7ycs
	iDv/nJkNDlAAAPQovIuq4eaAqKp9ZtHJ5HFXU=; b=dhfYr76YWmMK3tL/lm/qgz
	CnASxId78WQ6plP1eno0E/C2kMR3wkZYkQA4HFkItXBgDky3w8FPt5OYh/KIMw4a
	xEqAowRhSsGtfQhtIKqx/aAie5FL2SlYVOAsxXrGNtn7yoctoaljhRI3IFNn8rR8
	TCeIydZOTxp5bdvRN5JpatMoxshqpHK8Ac6iTXGr0SE/SlvBDnQCSXAIyqPdItVe
	KvPxsY9G7cEjrjFYHu0844nnHekKVKvA2AXHJIIyoKJ1hzUzP7QjblENf6w2xz1y
	pKYbI16Qvx87veDs9K0UHc39Ymt2zVlni3jsZ+dJyFYIzpxiUrZjMDWnBhpNeOQg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk021j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:03:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAuKNB006233;
	Wed, 12 Aug 2026 11:03:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq5u8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:03:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CB3f2b43647398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:03:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BAF120040;
	Wed, 12 Aug 2026 11:03:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3633720043;
	Wed, 12 Aug 2026 11:03:41 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:03:41 +0000 (GMT)
Message-ID: <48891afe-3d25-4a11-912c-4c2f7c86b0a2@de.ibm.com>
Date: Wed, 12 Aug 2026 13:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-5-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260812104436.109741-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX7fS2pwnLGBO8
 NTeSFbKzrBj6ztCENdfqtLd9CEpI44UjdMbMngbx5T1u8GBO0Vzboov0+ZlsCDE4MRa14BPsAvN
 QUyq5myu51AEg2uh/LpNUzypzJto2t1WkXza+/rmN6orTbtfHPfRDHiQqX5s82CXetVCGWTsgc0
 gRNKppQSYe3yYIe0bkceZSk0Tz35J0X2+NfjwJ+fw0tQFnv2SppunLCQ1AxOQ595t/xlBNG2pqz
 6JDs/lX0SUjlXJheMRGqa1adLwMe8hotJrn7NB3i5eIqDUPMNP3mEBcFrko1ELmCD3yexPRzSsI
 Ykn7ty1WebEZ5vGHjGwsQvUEmEDgYjlysBYuDXJ+jDruNck0x75K6Pj2Zi11NC6p/UMeJLnTRsu
 2WerTxDs2zWVsC9UWFQJKBKaf6GUHktfsJowE1g8eR1DwpxB58oa/zeVEYlVZFzfkkCXOdwZezu
 2v10XpifmplNaAIywyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfXyFN3BaHK9NQ8
 mw5jLucMSRK4P90kqUQIec6/CG0K+uYD+Edk0XIaB1wen8bBBBtAoS41NH5c2MSh/mbazU23K16
 vekZJkFZ2N3qZ/20SZI7L1pfOuLvG3Q=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c5312 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=dqkYFeMuMrd_YR1dp64A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Yq0cSBPr2R9qAeLA9iWOg7lqQ4VrFjsi
X-Proofpoint-ORIG-GUID: Yq0cSBPr2R9qAeLA9iWOg7lqQ4VrFjsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120089



Am 12.08.26 um 12:44 schrieb Claudio Imbrenda:

> @@ -3017,26 +3017,30 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>   				       struct kvm_s390_adapter_int *adapter_int,
>   				       int setbit)
>   {
> +	struct s390_map_info *ind_info, *summary_info;
>   	unsigned long bit;
>   	int summary_set;
> -	struct s390_map_info *ind_info, *summary_info;
>   	void *map;
>   
> -	spin_lock(&adapter->maps_lock);
> +	guard(srcu)(&kvm->srcu);
> +	guard(spinlock)(&adapter->maps_lock);
> +
>   	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> -	if (!ind_info) {
> -		spin_unlock(&adapter->maps_lock);
> +	if (!ind_info)
>   		return -EWOULDBLOCK;
> -	}
> +
>   	map = page_address(ind_info->page);
>   	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> -	if (setbit)
> +	if (setbit) {
> +		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
> +		set_page_dirty(ind_info->page);
>   		set_bit(bit, map);
> +	}

This marks the indicator page dirty before writing it.
The summary twenty lines below does it the other way round and so do both
slow-path branches.
The order matters because kvm_get_dirty_log_protect() harvests destructively.


