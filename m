Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177361BF33;
	Wed, 29 Apr 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481329; cv=none; b=TEhjh0IUBNGbSg5TvvrR/nXhR7VI41Z/7tpTMi4pT4isRxSasWCSvlpCDi5XwS54hR6Z5t1vXTZ/qoFD8X2AuJ8ldYgI0DMNplgfzjjjx3MZGDFBfhLpCP83utC/9aEt1MDrjSgc2HarhT2a+s+cYK9AUCRxgfjJcuy1RSLXv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481329; c=relaxed/simple;
	bh=4smGaLjoU0hrT/urGxaKNLqx+urAyoW/OI6iJfTTaoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFjw0bESqqXiMLHfcuRsNu20vIw54tFbfHwqI8i8ReyX0Sq0M9rAo+A9JASDWa+CaCisfMkwWyZxf8CltoO1Bjbl0NXDWjfn3k2xZFhADkDarFNCZ2rMbTXjRNHmKG5yNstlUMaOvEsEVAQLNYRVKTK2zJhFGcDM4tExiJstOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N5vu02I9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N5vu02I9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TAxLHV2581734;
	Wed, 29 Apr 2026 16:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D5Q9lE
	nAGTn1pTXPBMevVztOM+h15O7DUTqSvBWYnyA=; b=N5vu02I95vz31GZ4NS+1zB
	1MWy9mGm/3GPSeFSoHXYL5AyBVSz8qJ4UTYeRARXs0+FLRUC5koeZcZ0LNHN2OD8
	PwZScM1h44Bb2ySN4oIlNGiz7EihdVm9/7Z7o/o0KoWoTpHvIOQaAGBNZxmKyihj
	e+7hwajnSDidrTcbzn7rgtrkv86gLmnGrsppbeqCGGK/rdmXFQJDavdAk40bgAkC
	ugaTGLYyiauZIZ6Zoza3C8reBeCr+RTI5MQLZ6cBPvoZIoLXhj3+sXkIjjjsUQnU
	hO/oN2+Azt5orUgFnXG7HQ8FQwGBgaouYHBIyVXlrNxdHtXlGtzldN3UjyPZ0xEw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vj2hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:48:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TGcqFp030202;
	Wed, 29 Apr 2026 16:48:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avy88e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:48:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TGmXpt27525826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 16:48:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96EC758054;
	Wed, 29 Apr 2026 16:48:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D355803F;
	Wed, 29 Apr 2026 16:48:32 +0000 (GMT)
Received: from [9.61.245.137] (unknown [9.61.245.137])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 16:48:32 +0000 (GMT)
Message-ID: <3f0d25e2-fe8f-470e-a857-f5474cba8cdf@linux.ibm.com>
Date: Wed, 29 Apr 2026 09:48:32 -0700
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
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <08008a2a61556482c71f7f0ed65106e32e77f418.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f23663 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Ari48j0v6zWzjkmJ-KoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VHbjh4NNUMT9RRbPYTBkTEe7l_iadA-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2OSBTYWx0ZWRfX1tOLDRtHADMf
 dNP9g3WCikLXPb+0BHdubiWaQK/Mf8O5KBJf0d+6L7aO4k9h/EI3DjZsM2qHIARf7PQjSL2sJCa
 kCQDMDzwhxJmmwopZaKTsrhB4NwtvgaEAi2+m6RRiTS0zuTNqevXtv+UEBDQbst/HIfldFgw7vo
 +zVMJg06y0H2RljuyERAUgELjkA3oj10bM6u5iCoO9R5MegS/Dj/tFS1IHkuAD8wuXG2uS38KGW
 M/NlqxY3cZ97jPmMZPMA70QNufNubAojneNTrNu2C9xthSLXasuIWgBVkyvhimoilnDK7SVSY5m
 PlEWaCmV0Phtvcc0lZZFVEMLeEUT982VKGuDDRSM3+TyeHVVMyk9qqGORKGHBWdCs6Xs3ozH6g5
 cB1Oq9VBU2HxobHIEuvd24RJyAZ6u6Cfg7xa/TFa8P+c8dMqcsqOJKzBRqYz6PX0oQ+Mnv6ICft
 TYGQNztkuZIjwyEcoaw==
X-Proofpoint-GUID: VHbjh4NNUMT9RRbPYTBkTEe7l_iadA-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290169


