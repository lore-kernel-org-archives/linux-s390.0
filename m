Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693E3E2AD7;
	Fri,  4 Sep 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537976; cv=none; b=ogCbN/n8DxQ4d17voOU4m6oVH66R4898IXkTAIK6vszq4FIvj0TVBIGMouHpWXlRvlqDAdcyhRxSx4wBgTHq1gixWQd9BXk1rMKnMR70XFEK6niCzHXzQjGriVqivqQCYf7yfoazhzXj2nlL69qkqIct5V31Vt3OQdDKXiCHNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537976; c=relaxed/simple;
	bh=HCz7elWQ8NOJMnh+TNorsXYZXxA/fRZ7xEsrgqrUObc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2cb+OgxIpUC7q/W73IAzVch/FSoNJVGbGx5ufnTGNabxt3hUfx8Rs0M/dSypnhJFRg/OVjyrctY6IFT3jivRy5uuS+lN2/J+elZCzdx2RTmP1UYVtAFe1AR9loqfkg3+AdpD1sRgKhQIKy6y7a5ms2FeLRTE6FBDeZzLbs66+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D7S3QLEu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D7S3QLEu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684E1n2R1936213;
	Fri, 4 Sep 2026 16:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pXIkcB
	c9Uz4FE0f466KYSQs0emdUWknXa5D8597/qQw=; b=D7S3QLEujhKBngEimHRUqL
	j/lmmwv+TMVwcxja3i1G4/iKZr+hTNEIcDhGI4vstv64yCis4QNiYNuqyY2eW1K1
	grVHaIpcRadrzzYpi+0dVcTCyyN//zLQs1w6T+vTzFZXERdwDRRldSOgN0ymq9Tw
	Jx/mVslzIMd/thnxfns+WgPSCsDrKOdLqR4zuOefqVHhsGSq9TGiMOIMcyPUdlAm
	O2xTetfF36NGdKGmB49wikusXkZZHft+Yq8Nmst+30dJcS3gs1nQ6RGjC1xIVDrk
	qyEIJw0AFc6oSJF5DWSwhNSj3zFRsvBijz4dcByjN+RrrsTalfB3ju2hf3Mce3dg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq55bx8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 16:06:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684FuF2k020491;
	Fri, 4 Sep 2026 16:06:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceynsem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 16:06:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684G5SUd28377830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 16:05:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7252958056;
	Fri,  4 Sep 2026 16:06:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF12F5805A;
	Fri,  4 Sep 2026 16:06:08 +0000 (GMT)
Received: from [9.61.80.215] (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 16:06:08 +0000 (GMT)
Message-ID: <9d4235ef-c28d-4c7f-ada9-0504f7dcf8b9@linux.ibm.com>
Date: Fri, 4 Sep 2026 12:06:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] s390/vfio-ap: Fix leak of pinned NIB and
 registered GISC in vfio_ap_irq_enable/disable()
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-2-akrowiak@linux.ibm.com>
 <20260904095200.0E7D11F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260904095200.0E7D11F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NSBTYWx0ZWRfX0wmsOZ1RtLze
 TEnPUA7S7tY50ge7meq+2T8eZRrWXhpZ4ZkJ55YEK8jhiB6g7/3jkkWWd+PjSakgkux2ygPv1nL
 x9f36Y07J92lngMvYzmPkGUo/VUGula83NqtB4bzOIdqg4Pp7ykap+LVkZH8SPOxyUB729eg0J4
 ZGt+ANb5Dd3kVWo0NTyLaqcMCLz6wA0+K/Rnk4hsrzoBJDg0tHzppav59ru+0125khfJ3vBSPjR
 PTGm8GSNQ/D6SHAO3Yd+2zuOCC3Sh6Obi/SaQ6Up6T7Gp0vTcMwBQKc7j43dTh6I2UmvNqsrZde
 6IVBtFnw4QbYKt3FiGaCtJnFN2I4tXYadMlil/buHURrkbImicz425xu+Wimdh7ULVVfcqrx2vI
 FsgIbkhdZR6AekM42EWNzEe7dOae7+UDGsE+mzzFNJ++Roo9Cm3dgByihQ20rxLsil8opShwM5j
 METJJ2pIL4H2f64csXg==
