Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0439021D;
	Fri, 17 Jul 2026 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279552; cv=none; b=caqQo25YWOV4yHiwr6c3RImuj6r4/kSkHZzkk15DygQfQmMI6GQcg/tQe3Q8WjCh7Q13bQnYwJco5L7igMXnYq8RrAo5bJIlEU+rWIvHN4F5rcFkJo9TgR6bToXi7S/jwaGIJb3YrvzVngAEHf7aHtvbfx6emuYsn8w9/fkQBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279552; c=relaxed/simple;
	bh=NrgG6wzXsuhsxLaqWjclFd3viTkBoK0FKduICqGKJ3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uhdr06R/kAj/OrBFpimqCV9zp2Y1e+tmWM40ettmzQMmL8V85gduUadGmRF+Zltp3lV7j/tNECpEj/dbjYgZBpfasGqWZGN7kDo5g4KC6WRApuq/pfiZ7B1BGpe0U6pi4Yo8pBKUGtuojY6mbF+h1V66HI7umuULsvxtZ4qvyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLlUO/+s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLlUO/+s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6flI73602584;
	Fri, 17 Jul 2026 09:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pn1kCu
	S0T4Se22HREbtrjXuQ3pvjFUBQb+5p3tp0sY8=; b=oLlUO/+smHCXEaJa5mf/oA
	Dk8JP5pn8HYrI21OWqqFrMvbdlxmkbYoccNH+LpdwTfmbBrCXTjTxBInpnw3S5m2
	em136P1YOBTDMeKEx5cN+zpV+IBDY2+Ry3b8Vxg2gLsp8UDNp4WUajwYBSZQ1t/8
	LCCeGTvzixSKcPGkiHe1Q08XBV0Da7h7n6c+LAeQuYzbvmepwkSHUveFmKtPOoyH
	VsAPj096l3q3MhU52Mcq2OCXitopsVWEfp+BSInKKdQ9bk32MldES/mbK5e0orA1
	LUvPw4ttnfRxrd0vzZi9KLP92WR03JHQtv+uUjHrBYXCAD5lQn4g8GWOSi+4J4JQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33p744-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:12:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H94wEI027243;
	Fri, 17 Jul 2026 09:12:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgrt7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 09:12:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H9CA8p50332060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 09:12:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B932004D;
	Fri, 17 Jul 2026 09:12:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8431120043;
	Fri, 17 Jul 2026 09:12:09 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 09:12:09 +0000 (GMT)
Message-ID: <778ba45f-bd2e-46e0-8b08-fcd209dd174d@linux.ibm.com>
Date: Fri, 17 Jul 2026 11:12:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] KVM: s390: pv: Use VM_SPARSE area for guest variable
 storage area
To: sashiko-reviews@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org
References: <20260716141436.2125703-1-hca@linux.ibm.com>
 <20260716141436.2125703-2-hca@linux.ibm.com>
 <20260716143333.20B891F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260716143333.20B891F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX7nL0OE9i9Plo
 w+YiQ81mAR97EXKcX+GcHyV5LaJbjvbWoXwCk6tQwiIoIH7XLR0EqRryio30xGN0E25asb4YKt9
 c/MUNW9MBpAIDypHHBedIWGEZ8JL9P4=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a59f1ee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=p3ShsxbhR_tfeK4h5jMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i0U0AczYrcwKNzZQWhU0cX-Bu2WWKC0z
