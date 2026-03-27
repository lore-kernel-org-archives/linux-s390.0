Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A51D5ABA;
	Fri, 27 Mar 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625502; cv=none; b=cyBjFPErrJZ006udHQpE4BBz0FFzt+qZfg/GFz37XSPdC4aHM5AqoOh4UwJAp/OVnB7LfWbWIPNtqLZH4DqfkXMKeYU9e7NZIfNUy5dmqVQzSGQI6DsJKAFI5UE9QGwaUm8l+n4XQXSOU8GDIxOWfxsomqSzh11Fn8ptcmH4xS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625502; c=relaxed/simple;
	bh=NUkcljIgAJZLy40PxD5mlYk4jWQBZ0mbH5Vy4f6r2kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZdGpuG7PCE/zV3fgNg2ke38BbYHUb1JAH3dKU5XZ1yoJcywBA1pe8PsVolriSs3IJAGjtCy93CcZesk1B/MIguEVTCmJGjiQVvHyGkoGqUOolabeEcBnwodvsczsYTP+VeJlj7/LdkutvY/tURUjE5qmLIJMMmLltHsSarZlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CIYoJYtc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CIYoJYtc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RA9EEc666646;
	Fri, 27 Mar 2026 15:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lvaG/b
	C0nAJO37T1mwl1BA0RtMRFNEPHypMya1za+RQ=; b=CIYoJYtc8UydxgoMNwolrd
	GhTBEEvc9xiu50COjSXZ5XPLX8jQoFsKJhraNvKQocPsDyiFG67P7l0cvZJwayoH
	4zO3lnwKNN2fIFcncuc2Zx1xMySGX0izNZM4gN6v84RSDV1R+eX7uRmii3eQxZqb
	/1fxGFOwTpauh7GGy+ebG4PYMYfYrtnkmGY68XqP5Z0InmMHkEBrg1xYAvEeJU1G
	4LYJWqB3X6ncgkEx90InmejJzs0UkH9Ggo5aODm+hLmyY9uJ3yP/NWJDKHEu3xRQ
	5GtBmg0E46kOSeJxwQGondw1b2bDdeV8XyvUqbP7Y9UhQoKXEhiX09zDGeJIRQcg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktyatxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:31:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB8ewl009115;
	Fri, 27 Mar 2026 15:31:38 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np022r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:31:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFVa7V30147268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:31:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6541B5805A;
	Fri, 27 Mar 2026 15:31:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37A6A5805C;
	Fri, 27 Mar 2026 15:31:35 +0000 (GMT)
Received: from [9.61.244.240] (unknown [9.61.244.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:31:35 +0000 (GMT)
Message-ID: <5f03d78f-07d7-4e53-816b-4ff5306fc6c4@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:31:34 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Janosch Frank <frankja@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-2-freimuth@linux.ibm.com>
 <259c135b-2c1b-4f43-a177-925d7df8b909@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <259c135b-2c1b-4f43-a177-925d7df8b909@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c6a2db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Kq6gSilbqWK3yFYetpUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX9pmJPvgNFFdC
 o6b0s7CyUDCMrL8I2ZGpE10HudH0ApKIo/JHBzOd6xrjbM8NV/thLpz/5FsxqaTlBQPB9o3hEYe
 nTwLZ2Z8JUlgN9O4YAlxkCIrMEMdamFgNcem2agn4PPqZBpsfMN0RFBfCiNE9PIRRFEpCikONdx
 n7Tz1gXLvM8NOB0cdV4BDV4VHD+hioIcn7GaciG9QJYq6U2eCVCw817nqF/SR9VeFIgA2DuMJCx
 yWkkSB8pH8beHX21PXf9yCgLhXWGMQBeCl9eoVzZoKvRoM8H6fWt8onmVZkJorrmbPLzKMSgiZv
 HIp07Mi3vmJBovF2xzIgBsLnXXGgSiMzuAKoatzqrQz9Q43yNMB1LkH7KqFTc7WpmfS2PGNL9fR
 /dm3HGFrln4u3rNWGUDAkOTiPRslSn03Cd30cF3r8oC8vpJ7X9a95fiYzJVua0LMGl0KhZQgHCw
 3xKEgbt6Nm+rtSeP28Q==
X-Proofpoint-GUID: 6q7r6Rb1XjnjThRF0FdxxwgIYdSzl-nw
X-Proofpoint-ORIG-GUID: 6q7r6Rb1XjnjThRF0FdxxwgIYdSzl-nw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105



On 3/26/26 11:56 AM, Janosch Frank wrote:
> On 3/26/26 02:42, Douglas Freimuth wrote:
>> S390 needs map/unmap ioctls, which map the adapter set
>> indicator pages, so the pages can be accessed when interrupts are
>> disabled. The mappings are cleaned up when the guest is removed.
>>
>> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
>> in Secure Execution environments. In Secure Execution
>> environments the path of execution available before this patch is 
>> followed.
>>
>> Statistical counters to count map/unmap functions for adapter indicator
>> pages are added. The counters can be used to analyze
>> map/unmap functions in non-Secure Execution environments and similarly
>> can be used to analyze Secure Execution environments where the counters
>> will not be incremented as the adapter indicator pages are not mapped.
>>
>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
>> ---
> 
> Looks good, two nits below.
> 
> [...]
>>           if (ret > 0)
>>               ret = 0;
>>           break;
>> -    /*
>> -     * The following operations are no longer needed and therefore 
>> no-ops.
>> -     * The gpa to hva translation is done when an IRQ route is set 
>> up. The
>> -     * set_irq code uses get_user_pages_remote() to do the actual write.
>> -     */
>>       case KVM_S390_IO_ADAPTER_MAP:
>>       case KVM_S390_IO_ADAPTER_UNMAP:
>> -        ret = 0;
>> +        /* If in Secure Execution mode do not long term pin. */
>> +        mutex_lock(&dev->kvm->lock);
>> +        if (kvm_s390_pv_is_protected(dev->kvm)) {
>> +            mutex_unlock(&dev->kvm->lock);
>> +            return 0;
>> +        }
>> +        mutex_unlock(&dev->kvm->lock);
>> +        idx = srcu_read_lock(&dev->kvm->srcu);
>> +        host_addr = gpa_to_hva(dev->kvm, req.addr);
>> +        if (kvm_is_error_hva(host_addr)) {
>> +            srcu_read_unlock(&dev->kvm->srcu, idx);
>> +            return -EFAULT;
>> +            }
> 
> Alignment issue
> 
> [...]
> 

I will correct that. (Surprised checkpatch strict didn't catch it.)

>>   static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>>   {
>>       const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
>> @@ -2503,6 +2522,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, 
>> struct kvm_pv_cmd *cmd)
>>       switch (cmd->cmd) {
>>       case KVM_PV_ENABLE: {
>> +        kvm_s390_unmap_all_adapters_pv(kvm);
> 
> Shouldn't this be located after the check that's below?
> 

While all of my tests do not observe it, not sure if there is a state 
change where anything is left mapped while in pv. There should not be so 
I can move it after the check as you mention.

>>           r = -EINVAL;
>>           if (kvm_s390_pv_is_protected(kvm))
>>               break;
> 

