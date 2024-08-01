Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FE1A0703
	for <linux-s390@vger.kernel.org>; Thu,  1 Aug 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515276; cv=none; b=JlCIA331GiKkzmhQc6zKBuiqNTPDuz+0x+Ok4NLs5sEaudOX2H4TnGeNIfs4a4k+N63AanQw9g1O4QjY3rBZbZYh9Sxm8eKnuRf+tvLpu/6wLr5Cz3nvCCQfjIKHFQAIiI2Xyu0VCmRn075mrSww+CcJ6dyRv0qYss2Y6GnKGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515276; c=relaxed/simple;
	bh=8nKemGG4gp1ULyj6EJ/xBvvP/E6vm/bGRSUUiHDaHI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqSsb5nVP1MV3svPtxfJruLvyi+WyBjDX0xYhiAYtTBTtfGU4V/znILBfA9u4Bk1oSyI5EgHsfWXd/sRtnsz9h+MiGsPu0RkJBbgS8GT2Y44lJj3F1rHn7l8OzhKDEgGIMy2KaFKrh/QlmpX0ZibX2w7DhHJTsZjuK1axmfKZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cSgC777s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cSgC777s"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4716TQhK025109
	for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2024 12:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	DSf8SN9TfBmPcaa6QsxKRBonLHsw7Tudr1ptYKCpfAE=; b=cSgC777si11rcq8t
	mZKusWyDDzSgLZ8xnLADrmR8yIDVdUNj19sjUE0U3FfrXdCNsQG6VHcvN1i45gLh
	sKdvbQje0ETWHlfrJ09/eUjdsxGBN36TQXjfYkwA9AindADn7UD62Q2Xm6cXS9X/
	sxTdPxACT4ga10Ct1pyralickf4+YVGs0PxBgF1vMF2PTP8Iho8vMZXShbk7AGYn
	At24WsmG3opnoZ68jURsyP+bHL6uZB/5oUBKo3/gNwfZfg3A8kNEl7EVGM+wGMhe
	tCg7L6MFeLC3wY/KVBBWYeg1vhB9J6T1OcaQS3heWT+JYuJZO8x86VQjzbi1kpU0
	0sochQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u0r7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2024 12:27:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4719JFJa011151
	for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2024 12:27:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn1jw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2024 12:27:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471CRk1b54919638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 12:27:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D7492006C;
	Thu,  1 Aug 2024 12:27:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E730520071;
	Thu,  1 Aug 2024 12:27:45 +0000 (GMT)
Received: from [9.155.199.134] (unknown [9.155.199.134])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 12:27:45 +0000 (GMT)
Message-ID: <9a844e91-43a2-4c0a-92b2-65ade58e0514@linux.ibm.com>
Date: Thu, 1 Aug 2024 14:27:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: fix validity interception issue when gisa is
 switched off
To: Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, nrb@linux.ibm.com
References: <20240731113102.849562-1-mimu@linux.ibm.com>
 <9124f3d3-700f-4d54-be2c-df17cc6a719f@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
In-Reply-To: <9124f3d3-700f-4d54-be2c-df17cc6a719f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kvNN3nETGiqDJ1z5vvK42ppCkdEGDMbl
X-Proofpoint-ORIG-GUID: kvNN3nETGiqDJ1z5vvK42ppCkdEGDMbl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010080



On 31.07.24 14:05, Janosch Frank wrote:
> On 7/31/24 1:31 PM, Michael Mueller wrote:
>> The following validity interception occures when the gisa usage has been
>> switched off either by using kernel parameter "kvm.use_gisa=0" or by
>> setting the related sysfs attribute to N (echo N >/sys/module/kvm/
>> parameters/use_gisa).
>>
>> The issue surfaces in the host kernel with the following kernel 
>> message as
>> soon a new kvm guest start has been attemted.
> 
> How about:
> 
> We might run into a SIE validity if gisa has been disabled either via 
> using kernel parameter "kvm.use_gisa=0" or by setting the related sysfs 
> attribute to N (echo N >/sys/module/kvm/parameters/use_gisa).
> 
> The validity is caused by an invalid value in the SIE control block's 
> gisa designation. That happens because we pass the uninitialized gisa 
> origin to virt_to_phys() before writing it to the gisa designation.
> 
> To fix this we return 0 in kvm_s390_get_gisa_desc() if the origin is 0. 
> kvm_s390_get_gisa_desc() is used to determine which gisa designation to 
> set in the SIE control block. A value of 0 in the gisa designation 
> disables gisa usage.

Yep, used that version above now.
> 
> 
>> Cc: stable@vger.kernel.org
>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
>> Closes: 
>> https://ibm-systems-z.slack.com/archives/C04BWBXSKEY/p1722280755665409
> 
> I'd just remove that since it's not accessible for people outside of 
> IBM. Yes, checkpatch will complain but in this case it's ok to ignore that.
> 

dropped that line.

I will send v2 rigt away.

>> Fixes: fe0ef0030463 ("KVM: s390: sort out physical vs virtual pointers 
>> usage")
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index bf8534218af3..e680c6bf0c9d 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -267,7 +267,12 @@ static inline unsigned long 
>> kvm_s390_get_gfn_end(struct kvm_memslots *slots)
>>   static inline u32 kvm_s390_get_gisa_desc(struct kvm *kvm)
>>   {
>> -    u32 gd = virt_to_phys(kvm->arch.gisa_int.origin);
>> +    u32 gd;
>> +
>> +    if (!kvm->arch.gisa_int.origin)
>> +        return 0;
>> +
>> +    gd = virt_to_phys(kvm->arch.gisa_int.origin);
>>       if (gd && sclp.has_gisaf)
>>           gd |= GISA_FORMAT1;
> 
> 