X-Proofpoint-ORIG-GUID: JV_2ScxNN1Ud2fdK7rXQ1gTd7ICluGta
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9aec74 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NLlBKCS0E_FMv3qD2gMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JV_2ScxNN1Ud2fdK7rXQ1gTd7ICluGta
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NSBTYWx0ZWRfX4Tr86z3PV2e6
 clvwvMqpzIK58NBUiJMUUszm+MYyY25qW4N7FBi98xktJNBbzm1hW+XFyFe7dfdkPXa/5inbklt
 7q4vE0fUc/RG26y8elxlmTho6xO+xSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040145



On 9/4/26 5:51 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Guest-reachable WARN_ONCE macros violate KVM guidelines and can cause a host denial of service (DoS) under panic_on_warn.
>
> Pre-existing issues:
> - [High] Pinned NIB page and registered GISC are permanently leaked when a queue is removed from the host AP configuration or becomes physically unavailable.
> --
>
> commit ea9124e6c06c371c42de8146e0e3493413dc0829
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: Fix leak of pinned NIB and registered GISC in vfio_ap_irq_enable/disable()
>
> This commit updates the interrupt enable and disable handlers for vfio_ap
> to correctly manage pinned NIB pages and GISC registrations. It introduces
> an asynchronous wait process for interrupt clearing to prevent wild DMA
> writes, leaving resources allocated if the hardware doesn't confirm the
> operation.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668bee..383ec9f5c8107 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -257,12 +269,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>>   		default:
>>   			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>>   				  status.response_code, apqn);
>> -			return;
>> +			return -ENODEV;
>>   		}
>>   	} while (--retry);
>>   
>> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
>> -		  __func__, status.response_code, apqn);
>> +	WARN_ONCE(1, "%s: tapq rc %02x: timed out waiting for interrupts disabled for %02x.%04x\n",
>> +		  __func__, status.response_code,
>> +		  AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
>> +
>> +	return -ETIMEDOUT;
>>   }
> [Severity: High]
> Does this allow an unprivileged guest to trigger a host panic?
>
> According to KVM subsystem guidelines, guest-reachable WARN_ON or WARN_ONCE
> macros are prohibited because they can crash the host kernel on systems
> configured with panic_on_warn.
>
> If a guest forces a delay by issuing a ZAPQ reset (which can take up to
> 2000ms), and immediately follows it with a PQAP-AQIC disable instruction,
> this 100ms TAPQ polling loop (5 retries * 20ms) will time out.
>
> Could this be converted to pr_warn_once() to avoid host denial of service?

This problem has been reported and responded to for all six versions of
this patch as well as others in the series. I discovered while doing some
testing/tracing of manually injected error conditions and discovered that
this is a real possibility; so all of the code locations that are 
reachable from
a guest that log WARN messages need to be fixed by replacing them with
pr_warn_rate_limited() or dev_warn_rate_limited calls.

>
> [ ... ]
>
>> @@ -326,18 +372,47 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>>   		case AP_RESPONSE_Q_NOT_AVAIL:
>>   		case AP_RESPONSE_DECONFIGURED:
>>   		case AP_RESPONSE_CHECKSTOPPED:
>> +			/* AP not operational; no further interrupts possible */
>> +			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>> +				  status.response_code);
>> +			goto end_free;
>>   		case AP_RESPONSE_INVALID_ADDRESS:
>>   		default:
>> -			/* All cases in default means AP not operational */
>> +			/*
>> +			 * The AQIC disable was rejected; IRQ is still enabled
>> +			 * and the hardware still holds the NIB address. Do not
>> +			 * free resources.
>> +			 */
>>   			WARN_ONCE(1, "%s: ap_aqic status %d\n", __func__,
>>   				  status.response_code);
>> -			goto end_free;
>> +			goto end_fail;
>>   		}
>>   	} while (retries--);
> [Severity: High]
> Does this share the same risk of triggering a host panic as the warning above?
>
> Similar to the timeout case, if the AP returns statuses like DECONFIGURED
> or CHECKSTOPPED, this guest-reachable path triggers a WARN_ONCE. Should
> these be converted to pr_warn_once() to prevent a potential host DoS?

