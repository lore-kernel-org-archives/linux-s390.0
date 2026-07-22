Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890F1DF27F;
	Wed, 22 Jul 2026 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743547; cv=none; b=h8sWY5IwWkXViYGLXJYGrD8upQkbPwR1XI0NxLPd5ovrtIhZzkE8BNG+YI7xACil335ymo4ZPPzl8wVmeQGSmetQUzUt9HrqoRvwWzUa3W8Bsat5YUkvrskfLbb6NQG5asGbFfh07JQ5Fi3+OlaH6CaYMVswMzpzeGf5/lE/IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743547; c=relaxed/simple;
	bh=QPRP6F7yqsqPGfrJlwmcArGH3IE9n0TowFrshLG6sJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovGjvtd8zKS4ghdugwN9fF+z/fveDQdJZvkzSTkql9g7MGTGh5xplYOBuyCSj7mWByzoSfbzzCXmVaoIW5HtDxPtlZmrlV5CLJEP5ewd9OJjk03F01qC8oVcNYIFcWJ6RP27K7LaYeWE++720qQ7YzEyr8JHo2+coKlnTgDjuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7Vzk7/7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7Vzk7/7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFffdr383628;
	Wed, 22 Jul 2026 18:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Db4hm
	QOTDATjO8uTSnyqr2auNQcaCMhg0xqxQmQZkY=; b=Q7Vzk7/7cMmqJ4RhvakvQB
	klXyAZaCM86GdecDBPFhbTk8/Qz7TUy+qZzrE6AeOGtdmqJeUKZz+PBAgQ8OGNyq
	0wmoV7MEKhi4TcQ+defQKIj4rHv3EmrLz6ufzhh8nwQ2fieoDe7vNEZNKfoabPXW
	26e1cDgBl+5mh6+RReuZ7obvot9YQb0qK31I4o/cp8yR7AcGFwfKYn7/hIiXs5VC
	31lKMk/n1cAEP8+v0tt3kpu80+tbSAr7WR3D5VzZqKZwOBH6JQ8kfHWLhO5ghHue
	G4xny71SaTfMvVxFbtMwtWduwbjmEXyX1MwD+Vr8ZsQPedsfXQpnPJuKvVgc+H9A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahb4vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 18:05:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MI4kBV003313;
	Wed, 22 Jul 2026 18:05:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk0hpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 18:05:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MI5ft659834796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 18:05:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6562058061;
	Wed, 22 Jul 2026 18:05:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B6F95803F;
	Wed, 22 Jul 2026 18:05:41 +0000 (GMT)
Received: from [9.16.36.179] (unknown [9.16.36.179])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 18:05:41 +0000 (GMT)
Message-ID: <ed15f41a-d2c3-45b9-a5f6-2e86bcdf290a@linux.ibm.com>
Date: Wed, 22 Jul 2026 13:05:40 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720222238.1576-1-jhkim@linux.ibm.com>
 <1f64ec8b-2e22-42c7-b823-74d2bc30f3aa@linux.ibm.com>
 <2a080b3b-1a2f-489d-9d66-492e00c57f72@linux.ibm.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <2a080b3b-1a2f-489d-9d66-492e00c57f72@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k3wMPvXNPmaJ84Df8VJjC94Y8NBtuoku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE3NCBTYWx0ZWRfX6wGfpP1B17RE
 svtMZb0ZKVG7ye7kW4WfUrwOB0B/OuBrXbjh/Rf36lv9YmFFa4VYRrDh9OjpyNfzTspf6wNuO3+
 NmvselvDRCLYba261aIyq5ZV1Hv2bju4IVn65SaY4CR1mDSFl68SUhyIfm2MNlaiWCq3LqBlvza
 vfdSABflnScFg6IG3k8cUvA+8B763TsL6F/EdNvddMijOwsk/Z7TFACUwXOlWdMiaZz7qLwJPZ8
 hlkFZktnOZRzLEi+50jy50GfbUux2XH8ALPwMFDEJyTjeW4kyzD5OYWvPuOvj1YgHFRe0/UnBPG
 5BGtc2RGtPDj9/ZNXRORfy/hpyrdUCZA7rpvuWVoxYVrTaflXKqjqzg8IXAA3Dn+F4TjQT1i2bN
 cxjte3fbdjqHbNd4y94YGfEInaQF3SUcPyvjaDv20hD1UNgwUNIJuNvKDnZI20P6QsVPfuniczi
 6b6LiQuhGRmeLFWIhaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE3NCBTYWx0ZWRfX6Fn+1cm4Cp2c
 nZ4wCLmXiT/YIBUuJ1kH9sSXE0SAV//ROGVQf2KGVwH+O+O0/gLxKB7wO5OkcNW8moi8skYB/81
 ClK3JEzuhfqXP1RAAMM7mLL/vYyczeE=
