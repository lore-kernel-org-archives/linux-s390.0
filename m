Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1443469FC;
	Tue,  7 Apr 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584821; cv=none; b=JZXDhpEhgjDCXumvj33dV0egn/o0qBkotx30M4vCssN+65AVh/N5jOlquIYvcgukfreLAeK44kW/rKIDKkMffKrHV4onVNGuYuzuCJ4J1RpkwwHgfiAhRtVxSYmxGFlcMINa30p8acmqUeXvVuTQ69jn0Hr7/ELAJVY32TU7xyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584821; c=relaxed/simple;
	bh=3Oc82CuQtPfWXuluikNqCTtQ2AfMC7vpH0+GOQQoxyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDLaof5dnnusJSCbshBGwU+Pa95ih1Q1zX+6IQNPF1eau3BGGt8lH9TPxuT1ZZHgUrU79Y5bvlvhoAgb7zNMjF6Pp03addUBWyh8+XZNe4j6Im5c4Tcpxq2l8aEO/6PNE+4WdAYGh+F5EGtjhCEgCiqX3cx+ozk4acXABVgTAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XZb7Ga5v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XZb7Ga5v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EHqhW2315031;
	Tue, 7 Apr 2026 18:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oOYrBM
	s6o5yjqpMIwO4tk1hMjb+laIGfrabjrB+GMO0=; b=XZb7Ga5v95f3TtfBF6L389
	w14jPOq1vfnXoWJfiCA0yiUoli4Kt23BL71grIZBlX99M+gC6NcF4PgfCQW2dFBC
	5iMjk5qQLFtKDms6+I6TvfIDQk886kRJFnszZtJrvKaub3h3pJxv/FLXZRz+nloJ
	Uqf8reaKHkj+xK57J161E95NlP7wRt0HHA0OLwp2VBa0REVz1zDelLpDA12PPyj4
	ozJDEtovyaXzHz0ob5gWACKm5WTQJcRxWp8SsVpRGd827Dva/TE4EAWLAXm/+oqY
	kwxThwdo9JI461b8ag4vX+ocXXH/JRox170TdWA9T3bkwwUmKodKflHHyBmWolfQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fveyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 18:00:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637EUOef013824;
	Tue, 7 Apr 2026 18:00:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf449c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 18:00:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637HxfMp27591192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 17:59:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EAFC58055;
	Tue,  7 Apr 2026 18:00:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97BE58043;
	Tue,  7 Apr 2026 18:00:05 +0000 (GMT)
