Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727664;
	b=ZTOSitTBntSIuxxdJNt2d23ER1slVgfhqvTODOoFXcJzsUbDT2AsMvORprnYUoY2FZ5m
	 9a6pMxJ6tHUwYleV8T84TkRDTCzeLn37qwrrQFDCCBwMBNHlNZ+g4TRijrCIikiuHTBSm
	 MRE17Uk+/m46xALJZM6xVKbHrcKOEi/9MBbP2wHwcdJskL+DlOaBYM+svP0iyaCLZ5YP7
	 bHeRxjrnToNG48VBP1fFaVsOIwoDk99ofiBz3eP7A4U25tFLMCLgaUP76NZ1RCB2oXmPa
	 YgWXo47LCobTLHuNagFL1ALqnGpHQ19aVLJV3VSmBTV/pWdQHtkQq+P8p/3hjNyObKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=n3gSCpFfvay6/ozLAQoO991oc7EXaYwyYPRFWThDPPA=;
	b=Ur30RBUxz9UtwL81p6seDUpZnFtRVOflJJZJPxK70ortkEV8yjqjMtWrzp3E8OmVBVbG
	 xz9i4qgvdjlMpqiCnKPMHCJOP5AgABx3K7eP7ZuDUCflR85ZBBJay8dfATlPuW0P1aSYF
	 8za37n4RxSp//+V+iRTKgg3JdJV0YZ28ni4R3N3Lp6id3PHdXLYXTfBITCxXv8xphD00e
	 rPS5y+zdhpqHVYV3dVQa+tY36G72eBDjOVBllLhOrJJNiKVkAMZ8+GJLSUIMT5/OmLwjJ
	 qpmZV6kzkz/USDdBmW/qs2UUZVfOzbe+JvwOlXoOuVLmzfTjeDBkEEWdd9Gvb+4/1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nCizpxUU;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C545606A33D;
	Tue,  3 Nov 2026 17:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C545606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nCizpxUU
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEGVn860956;
	Tue, 3 Nov 2026 17:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n3gSCp
	Ffvay6/ozLAQoO991oc7EXaYwyYPRFWThDPPA=; b=nCizpxUU+Ghc5fIYBHr2c4
	pigMxbxbFQISx7NWC1G8+Lk2ZUqVGw6Oxr00l3Z2zngsb51AIMMuNMC2YZSao/0N
	LL+ot2M3y2GT+03MZ/m8XxBiWVrGwl0f40Vem1CVe8uaYme0abWeMLjth5IHqptW
	gFAPjsCPDZxLav3DA9ejyr04RwkTI9alFe5Sx/ZPXzIApOoCYSQ5rOu+JWPTXHII
	YKKYj3XmGtDoMqYQ2dan0XBcYbKx3Ijrd45BH6X1A78S3iEtwMAqqZmyRGfT5Yud
	EscjsoIIj2h7wq6cEUOy80g9bjW8HrMWlwOu1BbeMaWWyOfoPw7BmLuXw6n2BzuA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd7889-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:41:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HYwhH2863719;
	Tue, 3 Nov 2026 17:41:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqkaetk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 17:41:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3He9ei65339656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 17:40:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88DF15804E;
	Tue,  3 Nov 2026 17:40:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0A858055;
	Tue,  3 Nov 2026 17:40:56 +0000 (GMT)
Received: from [9.61.243.67] (unknown [9.61.243.67])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Nov 2026 17:40:56 +0000 (GMT)
Message-ID: <17f74b7d-8fd8-49e9-960e-212cc3cdb09c@linux.ibm.com>
Date: Tue, 3 Nov 2026 12:40:55 -0500
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/5] s390/pci: Improve function measurement state
 management
To: Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-3-oelghoul@linux.ibm.com>
 <712b9ec90b4020131144ce5cd7976568ca5d2efa.camel@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <712b9ec90b4020131144ce5cd7976568ca5d2efa.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cc-8OHUNAunp6ei0DbNCghkQVB2EocP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2OCBTYWx0ZWRfX1pNm78WMvNcE
 IWn+kHDzth0kntLONA5On0zW64kkq70OTWS9WpXU5KyHJgJhIvXqWCnGm5rbMhS0063AZ3nvnQj
 LxCnWeLQyu14Xt7lV7nuIcRota0jmKP1hYR445tAd/Uy8ob3VHVB/xKNiY+IIiO4MHLPhBEABQp
 IpQO0my5Mwe+gDOj60PBFK2NztxIMiv1gfg7r8FC7W0EQ9/sWMBIAP1GgGxpOIz+//jygI9f9Io
 jspXn9zmcDXK9EO1/gHvX/vywYTpbbyvTqY2NduCyxZA43FjjL0fYQKkRPi/h4GM0mpIIQTfA21
 KUX/Ps1NkVJjQqzHJuQw/wslTPw/7ZxxrNM39K9lugwIZQAzU8RBZCWZBfWya9R+Lx3VksSG+vr
 jRrJmgZ5jjSgtj+SoE7u4EsIaTkUaVgeyWymg+OMkgmY5Id+kkvCsC2uKQxVItrlXSWRVfWABLK
 pMwiyUs2tiGI3uij9mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2OCBTYWx0ZWRfX8Gx6O3p3rfK1
 ABHoZ/9E7HwSKkLz00gauSLXYiVxJ8o+/mi+igD1KOaVMijHeWVSjFIfIInXnRKU/VQoH/sAqc+
 +Jrix4MEI8RgOG1xSzPw2MOYE69AVIA=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aea1cac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=rg2yHbvt5J1vBAkt3D8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cc-8OHUNAunp6ei0DbNCghkQVB2EocP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030068

