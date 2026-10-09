Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D76390600;
	Fri,  9 Oct 2026 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564407; cv=none; b=MNF59NrCx55VNAkGA9GX9STcIN7wYBgq0B9aUBWj3h8hWDETjdXXDC7XpIVbvf3K5xSvyeinNn6htG4WnzkOi/bc2CeehtdCbKChI+SOo/hVP+Fqd2M5WDPO+sIkxb7MmLS5OAHPibX2ohjErRrIZkm0vlzQirV2G2B8cOsEFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564407; c=relaxed/simple;
	bh=//xgIxxqrD/FpqFYoZmGQCojUYP8arDp708R8VVmMIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMprYzjs4uOcnAT/iwDctk6SmKznfq4sDDfAmEoBl4TMOGTrN0u7153pcAO/i2cVMfZWO0QtSXhJVyz3TjQ5U0Gylaj8WtVPOGohRz4116Tri5KecA3A8D9KWF8r3xX3nRELKAw/f0t2h0DWrTojINAW9bAODnqil1/EjdJU0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hyGDSIbG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hyGDSIbG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZYUi3587669;
	Fri, 9 Oct 2026 16:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GYUoFt
	ri3BnOvXdFV/grz+KG5/wd0LatKMpaSoeWkPA=; b=hyGDSIbGu6yNkxL8deEMYx
	AmRCouly2i+3xN9Y7mYhyNDuTjMZiK7PAGh6m6szCmcQD/CTfVa4AKh20ID4ff59
	LOfgrZA+U/c/ofr94MqxvDhrNWlNSeeQALLk/+z9PnkR13AchItFlnYWaQq238/p
	JMEOg1WpNlkStbzwaKt+47+pjUK3uKeGqIHWYgkEsul+MmkJJbTMoLLrUiAsEexR
	vvSTdl2wz+KAXhC4L5ImJvh6lUuOv3VBXYXbnWwFxz2BQYM4nX7zlOfcKxq4ol9d
	cm5LMD4+rX4CQyNWidnGPc0F/N8OUshmwUrhA/99wMC52J1xT1FEJb2ZOsWwbuCA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1k2g6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:46:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699GJK9o1147086;
	Fri, 9 Oct 2026 16:46:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1y9b7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 16:46:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699GkaL950987398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 16:46:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D148220043;
	Fri,  9 Oct 2026 16:46:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4E820040;
	Fri,  9 Oct 2026 16:46:36 +0000 (GMT)
Received: from [9.111.13.15] (unknown [9.111.13.15])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 16:46:36 +0000 (GMT)
Message-ID: <f73f015a-1d2e-4a61-82b6-0c47a2ae66ca@linux.ibm.com>
Date: Fri, 9 Oct 2026 18:46:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 4/6] KVM/vfio: Use file-based reference counting for
 KVM
To: Paolo Bonzini <pbonzini@redhat.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-5-borntraeger@linux.ibm.com>
 <sashiko-outbox-165746@kernel.org>
 <4944d4a4-cb8d-4c46-aa84-c0050991cffb@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <4944d4a4-cb8d-4c46-aa84-c0050991cffb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac91a72 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qsEgGoFHUdzIM0miMNAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX7QlGtN6F4KnS
 sDzCBegzMDDe0LQ5qEFU1qA9l1JQj5SgSycqHAiyqJHvCWqsB4wrCwvjKNtRzsd2/gaxvU0cZrQ
 o5tPK2uhZyFb7ENaoDNjtkprmAMTcBOKVKfMt7Uj/O6yEkJLHeJmwmL1nJdb8B2NeM2tvW2y7HG
 /Bwb4CUl2F0nudtju7KdiNBi2tg5rH+Q/LCWhdALHQjtb8Gw6xXuA4lEv2rRaCjJY7AAJaTuHwA
 ddi0PX3eBBWDlaRCw7m+dwqKNGVRJsRDGHbzWCQFZSCJlwLeyh8lbo/nbDhD0QndRNI18vvsVfP
 0C2837r67wwIlvk9Wx/mYVFWxh2+PJUDIOT79RMP4WuD6ZbmhQCgCj2hpLsihFLQwLFWK1W4O68
 1MFdyOfOJFakCRszPUHAu8dm526AlayINKl0WVZdNU5vrl5bb0v1kSFNipyd4ItK5h8cJDxmBbH
 EcXgHFPzOvufGquHCbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX39oi5IP0oBzd
 Tl2A0klxnhXL+o4zBfhPsYhaTsOcSZBAt8qLH9ARm+0mSPDwN/JBGIp16+VyCRHw2XXxcOwAv4o
 igj5d2ybv58+LCWZ+Sr2+qnXoJ5ps6k=
X-Proofpoint-GUID: z9r7cvkcJmYrnNwxlJtBDh1r-7SxVnj3
X-Proofpoint-ORIG-GUID: z9r7cvkcJmYrnNwxlJtBDh1r-7SxVnj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066



Am 09.10.26 um 18:06 schrieb Paolo Bonzini:
> On 10/9/26 16:56, sashiko-bot@kernel.org wrote:
>>> -static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
>>> +static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
>>>   {
>>>       struct vfio_device_file *df = file->private_data;
>>> +    struct file *old;
>>> +
>>> +    if (kvm)
>>> +        get_file(kvm);
>>
>> [Severity: Critical]
>> Does taking a strong reference to the KVM file here create a circular
>> reference cycle?
>>
>> When userspace adds a VFIO device to a KVM VM, kvm_vfio_file_add() takes a
>> reference to the VFIO file. If vfio_device_file_set_kvm() then takes a
>> reference to the KVM file, both files hold references to each other.
>>
>> Because both file descriptors hold each other's references, their f_count
>> will never reach 0 when userspace closes the FDs, permanently leaking the
>> KVM VM and the VFIO structures.
> 
> False positive, the reference to VFIO is in the KVM-VFIO device file and not in the KVM file descriptor itself.  Using variable names, there is one reference from kvf to vfio and one from vfio to kvm.
> 
> (Right? :))
> 
Yes, already addressed here.

https://lore.kernel.org/kvm/b49ec974-6937-4057-869b-a6e2d5958c6d@linux.ibm.com/