X-Proofpoint-GUID: k3wMPvXNPmaJ84Df8VJjC94Y8NBtuoku
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a610677 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=jlelUyAgpgk8ZDXLglcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220174

On 7/22/2026 12:07 PM, Christian Borntraeger wrote:
>
>
> Am 22.07.26 um 17:51 schrieb Matthew Rosato:
>> On 7/20/26 6:22 PM, Jaehoon Kim wrote:
>>> FOLL_LONGTERM pinning fails for some memory types, such as file-backed
>>> guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
>>> irqfd adapter registration fails even though interrupt delivery could
>>> still work via the existing non-atomic path.
>>>
>>> When FOLL_LONGTERM pinning fails, verify that the page is accessible
>>> using a short-term pin instead. If the short-term pin succeeds,
>>> immediately unpin the page and return success. The non-atomic irqfd
>>> path already performs short-term pinning for interrupt delivery, so
>>> this restores the previous behavior for memory that cannot be pinned
>>> long-term.
>>>
>>> Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean 
>>> mappings post-guest")
>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>> ---
>>>   arch/s390/kvm/interrupt.c | 15 +++++++++++++--
>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>> index 9e3e6b0d72ad..4b68e0cb51f6 100644
>>> --- a/arch/s390/kvm/interrupt.c
>>> +++ b/arch/s390/kvm/interrupt.c
>>> @@ -2520,8 +2520,19 @@ static int kvm_s390_adapter_map(struct kvm 
>>> *kvm, unsigned int id, __u64 addr)
>>>       map->addr = host_addr;
>>>       map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
>>>       if (!map->page) {
>>> -        ret = -EINVAL;
>>> -        goto out;
>>> +        /*
>>> +         * Long-term pinning may fail for memory types such as 
>>> file-backed
>>> +         * memory. Check whether short-term pinning is possible so 
>>> that the
>>> +         * non-atomic irqfd path can handle interrupt injection.
>>> +         */
>>> +        map->page = pin_map_page(kvm, host_addr, 0);
>>> +        if (!map->page) {
>>> +            ret = -EINVAL;
>>> +            goto out;
>>> +        }
>>> +        unpin_user_page(map->page);
>>> +        kfree(map);
>>> +        return 0;
>>
>> This makes sense, but what happens later on the kvm_s390_adapter_unmap?
>>
>> Won't we return -ENOENT because nothing was in the list?
>>
>> Is it worth detecting/recognizing this case?  I could think of 2 ways...
>>
>> 1) re-doing the above test during unmap
>>
>> 2) stashing an entry in adapter->maps but with a new flag that indicates
>> it was approved for short-term pinning only (e.g. return NULL
>> immediately if a match is found during get_map_info() with this flag
>> set), and during kvm_s390_adapter_unmap() and
>> kvm_s390_unmap_all_adapters() just remove it from the list without doing
>> any unpin/page dirtying.
>>
>> #2 might be a little more code but sounds cleaner?
>>
>
> When we are at it, can we also fix 
> Documentation/virt/kvm/devices/s390_flic.rst ?
>
> To me it looks like qemu does not check the error for unmapping, but 
> yes, maybe 2 is
> the right thing to do.

I agree that option #2 is the cleaner approach as well. I'll also update the
documentation.

Thanks,
Jaehoon.

