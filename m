Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863FE27B340;
	Mon,  6 Apr 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489643; cv=none; b=X2BQUMfjV4Rc9HILOWuwcY/gexyWlWqwxHAeZe2FtSHXgmelNnji1fTbUwXJ9MGsVPjZfCbeut1/1w4iiF6vc1CMXZvZ4IXSZ8J8GW9n4u8lIu5ZhcgUBpTPzb+C5Leasy6bprJw3Tp9nDLh3xcjbpGY5Tr0XcTwuPRZjz8SfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489643; c=relaxed/simple;
	bh=1paIusfhVW8xR70rRuWrYhF9eF7MWDPmgJYnXhxCm8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ml3q7U9OCyRpJOl5o9rG3yS4cBvrS/dSXsTglMym59zRKzJ/oK6lq5sQ7hhQaGwXh1c3TKX7RKBgFnx/g5xGy+61mbhgysHrhwD1htU50vCKFpaiIiAVyD0gW4arBl4w1k+n+sb7+oGj7k5s+TUgoRFnOqxi0mH4iovQJSJS41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xcg2eUWZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xcg2eUWZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6361JjcD144608;
	Mon, 6 Apr 2026 15:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0JXQ+5
	E6TcrF+PxmIiH3WOnuweKTABIbYPB6kMSgnm8=; b=Xcg2eUWZd/bKGA3PWDBBLr
	4F5oiu4Bs02387Vitx5KyDUGmN3BWK97F7PO2M3Mae/STSGbeW5dGSyKf2WiNFq4
	/wpRD0HR/R92u8AVoNT+ebizjL55oUd0WTj+37T/Xvm+oOvykUdMGGlo0dGjd3si
	h8fHVXEVCz1pbKa1CjT3k97vA+LpI2RQuor4P40LiF3UIi5Gd8tY08lKvAwBuHCJ
	FGrpn2TJIJ1VfeOFnjNV1tiDgPZuSLL81EPqS0HdbwIGiuhlyzNM5GJ69w7eSH5J
	5/w/DVDM2SAWt/FGFcy1ZCXezEO3vpUvDoLrPZBp+WW884MJgfu9q4l/RoAO+kmA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat51ybhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 15:33:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636F89lC018525;
	Mon, 6 Apr 2026 15:33:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcyswbgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 15:33:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636FXuY126018342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 15:33:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA8F5805D;
	Mon,  6 Apr 2026 15:33:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 130BD58057;
	Mon,  6 Apr 2026 15:33:56 +0000 (GMT)
