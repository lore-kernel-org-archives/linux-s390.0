Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5205349D6;
	Wed, 23 Sep 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181458; cv=none; b=C9B7h+PalIzG0mzewPcn0pGxOSoOE5jF21O7uUr9TTQX1sECK2ud5/8GS9z0kjtu6NGa12ZMlGtEJ4s/Lcu2ICzrCx4Mi8wgpxoRcXD9dN0TDtU+AYldxr6ys/Q3OPAtgQIF5eALzEebVRxrrYT4sNPg7Za1B8dBcmdvmGfeUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181458; c=relaxed/simple;
	bh=v1/MIvWhwy1yerorOet7r3Vw2zMBXabcV7802TQ2xb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO+6hNvWvd4D1AgzqpvKB+k/ZVckSKb9ducK9GD73YMHjGILLl3+N8MPmK2j24TrFxyJ3rifSZa31kpUZibjgFEWEtEWTsAS3aKinCzy1lsPJ806ozCGzSM54edmlTSlg7C0e/riCiylAAf5zdObTxw7zr1WUOw5WTIeH9hkeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4plneQH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4plneQH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZhLR3922440;
	Wed, 23 Sep 2026 16:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VQVVsP
	oPmAsYgrDEvZN7KohGtEoBW72QWcMnIWM6S0g=; b=e4plneQHRDJCnP6QZF46dH
	i/pDRQhO3+M2ZqaXi/wVlXsHS2xTEietnD+x6sT6nSZvvRQKdMTuUH+374cXzGBi
	q0/67rXUD9W++9hqo6UkPrnfT17zzTXDVmq061H3Qcn2U1Yg8IcMYatuaG4nmMQk
	mZ3Nu50YW2gy3clIHfmFkMavwQZtupmmvXFXfCyQS3G/AhVswjBHuhDEfCeiFeiE
	maBfsSqhrgGOTC/huWUgr7yBXgBeovBRBDQ8+8gkjjizJyvop42NnKz+WFmmE71L
	xZXoozeMEsiWtROv3bE6pzcnZNfDXNsH1/xs4Ydswq6j//PzhgSEloaYOtmpbbEA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgscffe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 16:37:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWn5a664394;
	Wed, 23 Sep 2026 16:37:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1svr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 16:37:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NGbGix2687660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 16:37:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 197DF5805D;
	Wed, 23 Sep 2026 16:37:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82A9958058;
	Wed, 23 Sep 2026 16:37:14 +0000 (GMT)
Received: from [9.61.244.49] (unknown [9.61.244.49])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 16:37:14 +0000 (GMT)
Message-ID: <07094b4a-0c11-42a0-a9dd-8c46fe7e47f9@linux.ibm.com>
Date: Wed, 23 Sep 2026 12:37:13 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-3-oelghoul@linux.ibm.com>
 <d5a32ced819407ae370da37803e30acf541bc5d3.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <d5a32ced819407ae370da37803e30acf541bc5d3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4003e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YDUgYxK26XroMZ81QO0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hI4OMP6mrB9Fx9RktjTqwbJ-d45188Ft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NiBTYWx0ZWRfX16NujYWm56UF
 BcbLewrzYKMOMVEv16OS3jgUo3jeZA99Pplcg3xMXo4OMACjqUQRIlEFpzbe1Xo0A/RG2ICu17I
 +lp5VA+jHM3zivtVTFjZ2LqMwpoVRmAMBOPjG4a69XnTjb3ZdNzv0BXJPV1yH8F+csnm9DBST2R
 Rj9Y6S+QYos2xnVuaZOAqa7b+83WFaIspSMkJ9ls3vhSFUi0csjXJeGFdGjo4t7q49zCtM68gIJ
 qQstYTrgUW0IDLMj5a1NQJI6qzUOKkkI69xDG8dw9Xz7N2hkRSGRJlikgGZ3i/agpdU2ShFxCFh
 +AcYV1lYC0kSdrBIACc0IGAElsNyXUNIGEI7sPBTOHxVrHi1vt2bAwQgxGfHPmNF9Q47jG8N9OH
 85n+UDhPBd7w2NfcO8o8kqKvpR9scgpDpV4swfLHhIC/yhFAs+Bjgtx2AzELYEXNMPPHZIo33aY
 t4iu3ylrZk6AREm9wKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NiBTYWx0ZWRfX13jdBZ/RpHNQ
 TtQmB2rg3bRftHwPjHMTOEuAYdOZ+OJfz1Vt6IeoY2NNBmSH1NkpTPu+SpMLA1TAe2j7Iz57JF4
 OJlydBh5jdVk3tILZHFaohs1MsFnGCk=
