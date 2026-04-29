Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85941388380;
	Wed, 29 Apr 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481954; cv=none; b=QlD+XGe1aFX4HTAnf2NUqKTqzUnhSVHZmazSe1xYYdj3g20ty878dYA+QEFhDM41f0obJyxiSv8Z/fvqTFViwuK+w7DtavJPRP+445W37qazknt9OGZ2sq3YCqS8UChnxvg0cHAi7vIXWPQosivECpPOWcsa8NAALHoXRpTrXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481954; c=relaxed/simple;
	bh=YDn43t12upix4jq++xFliDQ1ZnScJiGxwg7wfw3WdLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OynLBsHJYOwi4U1opp150P6LIlzLhJpPirjkanbItRlQWAl36JEgbY8tdyeD6m3R4UU+7Aay7ZntOAZIHW4WsCdBNXp0HCqx5rAx/kcDBxFLB4N0Pw4HNwE+Fm7HME6NbTACOeDZS1IIygxVozrwqtMku83UsrNtJKt2yQcjoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qoDDf4tl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qoDDf4tl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCrpq81178033;
	Wed, 29 Apr 2026 16:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aAZJNQ
	HSn1SQy2X/GyYwXEHnNIb325lGn8mSP0P343Y=; b=qoDDf4tlgxTMsuWtAyU0Zd
	pZ7EnRmjXjBqvxCRr8J4F1Stfzz3Wx6CfbcvOhGtEddzKKuW6idf3LadVd/pjMPA
	IkFlkJSTUpvxXr/zGmdEYeK+6Kbt8iNY/h5qDOUEoFbW/GPwSHdA5qPtw+u6vz+T
	OGC+hq2vRSk58BNxaBQb8O6Mt2r259kyPiO51ZtLXNWrEmuYS+qX1yv/mj3jPHGj
	zjNKZPFv3s222hVO1PR2OY/yxiOmZj87CQQQaiJQGonJqmAJpgInp02yZ+4UK3OD
	pvD0OFJQsUfvTOQmAMEAyko8cQKPCmDGiOpWnNpQb/WbxVrZUZ3216QJScKCMQ3g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e26k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:59:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TGrmbr011617;
	Wed, 29 Apr 2026 16:59:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqfb44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:59:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63TGx5JW22217224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 16:59:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114A85804E;
	Wed, 29 Apr 2026 16:59:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D5458054;
	Wed, 29 Apr 2026 16:59:03 +0000 (GMT)
Received: from [9.61.245.137] (unknown [9.61.245.137])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 16:59:03 +0000 (GMT)
Message-ID: <19f8ffeb-9200-4f94-88bf-34b5cfa8b7d0@linux.ibm.com>
Date: Wed, 29 Apr 2026 09:59:03 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 5/7] vfio-pci/zdev: Add a device feature for error
 information
To: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        mjrosato@linux.ibm.com
References: <20260421163031.704-1-alifm@linux.ibm.com>
 <20260421163031.704-6-alifm@linux.ibm.com>
 <56bcc0f67c15ad01f6fff161164698f1689af0f1.camel@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <56bcc0f67c15ad01f6fff161164698f1689af0f1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9jDAYP2MpfvjM8Sn-NPp85dyTHZgKoA-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2OSBTYWx0ZWRfXxuPYF5EbUqY0
 2Q1AvEpMvGA5/DBIO4yo/wFycxl97THBdxzySVYkHgyANtLl+VtQu5AuXjo2BSkSxZHtrLW2v63
 NR2BBW9luY7zDcbqeb6g4vB4mTKvcQ2bpi9xjBbW3PYegm/eHG8fvYLazWgcgWOremMO0MgAmVr
 MIz2V9FXwBJnX+qg+skMGcabzT1+RoY11mss1wnVhT1mUdeZkd1afvKuSrMqa1iM+/wmX+7jM35
 KELC+aQy1tUD7jJ3b6cVOkBTUCPDqPM+hyv7o/6y0mUn1oYsrIjNOlzU30ZBE3ggLI5SL2dIDPT
 0zv6YfjEnTXfr/SVUbssYtBDuSwOfrIrX8eI93rejIo59ExnUxW8xIDjH+dUQpa70m95MSNnUnU
 hnktzQghj5aZOi52XkL1C56zmKyGck2JQWz0/+xZpbqXV4niW/mi+vKCM+qVUw37ZLK111CYlAS
 QzQFR121YQet6ymekEA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f238db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=uyGigAoYKZ-2hNDd9h8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9jDAYP2MpfvjM8Sn-NPp85dyTHZgKoA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290169


On 4/29/2026 2:40 AM, Niklas Schnelle wrote:
>> +struct vfio_device_feature_zpci_err {
>> +	__u32 flags;			/* Indicate feature in non CCDF reserved space */
> The "non CCDF" feels a bit subtle for marking this as a vfio-pci
> feature specific field. Maybe call it "vfio_feat_flags"?

I was a little hesitant about naming it with vfio as it's not exactly 
tied to anything in vfio framework. But if you feel strongly will change it.


>> +	__u32 reserved1;
>> +	__u32 fh;			/* function handle */
>> +	__u32 fid;			/* function id */
>> +	__u32 ett		:  4;	/* expected table type */
>> +	__u32 mvn		: 12;	/* MSI vector number */
>> +	__u32 dmaas		:  8;	/* DMA address space */
>> +	__u32 reserved2		:  6;
>> +	__u32 q			:  1;	/* event qualifier */
>> +	__u32 rw		:  1;	/* read/write */
>> +	__u64 faddr;			/* failing address */
>> +	__u32 reserved3;
>> +	__u16 reserved4;
>> +	__u16 pec;			/* PCI event code */
>> +	__u8 reserved5[28];		/* Non CCDF reserved space */
> While also vfio-pci specific for now, the reserved5 would potentially
> become CCDF if that ever grows. Maybe the comment could say "Allow for
> future expansion"?
>
>
Sure, will update the comment.

Thanks

Farhan