X-Proofpoint-ORIG-GUID: i0U0AczYrcwKNzZQWhU0cX-Bu2WWKC0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MSBTYWx0ZWRfX2vasTyfbCrC1
 HOqnFxFHR5vwe5t/zRcPpx2Z5v1PHQOmP48a8loLwNcESgBIuCCvMnWiEEJZqHsbYa6gdMqMfLQ
 cawbXBlkqQVabxV8qQpsOn8+/a0xNgAz2HPxO+nMD5MWRVewUBrV/VeUVaxomS6d5oq2/sqG3wR
 uYO5egtccDA56GKZvORIwJDDPvVVo1Wz3dRlClaajZwkHHJ9vm7Sj+xnSJOKJ23b7VT3tWiSg/o
 aMzKo4BFU63Q3Cd7mJvzIwqr2w7YIApV2H0nWthbcmY9t5I5gaOi7aFOVY1v7lYYTyNGqhqCmHc
 OmV7Gt64lNBSroVP4uoL4RsbF3ZHOPBr1DcL41mcNsy0QMIiP88hUXPOsU7lrJSquxpVBX5AqpX
 0U39sSS2vZmySuO7a7qktlYO9xKHd1TiCk5KXm3BSCvqses9KVF/Vs4PAiOnIhGtbBAjyz8kQ/k
 w3z5w9mqmZ4KxmB5Zug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170091

Am 16.07.26 um 16:33 schrieb sashiko-bot@kernel.org:
[...]

>> +void uv_free_stor_var(void *stor_var)
>> +{
>> +	unsigned long addr, size;
>> +	struct vm_struct *area;
>> +
>> +	if (!stor_var)
>> +		return;
>> +	area = find_vm_area(stor_var);
>> +	if (WARN_ON_ONCE(!area || !(area->flags & VM_SPARSE)))
>> +		return;
>> +	size = get_vm_area_size(area);
>> +	addr = (unsigned long)area->addr;
>> +	apply_to_existing_page_range(&init_mm, addr, size, uv_free_range_cb, NULL);
>> +	free_vm_area(area);
> 
> [Severity: High]
> Does this create a Use-After-Free window during VM teardown?
> 
> In uv_free_stor_var(), we call apply_to_existing_page_range() which invokes
> uv_free_range_cb() for each page. The callback frees the physical page
> directly to the buddy allocator via __free_page() while the PTE remains
> fully present and writable in the init_mm page tables.
> 
> After all pages are freed, free_vm_area() is called to clear the PTEs and
> flush the TLB. If a freed page is immediately reallocated to another
> subsystem, can concurrent accesses via the stale vmalloc alias read or
> overwrite the newly reallocated page before free_vm_area() completes?

I guess this is a very very theoretical problem. Not sure if we really want
to address this. The necessary allocation in a freeing function might be
worse than temporary access via the kernel mapping.

> 
>> +}
>> +EXPORT_SYMBOL_FOR_MODULES(uv_free_stor_var, "kvm");
> 
> [ ... ]
> 
>> +void *uv_alloc_stor_var(unsigned long size)
>> +{
>> +	struct vm_struct *area;
>> +	unsigned long addr;
>> +
>> +	area = get_vm_area(size, VM_SPARSE);
>> +	if (!area)
>> +		return NULL;
>> +	addr = (unsigned long)area->addr;
>> +	if (apply_to_page_range(&init_mm, addr, size, uv_alloc_range_cb, NULL))
> 
> [Severity: High]
> If an unaligned size is passed to uv_alloc_stor_var(), could this cause an
> infinite loop in the page table walker?
> 
> The size parameter is passed directly to apply_to_page_range(). The internal
> page table walker loop relies on the end boundary being exactly page-aligned
> to terminate:

This is one of those things that wont happen in reality as the returned sized
will be aligned, but as the interface for base variable storage returns bytes
and in theory _COULD_ be unaligned
maybe change belows hunk to

@@ -369,7 +369,7 @@ static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
  	/* Allocate variable storage */
  	vlen = ALIGN(virt * ((npages * PAGE_SIZE) / HPAGE_SIZE), PAGE_SIZE);
---->	vlen += uv_info.guest_virt_base_stor_len;   <--- also add ALIGN here
-	kvm->arch.pv.stor_var = vzalloc(vlen);
+	kvm->arch.pv.stor_var = uv_alloc_stor_var(vlen);
  	if (!kvm->arch.pv.stor_var)
  		goto out_err;
  	return 0;


Could also be a separate patch if we want to.