Received: from [9.61.9.165] (unknown [9.61.9.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 15:33:55 +0000 (GMT)
Message-ID: <acf2e032-ba50-4be9-8299-6258e1352c38@linux.ibm.com>
Date: Mon, 6 Apr 2026 11:33:55 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-3-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260406064419.14384-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d3d267 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=aEYmPwq50TgnHAoWGOkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4N1l_4nAfyVtw_evPXwtxwyoV8Hs2PO2
X-Proofpoint-ORIG-GUID: 4N1l_4nAfyVtw_evPXwtxwyoV8Hs2PO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE1MSBTYWx0ZWRfXzQ5YOD+hl8h6
 mSusd5ts3622SAcfSLjCEyN/a3M7Yv6Emkbb3qtFT979p4Ka5v07OA2Gc23DKsn5fYUbfDU+qKZ
 SEzmUYmIeIXkt3HnpzQYtgQRQdihi7VmDe+ofOEowwkQCuRH7KVetI/anc4e1FkBVIDzhZAFYv9
 5tK9urNZucMbxNmcJlHnjnX5oNymLY2jvXBD0MuMcnv3Ki0jaMETSeiGa5L/kYc69aVq/pXi4SN
 GgpOjsgnAv8iZbg9aX3RKP3Yh8AcLH4ujKhaTwL8zNDLFKOtwzF4phNimEzFaXLeWbZ7WIF5gsp
 TMG1DTKfWYWUNrnY2s/CtRqAvPm+ubhdb4yY9EAqGhdeOyRhCsXkR1KonNndjjnuZ3hivrvvY5+
 xiUvIwwr8vPtlQ2QZIom836lT4ocdS1WkzWyBo2t870lz7JhSWBjRR+4gLCJk3eTrlc1vana3BJ
 crLVz0xfa2g5r51vgLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060151

On 4/6/26 2:44 AM, Douglas Freimuth wrote:
> The S390 adapter_indicators_set function needs to be able to use mapped 
> pages so that worked can be processed,on a fast path when interrupts are
> disabled. If adapter indicator pages are not mapped then local mapping is 
> done on a slow path as it is prior to this patch. For example, Secure
> Execution environments will take the local mapping path as it does prior to
> this patch.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 91 ++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 47bd6361c849..f3183c9ec7f1 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2847,41 +2847,82 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>  }
>  
> +static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
> +					  u64 addr)
> +{
> +	struct s390_map_info *map;
> +
> +	if (!adapter)
> +		return NULL;
> +
> +	list_for_each_entry(map, &adapter->maps, list) {
> +		if (map->guest_addr == addr)
> +			return map;
> +	}
> +	return NULL;
> +}
> +
>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {
>  	unsigned long bit;
>  	int summary_set, idx;
> -	struct page *ind_page, *summary_page;
> +	struct s390_map_info *ind_info, *summary_info;
>  	void *map;
> +	struct page *ind_page, *summary_page;
> +	unsigned long flags;
>  
> -	ind_page = get_map_page(kvm, adapter_int->ind_addr);
> -	if (!ind_page)
> -		return -1;
> -	summary_page = get_map_page(kvm, adapter_int->summary_addr);
> -	if (!summary_page) {
> -		put_page(ind_page);
> -		return -1;
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		ind_page = get_map_page(kvm, adapter_int->ind_addr);
> +		if (!ind_page)
> +			return -1;
> +		idx = srcu_read_lock(&kvm->srcu);
> +		map = page_address(ind_page);
> +		bit = get_ind_bit(adapter_int->ind_addr,
> +				  adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(ind_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
> +	} else {
> +		map = page_address(ind_info->page);
> +		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +	}
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page = get_map_page(kvm, adapter_int->summary_addr);
> +		if (!summary_page && !ind_info) {
> +			put_page(ind_page);
> +			return -1;

1) Sashiko mentions that this now allows for a path where we already set
the indicator bits above but bail out early because we couldn't find the
summary page.  The old code validated that it could find the indicator
page AND the summary page before setting any bits.

I think re-implementing to achieve that model is _preferable_ but I
think we are also OK with the current approach; in this unlikely event
the indicator bits are set but we fail to set the summary bit, then I
can envision at least 2 scenarios...

1a) an already-running interrupt handler in the guest happens to see the
indicator bits on because the summary bit was already set and proceeds
to handle it and clear the indicator bits.  I suppose we might get an
over-indication of those bits later if the host attempts a re-delivery.

1b) Same as above but the summary bit was off (or the interrupt handler
never was given initiative to run in the first place) so the indicator
bits are not noticed and nothing is handled.  But if re-delivery is
attempted then this code would re-indicate the same bits which were
already on -- this would not prevent an attempt at indicating the
summary bit again.  Assuming that succeeds, it will result in an adapter
interrupt delivered.

If we continually fail to map the summary page I guess it could be an
awkward dance of indicating the bits but never being able to set the
summary bit.  Realistically, if we are in this situation (cannot map the
summary page that was previously valid) it seems to me we've got a
bigger issue.  Would a WARN_ON_ONCE make sense?


2) If you keep this approach then there is another issue here that is
definitely a valid concern -- if summary_page is NULL but info_info is
non-NULL, you continue on and use a summary_page of 0 below which is
wrong - I think you wanted to return -1 (but without a put_page) in this
case e.g.:

if (!summary_page) {
	if (!ind_page)
		put_page(ind_page);
	return -1;
}