On 11/3/26 12:02 PM, Gerd Bayer wrote:
> On Wed, 2026-10-28 at 11:43 -0400, Omar Elghoul wrote:
>> When a zPCI function is disabled and re-enabled, the firmware implicitly
>> disables function measurement while the kernel still believes it is
>> enabled, leading to a disconnect between the user-visible state and the
>> actual device state.
>>
>> Add the statistics_on field to struct zpci_dev to track the desired FMB
>> state. Introduce the functions zpci_fmb_request_on() and off(), which
>> defer to zpci_fmb_enable() or disable() to perform the actual firmware
>> change. This decouples the enablement or disablement step from managing
>> the user's requested state.
>>
>> Preserve the state in pcibios_enable_device(), pcibios_disable_device(),
>> and zpci_reenable_device(), so measurement is restored automatically
>> after a re-enable. New devices start with measurement on by default,
>> unchanged from before.
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h |  7 +++--
>>   arch/s390/pci/pci.c         | 60 +++++++++++++++++++++++++++++++++----
>>   arch/s390/pci/pci_debug.c   |  6 ++--
>>   3 files changed, 63 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
>> index 88a125b92bdd..dd7a17955362 100644
>> --- a/arch/s390/include/asm/pci.h
>> +++ b/arch/s390/include/asm/pci.h
>> @@ -208,6 +208,7 @@ struct zpci_dev {
>>   	struct zpci_fmb *fmb;
>>   	u16		fmb_update;	/* update interval */
>>   	u16		fmb_length;
>> +	bool		statistics_on;	/* desired FMB enablement */
>>   
>>   	u8		version;
>>   	enum pci_bus_speed max_bus_speed;
>> @@ -349,8 +350,10 @@ int zpci_create_parent_msi_domain(struct zpci_bus *zbus);
>>   void zpci_remove_parent_msi_domain(struct zpci_bus *zbus);
>>   
>>   /* FMB */
>> -int zpci_fmb_enable_device(struct zpci_dev *);
>> -int zpci_fmb_disable_device(struct zpci_dev *);
>> +int zpci_fmb_request_on(struct zpci_dev *zdev);
>> +int zpci_fmb_request_off(struct zpci_dev *zdev);
>> +int zpci_fmb_enable(struct zpci_dev *zdev);
>> +int zpci_fmb_disable(struct zpci_dev *zdev);
>>   
>>   /* Debug */
>>   int zpci_debug_init(void);
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index c055a9ad0972..5889dd227009 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -164,8 +164,44 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
>>   	return cc;
>>   }
>>   
>> +int zpci_fmb_request_on(struct zpci_dev *zdev)
>> +{
>> +	int rc;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
>> +
>> +	if (zdev->statistics_on)
>> +		return -EINVAL;
> 
> It's perhaps a question of taste, but is this strict rejection of
> double-enable really necessary? Wouldn't it be more defensive if the
> enable was just let to pass?

It isn't, and I actually just dropped it in v12. After introducing the
fmb_enabled bool in v12, we now reject double-enables right from within
zpci_fmb_enable() itself, matching the pre-existing behavior.

> Ah nevermind: That would allocate a new FMB buffer from zdev_fmb_cache
> and is a memory leak.

With this patch alone, the buffer doesn't leak because zpci_fmb_enable()
already rejects a double-enable with zdev->fmb is non-null. Of course,
patch 3 here (v11) does introduce an issue where we reuse the same FMB
buffer without adequately replacing the liveness check. This is again
addressed in v12.

> 
> 
>> +
>> +	rc = zpci_fmb_enable(zdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	zdev->statistics_on = true;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_request_on);
>> +
>> +int zpci_fmb_request_off(struct zpci_dev *zdev)
>> +{
>> +	int rc;
>> +
>> +	lockdep_assert_held(&zdev->fmb_lock);
>> +
>> +	if (!zdev->statistics_on)
>> +		return -EINVAL;
> 
> Same question here: Would a double-disable hurt anybody?
> Doh: Yeah, you don't want to go down that route...
> 
>> +
>> +	rc = zpci_fmb_disable(zdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	zdev->statistics_on = false;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_fmb_request_off);
>> +
>>   /* Modify PCI: Set PCI function measurement parameters */
>> -int zpci_fmb_enable_device(struct zpci_dev *zdev)
>> +int zpci_fmb_enable(struct zpci_dev *zdev)
>>   {
>>   	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>>   	struct zpci_iommu_ctrs *ctrs;
>> @@ -207,7 +243,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>>   }
>>   
>>   /* Modify PCI: Disable PCI function measurement */
>> -int zpci_fmb_disable_device(struct zpci_dev *zdev)
>> +int zpci_fmb_disable(struct zpci_dev *zdev)
>>   {
>>   	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
>>   	struct zpci_fib fib = {0};
>> @@ -644,7 +680,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
>>   
>>   	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
>>   	mutex_lock(&zdev->fmb_lock);
>> -	zpci_fmb_enable_device(zdev);
>> +	if (zdev->statistics_on)
>> +		zpci_fmb_enable(zdev);
>>   	mutex_unlock(&zdev->fmb_lock);
>>   
>>   	return pci_enable_resources(pdev, mask);
>> @@ -655,7 +692,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>>   
>>   	mutex_lock(&zdev->fmb_lock);
>> -	zpci_fmb_disable_device(zdev);
>> +	if (zdev->statistics_on)
>> +		zpci_fmb_disable(zdev);
>>   	mutex_unlock(&zdev->fmb_lock);
>>   	zpci_debug_exit_device(zdev);
>>   }
>> @@ -737,8 +775,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
>> +	if (zdev->statistics_on)
>> +		zpci_fmb_enable(zdev);
> 
> But that discussion about double-enable above makes me wonder:
> Would we leak an FMB buffer, here - at least until patch 3 comes to the
> rescue? Maybe the two patches are not so independent after all?

Nope, we don't because the behavior of zpci_fmb_enable()/_disable() is
still unchanged from before this patch. They will still reject a double-
disable/enable attempt even without patch 3.

> 
> So, I experimented a little with patch 1 and 2 applied in an LPAR: I
> injected PCI auto-recovery with 'zpcictl --reset-fw' to a NETD PF and a
> NVMe PF and was pleasantly surprised that no resources were leaked
> *and* statistics were enabled before and after the PCI auto-recovery.
> 
> Turns out that both the mlx5 and the nvme drivers pci_error_handlers
> callbacks for error_detected() switch off statistics by way of
> pci_disable_device() which calls pcibios_disable_device() - and the
> callback for slot_reset (mlx5) resp. reset_done (nvme) restore the
> statistics setting again by way of pci_enable_device() which calls
> pcibios_enable_device().
> 
> So one could argue, that at least for the PCI auto-recovery case, this
> conditional call to zpci_fmb_enable() is not needed?

I think you're right, but we still need this call here for other paths
that call zpci_reenable_device() without pcibios_enable_device(). IIRC
a sysfs recovery (via recover_store() -> _do_recover()) disables the
device and then re-enables it using zpci_reenable_device().

Thanks

> 
>>   
>>   	return rc;
>>   }
>> @@ -847,6 +891,12 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>>   		goto error;
>>   	zdev->state =  state;
>>   
>> +	/*
>> +	 * Measurement is on by default for new functions, this will be honored
>> +	 * by pcibios_enable_device().
>> +	 */
>> +	zdev->statistics_on = true;
>> +
>>   	mutex_init(&zdev->state_lock);
>>   	mutex_init(&zdev->fmb_lock);
>>   	mutex_init(&zdev->kzdev_lock);
>> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
>> index c7ed7bf254b5..e479763858cd 100644
>> --- a/arch/s390/pci/pci_debug.c
>> +++ b/arch/s390/pci/pci_debug.c
>> @@ -97,7 +97,7 @@ static int pci_perf_show(struct seq_file *m, void *v)
>>   		return 0;
>>   
>>   	mutex_lock(&zdev->fmb_lock);
>> -	if (!zdev->fmb) {
>> +	if (!zdev->statistics_on || !zdev->fmb) {
>>   		mutex_unlock(&zdev->fmb_lock);
>>   		seq_puts(m, "FMB statistics disabled\n");
>>   		return 0;
>> @@ -156,10 +156,10 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
>>   	mutex_lock(&zdev->fmb_lock);
>>   	switch (val) {
>>   	case 0:
>> -		rc = zpci_fmb_disable_device(zdev);
>> +		rc = zpci_fmb_request_off(zdev);
>>   		break;
>>   	case 1:
>> -		rc = zpci_fmb_enable_device(zdev);
>> +		rc = zpci_fmb_request_on(zdev);
>>   		break;
>>   	}
>>   	mutex_unlock(&zdev->fmb_lock);
> 
> But overall, this is looking good!
> Thanks, Gerd

