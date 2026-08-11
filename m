Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4D386426;
	Tue, 11 Aug 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473847; cv=none; b=VyzVwxPIKWwg444cJyTOVwR9SY+oyXlYY/KnSIPIyNp17+K8pnRp+vorQ2xh+2/JsxmSX5GNR3w+8J9T67SVbzIkvgDksZBdiXrcV2PhAP8RUP6MCBf+l8samDJqvgfAqF62CThV08V4mOWOShqpX3eeNqS1OzqUx73egr2PfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473847; c=relaxed/simple;
	bh=xlG82s+h5sv8Q6fffeyd70M3/aMVHeaKQn0QXEpnzRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9Gvhy/wdzPX8fa/QOMczRxVVmTkz87lRxDBmERQTBlzLlWPPVKOu/zxEvzTfTcMyN+k7FvyyOIMxfDSicWrBhZfOjoqg7XkK0bhzXZf+S3B/2sYw23U61wL7OoCJvyoKSY22EzxEmU2qVusI+M/dX+n+jksQnT403v6mVnyaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g71Gonn/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g71Gonn/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVZCN3260704;
	Tue, 11 Aug 2026 18:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5MO44F
	4Zv0eyMYW2iYWod+3Xppi+HLTR/i6mChX/HCc=; b=g71Gonn/Iz7449tUBFWXmS
	EAFNvNlO+NX1GDPG+4H3SETLnRU5QrdfaJjzzF9xmDtR/94hh1O3EFPQNASFZvkH
	xHiD2/9ncGJaXUdlSJgEijT8tBTapT2Qh5Ikn42lYXgLeav2hQu1cavYL8z8Xs/2
	A91DoAlKMLt+QiuXH80FxIARj1uJ8/TkhkVypsjQuwckrD+RRo6xnio++p+w/nAY
	r4aqQVwn3cchbXNeG7L+S9VoQq1tEynhHSf2S3Yuhcjovg7gSSSvAlDaClN9z+5b
	WBF0QF7mEjFQbawRgL3g7TK1EDRcXDj2ftkhs2AFZFhzLzgKcsZfhQMttwqfRFVw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyxgpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:42:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfIDY011798;
	Tue, 11 Aug 2026 18:42:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ga54d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:42:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIgtWL29426278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:42:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24525805D;
	Tue, 11 Aug 2026 18:42:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9F2558052;
	Tue, 11 Aug 2026 18:42:54 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:42:54 +0000 (GMT)
Message-ID: <00b0ea7d-bdeb-42d3-aad1-a8a827f2deb1@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:42:54 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] s390/vfio-ap: Fix use of wrong lock in mdev probe
 function
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-4-akrowiak@linux.ibm.com>
 <4ca672ce-da47-497c-aed1-9500b7e89798@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <4ca672ce-da47-497c-aed1-9500b7e89798@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9VU4Eokx9buj
 aKLNy1s7YP3w54ruBV73u3ndZlr5A7ItZotsQE1gxFxE9VziosSY3gAURXPyYdZl1wRzMtgnwqq
 W3b5bCw5pL5qFQk/L25g7hfV53u4pRjdJh7QJfE+bsskjMnz3LigGaTcb1MdpLSpS9caY8sDqKT
 c9UeHs57XwZls49WvLjKGQfIVt8uxvqjvgr9t94sS+Ft4zk8tVOi59bVI2lFl1swlTtEui1MviX
 2wfb+4MSi3R+jhAiCB7MiN/84o+nVW6eoFlALzT37ojjTHZyJ4andRhZ9/EAGHC1N1e2YcRTSv1
 g0jmQXsCu1NJSXJRtN1LTeEGZH9fUdM4zAi+NWUmZidOJXq+Nr0o4jcJD7Bmr0iIoEJLOwXRIwI
 mAdfWnsDzyQEbb0SFoksX+P6nP6AodlV55mTJ0V26VLW4bxfdxZifNHArvkL+LTjtNuWhpD5DP/
 BffFBV+onasV7UyyB8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX4umAFPZHvgsx
 Ww4ho4jM/wqRiWq5TCKGQUp39hxiBE0bJCcoiADYvxbjJ49hRHHXwCe/1Xd8dCMzBGovO/9BKYn
 5vhJRTzddPjXnmGAa9fIxOr5R8Z7Is0=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b6d32 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jtReu2WqipzCHsYDBJAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MwzcveZLEw94U2_lvS6XG9FBCsjg6xpf
X-Proofpoint-ORIG-GUID: MwzcveZLEw94U2_lvS6XG9FBCsjg6xpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155



On 8/11/26 11:58 AM, Matthew Rosato wrote:
> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>> The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
>> mutex to guard the add of a newly created ap_matrix_mdev object to the
>> matrix_dev->mdev_list. This mutex does not protect against traversal
>> of the list; its purpose is to guard against concurrent access to fields
>> contained in an ap_matrix_mdev object. This could lead to kernel memory
>> corruption or use-after-free if another mdev is created concurrently.
>>
>> The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
>> is now guarded by the matrix_dev->guests_lock which is the correct
>> way to protect against concurrent mdev_list access.
>>
>> See the vfio-ap-locking.rst in the linux kernel tree.
>>
>> Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index e382e5a1cb99..a472de00bc14 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -803,9 +803,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>>   	matrix_mdev->req_trigger = NULL;
>>   	matrix_mdev->cfg_chg_trigger = NULL;
>>   	dev_set_drvdata(&mdev->dev, matrix_mdev);
>> -	mutex_lock(&matrix_dev->mdevs_lock);
>> +	mutex_lock(&matrix_dev->guests_lock);
> Sashiko reports that this patch introduces a regression, which seems valid.
>
> AFAICT you resolve this regression with patch 7 of this series.
>
> For the sake of bisect, can you look at whether squashing these 2
> patches together would work so that we don't have an interim regression?

The reason for the two different patches is because the shah on the 
Fixes: tag
differ.

>
>

