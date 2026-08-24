Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9F38B135;
	Mon, 24 Aug 2026 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602099; cv=none; b=Yn147NntIm9q28sdcvWGn/A+t1PNB1IcyAxlyCayPX5MOeIJfCNF/6vPNKEBmQMjWgeqgMpg/GruZxmAM/+IgNcGWBE64lBRVd+ibxuYsm3mQghTpDi4/bCyr4MLgY5TerFR7ngygqpn9O7wYEZ4Equ7kDeN5eMWI1MtIAPPCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602099; c=relaxed/simple;
	bh=6lOZD74hmsxPvxmBbRS/bcK4hbZYLczBN5Hio0TOxWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq7RCfkkkHU9Z9Vs80coHPjJ6S0yhNNV53/UO3W2d1fR6Uuh+XSvE5MO9u4eZqt3tra5RjZw8EIIa1hssvNlHY5YPojII+lbXzRpM+X6uQZEtevQoNrEdKr4215guqsDGXVp0k94ch24ATKd8JDlwcLJFk1eb2gDY8KnRcqzTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VisNziad; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VisNziad"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVh2N1725617;
	Mon, 24 Aug 2026 20:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ja+ht4
	7Ti4t1oI4fLD11MIDWVwD/TA169NDYv1uYkGE=; b=VisNziadq/KaGGXL7XQskp
	PuzK9uly5Adld5aN++vp8/6mWFoi3KD/FT6N0WcrBmcprHh+NwGc06bRTGtMNQa/
	dR7zE3ji7SmIW1nMtXlHdPxKQW5GF1H1m8rNW4nshncdsKCqhZxcUAisABjj4VD5
	DomctnaZTQ9mC60CiigOEd8Bq68h8yEUY35/gp3Ivco3Ck4wDqXWX+WY5LVIrVmt
	2RCgiG2knOH7FDmVg0WWFT+3MZxDKC2vTSR+uTazWmJ9C21p6+RqzxS9gRF0rLiy
	EzrhiKnV70jJX/yu2uKKTjbhXfdstc4b8HvqI4MDZTqdQqH8e7Fbhn9xNkIUws7g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ebw36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 20:08:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJuINW030108;
	Mon, 24 Aug 2026 20:08:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag832b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 20:08:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OK8AKX30278252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 20:08:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9094058051;
	Mon, 24 Aug 2026 20:08:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DEBE5805A;
	Mon, 24 Aug 2026 20:08:09 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 20:08:09 +0000 (GMT)
Message-ID: <5e766b0f-4270-4414-8f3f-2568d1b9a75b@linux.ibm.com>
Date: Mon, 24 Aug 2026 16:08:08 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] s390/vfio-ap: Fix unbounded loop in apq_reset_check()
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-4-akrowiak@linux.ibm.com>
 <07bdd3bb-0f9e-4288-9fd0-52ea9edf4b0d@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <07bdd3bb-0f9e-4288-9fd0-52ea9edf4b0d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8ca4ac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WMBu6IYHjKrs_xjfU4gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2OSBTYWx0ZWRfX3gEp23Qj0wpn
 WdsYlOr5N3MNQUNKmUNQJH3L8uTPdcgZflzn/16ZUw9zpeSSHLqzQCMUVoh288bHX1CVj9/BCDw
 srmDzEhd2uxM4hOoxk57BcUYiKQyxC0=
X-Proofpoint-GUID: X70ejJFT2kRHM3r2wqdZIsUL1ORk1S_m
X-Proofpoint-ORIG-GUID: X70ejJFT2kRHM3r2wqdZIsUL1ORk1S_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2OSBTYWx0ZWRfX/TStpE7iyYdw
 lV5Xw+eBNwdayc0ScD5RFwyF/Gf41ZrWowvZaYkZIiIfTwL3jG7lY6bvi8c9O+MhhWIakfyMVdv
 iEJLY4XUicB2Yntlw9FezFWF8aEDFBywMUNSGlmyJtZOwaXlB7IlUIgGN8nwvn8edj/VU/PnEKV
 EiJb+UrzhmZW1erM0TyFl0HMGs+guFDIQfp5UaSLPGnJIL2YZyX0pzdqPvKfDZkaB9upsx/5Q/0
 phOwSOMFPIGaYS4buHjTtxea22CWI7vKdWgNny0UnDYtE2GuAGfQoZnFbvlCyM2RGBmFzCvoMOW
 53vIpfHFIvBgNXbO5Nmw4ZeBmwJCS2tRhK2jdOANyCKjCA5LpomOtQ+/cgAcigzzzcgDOkge+xx
 uddJwEssjDmG7g7Rp5E8ymtwbTuRwAfyYabmuMXYoA6+F11V2Asot2Y411cKTPRssh8TxafDuJ0
 8LzliHAwU8cixeFY4Pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240169