X-Proofpoint-GUID: hI4OMP6mrB9Fx9RktjTqwbJ-d45188Ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230066

On 9/23/26 11:09 AM, Gerd Bayer wrote:
> On Tue, 2026-09-22 at 15:51 -0400, Omar Elghoul wrote:
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
> 
> While I understand how this evolved, this commit message reads upside-
> down for me. Shouldn't we consider the changes described in this second
> part of the commit message as a preparatory step for the introduction
> of zpci_fmb_reenable_device() and put this paragraph first - or even
> into a separate commit of its own?

That's a fair point, the commit message can be restructured to describe
exactly what the function does first, and then afterwards describe where
we're calling it and why.

I also think having everything in one commit is necessary because this
commit changes the semantics of zdev->fmb, where the old code used it
as both the buffer and also as an FMB enablement check. The latter check
is no longer valid after this commit, unless we want to add a separate
commit that just adds the fmb_enabled bool, which I thought was a little
overkill.

> 
> Or, do you want to capture some (the outcome) of the prior discussion
> about the "grace period" that architecture imposes on re-using the
> memory that was ever registered as FMB with a PCI function? As
> rationale why this patch changes when the FMB memory is freed.
> [...]
> 
> Nothing wrong in this patch, but apparently there's no common "style"
> in this file regarding whether parameters are named in the function
> prototypes.
> 
>>   
>>   /* Debug */
>>   int zpci_debug_init(void);
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index c055a9ad0972..815257ddb6c8 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -175,13 +175,18 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>>   
>>   	lockdep_assert_held(&zdev->fmb_lock);
>>   
>> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
>> +	if (zdev->fmb_enabled || sizeof(*zdev->fmb) < zdev->fmb_length)
>>   		return -EINVAL;
>>   
>> -	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
>> -	if (!zdev->fmb)
>> -		return -ENOMEM;
>> -	WARN_ON((u64) zdev->fmb & 0xf);
>> +	if (!zdev->fmb) {
>> +		zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
>> +		if (!zdev->fmb)
>> +			return -ENOMEM;
>> +		WARN_ON((u64) zdev->fmb & 0xf);
> 
> Already before this patch: Is this WARN_ON necessary, with the
> alignment on struct zpci_fmb when zdev_fmb_cache is created in
> zpci_mem_init()?

It's not necessary and it was just preserved from the old code. You're
right that the cache already guarantees the alignment.

> 
>> +	} else {
>> +		/* FMB buffers are intentionally persistent for later reuse */
> 
> How about changing this comment to: /* reuse same FMB buffer as long a
> zdev lives */

Sure

> 
>> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
>> +	}
>>   
>>   	/* reset software counters */
>>   	spin_lock_irqsave(&zdev->dom_lock, flags);
>> @@ -199,11 +204,11 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>>   	fib.fmb_addr = virt_to_phys(zdev->fmb);
>>   	fib.gd = zdev->gisa;
>>   	cc = zpci_mod_fc(req, &fib, &status);
>> -	if (cc) {
>> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> -		zdev->fmb = NULL;
>> -	}
>> -	return cc ? -EIO : 0;
>> +	if (cc)
>> +		return -EIO;
>> +
>> +	zdev->fmb_enabled = 1;
>> +	return 0;
>>   }
>>   
>>   /* Modify PCI: Disable PCI function measurement */
>> @@ -215,7 +220,7 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
>>   
>>   	lockdep_assert_held(&zdev->fmb_lock);
>>   
>> -	if (!zdev->fmb)
>> +	if (!zdev->fmb_enabled)
>>   		return -EINVAL;
>>   
>>   	fib.gd = zdev->gisa;
>> @@ -224,13 +229,39 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
>>   	cc = zpci_mod_fc(req, &fib, &status);
>>   	if (cc == 3) /* Function already gone. */
>>   		cc = 0;
>> +	if (cc)
>> +		return -EIO;
>>   
>> -	if (!cc) {
>> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> -		zdev->fmb = NULL;
>> -	}
>> -	return cc ? -EIO : 0;
>> +	zdev->fmb_enabled = 0;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
>> +
>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>> +{
>> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> +	struct zpci_fib fib = {0};
>> +	u8 cc, status;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
>> +
>> +	if (!zdev->fmb_enabled)
>> +		return zpci_fmb_enable_device(zdev);
>> +
>> +	fib.gd = zdev->gisa;
>> +	cc = zpci_mod_fc(req, &fib, &status); /* Disable function measurement */
>> +
>> +	/* Unlike in zpci_fmb_disable_device(), cc == 3 is not a valid state here
>> +	 * because we are re-enabling function measurement for the same function
>> +	 * handle.
>> +	 */
>> +	if (cc)
>> +		return -EIO;
>> +
>> +	zdev->fmb_enabled = 0;
>> +	return zpci_fmb_enable_device(zdev);
>>   }
>> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> 
> I see a little imbalance of the semantics of "reenable" in
> zpci_fmb_reenable_device() vs. zpci_reenable_device():
> zpci_reenable_device() "just" enables + registers existing data
> structures with the underlying system - while
> zpci_fmb_reenable_device() does both the disablement + the enablement.

