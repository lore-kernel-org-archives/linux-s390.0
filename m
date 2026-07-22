Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690B357D05;
	Wed, 22 Jul 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740063; cv=none; b=WPvf61sSTyQEiq+sA5yrnUvQqUZktiyRpiDvZ4Wy+oPEEm4USwss+waJPfo+BidHrNv+RXU8ZKRoTCcX/kF9FIjkOVnaG+Q+H7D8Dt/9wdNwvkT9w1d8mnzyt6I7Sn/g9PMbcBz2EVTxBCH+6imh82bGdcqGZaUfDKtrGXXA2vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740063; c=relaxed/simple;
	bh=RGcOPnSYLJ4mOJrYDgSzpmIPBpkS7L5XiBWEFg4u+uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvDH8WVlvDBiTaXdR7jaz5U868lJa35kAL+810LY5i/6HS4DIdqCXGOiVMLdDW9vR4wfw1QWvpoHtpu09ez4ExH1KVRsWjgOafpn0ra35o2jPF9sPpPbmWnSYZ4AhYQITEXJy+8o/TMQaV6mNG8B4Z0s+fauurFOAEAsDFHG5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ObuIuTJf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ObuIuTJf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFfZoK382674;
	Wed, 22 Jul 2026 17:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T9+QSJ
	F9EgXIyN+CEtxcSgBjFojG8nomL2QDWuuhZgw=; b=ObuIuTJfGKLsIi0HgqEtjX
	EUK2ID/jU1QSMaFhejUDk8oLt/+pU7g1qbotSvxx9L/3dirqMi17ZYOzAH+RbyQY
	Mk2Z79RRVoiOcD7aeIYBfuGkPzoIB6ac8BEt9Yt3ysSZxLoYavjT4XrQs4e2Q9A9
	0PelnXHcX9akVyRWXKSeCkRFjRvoxB22zx9l/fLykr/Lh3Bo5FGm95KTr2xQf2gz
	BpwrnEj5OboAky0uBv9VPa2v8KtEfJn3/DxCVsmYa0zqhMaFWm6vnpZ8c4N0HMt5
	jDhYa7cN4rT+r+zqTC5N50O90KBcFv7J1VZ64Pb9rQssW+OJDQD9Um8wT35DRiVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7913d5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:07:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH52bw023639;
	Wed, 22 Jul 2026 17:07:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w8dfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:07:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH7XMx34472334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:07:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B43200EF;
	Wed, 22 Jul 2026 17:07:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D558200E9;
	Wed, 22 Jul 2026 17:07:33 +0000 (GMT)
Received: from [9.87.159.222] (unknown [9.87.159.222])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:07:32 +0000 (GMT)
Message-ID: <2a080b3b-1a2f-489d-9d66-492e00c57f72@linux.ibm.com>
Date: Wed, 22 Jul 2026 19:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim
 <jhkim@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720222238.1576-1-jhkim@linux.ibm.com>
 <1f64ec8b-2e22-42c7-b823-74d2bc30f3aa@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <1f64ec8b-2e22-42c7-b823-74d2bc30f3aa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e7YFXAHHWg0xyFtufh7V8dV_SLrB-nQn
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a60f8db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Z92YMGwyAAsvk4tsDzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX9gtJeBmyhAj1
 qkchpSvPHE6acSwEksRFqCQdpZ6C6lO8i+FwjkVke7f8w260WhMiQiiJlLGR0eEz7bKqxUnmypw
 jq56tHJSaByuOnRdsNNPoRsZuRlpwKM=
X-Proofpoint-GUID: e7YFXAHHWg0xyFtufh7V8dV_SLrB-nQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX59GAfomS4c5B
 5zMsfVdeGA58BX1TrwPKiUm3Z3TUVlRFCgKe489tkTVv1459PmLEd6HRypm3hNbfW0m6TjwfDQL
 lZRHkZTIQ4WufMFiH+Nu9rNWasNQCsbPklRbtWQnVvuZzT25Ahb2AdJcOhSxZksrrY1yGkG8MIi
 QvZEZ7e2ON+swtrtkF4SxbccBYR7rnbcr8r4c17gdeTNBnQ+1lvd1IvOgWlLfnUVJc8B0lO8L6+
 lHq1hMHC5XbX6NS3BQYlfCcNV52sGfcGQuzaYLAT/we42SXiV1uT/7o8/4/GFkIuOQWWDaIRmdd
 7hbsEgkSz9huS7wtMFU7cFNHr3u69s1l/4FtfldGnpepzoB3gZWm3XNNYuNgP+rHicsJHUfHdnn
 L3oIxdcbrKuxfMd3O9V0cK9RfZsP81CsJpxMBuiBwolMBiM4HKXnBAY0j0ejX9EF6a3SNflB4JB
 Dr6oCBm1+VxJ+ZmV4PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220164



Am 22.07.26 um 17:51 schrieb Matthew Rosato:
> On 7/20/26 6:22 PM, Jaehoon Kim wrote:
>> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
>> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
>> irqfd adapter registration fails even though interrupt delivery could
>> still work via the existing non-atomic path.
>>
>> When FOLL_LONGTERM pinning fails, verify that the page is accessible
>> using a short-term pin instead. If the short-term pin succeeds,
>> immediately unpin the page and return success. The non-atomic irqfd
>> path already performs short-term pinning for interrupt delivery, so
>> this restores the previous behavior for memory that cannot be pinned
>> long-term.
>>
>> Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 9e3e6b0d72ad..4b68e0cb51f6 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2520,8 +2520,19 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
>>   	map->addr = host_addr;
>>   	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
>>   	if (!map->page) {
>> -		ret = -EINVAL;
>> -		goto out;
>> +		/*
>> +		 * Long-term pinning may fail for memory types such as file-backed
>> +		 * memory. Check whether short-term pinning is possible so that the
>> +		 * non-atomic irqfd path can handle interrupt injection.
>> +		 */
>> +		map->page = pin_map_page(kvm, host_addr, 0);
>> +		if (!map->page) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		unpin_user_page(map->page);
>> +		kfree(map);
>> +		return 0;
> 
> This makes sense, but what happens later on the kvm_s390_adapter_unmap?
> 
> Won't we return -ENOENT because nothing was in the list?
> 
> Is it worth detecting/recognizing this case?  I could think of 2 ways...
> 
> 1) re-doing the above test during unmap
> 
> 2) stashing an entry in adapter->maps but with a new flag that indicates
> it was approved for short-term pinning only (e.g. return NULL
> immediately if a match is found during get_map_info() with this flag
> set), and during kvm_s390_adapter_unmap() and
> kvm_s390_unmap_all_adapters() just remove it from the list without doing
> any unpin/page dirtying.
> 
> #2 might be a little more code but sounds cleaner?
> 

When we are at it, can we also fix  Documentation/virt/kvm/devices/s390_flic.rst ?

To me it looks like qemu does not check the error for unmapping, but yes, maybe 2 is
the right thing to do.