Received: from [9.61.244.198] (unknown [9.61.244.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 18:00:05 +0000 (GMT)
Message-ID: <5d8ba477-9a4c-4bac-b36f-a5c33de57850@linux.ibm.com>
Date: Tue, 7 Apr 2026 11:00:05 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-5-alifm@linux.ibm.com>
 <20260407093814.3d95263a@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260407093814.3d95263a@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d54629 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=w2gAOB7MCSGFKRSxISkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T0X44Hs7zOCFVhQaIx1Fq2Px_iyo350z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE2MSBTYWx0ZWRfX/G3GSsrUs/gP
 Kgy21a9k3fS+lDKja1P35MekA2ClR3bL1JMSd5B8W+J01/rlQnoUK0+h/hlQq/ng+cg+kFblwPc
 xHhKwb3rdIyB1KpxLoTwsM2nD7HwcN35VUpcBwdLUWI2iaL33pMqfGUqyEyf+fZUDyhPuAbgUtn
 Wg6M7r33uaiqbFmg4aRGwDqhqbjSn+YijUy60CxzqYNGN5+oDc0brbBfONClQd5aRAL9HTRA6Hq
 P+IPjlo9EUu1f59OGSNe0dmf1ovKEki8wvfH9SjOnHWq2Qv8xjd7+eJl7X4Xj/OXl4bSBp1kHr6
 xBYfsohxrqN5y+dPvl12ohk+vYYLrICW0Zoqp4s92AdXwsDJmuvux1WSF4CJCNCeA0F1IZGxwfT
 jkXE64DGQ9SF0A5UeW1vE86GX3jOw2CwLhnbyrkN45j6YjyuZui47FwartIq4E5wWyidqJe550a
 XN636JOeUj3r7X6KDOA==
X-Proofpoint-GUID: T0X44Hs7zOCFVhQaIx1Fq2Px_iyo350z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070161


On 4/7/2026 8:38 AM, Alex Williamson wrote:
> On Mon, 30 Mar 2026 10:40:08 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
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
>>   	spinlock_t dom_lock;		/* protect s390_domain change */
>>   };
>>   
>> @@ -330,6 +358,8 @@ void zpci_debug_exit_device(struct zpci_dev *);
>>   int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
>>   int zpci_clear_error_state(struct zpci_dev *zdev);
>>   int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>> +void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
>>   
>>   #ifdef CONFIG_NUMA
>>   
>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>> index 2a430722cbe4..d64d370d86cf 100644
>> --- a/arch/s390/pci/pci.c
>> +++ b/arch/s390/pci/pci.c
>> @@ -841,6 +841,7 @@ struct zpci_dev *zpci_create_device(u32 fid, u32 fh, enum zpci_state state)
>>   	mutex_init(&zdev->state_lock);
>>   	mutex_init(&zdev->fmb_lock);
>>   	mutex_init(&zdev->kzdev_lock);
>> +	mutex_init(&zdev->pending_errs_lock);
>>   
>>   	return zdev;
>>   
>> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
>> index 839bd91c056e..9cda09da8b43 100644
>> --- a/arch/s390/pci/pci_event.c
>> +++ b/arch/s390/pci/pci_event.c
>> @@ -17,23 +17,6 @@
>>   #include "pci_bus.h"
>>   #include "pci_report.h"
>>   
>> -/* Content Code Description for PCI Function Error */
>> -struct zpci_ccdf_err {
>> -	u32 reserved1;
>> -	u32 fh;				/* function handle */
>> -	u32 fid;			/* function id */
>> -	u32 ett		:  4;		/* expected table type */
>> -	u32 mvn		: 12;		/* MSI vector number */
>> -	u32 dmaas	:  8;		/* DMA address space */
>> -	u32		:  6;
>> -	u32 q		:  1;		/* event qualifier */
>> -	u32 rw		:  1;		/* read/write */
>> -	u64 faddr;			/* failing address */
>> -	u32 reserved3;
>> -	u16 reserved4;
>> -	u16 pec;			/* PCI event code */
>> -} __packed;
>> -
>>   /* Content Code Description for PCI Function Availability */
>>   struct zpci_ccdf_avail {
>>   	u32 reserved1;
>> @@ -60,16 +43,11 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
>>   	}
>>   }
>>   
>> -static bool is_passed_through(struct pci_dev *pdev)
>> +static bool needs_mediated_recovery(struct pci_dev *pdev)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>> -	bool ret;
>> -
>> -	mutex_lock(&zdev->kzdev_lock);
>> -	ret = !!zdev->kzdev;
>> -	mutex_unlock(&zdev->kzdev_lock);
>> -
>> -	return ret;
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	return zdev->mediated_recovery;
>>   }
> This immediately raises a red flag, the caller gets a snapshot of the
> value under mutex, but nothing guarantees the value doesn't immediately
> change before the caller can take action using the (now stale) value.
>
> The pending_errs_lock is attempting to be used to protect the recovery
> state, in kernel vs mediated, but it only provides an instantaneous
> snapshot.
>
>>   
>>   static bool is_driver_supported(struct pci_driver *driver)
>> @@ -81,6 +59,47 @@ static bool is_driver_supported(struct pci_driver *driver)
>>   	return true;
>>   }
>>   
>> +static void zpci_store_pci_error(struct pci_dev *pdev,
>> +				 struct zpci_ccdf_err *ccdf)
>> +{
>> +	struct zpci_dev *zdev = to_zpci(pdev);
>> +	int i;
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
>> +		pr_err("%s: Maximum number (%d) of pending error events queued",
>> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
>> +		return;
>> +	}
>> +
>> +	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
>> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
>> +	zdev->pending_errs.tail++;
>> +	zdev->pending_errs.count++;
>> +}
> Here we're using the mutex for something different, serializing access
> to the buffer.

Maybe I misunderstood, but I trying to implement this based on your 
suggestion [1] from previous version of using the pending_errs_lock to 
protect the mediated_recovery flag. I think it might be better to rename 
the lock or maybe even have 2 separate locks?


