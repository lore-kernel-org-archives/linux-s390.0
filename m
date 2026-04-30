Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C432517AF;
	Thu, 30 Apr 2026 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567482; cv=none; b=TsGfI3TQt4rEsFxXWYptuxGbtJzDgBymHV5uwlORjRddywzU0xPtsE6FfSCAFR0ePsKF8FWYsqZMbGTz7pw6ww19bQ7a3YMl0T9l5yRXuqRgh04Kxf/ybpcn9+s7ovVGBG0S8PEjSJGJ2dOxALOXq2heLtucto/9DHl1OIyqfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567482; c=relaxed/simple;
	bh=XvhtE89rLKN7yVzsswPn+nom3MnXKQQfnZSBu45uKi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWqziZCiDcQIbH0Vp/9YLfnc7YruC9FDGzsRu6f10I6ypGDgKBcmhvFbUghfJUCPol9jFgi//+iFOGuV6RjaOYh6ewhIhWxhBjFDyHtqhdaV9PwqT//aSc2kmPlauuZ7ZvesBio/8eusp/czAmIfX17dq1RB0BvrgjIj7GkD5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7wyTuYB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7wyTuYB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UE9nGt3636208;
	Thu, 30 Apr 2026 16:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5L4vfz
	ysA474NLkV3xAw2FMxF+dbAjPGijsSY0GZs5Y=; b=Q7wyTuYBrbuZYY6LlSbKAV
	2pelZzxF8YmeP3J2c8vYGCM9kiebyKAEjIERneXlPJx1Vj3rd8+X2Xguy1LeGrLw
	qqvdFV6KQ/GeewzI46504OTwpCjoGdQVnGPGCobPUYfW4+mufiiNjmTFrfwFUyCO
	ZBlEBDSI+Z5+P3WCHs4BhZC2OiNchQTjx3RCv0TwkWUaApw0pzTXZt7KUMjeNDD9
	7TFAiVNCDk1qc6gC/RkUae8F7GX8mkH4c8FzhI0sW/y5wWBh9BqBdxIguKoVCyJ6
	1876kzq12DEZrjrYCRYY539+Wtw58NlFyvg7HT9c1s9nOQ1l+QkpweII618MHNhA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e74hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 16:44:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UGcjpL029936;
	Thu, 30 Apr 2026 16:44:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehks2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 16:44:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UGiXCt5505992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 16:44:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FD685805D;
	Thu, 30 Apr 2026 16:44:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47BB65805F;
	Thu, 30 Apr 2026 16:44:32 +0000 (GMT)
Received: from [9.61.253.116] (unknown [9.61.253.116])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 16:44:32 +0000 (GMT)
Message-ID: <d8db6828-b747-48c8-84a0-3fd56e0d52d4@linux.ibm.com>
Date: Thu, 30 Apr 2026 09:44:31 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        mjrosato@linux.ibm.com
References: <20260421163031.704-1-alifm@linux.ibm.com>
 <20260421163031.704-5-alifm@linux.ibm.com>
 <08008a2a61556482c71f7f0ed65106e32e77f418.camel@linux.ibm.com>
 <3f0d25e2-fe8f-470e-a857-f5474cba8cdf@linux.ibm.com>
 <c6363f08f898c7f4bb3e291ab2d3f7d8e3280459.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <c6363f08f898c7f4bb3e291ab2d3f7d8e3280459.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IFmZxmEnUWTCeQqpHlwcAj4hUnnFu0AB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2OSBTYWx0ZWRfXy1dXM3xljbt+
 G1ViHOI1Pfo3wQ5WizBOVv+gQSH7mocjWi58xiOzEp7+S7DvJD5Hkn7CTCM7YNvkg6CqfACPQBS
 E1n6gkZJ6v6udETtwNtnZtciKNP6U9FSMhOlJs+Fme3nWPpkS8hExsWtqS2FsUEIeelcP6/JVfN
 HsbQxHwI/nWrqtYr0k9XeM5s+2ZY7aRxbc3VILXT1l1+qeHadvWzJPANnaVf6LZ5+UrVNkPpJo6
 pTqdZutk3AdpgWV1nqGCM3NW8lhDi7m6lun0txlkaaZ9irNHHE42jD/oYDBwXKR37rLJ1jFfAM9
 8907bDuodEPbrjIrm3uUpY9WlfduZdY/vCqr5jR8qoKEmognwsDbEdxmOUYGLRhrmfWYZzYkcHF
 nj3yvGBHXDTHuNq0gjS4dcIm1Vt6Vi+LB0FEjmo22NYKu6BgChx12P7nG0y1pDYnB5zwRIYGelF
 YmZ4VSm3L9w9QdlFAYg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f386f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=VnNF1IyMAAAA:8 a=rClJao6qy1NmKOyu5GIA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: IFmZxmEnUWTCeQqpHlwcAj4hUnnFu0AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300169


