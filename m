Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E354A2E2A;
	Wed,  6 May 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088030; cv=none; b=hdyRZSgZX0fCwFFwvJao7PNVfdJMW2DgUaubb5KGwxug8oEm/bGc9BdBbGYJgY18PHRtAjODQhPzaEjL9iJm86Q8aPa3Y1pe4ipOJAeiEvdRmzKWIUjOD3rAoomQsTizj+gS83f4GUY8jUpzdaUeuX+3R1gWWZI3bgeQtCw0iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088030; c=relaxed/simple;
	bh=Hp1lJOp0YxPQbrHz7lo5IQffDi+ZfzjM5/iRsxESbGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8ZPCdE3gVtnFIoAXGXKnzG89xFYmng7EjFxPJI4eThcq7hWDiDnY5ztRBrQvwUWzzWdqXEn/9iearlxavqymbFxqKvSQJ3V6PoNft6xnx2Jmh7F1ngb8fJzlxE0WJulRHFQjG5xHblgnwX4BFyFpSCTZGWdml3vIrGRe+WOzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kUt27X/g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kUt27X/g"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646B4pSg2210426;
	Wed, 6 May 2026 17:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zT0wyT
	zBoEzpe0y1s5RZU3k1Zjz0zZtpKJE35IPOxaY=; b=kUt27X/gvbWguPc56IGpnH
	wwzizIMX2MswwztZ1XjgNohDbNQzew4Ot7BVsP3L76/Th26AJ/uxw5QSQigIj+Yb
	ZLh7Jjnz+dTGWQzxBd96bnIEt17fgtyRk2R3Tv2ucJ+HMXQJ9OO03w2fO88dL3zB
	J0TCyQtdGrFQJUenMr3yppkiyeikTOyvVqPWzUZ/blQ8dvdwpbiHp5o6+DhxP4wq
	99LIBIgeimPK1ikPNI83mb1hLV03Vt9ycQ+cr43PjyHKkqFZs+D63x5huo+pZrO1
	x4UPLli71w6i0SO1aXe7RDYUGtSl8ZgJ21g+KxcWDYbnCRxHYRMXOYcbI2XXcq0A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1hxbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 17:20:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646H9WwT009781;
	Wed, 6 May 2026 17:20:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqfefa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 17:20:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646HKE6s45416762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 17:20:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9162158052;
	Wed,  6 May 2026 17:20:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE9DE58065;
	Wed,  6 May 2026 17:20:13 +0000 (GMT)
Received: from [9.61.252.150] (unknown [9.61.252.150])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 17:20:13 +0000 (GMT)
Message-ID: <c4bb6240-e29c-4ed0-917d-47a0d21d4c11@linux.ibm.com>
Date: Wed, 6 May 2026 10:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
References: <20260505200510.2954-1-alifm@linux.ibm.com>
 <20260505200510.2954-5-alifm@linux.ibm.com>
 <24bd0f694b2bddf07450e09fcea0488ee42ccdf7.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <24bd0f694b2bddf07450e09fcea0488ee42ccdf7.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aMcoaRb_9bmdJlp8LYa5_tr2NndO0JlD
X-Proofpoint-GUID: aMcoaRb_9bmdJlp8LYa5_tr2NndO0JlD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2NyBTYWx0ZWRfX7v4BLRSV54wv
 GdMjYyXjnMxIMiIS0P5IGZJQEEPomF1fzfAAHWxL7J7gz/2+iyv8iKzuW0mYHWtVbqvi8SXA6Qc
 2+HHOGhDYj4+fXP+93AkJNvs6MlpWEFcZEBwaRvCnWxhfKoUJFkB05wBCh40RN5ZxrE79Y7FN7u
 l6I6QiarXpdj83cahOuheEbFMGIcLHC8IqNxtEUyz1aLvZCCSnSaf04z/I8VCKccNpvzetfwPGl
 qdjbnCqGbhFkgCpNTl+e/KVOhIKlwa5ZkhvpHCIZ+dKiYjkHIUqDYDmh+8sC3hZLfr55TUR3J57
 26TWGXTNNZfWhx3cMaIQXKQHNkUqwiTp+gTVXidKO6bFPnnasrc0Ik9UnpXf6r69aM9veH/5Oe2
 0KAVFN+EFcW5XjUI1K6LqpVnNCuZIQVHo32ryb2DzZXvFsuRbAnOTQCYJLKsT3IfHqiO+t1GP0r
 9V7vNW4cmVab/GQAs6g==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb7851 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=tMQGJFuMjxEuE5_F9zkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060167


On 5/6/2026 2:38 AM, Niklas Schnelle wrote:
>> -static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>> +static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
>> +							  struct zpci_ccdf_err *ccdf)
>>   {
>>   	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
>>   	struct zpci_dev *zdev = to_zpci(pdev);
>> @@ -194,13 +206,6 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
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
>> @@ -216,12 +221,25 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>>   		goto out_unlock;
>>   	}
>>   
>> +	zpci_store_pci_error(pdev, ccdf);
> Sashiko notes that zdev->pendings_errs.mediated_recovery could become
> true between the above zpci_store_pci_error() and the below check for
> leaving recovery to user-space. I think we could make a general
> improvement that also tackles this concern. The ideas is that we could
> have zpci_store_pci_error() return true if it did store the error and
> we are in mediated recovery mode. Then we use that as the signal to
> skip host recovery below. That way we also don't need to retake the
> pending_errs_lock which makes the below much simpler and it would be a
> win independent of the race. As for the race this would make sure that
> we either do the host recovery or store the error and let user-space
> recover.

I did think of the concern about mediated_recovery becoming true after 
zpci_store_pci_error(), but IIUC in that case we won't even be able to 
deliver the error signal to userspace (via error_detected()). And I 
don't think mediated_recovery flag can be set to true. Since we are 
holding the pci device lock, vfio_pci_core_enable() will fail as it will 
fail trying to reset the device.

Thanks

Farhan

>>   	ers_res = zpci_event_notify_error_detected(pdev, driver);
>>   	if (ers_result_indicates_abort(ers_res)) {
>>   		status_str = "failed (abort on detection)";
>>   		goto out_unlock;
>>   	}
>>   
>> +	mutex_lock(&zdev->pending_errs_lock);
>> +	if (zdev->pending_errs.mediated_recovery) {
>> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
>> +			pci_name(pdev));
>> +		ers_res = PCI_ERS_RESULT_RECOVERED;
>> +		status_str = "in progress";
>> +		mutex_unlock(&zdev->pending_errs_lock);
>> +		goto out_unlock;
>> +	}
>> +	mutex_unlock(&zdev->pending_errs_lock);