>
>> +
>> +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>> +{
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	zdev->mediated_recovery = true;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
> An now back to protecting the recovery mode, but not really.
>
>> +
>> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
>> +{
>> +	struct pci_dev *pdev = NULL;
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	zdev->mediated_recovery = false;
>> +	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
>> +	if (zdev->pending_errs.count)
>> +		pr_info("%s: Unhandled PCI error events count=%d",
>> +			pci_name(pdev), zdev->pending_errs.count);
>> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
>> +	pci_dev_put(pdev);
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
> This brings the use cases together, fair.
>
>> +
>>   static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
>>   							 struct pci_driver *driver)
>>   {
>> @@ -175,7 +194,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
>>    * and the platform determines which functions are affected for
>>    * multi-function devices.
>>    */
>> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
>> +							  struct zpci_ccdf_err *ccdf)
>>   {
>>   	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>> @@ -194,13 +214,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>   	}
>>   	pdev->error_state = pci_channel_io_frozen;
>>   
>> -	if (is_passed_through(pdev)) {
>> -		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
>> -			pci_name(pdev));
>> -		status_str = "failed (pass-through)";
>> -		goto out_unlock;
>> -	}
>> -
>>   	driver = to_pci_driver(pdev->dev.driver);
>>   	if (!is_driver_supported(driver)) {
>>   		if (!driver) {
>> @@ -216,12 +229,23 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>   		goto out_unlock;
>>   	}
>>   
>> +	if (needs_mediated_recovery(pdev))
> The test result is invalid here.  Why not call zpci_store_pci_error()
> unconditionally here and wrap both in the same guard?
> needs_mediated_recovery() should have a lockdep_assert.

I think storing the error via zpci_store_pci_error() only made sense if 
the error needed to be handled outside the kernel. Thinking more now I 
think it makes sense to have separate locks, as the mediated_recovery 
flag really provides information on if the vfio device is still opened 
or closed.


>
>> +		zpci_store_pci_error(pdev, ccdf);
>> +
>>   	ers_res = zpci_event_notify_error_detected(pdev, driver);
>>   	if (ers_result_indicates_abort(ers_res)) {
>>   		status_str = "failed (abort on detection)";
>>   		goto out_unlock;
>>   	}
>>   
>> +	if (needs_mediated_recovery(pdev)) {
>> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
>> +			pci_name(pdev));
>> +		ers_res = PCI_ERS_RESULT_RECOVERED;
>> +		status_str = "in progress";
>> +		goto out_unlock;
>> +	}
> Does the mutex guard need to extend to here to make sure this is
> consistent with the previous test?  What prevents an open/close
> across these discrete tests?

Yeah nothing prevents the device from being open/closed between the 
test. Will fix this.


>
>> +
>>   	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
>>   		ers_res = zpci_event_do_error_state_clear(pdev, driver);
>>   		if (ers_result_indicates_abort(ers_res)) {
>> @@ -266,25 +290,20 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>    * @pdev: PCI function for which to report
>>    * @es: PCI channel failure state to report
>>    */
>> -static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
>> +static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es,
>> +				  struct zpci_ccdf_err *ccdf)
>>   {
>>   	struct pci_driver *driver;
>>   
>>   	pci_dev_lock(pdev);
>>   	pdev->error_state = es;
>> -	/**
>> -	 * While vfio-pci's error_detected callback notifies user-space QEMU
>> -	 * reacts to this by freezing the guest. In an s390 environment PCI
>> -	 * errors are rarely fatal so this is overkill. Instead in the future
>> -	 * we will inject the error event and let the guest recover the device
>> -	 * itself.
>> -	 */
>> -	if (is_passed_through(pdev))
>> -		goto out;
>> +
>> +	if (needs_mediated_recovery(pdev))
>> +		zpci_store_pci_error(pdev, ccdf);
> Same.  Unless something else prevents this from changing, the mutex is
> not effective between test and use.  Thanks,

Yes, will fix this.

Thanks

Farhan

>
> Alex
>
>>   	driver = to_pci_driver(pdev->dev.driver);
>>   	if (driver && driver->err_handler && driver->err_handler->error_detected)
>>   		driver->err_handler->error_detected(pdev, pdev->error_state);
>> -out:
>> +
>>   	pci_dev_unlock(pdev);
>>   }
>>   
>> @@ -330,12 +349,12 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
>>   		break;
>>   	case 0x0040: /* Service Action or Error Recovery Failed */
>>   	case 0x003b:
>> -		zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
>> +		zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
>>   		break;
>>   	default: /* PCI function left in the error state attempt to recover */
>> -		ers_res = zpci_event_attempt_error_recovery(pdev);
>> +		ers_res = zpci_event_attempt_error_recovery(pdev, ccdf);
>>   		if (ers_res != PCI_ERS_RESULT_RECOVERED)
>> -			zpci_event_io_failure(pdev, pci_channel_io_perm_failure);
>> +			zpci_event_io_failure(pdev, pci_channel_io_perm_failure, ccdf);
>>   		break;
>>   	}
>>   	pci_dev_put(pdev);
>> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
>> index 0990fdb146b7..0658095ac5b1 100644
>> --- a/drivers/vfio/pci/vfio_pci_zdev.c
>> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
>> @@ -148,6 +148,8 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>>   	if (!zdev)
>>   		return -ENODEV;
>>   
>> +	zpci_start_mediated_recovery(zdev);
>> +
>>   	if (!vdev->vdev.kvm)
>>   		return 0;
>>   
>> @@ -161,7 +163,12 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>>   {
>>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
>>   
>> -	if (!zdev || !vdev->vdev.kvm)
>> +	if (!zdev)
>> +		return;
>> +
>> +	zpci_stop_mediated_recovery(zdev);
>> +
>> +	if (!vdev->vdev.kvm)
>>   		return;
>>   
>>   	if (zpci_kvm_hook.kvm_unregister)
