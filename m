Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CA4B8262;
	Mon, 12 Oct 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826871; cv=none; b=h+iSzQKBLbsjK98dDWCrx4uitErXGSH7KPWpzwXaOJwad6u2zFfypwp9dbF5kNuVKU555/idAOxUwWkO1dhUNLg7tKSbDmhoneGWw8AuSHfRsb1bufADyJoNwmxEf2lCnMBoGSlXnzEUXzzlU1MKc6yUWqDNPyoius/ta3lHWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826871; c=relaxed/simple;
	bh=VKXUlOxOu608S094FOJXDT1LqtRM2ShgCtmkrCFolrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQlcH/iqithPWx/uBU2lItjQ9lBqfT5IVLM6C8Du/kbbplJ+PnFtMVigZuByk0N2hLJ2w00YiExCuRUQ9S1z2hHmT+DcEM+CbmFV+24WsdSOo5+oj7CDjPfTJ2IQY2PEigWQhYMh4MULxrEwddD7+W86vqEUU9jJ5SrB4rybqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sqRLGpJD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sqRLGpJD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiUrQ664649;
	Mon, 12 Oct 2026 17:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=09s+Mx
	XtIoHjt1pZrBnTtti9mB+xNPpfbcSxwta6P5Y=; b=sqRLGpJDQb4Brr0Y4LqIQM
	jNPosbJgo2d+pQD1jxp6qXj02HlE6BLXvwSaBckMxDiBimOTAvrbmUUCxzB7G1AY
	W/YOj2R0nXkxohryOybbU/sYjGBaQSZnWjMMZZK8R0TYC/zqdB6tKv2/D8bb7gzu
	OazsGzOHqju3WI+L7YAV67soBBm6VTWvzYvNpi4O6WJU4DLmdmWUlzHTn6vPts3O
	7vs9K0igLitTXg5VI3zg8wicehug1MfxW58NtO7J1Wuiic5RlVo5n2u9dFCLzyrb
	tVSogulYkJeJH+xw7zQm0y1SH/4Ny317XJn3cnkg5G0B3uyhZzstAxUINAu0acfw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w1tfh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 17:41:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CG4urp1564911;
	Mon, 12 Oct 2026 17:41:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vpc5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 17:41:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CHeJm825625224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 17:40:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0A0958052;
	Mon, 12 Oct 2026 17:41:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C496758056;
	Mon, 12 Oct 2026 17:41:03 +0000 (GMT)
Received: from [9.61.249.103] (unknown [9.61.249.103])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 17:41:03 +0000 (GMT)
Message-ID: <4d6b3e6c-c1af-4a1f-9a8b-4266f386a299@linux.ibm.com>
Date: Mon, 12 Oct 2026 13:41:03 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
 <20261007135926.82935-3-oelghoul@linux.ibm.com>
 <722e46379f3e7825ac1d40805ae67d236fcc6867.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <722e46379f3e7825ac1d40805ae67d236fcc6867.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX8/epJLFADu+5
 DIbsigP65oXrvb0XHSUsNAP+r11lc15h0vcpK64cTXr6t+Nx6SVrZYc/tzgNQ6ayaxmMHHbV894
 Prc4wYeiQNiyRTN4y8LFAt+Bb5o/JZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX/hKTdQ5irUQ3
 k3kSpE1AaadlY609Ia9Iximfvd9gtm17Dc+nptPp5bQ3Vct2Q1qomZc7doXCtGYtmgkdXde6And
 GEf+41R8CQFb7MMoQmyEUllFA+PhY5B9gJHIOPZiIfMOv9AEt+xSRDtp7zXr5pv1sSumBA5uGLt
 qtbWBihezc9IiHdAhSwxmuB7WBh/ky2xb4uapu4W3Q5D1UixT/tAsriGNogbTQNR2Ef+uepu0Wq
 bUIGWDiE1o2JKKi7SGNZ+Jqy/a8NMmGoxuyWk0XoGnHfcC8fWtVeoxNIIWFPgdgayAfnoPbHNZW
 ZmcrAphWkX/daTkTFltRzh8ae0lGHsCvle3IndQcPL04v1tRSJKlj04iXHS26OZNdgdNhfEVcvE
 8kqUgxgbBI8xIqoUjNZPACnA/O7Cn8+yHZLZ9zIb8Ml0bqlrK5KpbGSR8PsgRgk0tL47mpOXRyP
 xljHPd0Mmc5ucvlPpUA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acd1bb3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=mWVGzeLskVhEkvpM98QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yp8yh1qBA6mx6VlJ2MQh5RPWVSGnquna