On 4/30/2026 12:48 AM, Niklas Schnelle wrote:
> On Wed, 2026-04-29 at 09:48 -0700, Farhan Ali wrote:
>> On 4/29/2026 4:41 AM, Niklas Schnelle wrote:
>>> On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
>>>> For a passthrough device we need co-operation from user space to recover
>>>> the device. This would require to bubble up any error information to user
>>>> space.  Let's store this error information for passthrough devices, so it
>>>> can be retrieved later.
>>>>
>>>> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
>>>> drivers will not have any KVM fd and so no kzdev associated with them. So
>>>> we need to update the logic for detecting passthrough devices to not depend
>>>> on struct kvm_zdev.
>>>>
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    arch/s390/include/asm/pci.h      |  30 ++++++++
>>>>    arch/s390/pci/pci.c              |   1 +
>>>>    arch/s390/pci/pci_event.c        | 117 +++++++++++++++++--------------
>>>>    drivers/vfio/pci/vfio_pci_zdev.c |   9 ++-
>>>>    4 files changed, 105 insertions(+), 52 deletions(-)
>>>>
>>> --- snip ---
>>>> +
>>>> +void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>>>> +{
>>>> +	guard(mutex)(&zdev->pending_errs_lock);
>>>> +	zdev->pending_errs.mediated_recovery = true;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(zpci_start_mediated_recovery);
>>>> +
>>>> +void zpci_stop_mediated_recovery(struct zpci_dev *zdev)
>>>> +{
>>>> +	struct pci_dev *pdev = NULL;
>>>> +
>>>> +	guard(mutex)(&zdev->pending_errs_lock);
>>>> +	zdev->pending_errs.mediated_recovery = false;
>>>> +	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
>>>> +	if (zdev->pending_errs.count)
>>>> +		pr_info("%s: Unhandled PCI error events count=%d",
>>>> +			pci_name(pdev), zdev->pending_errs.count);
>>> Sashiko notes a possible ABBA locking issue here between
>>> pending_errs_lock and the pci_bus_sem inside pci_get_slot(). I wonder
>>> if that would also be visible with lockdep? Also Sashiko notes that
>>> zdev->zbus->bus could be NULL I don't think this is possible at the
>>> current callsites via vfio-pci though. Similarly I don't think
>>> pci_get_slot() can really be NULL at the current call sites. This makes
>>> me wonder however, would it maybe be cleaner to pass a struct pci_dev
>>> here so you don't need the pci_get_slot() at all? Both
>>> vfio_pci_zdev_open_device() and vfio_pci_zdev_close_device() have that
>>> readily available via vdev->pdev.
>> The pdev here was meant for helpful error message. On second thought
>> maybe removing the pdev usage, and using the fid would be better?
> Either that or maybe just return the number of left over errors and do
> the print in the caller?
>
>>>
>>>> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
>>>> +	pci_dev_put(pdev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
>>>> +
>>>>    static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
>>>>    							 struct pci_driver *driver)
>>>>    {
>>>> @@ -175,7 +190,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
>>>>     * and the platform determines which functions are affected for
>>>>     * multi-function devices.
>>>>     */
>>>> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>>> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
>>>> +							  struct zpci_ccdf_err *ccdf)
>>>>    {
>>>>
> --- snip ---
>>>>    
>>>> +	scoped_guard(mutex, &zdev->pending_errs_lock) {
>>>> +		if (zdev->pending_errs.mediated_recovery) {
>>>> +			pr_info("%s: Leaving recovery of pass-through device to user-space\n",
>>>> +				pci_name(pdev));
>>>> +			ers_res = PCI_ERS_RESULT_RECOVERED;
>>>> +			status_str = "in progress";
>>>> +			goto out_unlock;
>>>> +		}
>>>> +	}
>>>> +
>>> Sashiko notes that mixing goto unlock and lock guards within one
>>> function is discouraged. Here it's not that hard to read since it is
>>> just a scoped guard but I think we should still not mix it.
>>>
>>> However if we also convert the device_lock() to a guard lock here the
>>> goto would still make sense to go to the zpci_report_status() and that
>>> is still a bit odd with guarded locks. So I think an alternative simple
>>> fix, that makes this overall cleaner too, is to put the whole
>>> scoped_guard() block above into a helper function then you can do the
>>> goto out_unlock on that helper returning PCI_ERS_RESULT_RECVOERED in
>>> line with e.g. zpci_event_notify_error_detected(). That way you don't
>>> need to touch existing locks and you get to keep the guard locking.
>> How about changing it to mutex_lock/mutex_unlock? I think the block is
>> small enough that it shouldn't be too confusing. Moving to a function
>> opens up the possibility of using a stale value for mediated_recovery.
> I'm probably missing something but I don't see how moving it to a
> helper function changes whether the mediated_recovery can be stale?
> You'd still use the same pending_errs_lock and passed in struct
> zpci_dev * then you just return PCI_ERS_RESULT_RECOVERED if mediated
> recovery is in effect? And you can do the pr_info() at the caller so
> you don't need to pass in the pdev too.

I think Alex raised a concern about a similar approach in a previous 
version[1]. IIUC there could be a device open/close when we check the 
mediated_recovery and return PCI_ERS_RESULT_RECOVERED to when execute 
the goto. So i think its safer to do this with the pending_errs lock held.

[1]https://lore.kernel.org/all/20260407093814.3d95263a@shazbot.org/

Thanks

Farhan


