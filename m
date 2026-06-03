Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510113A382B;
	Wed,  3 Jun 2026 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529722; cv=none; b=H0wFiOqoaJ8v6SjtpI5s78mK1cl1+9YNLFqETnlGo4hH9ctj4tbE4wNE5ou9uXaRaYaSi/DXQroHYTuGPDbcfBiY/6vnVA0LzAgKiUsaJX2eh0xD7s48lgOq0Rmq0Yj5RtECq2Yk73Jn2D85K3psv2kxL1P4AAlxP/PLHJU3otU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529722; c=relaxed/simple;
	bh=qXC0dKqrwxkTHC2AnBHia6wu1kyt9oSmx9N8lYqXCBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXUuJ0MeC56WJxXNFa72Yp/nWd3SK8JCv7kBYTvR63ucVfl6DizyCcwc7n6IU0xwJtXuVmhRZ9wZqOSXbq4bDhTwfAayY4Gd8DHLmBNX9wlSXU84kiggoPpRwAyEBqbWwtDdoFDqnh4cz2ppYx+6deKb3IcfHzGtJYNMuQWVKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q+VCKIIC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q+VCKIIC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653LeEH22223981;
	Wed, 3 Jun 2026 23:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zWZ3Rr
	E0alF0Fq8cOGiyS9ZwA+o4uQsci8MYhfwp6wM=; b=Q+VCKIICLu3VAlZLiAWfiQ
	CiuN6kdZTZ0K5vrsqkvjYCQKudHyIHafOU1oILAAwa0uN229dIjfOOMtSMjdnh9T
	4Kqk+Z6gRCK4H7QlZjbDkuxnSdEuE2jQpamL0AY/XtdNnY8+Gsfq5kUF+gGWnRVS
	euCWyaxChWKEkIUWa/yImzqhz5zkZvkSGjQwlDPDLhUqbQdWeAIeorfa4DFJpghb
	AXwTq/svYFfIV75A2eLdFPJcOv5+I6b3pawEprnUqPox1FOCmAUUi+eXC9mqamJ5
	6sA/wLD1icigB9q8AU+dez+nSiGktTt2KnMBB3wiWlsbeR1Ty6+H5dlG7RL6W/ww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4dfsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 23:35:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653NO6ik004754;
	Wed, 3 Jun 2026 23:35:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegtctv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 23:35:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653NZEYo54788502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 23:35:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30505805F;
	Wed,  3 Jun 2026 23:35:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F2B58043;
	Wed,  3 Jun 2026 23:35:13 +0000 (GMT)
Received: from [9.61.253.104] (unknown [9.61.253.104])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 23:35:13 +0000 (GMT)
Message-ID: <d352f011-3c47-475a-b0a3-6005e56ef21d@linux.ibm.com>
Date: Wed, 3 Jun 2026 16:35:11 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 1/4] s390/pci: Store PCI error information for
 passthrough devices
To: Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-2-alifm@linux.ibm.com>
 <20260603162006.27b78de5@shazbot.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260603162006.27b78de5@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfXzn3UUoliETS6
 k8gdD4LFuDjEJ7QVB8KYGZ281B9xThmIozYLVyszbjbx2pL2nmIWdRiGjpnnbLRXRB7Tay48UXF
 wUMddUuJ2t5Y+CGCPQdXM5s8buui7A8yT0V3jUj1NK2ZZCqv3Zw1ctB3j6gg2Ty8M9Jn3RBdWaR
 0bq5MEHHVpFucpj6lfMrOH2m37PXxCJU6Qj66i6WJZ1U1L6673XctlSXdgT3AzvdZmGDwAefmXE
 T9I2VVAuSa550vNsXg3RDIFmnXHHEAoyDuk2ZlLMeEj4OXrCoX5DIXAMWjw1cvfeKTAghfMT4Ug
 gyfGu6eJ20ghqOyy7uKNozWyI2dNZdWFiCmxUz/a0VG9+L3jh8/ZcOi0XY8MJM4AiQkyhlsBhTm
 7vPyX6FfzMa/C19wmYsi7g5sO6jF4/kY91bZKxhtWGiz6pKFVVPPxgUqSP9NJa8jZJFeESmwPwd
 qr7wYsRloBVtU1xP9Gw==
X-Proofpoint-GUID: RVLJDxbl3_lBsOL-3hRBMcvpKZCW2kmk
X-Proofpoint-ORIG-GUID: RVLJDxbl3_lBsOL-3hRBMcvpKZCW2kmk
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a20ba34 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jHfqqAy6MWXFn1doRmUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226