X-Proofpoint-GUID: yp8yh1qBA6mx6VlJ2MQh5RPWVSGnquna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068

On 10/12/26 5:22 AM, Gerd Bayer wrote:
> On Wed, 2026-10-07 at 09:59 -0400, Omar Elghoul wrote:
>> Don't free the FMB buffer when disabling measurement in
>> zpci_fmb_disable_device(). Instead, make the buffer persistent for the
>> lifetime of the device and reuse it across enable/disable cycles. Defer
>> freeing the buffer until teardown in zpci_release_device().
> 
> I lost track if this was discussed before: Would it make sense to break
> this out into a separate patch, so that memory allocation/life-time
> questions are decoupled from function-measurement preservation?

I think we did discuss that before and I expressed a preference for
leaving them in together, but since this patch seems to be growing I
guess splitting it would make review easier.

> 
>> Introduce the bool fmb_requested to struct zpci_dev to track whether FMB
>> enablement has been requested. This decouples tracking the enablement
>> from whether the buffer had been previously allocated, allowing us to
>> account for implicit disablement by firmware in zpci_disable_device().
>> Audit the only consumer of zdev->fmb and update its liveness check to
>> reflect this change.
>>
>> Separate the buffer allocation and measurement enablement step into the
>> new function zpci_fmb_reenable_device(), which allocates the FMB buffer
>> on first use, zeroes it on reuse, resets the software IOMMU counters,
>> and enables measurement. Make zpci_fmb_enable_device() delegate to this
>> function, and call the latter from zpci_reenable_device() when
>> fmb_requested is true.
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |   2 +
>>   arch/s390/pci/pci.c         | 106 +++++++++++++++++++++++-------------
>>   arch/s390/pci/pci_debug.c   |   2 +-
>>   3 files changed, 70 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 88a125b92bdd..77c8c49ba6c8 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -208,6 +208,7 @@ struct zpci_dev {
>>   	struct zpci_fmb *fmb;
>>   	u16		fmb_update;	/* update interval */
>>   	u16		fmb_length;
>> +	bool		fmb_requested;	/* desired FMB enablement state */
> 
> How about calling this "statistics_on" - derived from the sysfs
> attribute, to decouple this "user intent" even more from the actual ISA
> level enablement?

Sure.

> 
>>   
>>   	u8		version;
>>   	enum pci_bus_speed max_bus_speed;
>> @@ -351,6 +352,7 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
>>   /* FMB */
>>   int zpci_fmb_enable_device(struct zpci_dev *);
>>   int zpci_fmb_disable_device(struct zpci_dev *);
>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev);
>>   
>>   /* Debug */
>>   int zpci_debug_init(void);
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index c055a9ad0972..bda91d79bafd 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -167,43 +167,13 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
>>   /* Modify PCI: Set PCI function measurement parameters */
>>   int zpci_fmb_enable_device(struct zpci_dev *zdev)
>>   {
>> -	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> -	struct zpci_iommu_ctrs *ctrs;
>> -	struct zpci_fib fib = {0};
>> -	unsigned long flags;
>> -	u8 cc, status;
>> -
>>   	lockdep_assert_held(&zdev->fmb_lock);
>>   
>> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
>> +	if (zdev->fmb_requested || sizeof(*zdev->fmb) < zdev->fmb_length)
>>   		return -EINVAL;
>>   
>> -	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
>> -	if (!zdev->fmb)
>> -		return -ENOMEM;
>> -	WARN_ON((u64) zdev->fmb & 0xf);
>> -
>> -	/* reset software counters */
>> -	spin_lock_irqsave(&zdev->dom_lock, flags);
>> -	ctrs = zpci_get_iommu_ctrs(zdev);
>> -	if (ctrs) {
>> -		atomic64_set(&ctrs->mapped_pages, 0);
>> -		atomic64_set(&ctrs->unmapped_pages, 0);
>> -		atomic64_set(&ctrs->global_rpcits, 0);
>> -		atomic64_set(&ctrs->sync_map_rpcits, 0);
>> -		atomic64_set(&ctrs->sync_rpcits, 0);
>> -	}
>> -	spin_unlock_irqrestore(&zdev->dom_lock, flags);
>> -
>> -
>> -	fib.fmb_addr = virt_to_phys(zdev->fmb);
>> -	fib.gd = zdev->gisa;
>> -	cc = zpci_mod_fc(req, &fib, &status);
>> -	if (cc) {
>> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> -		zdev->fmb = NULL;
>> -	}
>> -	return cc ? -EIO : 0;
>> +	zdev->fmb_requested = true;
>> +	return zpci_fmb_reenable_device(zdev);
> 
> I'm not quite happy with "reenable" now becoming the "work horse" for
> enabling function measurement at the pci device. I append a suggested
> change at the end (since it's lengthy). My train of thought was:
> Introduce symmetric zpci_fmb_req_{dis|en}able_device() that toggle the
> "statistics_on" boolean, then call zpci_fmb_{dis|en}able_device() that
> does the actual zpci_mod_fc(). This allowed zpci_reenable_device() to
> call zpci_fmb_enable_device() if case of "statics_on", while the writes
> into sysfs would call zpci_fmb_req_{dis|en}able_device().
> 
> And another after-thought, since the whole _device postfix on these
> function names seems redundant, how about the following names:
> 
> zpci_request_fm_on()
> zpci_request_fm_off()
> zpci_enable_fm()
> zpci_disable_fm()

That's fine by me. It makes sense and as an added bonus, it makes it
easier to fix the issue you report where the state isn't correctly
preserved after zpcictl reset (please see below.)

> 
> 
>>   }
>>   
>>   /* Modify PCI: Disable PCI function measurement */
>> @@ -215,22 +185,68 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
>>   
>>   	lockdep_assert_held(&zdev->fmb_lock);
>>   
>> -	if (!zdev->fmb)
>> +	if (!zdev->fmb_requested)
>>   		return -EINVAL;
>>   
>> +	zdev->fmb_requested = false;
>>   	fib.gd = zdev->gisa;
>>   
>>   	/* Function measurement is disabled if fmb address is zero */
>>   	cc = zpci_mod_fc(req, &fib, &status);
>>   	if (cc == 3) /* Function already gone. */
>>   		cc = 0;
>> +	if (cc)
>> +		return -EIO;
>>   
>> -	if (!cc) {
>> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> -		zdev->fmb = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
>> +
>> +/* Re-enable PCI function measurement: clear the software IOMMU counters
>> + * and (re-)enable the FMB. This function is used to restore the desired
>> + * FMB enablement state when measurement may be implicitly disabled by
>> + * firmware (i.e., via CLP in zpci_disable_device())
>> + */
>> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>> +{
>> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>> +	struct zpci_iommu_ctrs *ctrs;
>> +	struct zpci_fib fib = {0};
>> +	unsigned long flags;
>> +	u8 cc, status;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
>> +
>> +	if (!zdev->fmb) {
>> +		zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
>> +		if (!zdev->fmb)
>> +			return -ENOMEM;
>> +	} else {
>> +		/* reuse the same FMB buffer for as long the zdev lives */
>> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
>>   	}
>> -	return cc ? -EIO : 0;
>> +
>> +	/* reset software counters */
>> +	spin_lock_irqsave(&zdev->dom_lock, flags);
>> +	ctrs = zpci_get_iommu_ctrs(zdev);
>> +	if (ctrs) {
>> +		atomic64_set(&ctrs->mapped_pages, 0);
>> +		atomic64_set(&ctrs->unmapped_pages, 0);
>> +		atomic64_set(&ctrs->global_rpcits, 0);
>> +		atomic64_set(&ctrs->sync_map_rpcits, 0);
>> +		atomic64_set(&ctrs->sync_rpcits, 0);
>> +	}
>> +	spin_unlock_irqrestore(&zdev->dom_lock, flags);
> 
> I know this is pre-existing, but how about breaking out the buffer and
> counter preparation/clearing into a helper function?

I believe it has been done in a previous version of this series at which
point we had two callers for it. Since we don't have another caller now
I didn't think of splitting it up.

> 
>> +
>> +	fib.fmb_addr = virt_to_phys(zdev->fmb);
>> +	fib.gd = zdev->gisa;
>> +	cc = zpci_mod_fc(req, &fib, &status);
>> +	if (cc)
>> +		return -EIO;
>> +
>> +	return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
>>   
>>   static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val, u8 len)
>>   {
>> @@ -737,8 +753,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
>> +	if (zdev->fmb_requested)
>> +		zpci_fmb_reenable_device(zdev);
>>   
>>   	return rc;
>>   }
>> @@ -1003,6 +1025,12 @@ void zpci_release_device(struct kref *kref)
>>   	if (zdev->has_resources)
>>   		zpci_cleanup_bus_resources(zdev);
>>   
>> +	if (zdev->fmb) {
>> +		zdev->fmb_requested = false;
>> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
>> +		zdev->fmb = NULL;
>> +	}
>> +
>>   	zpci_bus_device_unregister(zdev);
>>   	zpci_destroy_iommu(zdev);
>>   	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
>> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
>> index c7ed7bf254b5..9a960310d4dd 100644
>> --- a/arch/s390/pci/pci_debug.c
>> +++ b/arch/s390/pci/pci_debug.c
>> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>>   		return 0;
>>   
>>   	mutex_lock(&zdev->fmb_lock);
>> -	if (!zdev->fmb) {
>> +	if (!zdev->fmb_requested) {
>>   		mutex_unlock(&zdev->fmb_lock);
>>   		seq_puts(m, "FMB statistics disabled\n");
>>   		return 0;
> 
> Oh, and while playing around with this patch (with and without my
> additional modifications), I realized that statistics/function
> measurement gets re-enabled when I run `zpcictl --reset-fw <bdf>` to a
> function - despite it being switched off before the reset.

Great catch -- the FMB re-enablement in zpci_reenable_device() was just
one of the two places that needed it, I missed to add it in
pcibios_enable_device() instead of the existing unconditional enable. I
will fix this in the next version.

re: splitting up the functions into a pair of request functions and a
pair that actually do the MPCIFC: it will make resolving this issue more
straightforward, because preserving the state in pcibios_enable_device()
will require us to disable FMB without clearing its flag in
pcibios_disable_device() as well, which is cleanly possible with the
changes you suggested.

Thanks!

> 
> Thanks,
> Gerd
> 
> 
> [ here's the patch to avoid zpci_fmb_reenable_device(): ]
> 
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 77c8c49ba6c8..26c6b616cc25 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -350,9 +350,10 @@ int zpci_create_parent_msi_domain(struct zpci_bus
> *zbus);
>   void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
>   
>   /* FMB */
> -int zpci_fmb_enable_device(struct zpci_dev *);
> -int zpci_fmb_disable_device(struct zpci_dev *);
> -int zpci_fmb_reenable_device(struct zpci_dev *zdev);
> +int zpci_fmb_req_enable_device(struct zpci_dev *);
> +int zpci_fmb_req_disable_device(struct zpci_dev *);
> +int zpci_fmb_enable_device(struct zpci_dev *zdev);
> +int zpci_fmb_disable_device(struct zpci_dev *zdev);
>   
>   /* Debug */
>   int zpci_debug_init(void);
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index bda91d79bafd..c0bd76eac717 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -165,7 +165,7 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8
> dmaas)
>   }
>   
>   /* Modify PCI: Set PCI function measurement parameters */
> -int zpci_fmb_enable_device(struct zpci_dev *zdev)
> +int zpci_fmb_req_enable_device(struct zpci_dev *zdev)
>   {
>   	lockdep_assert_held(&zdev->fmb_lock);
>   
> @@ -173,20 +173,25 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>   		return -EINVAL;
>   
>   	zdev->fmb_requested = true;
> -	return zpci_fmb_reenable_device(zdev);
> +	return zpci_fmb_enable_device(zdev);
>   }
>   
>   /* Modify PCI: Disable PCI function measurement */
> -int zpci_fmb_disable_device(struct zpci_dev *zdev)
> +int zpci_fmb_req_disable_device(struct zpci_dev *zdev)
>   {
> -	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0,
> ZPCI_MOD_FC_SET_MEASURE);
> -	struct zpci_fib fib = {0};
> -	u8 cc, status;
> -
>   	lockdep_assert_held(&zdev->fmb_lock);
>   
>   	if (!zdev->fmb_requested)
>   		return -EINVAL;
> +	return zpci_fmb_disable_device(zdev);
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_req_disable_device);
> +
> +int zpci_fmb_disable_device(struct zpci_dev *zdev)
> +{
> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0,
> ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib = {0};
> +	u8 cc, status;
>   
>   	zdev->fmb_requested = false;
>   	fib.gd = zdev->gisa;
> @@ -200,14 +205,13 @@ int zpci_fmb_disable_device(struct zpci_dev
> *zdev)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(zpci_fmb_disable_device);
>   
>   /* Re-enable PCI function measurement: clear the software IOMMU
> counters
>    * and (re-)enable the FMB. This function is used to restore the
> desired
>    * FMB enablement state when measurement may be implicitly disabled by
>    * firmware (i.e., via CLP in zpci_disable_device())
>    */
> -int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +int zpci_fmb_enable_device(struct zpci_dev *zdev)
>   {
>   	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0,
> ZPCI_MOD_FC_SET_MEASURE);
>   	struct zpci_iommu_ctrs *ctrs;
> @@ -246,7 +250,7 @@ int zpci_fmb_reenable_device(struct zpci_dev *zdev)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);
> +EXPORT_SYMBOL_GPL(zpci_fmb_enable_device);
>   
>   static int zpci_cfg_load(struct zpci_dev *zdev, int offset, u32 *val,
> u8 len)
>   {
> @@ -660,7 +664,7 @@ int pcibios_enable_device(struct pci_dev *pdev, int
> mask)
>   
>   	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
>   	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_enable_device(zdev);
> +	zpci_fmb_req_enable_device(zdev);
>   	mutex_unlock(&zdev->fmb_lock);
>   
>   	return pci_enable_resources(pdev, mask);
> @@ -671,7 +675,7 @@ void pcibios_disable_device(struct pci_dev *pdev)
>   	struct zpci_dev *zdev = to_zpci(pdev);
>   
>   	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_disable_device(zdev);
> +	zpci_fmb_req_disable_device(zdev);
>   	mutex_unlock(&zdev->fmb_lock);
>   	zpci_debug_exit_device(zdev);
>   }
> @@ -760,7 +764,7 @@ int zpci_reenable_device(struct zpci_dev *zdev)
>   
>   	guard(mutex)(&zdev->fmb_lock);
>   	if (zdev->fmb_requested)
> -		zpci_fmb_reenable_device(zdev);
> +		zpci_fmb_enable_device(zdev);
>   
>   	return rc;
>   }
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index 9a960310d4dd..f2f0e7f44842 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -156,10 +156,10 @@ static ssize_t pci_perf_seq_write(struct file
> *file, const char __user *ubuf,
>   	mutex_lock(&zdev->fmb_lock);
>   	switch (val) {
>   	case 0:
> -		rc = zpci_fmb_disable_device(zdev);
> +		rc = zpci_fmb_req_disable_device(zdev);
>   		break;
>   	case 1:
> -		rc = zpci_fmb_enable_device(zdev);
> +		rc = zpci_fmb_req_enable_device(zdev);
>   		break;
>   	}
>   	mutex_unlock(&zdev->fmb_lock);