Strictly speaking, the disablement step may not be necessary, provided
firmware starts the counters at zero upon changing an FMB address, which
does seem to be true in practice. The architecture doesn't explicitly
require that though, so I thought it's a reasonable safeguard to use it
as an intermediate step that signals firmware to stop counting before we
immediately restart measurement after.

> 
> Since zpci_disable_device() includes the disablement of FMB per
> architecture, I wonder if it would suffice to set zdev->fmb_enabled = 0
> in that function, and drop the explicit disable FMB there?

The semantics of the FMB re-enable function were intended to allow us
to re-enable the FMB when we re-enable the device after FMB was
implicitly disabled via zpci_disable_device(), like you said. Prior to
this patch, there was a sort of "limbo" state where firmware thinks FMB
is disabled, but the kernel is unaware of it because it was implicit.

For that same reason, I would prefer to not touch zpci_disable_device()
at all, neither explicitly disabling FMB nor setting fmb_enabled to 0.
The purpose of fmb_enabled variable is to allow us to restore the
original FMB enablement when we re-enable the device, and so we want to
preserve it here [1].

Thanks

[1] 
https://lore.kernel.org/all/dae3c7cd-21aa-4263-bec5-792b018d21e2@linux.ibm.com/

> 
>>   
>>   static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
>>   {
>> @@ -737,8 +768,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
>>   	}
>>   
>>   	rc = zpci_iommu_register_ioat(zdev, &status);
>> -	if (rc)
>> +	if (rc) {
>>   		zpci_disable_device(zdev);
>> +		return rc;
>> +	}
>> +
>> +	guard(mutex)(&zdev->fmb_lock);
>> +	if (zdev->fmb_enabled)
>> +		zpci_fmb_reenable_device(zdev);
>>   
>>   	return rc;
>>   }
>> @@ -1003,6 +1040,12 @@ void zpci_release_device(struct kref *kref)
>>   	if (zdev->has_resources)
>>   		zpci_cleanup_bus_resources(zdev);
>>   
>> +	if (zdev->fmb) {
>> +		zdev->fmb_enabled = 0;
>> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> +		zdev->fmb = NULL;
>> +	}
>> +
>>   	zpci_bus_device_unregister(zdev);
>>   	zpci_destroy_iommu(zdev);
>>   	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
>> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
>> index c7ed7bf254b5..44f026ead414 100644
>> --- a/arch/s390/pci/pci_debug.c
>> +++ b/arch/s390/pci/pci_debug.c
>> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>>   		return 0;
>>   
>>   	mutex_lock(&zdev->fmb_lock);
>> -	if (!zdev->fmb) {
>> +	if (!zdev->fmb_enabled) {
>>   		mutex_unlock(&zdev->fmb_lock);
>>   		seq_puts(m, "FMB statistics disabled\n");
>>   		return 0;
> 
> Thank you,
> Gerd