On 6/3/2026 3:20 PM, Alex Williamson wrote:
> On Wed,  3 Jun 2026 11:24:12 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>> @@ -81,6 +52,47 @@ static bool is_driver_supported(struct pci_driver *driver)
>>   	return true;
>>   }
>>   
>> +static int zpci_store_pci_error(struct pci_dev *pdev,
>> +				 struct zpci_ccdf_err *ccdf)
>> +{
>> +	struct zpci_dev *zdev = to_zpci(pdev);
>> +	int i;
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	if (!zdev->pending_errs.mediated_recovery)
>> +		return -EINVAL;
>> +
>> +	if (zdev->pending_errs.count >= ZPCI_ERR_PENDING_MAX) {
>> +		pr_err("%s: Maximum number (%d) of pending error events queued\n",
>> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
> Is this really an err condition or just a warn?  Nothing is
> fundamentally broken here, the queue is just full and we're losing
> errors.  Maybe this should be a warn?
>
> Can this create a DoS if a device continues to generate errors and
> nobody is consuming them?  Userspace could ignore the error.  This
> should probably be _ratelimited.

Architecturally once a device is an error state, then it doesn't 
generate any further error events. It normally will have only one event 
pending, we used a value of 4 for ZPCI_ERR_PENDING_MAX just to be 
cautious. Though it could be improved to be ratelimited.


>
> pr_err + pci_name suggests this should be a pci_ or dev_ call and since
> the pci variant doesn't exist, use dev_warn_ratelimited().
>
>> +		return -ENOMEM;
>> +	}
>> +
>> +	i = zdev->pending_errs.tail % ZPCI_ERR_PENDING_MAX;
>> +	memcpy(&zdev->pending_errs.err[i], ccdf, sizeof(struct zpci_ccdf_err));
>> +	zdev->pending_errs.tail++;
>> +	zdev->pending_errs.count++;
>> +	return 0;
>> +}
>> +
>> +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>> +{
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	zdev->pending_errs.mediated_recovery = true;
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
>> +
>> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
>> +{
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	zdev->pending_errs.mediated_recovery = false;
>> +	if (zdev->pending_errs.count)
>> +		pr_info("Unhandled PCI error events count=%d for PCI function 0x%x\n",
>> +			zdev->pending_errs.count, zdev->fid);
> It seems like there's always a race that an error could occur as the
> user is closing the device.  Is this really worth logging at anything
> more than a dbg level, pci_dbg() in this case?

I wanted to avoid pci_* log messages as it would require getting a 
handle of struct pci_dev and there were some concerns indicated by 
sashiko as mentioned in the thread

https://lore.kernel.org/all/c6363f08f898c7f4bb3e291ab2d3f7d8e3280459.camel@linux.ibm.com/


>
>> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
>> +
>>   static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
>>   							 struct pci_driver *driver)
>>   {
>> @@ -175,12 +187,15 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
>>    * and the platform determines which functions are affected for
>>    * multi-function devices.
>>    */
>> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
>> +							  struct zpci_ccdf_err *ccdf)
>>   {
>>   	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>> +	bool mediated_recovery = false;
>>   	char *status_str = "success";
>>   	struct pci_driver *driver;
>> +	int rc;
>>   
>>   	/*
>>   	 * Ensure that the PCI function is not removed concurrently, no driver
>> @@ -194,13 +209,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
>> @@ -216,12 +224,24 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>   		goto out_unlock;
>>   	}
>>   
>> +	rc = zpci_store_pci_error(pdev, ccdf);
>> +	if (!rc || rc == -ENOMEM)
>> +		mediated_recovery = true;
> This is a convoluted way to get the state of
> zdev->pending_errs.mediated_recovery, which becomes invalid out of
> pending_errs_lock anyway.

We had some discussion around this on a previous version, to simplify 
the error recovery to be driven by host or userspace recovery we decided 
with this approach 
https://lore.kernel.org/all/6dd6de60d72a70ff85ecab2a9d14f45a617f05e7.camel@linux.ibm.com/.


>
>> +
>>   	ers_res = zpci_event_notify_error_detected(pdev, driver);
>>   	if (ers_result_indicates_abort(ers_res)) {
>>   		status_str = "failed (abort on detection)";
>>   		goto out_unlock;
>>   	}
>>   
>> +	if (mediated_recovery) {
>> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
>> +			pci_name(pdev));
>> +		ers_res = PCI_ERS_RESULT_RECOVERED;
>> +		status_str = "in progress";
>> +		goto out_unlock;
>> +	}
> Since zdev->pending_errs.mediated_recovery is only valid while holding
> pending_errs_lock, this is really no better than the
> is_passed_through() test.
>
>> +
>>   	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
>>   		ers_res = zpci_event_do_error_state_clear(pdev, driver);
>>   		if (ers_result_indicates_abort(ers_res)) {
>> @@ -266,25 +286,19 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
>> +	zpci_store_pci_error(pdev, ccdf);
>>   	driver = to_pci_driver(pdev->dev.driver);
>>   	if (driver && driver->err_handler && driver->err_handler->error_detected)
>>   		driver->err_handler->error_detected(pdev, pdev->error_state);
> How do you intend to stage this versus QEMU changes?  This seems like a
> big regression if we're suddenly triggering the eventfd that causes
> QEMU to halt.  Do you need userspace to opt-in to mediated recovery
> rather than automatically enabling it on open?  Thanks,
>
> Alex

AFAIU userspace registering an eventfd to receive notification for error 
events is an opt-in? And yes for QEMU the current behavior halts the 
guest, but even today on an error device becomes unusable and requires 
manual intervention. I am not sure if we need to add another opt-in 
mechanism for QEMU.

Thanks

Farhan