See above

>
> [ ... ]
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the vfio_ap driver leak
> the pinned NIB page and registered GISC when a queue is physically removed
> or becomes unavailable?
>
> Looking at vfio_ap_mdev_remove_queue(), if a queue with active interrupts is
> removed from the host AP configuration, the bit test fails and we skip
> calling vfio_ap_mdev_reset_queue(q):
>
> 	/*
> 	 * If the queue is not in the host's AP configuration, then resetting
> 	 * it will fail with response code 01, (APQN not valid); so, let's make
> 	 * sure it is in the host's config.
> 	 */
> 	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
> 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
> 		vfio_ap_mdev_reset_queue(q);
> 		flush_work(&q->reset_work);
> 	}
>
> done:
> 	if (matrix_mdev)
> 		vfio_ap_unlink_queue_fr_mdev(q);
>
> 	dev_set_drvdata(&apdev->device, NULL);
> 	kfree(q);
>
> Because the reset is bypassed, vfio_ap_free_aqic_resources(q) is never
> called, permanently leaking the page and KVM routing entries.
>
> Similarly, in vfio_ap_mdev_reset_queue():
>
> 	default:
> 		WARN(true,
> 		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
> 		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
> 		     status.response_code);
> 	}
>
> If ap_zapq() returns AP_RESPONSE_Q_NOT_AVAIL (0x01) because the queue is
> physically unavailable, the default case is hit. It logs a warning but fails
> to call vfio_ap_free_aqic_resources(q), leaking the resources.
>
> Could this lead to memory exhaustion and depletion of KVM ISCs over time if
> devices are dynamically reconfigured?

This analysis is correct, there is a resource leak in
vfio_ap_mdev_reset_queue() when ap_zapq() returns
AP_RESPONSE_Q_NOT_AVAIL (0x01). That response code falls through
to the default case which only fires a WARN without calling
vfio_ap_free_aqic_resources(q).

Regarding vfio_ap_mdev_remove_queue(): there are two distinct
invocation paths to consider:

Sysfs unbind: the queue is still in the host's AP
configuration, so the test_bit_inv guard passes and
vfio_ap_mdev_reset_queue() is called normally. The ZAPQ will
succeed and resources are freed through the normal reset path.

AP bus scan (queue physically removed): the queue is no
longer in the host's AP configuration, so the test_bit_inv
guard is false and the ZAPQ is intentionally skipped — issuing
it would just return rc=0x01 anyway. Since the hardware is gone
and can no longer DMA-write to the NIB, it is safe to call
vfio_ap_free_aqic_resources(q) directly without a ZAPQ.
This is the fix needed here.

Note that vfio_ap_free_aqic_resources() is safe to call
unconditionally in the AP bus scan path even when q->matrix_mdev
is NULL (i.e., the queue is bound to vfio_ap but not assigned to
any mdev). The WARN_ON guards inside the function will protect
against the unpin and unregister operations. Since interrupts can
only be enabled for a queue assigned to an mdev with an active KVM
guest, saved_iova and saved_isc will not be set in that case,
making the call a safe no-op.

The fix for vfio_ap_mdev_reset_queue() is to add
AP_RESPONSE_Q_NOT_AVAIL alongside the existing
AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED cases
so that resources are freed when the queue is not available.

>