On 8/24/26 1:04 PM, Matthew Rosato wrote:
> On 8/24/26 9:58 AM, Anthony Krowiak wrote:
>> The apq_reset_check() worker polls ap_tapq() in a while(true) loop
>> waiting for a queue reset to complete. When ap_tapq() returns
>> AP_RESPONSE_BUSY or AP_RESPONSE_RESET_IN_PROGRESS,
>> apq_status_check() returns -EBUSY and the loop continues after
>> sleeping AP_RESET_INTERVAL (20ms). There is no upper bound on how
>> many times the loop iterates, so if the hardware continuously
>> returns a busy response the worker runs indefinitely.
>>
>> This is particularly harmful because several callers of
>> vfio_ap_mdev_reset_queues() and vfio_ap_mdev_reset_qlist() call
>> flush_work() on each queue's reset_work while holding one or more
>> of the global matrix_dev locks (guests_lock, mdevs_lock) or the
>> KVM lock. An indefinitely spinning worker permanently blocks all
>> of those locks, hanging mdev removal, KVM guest teardown, and the
>> VFIO_DEVICE_RESET ioctl path.
>>
>> Fix this by introducing AP_RESET_TIMEOUT (2000ms) and breaking out
> s/AP_RESET_TIMEOUT/AP_RESET_MAX_WAIT/ ?
>
>> of the poll loop when elapsed time reaches that threshold. On
>> timeout the final busy status is written back to q->reset_status
>> so that callers inspecting reset_status.response_code after
>> flush_work() see a non-zero value and can return an appropriate
>> error. vfio_ap_free_aqic_resources() is called before returning
>> to release any KVM ISC registration and pinned NIB page,
>> consistent with all other early-exit paths in the function.
>>
>> Fixes: dd174833e44e ("s390/vfio-ap: remove upper limit on wait for queue reset to complete")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 6e4569d6b975..c7eebbd0ed40 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -31,6 +31,7 @@
>>   #define AP_QUEUE_IN_USE "in use"
>>   
>>   #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
>> +#define AP_RESET_MAX_WAIT		2000	/* Maximum wait for reset (2000ms)	*/
>>   
>>   static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
>>   static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
>> @@ -1973,6 +1974,12 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   					      status.response_code,
>>   					      status.queue_empty,
>>   					      status.irq_enabled);
>> +			if (elapsed >= AP_RESET_MAX_WAIT) {
>> +				/* Timed out waiting for reset to complete */
>> +				memcpy(&q->reset_status, &status, sizeof(status));
>> +				vfio_ap_free_aqic_resources(q);
>> +				return;
> Sashiko points out a concern here and I tend to agree; if this timer
> elapses you are effectively freeing resources that could still be in-use.

Ironically, it was sashiko that precipitated this change given the
issue of hanging forever.

>
> This seems to go back to dd174833e44e 's390/vfio-ap: remove upper limit
> on wait for queue reset to complete' where it was decided to hang
> forever vs leak resources -- e.g. the hang seems intentional?

It may have been intentional, but I don't recall.

>
> If we don't have a way of forcing firmware to give up the resources I
> think we are stuck either waiting indefinitely or quarantining (leaking)
> the resources consciously.  And documenting the rationale in a comment
> block.

The AP architecture defines only a few instructions, none of which
provide a way to give up resources. I think it best to document this
in a comment block rather than waiting indefinitely. The
apq_reset_check() function is called under the matrix_dev->mdevs_lock
mutex which is a global lock that guards access to all active mdevs
in the system. Since the likelihood of this is happening is probably
extremely rare and the amount of storage leaked is not significant,
I think it makes more sense to allow things to proceed in this case.

>
>> +			}
>>   		} else {
>>   			if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>>   			    q->reset_status.response_code == AP_RESPONSE_BUSY ||

