Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7F3B9616;
	Thu, 24 Sep 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260036; cv=none; b=Kmk2JWK5mV3mPoVOIRsD7zGw1XPPcvShHvob5tPbYvVLOGC+GXW68UuB2TGG5QjQq+QxxIZpFDJiBTNZRnlmbNb+chqOp0VTTF3E17PPW+wi6H8skzQEcokY8/AZXdcCyeHKQyOAnF+VHGtLeAboAs7JlbnoHMtXokuoDTHTnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260036; c=relaxed/simple;
	bh=wJSs0EKd8pIUePEqBwBH6Y0xYqoPtBs5rizujkGhuxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZynFaZLH8MpI+WOJueluBfYHoVupg2R926HZBYKDsKyhRYN0nis1Fpl5vSd4wvbmv7+bHB/5NtWw39h5UAIVhboh/OqzyjdHf8WqxjdActnMS9yYE8UZXn6SEYvT43IdcCheQwwKutUXFHlfCEBd2lhyDLP703NfQCyrcD+PS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N2wruQXj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N2wruQXj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC77CF2223170;
	Thu, 24 Sep 2026 14:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gVg7cv
	RQpMwO/x6V0qf42gL3T3Mua0Ctfk+ftmuWizg=; b=N2wruQXjjis2CX4YLm/tsD
	w96mNLFPeFbdDutwPesCSr6/1EDFJHXtoTRSfNIEBXMTkDcX1wbizyH4hIhcBafp
	rMPqNaltyZ5EUeZzjJK9TaNjt1FHB9/uRzy8DKB4pySFDuOdiF1BKGnlfFsDe852
	WpODbU0q+l9klL23/IGSdPFpL9kkCVl4FoKZj+Pst03KFcnmmqLWI3bWwjt3hGtG
	cNC5w9bOezziN1YbVMQuNMPTRrt7KL5UMWVuQMQdFrNMYmU+2sEgTW5qgFP7gjJJ
	i+NNB0sx0jYlHlBInlFFokMMMhbE+/F501qtruJjfSWV2iqiAWQyBkGs01uwVBGA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvgwqb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 14:27:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OENh2f2244039;
	Thu, 24 Sep 2026 14:27:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qp882-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 14:27:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OER9QK7471790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 14:27:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335D058063;
	Thu, 24 Sep 2026 14:27:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E71958064;
	Thu, 24 Sep 2026 14:27:08 +0000 (GMT)
Received: from [9.61.251.135] (unknown [9.61.251.135])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 14:27:08 +0000 (GMT)
Message-ID: <f900fc9f-948c-4786-95ac-3096f3455dbf@linux.ibm.com>
Date: Thu, 24 Sep 2026 10:27:07 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-3-oelghoul@linux.ibm.com>
 <502d511c-0cea-4245-a8ee-06e8d05a141b@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <502d511c-0cea-4245-a8ee-06e8d05a141b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7Yb7gJoLH7WqKSKtnTOBZ0trn26vVcG4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1OCBTYWx0ZWRfX90dWFLhPlXbm
 HjPPOPNQbi/hYp6949GRlOTuLciFFCJH02lM4UTIuyqzIxrVTMMXliRy143aJ89Misl8eEqnlSD
 SBhtpCpMo8/ZNyl32yNjEp5trXl0L48=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab5333e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=P9aTqzD4msjllVbOdy8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7Yb7gJoLH7WqKSKtnTOBZ0trn26vVcG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1OCBTYWx0ZWRfX0Q/FeWOQxhNu
 BpP0pxdbVergMYIJepJaro48+B1MEMJh9j8S9onyIg39DUAzBW8FOdq5p5yYw+n3Wi7xE31h4H3
 wKJyNg2vpOsCFTdgsvxImHXxmPDc0eEIBzT5MArPA/Lr1+CUG+5rpxvPKcwPU7DwkkFjFingklk
 tZd3I4ygQU+azTiZtWIbNOkitG1iQan4kvCKT5EZ6uUYWAMmiNXhDnUW8bSNm8LoV9iH/PMJRaS
 XeXBhjV/bSN6elVB3k/zXJG2uf81TszVng8Q7alMdiMuYwXdj1WffbvAng3DIUetEZ/xwXQOCTq
 cZ8IZvnWWXENkKwhml3bAWvpgsKXa92z/7n9P8Sq/D2l3AfVUI+mrKDPnXMiGd8PviGNr1cpINf
 M/Xab75AMkcuxqdY7I/rGf0QhMLQcVcnDQhGdZ9NvriuANpMTTE1jMoH2mvuhOgLA7WZwWkQbPY
 9chf9syEt3JD0orNFow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240058

On 9/23/26 6:20 PM, Matthew Rosato wrote:
> On 9/22/26 3:51 PM, Omar Elghoul wrote:
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
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> 
> [...]
> 
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
> 
> [...]
> 
>> +	if (zdev->fmb_enabled)
>> +		zpci_fmb_reenable_device(zdev);
>>   
> Besides Gerd's comments, I was looking at this patch in isolation and
> this combination made me wonder why you were adding what appears to be
> dead code (of course, patch 4 adds another caller that doesn't check
> zdev->fmb_enabled before calling)
> 
> Maybe you could add a bit to the commit message besides 'Call
>> this function from zpci_reenable_device().' to indicate that this
> function is also being setup for future re-use where we might be going
> disabled->enabled rather than enabled->disabled->enabled.

Sure, how's this for a new commit message? Hopefully this is clearer and
doesn't read as upside down. I also added a blurb about firmware
implicitly disabling FMB when we disable the device.

"Don't free the FMB buffer when disabling measurement in
zpci_fmb_disable_device(). Instead, make the buffer persistent for the
lifetime of the device and reuse it across enable/disable cycles. Defer
freeing the buffer until teardown in zpci_release_device().

To support the persistent buffers, add the fmb_enabled field to struct
zpci_dev to decouple whether FMB is enabled from whether the buffer has
been allocated. Audit the only consumer of zdev->fmb as a liveness check
and update it to reflect this change.

Introduce the function zpci_fmb_reenable_device() to ensure that the FMB
is enabled. If it was already enabled, disable it, zero the counters,
and re-enable it. This allows the function to be used in both first-time
enabling and re-enabling measurement. Call it in zpci_reenable_device()
to preserve the FMB enablement if it had been implicitly disabled by
firmware in zpci_disable_device()."


