Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888673A3E7E;
	Tue, 31 Mar 2026 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985053; cv=none; b=RDnQoPxjNcXh8W0oLt63Dg7NgwhCfh9Hqx/BuSErylJxNOSX78+J2xkEyDKlZ/AozNaLOJdFB3Dg985Z1kkMD4GeUic/mdUQr2TBPwGGJg6NDC5CXXIj8RWgX+E4SysmWAW+BKwSISk9aZ85V+yLsk1ThGSR1mLEujHc1i+bYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985053; c=relaxed/simple;
	bh=rN+SOaMRgtJg/+8hSMiitrpkTENCrF7uvywDy+R9x7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEYfKsLV3fqPPLlin38vuzmZ15qEhsD7VsZwtE03VoQnV6s06K3g9RGT8pPdeOd+QTtYH3o+rstgFYI/CdD5ZbhZ9ZfAyAtYD7Yx0/cOMM6k8BjZvwuu+a8u6YZw8SwlQWM+FPtMwqBEht8qzzgRs5VoZ893smksqTtzQPQKzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJ+dBeRu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJ+dBeRu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VIGQVL064853;
	Tue, 31 Mar 2026 19:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Sa6zPD
	qajn222jwPLJ0xLEdYSoLTSwUmM9bzOLj2mU0=; b=TJ+dBeRu7cqWt0sFpVAPRr
	Zbg1xbDBYNwhAxbq8voXqRmP5a5hKkVIUyqeaJbRB9G+wOXOLryzuO0wi5aBWSdq
	YI+xDFX/RS9X5hwiV/zyixSFCeYxRSHPunHRwCyevmx+Ll1JBN/Inx8ZPN6UXMK/
	SPFLrTtJoDUIPdUhAwzIqsmiSqxZrNlbhtapOTX9QYmPKp9A6gHUb4cOoRst5psj
	SaaNbUHtiDAONAaT3Cyf59xz/EQMJr6wYDPeYVdbS6w8I+zb1nYGTpaXq8NeqECL
	ymwqy9uQx+NcN9JrkxEXK+BrI3Us5t5/wXLrVsR/R+FEaMHkMHK56FcZ8ZpfY40g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q350sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 19:24:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VJI6GG021713;
	Tue, 31 Mar 2026 19:24:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasjrvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 19:24:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VJO29r30867988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 19:24:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA4C85805D;
	Tue, 31 Mar 2026 19:24:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1D3458059;
	Tue, 31 Mar 2026 19:24:01 +0000 (GMT)
Received: from [9.61.250.144] (unknown [9.61.250.144])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 19:24:01 +0000 (GMT)
Message-ID: <ec10fa8b-b499-4f06-9a7a-71cb6d76e03d@linux.ibm.com>
Date: Tue, 31 Mar 2026 12:23:59 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, schnelle@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-5-alifm@linux.ibm.com>
 <8c080d9b-34f6-469c-8e53-c5d0a175556d@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <8c080d9b-34f6-469c-8e53-c5d0a175556d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zlMGu47PfNAQkk4BcK5zhT066O6mAB8Q
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cc1f54 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mpIQvMssudcUmQtL05oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zlMGu47PfNAQkk4BcK5zhT066O6mAB8Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4NiBTYWx0ZWRfX13c4+Wu0Uj4L
 9DnfoAl4mbIgA5WM0REa0YaAoFvGVBPn4LZViENQ909he+5QITfPq/MIaHa4tlm1zWx6Dl+FUW7
 iZIpyIIANKhW6cdxyFV1lw4KAoGcLMhMGkT+x7hrXcyCih3On5+Z4/nP5s+90PTyhlA0UVEQLcq
 XC+WEhmPjsP1zDSznrQDI5SW02QXLYeIJGSYyOOszrCa5Zhi4V3bYEVTn2LLfYGHZMiQu0MbfbR
 2uH2Epp/QGGseInDltgnaURwncIQmanP+foHFt7rLFJAGe2MYsmO+ja+NJY2DrcJ21SijnpEAsu
 Z+ikA5Cqqi71rbObN3bTd9RwpIUb7xRXVLQRhGuBc/fHsILuwd/hjokgmXQClequWk6k+A1ug5/
 poMRRJyz/nXB3UORNpSbM4YYxevzOAJ48xHVJK24GQ+RjmMhKYHc69blM5Pd5i95+P+9yegVLzj
 TzahYzpPkBplJn0HMZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310186

