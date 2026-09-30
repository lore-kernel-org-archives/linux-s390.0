Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09030453A48;
	Wed, 30 Sep 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797006; cv=none; b=XzLtCwTX9BP/I05lFbR84BABg4Bfan1F9/2HQz0ULl/TEMM3M0gVzvzpmoCnJ/qbCwuls9/4rNudQ7DFsCV1Aae16Nc48sJhnGsQIKLSaTLjSvINSNF2bZbRWH0tfYv31tC1le7Ewn4YsYzxVcKsVzOb9omo/I6AbQzIW2jfZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797006; c=relaxed/simple;
	bh=ZZHoZPPtZW5aMIslJVFwJ3qHVmwEORAaymIXg1E4d+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEyWt4GBxegMWuXXjbi9ugCH5sfYBM1TksoNZUjrMbS2tfjBl5xQ/pOYl4zh84/wMGvFFj/NnStSRm4Z5KcYIvhGOQUCbopltWPEJCYlqYKvKJfAc5E8odKz/sj/QcL4ivRKHHr9TVk6SkWN9rzVnvgJH61EATY3VeJPDe1bmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YYOpyIgN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YYOpyIgN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UI5c6h3708442;
	Wed, 30 Sep 2026 19:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dwvSZk
	zhND6iBXHMqvXBa2+2QNcS2Tn6c9C0CwjpGck=; b=YYOpyIgNJaPuDe7VZ76dwl
	e9UItXAzxC8DGiy990t4qhobuiB3GEUwvQu0TMMa/YmtRAzZM9zJY5QCV7q/V2X4
	s9qonCTRnE13AHSQVAPw55zxVgnXShHvoRUCaZCB8o+KVW/PWESZlGqqcQC2ZSzd
	C5GQpl3/UA9zVF73889Tl8LCnaUDC9REOVZA2FNNAPAIMyGSsKURAw/ePTY5oyEg
	6pn0/Z3ItmmmeFZB7Qjh+u0XhNwF0Pk5Eq2fAUPD94RhAKZdsyNkr6GbGyqE1oyE
	Xm6eM2nXkMaNrUUPnUz8Yr6jTNa9gCvOJMr3Kxip7lDWTnOAS45EtzQjYzWRWRqg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5f9ex-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 19:36:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHlUYV3874704;
	Wed, 30 Sep 2026 19:36:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23na5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 19:36:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UJZsTE28902040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 19:35:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F26F58060;
	Wed, 30 Sep 2026 19:36:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50AE85805A;
	Wed, 30 Sep 2026 19:36:38 +0000 (GMT)
Received: from [9.12.71.245] (unknown [9.12.71.245])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 19:36:38 +0000 (GMT)
Message-ID: <9eaf1d6a-ee32-4a8e-817d-bc7a74baf01d@linux.ibm.com>
Date: Wed, 30 Sep 2026 15:36:37 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-3-oelghoul@linux.ibm.com>
 <20260930125744.2c03b68a@shazbot.org>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260930125744.2c03b68a@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX6C2DplFrnZgE
 20eACgDh9wKJf3ziu3r+WH/rDOflqHBmrh7O/Bn+R0YntNJf1GRB1GKC1zNeT8MlC63wV/8pdRB
 0SSYbteA3lTNJwI8dYSrbA2IXOjkzTQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX8ou8cw8g1rE6
 gRcMqOFi0EjGd6CoD2I5e/dVXJ9GNd2pMXZftLLjDxPGk4sEfywxXkpOaJwB/f9w39OwjHmtvFB
 rvv2+5HblFTXF8NVuHiDmEmsWIIj5c8B6NtPnIAjnL7x9e8MaKo9/CohbuHPoKHg/WISLqzTNkC
 QcgxLOsjfca/GI6XyjOLQoAFF9fPhryWr59zM4RQVD9Hc1n66zsg83dkCQN0omN+oIWqWdS0JvU
 hLBy3+GcDS/jqg7mkHh+6xGO0uDtFbFQrXvB24I1m6eJQILkvdzx6OSQQBM6ZkERnumS2xMqJcb
 9tMJdpElby0phPiot4ASWbShbXuq+FR+fr4k6AhuqFp91x8Z37oXZFp47xGaHoq/7BE3pIhAeYp
 OrH46DuGJhv1NQP8VNG6ZOtE4u/0W88nF4OVx/VaTzCZGUPDqHqcK8jioVu2ChwThBDlv/T/KNN
 jXc4hsoy0hgQU1jEDJw==
X-Proofpoint-GUID: 8TFlXOGA_3bhUTb97eDhnMiHjNlqpdKW
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd64c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=NrWW4bp0LhECzA1yxrIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8TFlXOGA_3bhUTb97eDhnMiHjNlqpdKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300080

On 9/30/26 2:57 PM, Alex Williamson wrote:
> On Tue, 22 Sep 2026 15:51:39 -0400
> Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> 
>> Introduce the function zpci_fmb_reenable_device() that checks the state
>> of function measurement and ensures it is enabled. Reset the counters to
>> zero, disable, and re-enable the FMB if it was already enabled. Call
>> this function from zpci_reenable_device().
>>
>> Don't free the FMB buffer during disabling and reuse it when re-enabling
>> measurement. Instead, free the buffer upon device teardown, allowing the
>> same buffer to be reused in the enable path and add the bit fmb_enabled
>> to struct zpci_dev. Audit the only consumer of zdev->fmb and update it
>> to reflect the change in semantics.
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |  2 +
>>   arch/s390/pci/pci.c         | 77 +++++++++++++++++++++++++++++--------
>>   arch/s390/pci/pci_debug.c   |  2 +-
>>   3 files changed, 63 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 88a125b92bdd..b8162f7a8968 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -175,6 +175,7 @@ struct zpci_dev {
>>   	u8		util_str_avail	: 1;
>>   	u8		tid_avail	: 1;
>>   	u8		rtr_avail	: 1; /* Relaxed translation allowed */
>> +	u8		fmb_enabled	: 1;
> 
> This appears safe, fmb_enabled seems to be the only runtime mutated
> bitfield in this set, but it might be a good idea to flag it as such or
> use a separate storage unit to avoid a tearing hazard in the future.

Great catch, I completely missed that. It makes sense to just move it
into a separate bool since it's the only bit that isn't representing
the existence of some feature/capability, thanks.

> Thanks,
> 
> Alex