On 4/29/2026 4:41 AM, Niklas Schnelle wrote:
> On Tue, 2026-04-21 at 09:30 -0700, Farhan Ali wrote:
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
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/pci.h      |  30 ++++++++
>>   arch/s390/pci/pci.c              |   1 +
>>   arch/s390/pci/pci_event.c        | 117 +++++++++++++++++--------------
>>   drivers/vfio/pci/vfio_pci_zdev.c |   9 ++-
>>   4 files changed, 105 insertions(+), 52 deletions(-)
>>
> --- snip ---
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
>> +	struct pci_dev *pdev = NULL;
>> +
>> +	guard(mutex)(&zdev->pending_errs_lock);
>> +	zdev->pending_errs.mediated_recovery = false;
>> +	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
>> +	if (zdev->pending_errs.count)
>> +		pr_info("%s: Unhandled PCI error events count=%d",
>> +			pci_name(pdev), zdev->pending_errs.count);
> Sashiko notes a possible ABBA locking issue here between
> pending_errs_lock and the pci_bus_sem inside pci_get_slot(). I wonder
> if that would also be visible with lockdep? Also Sashiko notes that
> zdev->zbus->bus could be NULL I don't think this is possible at the
> current callsites via vfio-pci though. Similarly I don't think
> pci_get_slot() can really be NULL at the current call sites. This makes
> me wonder however, would it maybe be cleaner to pass a struct pci_dev
> here so you don't need the pci_get_slot() at all? Both
> vfio_pci_zdev_open_device() and vfio_pci_zdev_close_device() have that
> readily available via vdev->pdev.

The pdev here was meant for helpful error message. On second thought 
maybe removing the pdev usage, and using the fid would be better?

>
>
>> +	memset(&zdev->pending_errs, 0, sizeof(struct zpci_ccdf_pending));
>> +	pci_dev_put(pdev);
>> +}
>> +EXPORT_SYMBOL_GPL(zpci_stop_mediated_recovery);
>> +
>>   static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
>>   							 struct pci_driver *driver)
>>   {
>> @@ -175,7 +190,8 @@ static pci_ers_result_t zpci_event_do_reset(struct pci_dev *pdev,
>>    * and the platform determines which functions are affected for
>>    * multi-function devices.
>>    */
>> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
>> +							  struct zpci_ccdf_err *ccdf)
>>   {
>>   	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>> @@ -194,13 +210,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
>> @@ -216,12 +225,24 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>   		goto out_unlock;
>>   	}
>>   
>> +	zpci_store_pci_error(pdev, ccdf);
>> +
>>   	ers_res = zpci_event_notify_error_detected(pdev, driver);
>>   	if (ers_result_indicates_abort(ers_res)) {
>>   		status_str = "failed (abort on detection)";
>>   		goto out_unlock;
>>   	}
>>   
>> +	scoped_guard(mutex, &zdev->pending_errs_lock) {
>> +		if (zdev->pending_errs.mediated_recovery) {
>> +			pr_info("%s: Leaving recovery of pass-through device to user-space\n",
>> +				pci_name(pdev));
>> +			ers_res = PCI_ERS_RESULT_RECOVERED;
>> +			status_str = "in progress";
>> +			goto out_unlock;
>> +		}
>> +	}
>> +
> Sashiko notes that mixing goto unlock and lock guards within one
> function is discouraged. Here it's not that hard to read since it is
> just a scoped guard but I think we should still not mix it.
>
> However if we also convert the device_lock() to a guard lock here the
> goto would still make sense to go to the zpci_report_status() and that
> is still a bit odd with guarded locks. So I think an alternative simple
> fix, that makes this overall cleaner too, is to put the whole
> scoped_guard() block above into a helper function then you can do the
> goto out_unlock on that helper returning PCI_ERS_RESULT_RECVOERED in
> line with e.g. zpci_event_notify_error_detected(). That way you don't
> need to touch existing locks and you get to keep the guard locking.

How about changing it to mutex_lock/mutex_unlock? I think the block is 
small enough that it shouldn't be too confusing. Moving to a function 
opens up the possibility of using a stale value for mediated_recovery.


>>   	if (ers_res != PCI_ERS_RESULT_NEED_RESET) {
>>   		ers_res = zpci_event_do_error_state_clear(pdev, driver);
>>   		if (ers_result_indicates_abort(ers_res)) {
>> @@ -266,25 +287,19 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
>> -out:
>> +
>>   	pci_dev_unlock(pdev);
>>   }
>>   
>> @@ -330,12 +345,12 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
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
> Sashiko notes that mediated recovery stays true iif kvm_register()
> fails later in this function. I think Sashiko is right there.

Yes, indeed. This needs to be fixed.

Thanks

Farhan

>
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
