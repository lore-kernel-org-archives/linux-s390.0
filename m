Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628343264EF;
	Mon, 30 Mar 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882422; cv=none; b=jjZWqQKW2QdRrQ+PwaiyYNJxaT5ZdFc41G+mgoziNY8VYBf96IAeEOZLkylE6xUjoRMiKc1iHHUxwuOqBwkFBDQblefr1LDOfm5BhniUMa3uaUMJtSCLU5CLAm2Q8QjS5GEaDXcR5Wur82T92kKSBh0PyzlGjUav8QgEFSsj32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882422; c=relaxed/simple;
	bh=DfYVsRNVn8VQ2MJI8p8at6JPpsiaadxH8kM9rmOjgPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJLPLeO56lS/FZNbIqTlduqDikCmoBC/lns9C2Kt2m16wLUixtcR0PrEpUdM0XxN30mMozVpdLwiBvw8DLoEJXPDv+s9sdjpkmm9aj6lsBL9s5qO4qgy0/la47ziPMz+dDDMoN3d2cJkdwheMea/hDOyQJF13Ymu3RDUFRRBK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hkQZDCfM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hkQZDCfM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U7fWAt2411380;
	Mon, 30 Mar 2026 14:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0V+FdM
	fUhjzexF9yP5xAkxwKX2+ToVNj99U1BMia3Yk=; b=hkQZDCfM7YeSHYMQK4Jh6a
	GqYvaV9A3ztsWO8T5QIClrHDDkUukpuwaxVBD7pAv0wbpb4ZVjGTmluc0ZRaU/u1
	dX1Kiu/5q/gYkgirzyIySSmIENDQ3fQOrKqM26GaHLoy+8OhlEyAP5nSfh/G0p51
	L9twA2F31Zys4zkCZo/kMUyK1jg0FKMK14V2ao/f9/WvPyOq2gs3lZmpPAouVolA
	U5n0ZhN/GSU3+s0K0qFFvEVNSBVRrENxAPhUow7UEs6nr0+iV8dp7qoANhyjhFk2
	AMrNSn/kjvUlpg5gAcha1q94VD3H2PNgjL1wW8waNt5jucYeZcvy/9de3+skdyVw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgf6x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 14:53:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UBZnu9008751;
	Mon, 30 Mar 2026 14:53:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11d2k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 14:53:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UErZSo30933616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 14:53:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA9C20040;
	Mon, 30 Mar 2026 14:53:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C22422004B;
	Mon, 30 Mar 2026 14:53:34 +0000 (GMT)
Received: from [9.111.73.117] (unknown [9.111.73.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 14:53:34 +0000 (GMT)
Message-ID: <ac419933-6eb5-4a11-894f-94c19c6e8003@linux.ibm.com>
Date: Mon, 30 Mar 2026 16:53:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 08/10] KVM: s390: Use gpa_t in priv.c
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-9-frankja@linux.ibm.com>
 <20260318170259.2cb92001@p-imbrenda>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260318170259.2cb92001@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDExNiBTYWx0ZWRfX78UoYgPlaTXw
 2+RYvZ0/3s3dPv/QZJ8kYOYhp995mNbf/UIRQxtCvYKDk7ojuCkUN4pYKeiqKvZefTn0h8tpXf0
 YuCGGGHXodcwdkDFLf1+X2EeALY9H8exak6g2trrM0JnFUtqQvkSJVOo1SukwXaKRg1qSu6n3ey
 BcE/TH5wev+s4zWG2eLbthdttqmkvZ0vUEOd1eq7KulBnmNavYKnnWnpKRJjKdirLGqCnVouRhG
 Ti7oCu5SeYbpo+Cs5VVkpggj1QE1JadYTFhyMr4V1HsNNc97yVNBdSMPDvZ3FszeVyuO9sn4htj
 Fz5L6ZZxnSKYg8c3eu5cLLXIk6JTCGoVy6uaiIIAfp8tm8F+Uflarx1Bforx2O//TJ4p6RUPY/T
 kQ3na7gAGbK2HFdXNKRoLQrn07XZNPPe/TV8h86snIN02ujyFZDSorOqB2Ld/qhsvQmb3Bap6MI
 rhDhDDAkkZXqrncQizg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ca8e73 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZXZ5jkJX7H5pkj7HFxgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DM8dmbxiB1oKFP5ZQUqDUNgiJf2O-EEh
X-Proofpoint-ORIG-GUID: DM8dmbxiB1oKFP5ZQUqDUNgiJf2O-EEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300116

On 3/18/26 17:02, Claudio Imbrenda wrote:
> On Mon, 16 Mar 2026 16:23:55 +0000
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> More unsigned long to gpa_t conversions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   arch/s390/kvm/gaccess.h |  8 ++++++++
>>   arch/s390/kvm/priv.c    | 27 ++++++++++++---------------
>>   2 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
>> index f23dc0729649..970d9020dc14 100644
>> --- a/arch/s390/kvm/gaccess.h
>> +++ b/arch/s390/kvm/gaccess.h
>> @@ -89,6 +89,14 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
>>   	return _kvm_s390_logical_to_effective(&vcpu->arch.sie_block->gpsw, ga);
>>   }
>>   
>> +static inline gpa_t kvm_s390_real_to_abs_effective(struct kvm_vcpu *vcpu,
>> +						   unsigned long gra)
> 
> the name is confusing, it should be something more like
> kvm_logical_to_abs, or kvm_logical_effective_to_abs
Since logical can be virtual, I don't think these suggestions fit the 
bill. It works for logical to effective since that's about address size. 
Logical is a catch-all and so is effective.