Hey Matt,

On 3/31/2026 10:41 AM, Matthew Rosato wrote:
> On 3/30/26 1:40 PM, Farhan Ali wrote:
>> For a passthrough device we need co-operation from user space to recover
>> the device. This would require to bubble up any error information to user
>> space.  Let's store this error information for passthrough devices, so it
>> can be retrieved later.
>>
>> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
>> drivers will not have any KVM fd and so no kzdev associated with them. So
>> we need to update the logic for detecting passthrough devices to not depend
>> on struct kvm_zdev.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks for reviewing!


> But a suggestion below:
>
>> ---
>>   arch/s390/include/asm/pci.h      |  30 ++++++++
>>   arch/s390/pci/pci.c              |   1 +
>>   arch/s390/pci/pci_event.c        | 113 ++++++++++++++++++-------------
>>   drivers/vfio/pci/vfio_pci_zdev.c |   9 ++-
>>   4 files changed, 105 insertions(+), 48 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index c0ff19dab580..7fb9a80b0175 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -118,6 +118,31 @@ struct zpci_bus {
>>   	enum pci_bus_speed	max_bus_speed;
>>   };
>>   
>> +/* Content Code Description for PCI Function Error */
>> +struct zpci_ccdf_err {
>> +	u32 reserved1;
>> +	u32 fh;                         /* function handle */
>> +	u32 fid;                        /* function id */
>> +	u32 ett         :  4;           /* expected table type */
>> +	u32 mvn         : 12;           /* MSI vector number */
>> +	u32 dmaas       :  8;           /* DMA address space */
>> +	u32 reserved2   :  6;
>> +	u32 q           :  1;           /* event qualifier */
>> +	u32 rw          :  1;           /* read/write */
>> +	u64 faddr;                      /* failing address */
>> +	u32 reserved3;
>> +	u16 reserved4;
>> +	u16 pec;                        /* PCI event code */
>> +} __packed;
>> +
>> +#define ZPCI_ERR_PENDING_MAX 4
>> +struct zpci_ccdf_pending {
>> +	u8 count;
>> +	u8 head;
>> +	u8 tail;
>> +	struct zpci_ccdf_err err[ZPCI_ERR_PENDING_MAX];
>> +};
>> +
>>   /* Private data per function */
>>   struct zpci_dev {
>>   	struct zpci_bus *zbus;
>> @@ -171,6 +196,7 @@ struct zpci_dev {
>>   
>>   	char res_name[16];
>>   	bool mio_capable;
>> +	bool mediated_recovery;
>>   	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
>>   
>>   	u64		start_dma;	/* Start of available DMA addresses */
>> @@ -192,6 +218,8 @@ struct zpci_dev {
>>   	struct iommu_domain *s390_domain; /* attached IOMMU domain */
>>   	struct kvm_zdev *kzdev;
>>   	struct mutex kzdev_lock;
>> +	struct zpci_ccdf_pending pending_errs;
>> +	struct mutex pending_errs_lock;
> This mutex now protects the pending_errs struct (obvious) as well as the
> mediated_recovery bool (not obvious).  Add a comment here and/or as a
> block before the needs/start/stop functions?

I can add a comment here. I was in two minds about renaming the lock, 
but at the end decided against to keep the diff minimum for the patches.


>
> Actually..  Could mediated_recovery just be part of the
> zpci_ccdf_pending stucture?  AFAICT the bit basically controls whether
> or not the zpci_ccdf_pending structure is used / has meaning.  You even
> turn the bit off at the same time you memset(&zdev->pending_errs, 0) in
> zpci_stop_mediated_recovery() -- though an explicit setting of
> mediated_devices = false would still be nice for code clarity.
>
> Then the spinlock continues to protect only this structure.

You are right, the mediated_recovery flag drives the use of the 
zpci_ccdf_pending struct. IMHO keeping the flag helped me with code 
clarity and keeping the struct simple and not be tied with the flag. But 
if you (or anyone) feels strongly about it then I can add the flag to 
the zpci_ccdf_pending struct.

Thanks

Farhan

>
