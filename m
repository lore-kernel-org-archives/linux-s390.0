Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750E1DED49;
	Wed,  6 Nov 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895537; cv=none; b=BzPndzxtQdr2G1pI02B1n9v0l8OHzJmt/Upi/JcudkSdXuEGqo/bUSJK55FHLBH2m8G7JJ+DFO/g23nHE0zneTIhhgkbM/7fEHqIFTe0ZH4Fd4dN15CKv6QJ/9k+JfQMCmJKqOE6GIxLOKQiJBD/mzClbpV8c83zjEJdvsdZJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895537; c=relaxed/simple;
	bh=3CVeQLY73Hqsc1GqMKPPC/Jjjw1e0xTEovtO+WzIxIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJMfvdxKGh1unsOG27GgZJOYMAIn8A5HRf1TrBwYcuDiIgGFwX2VHsK6VFVsgZbRZhz33SxjsWt3nRiKPENxLFSTE4K3r3muvK2EIt4DnnCF1rzk6WpWHfelZ9s57XueAd2tVDUJtJ/l+bUe+nI/lSsAMjh+NZ0xOXu/wAuSe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RppNg5Yr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RppNg5Yr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6AAO57000941;
	Wed, 6 Nov 2024 12:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JLYFSO
	Qgx67CtVFvTm+73ZaW44P08m56s6HHeuQHQyY=; b=RppNg5Yr4ThbRvrBQWlNuo
	cq3rlGZiko0PhQ1qbHDxlBnZDNqDEoj+96OQqA4pCWlM0JvdnlkHTJS1stWEAiaz
	Vsm2SF0NQdCPZjdMyr5jdv1rik69VFtflQAdKkYE5BroiX4Qp4DxEBtF93GPOUE6
	rDEnFLHJRb+OkGpK3dhfSMsmDTnQr958uXW3moopWDGHEh9gT5k9Bbq6xilt9r4B
	ooKHqgKoJTRdPfQtyEFSeraYB6F0fwAi9WkZKNJJSlKWKUpdvVGbTCV1yfJEiqFz
	0//HlENe2XhPKswT1/IshYScV0ZxW/A/S7bfbEfRzVQsc5wwNAo49vhOk/ZUp2vg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r6fb0nh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 12:18:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A65OI45012253;
	Wed, 6 Nov 2024 12:18:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140x1fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 12:18:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6CIogJ46006724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 12:18:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20D465804E;
	Wed,  6 Nov 2024 12:18:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A3F5803F;
	Wed,  6 Nov 2024 12:18:47 +0000 (GMT)
Received: from [9.155.199.163] (unknown [9.155.199.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 12:18:47 +0000 (GMT)
Message-ID: <479b6b3e-72d4-4755-acf4-11011b822682@linux.ibm.com>
Date: Wed, 6 Nov 2024 13:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] s390/uvdevice: Support longer secret lists
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
References: <20241104153609.1361388-1-seiden@linux.ibm.com>
 <20241106081004.16507-A-hca@linux.ibm.com>
 <a74cfc12-f404-47ca-85a8-164da22bdbfc@linux.ibm.com>
 <20241106091345.16507-B-hca@linux.ibm.com>
Content-Language: en-US, en-HK
From: Steffen Eiden <seiden@linux.ibm.com>
In-Reply-To: <20241106091345.16507-B-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w8PSHmkbUXE0IvuomI-4rejHQxHworza
X-Proofpoint-ORIG-GUID: w8PSHmkbUXE0IvuomI-4rejHQxHworza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=695 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060099



On 11/6/24 10:13 AM, Heiko Carstens wrote:
> On Wed, Nov 06, 2024 at 09:54:33AM +0100, Janosch Frank wrote:
>> On 11/6/24 9:10 AM, Heiko Carstens wrote:
>>> On Mon, Nov 04, 2024 at 04:36:09PM +0100, Steffen Eiden wrote:
>>>> +		copy_len = sizeof(list->secrets[0]) * list->num_secr_stored;
>>>> +		WARN_ON(copy_len > sizeof(list->secrets));
>>>
>>> Is this really possible? Without checking the documentation I guess
>>> this is not possible and therefore the WARN_ON() should be removed.
>>>
>>
>> This happening requires a FW error, no?
>> list->num_secr_stored is reported by FW and would need to be >85.
>>
>> We could clamp it down to 85 secrets / 4k - sizeof(header) with a
>> WARN_ON_ONCE() to catch FW problems if that suits you more.
> 
> If this would be an *error* why even add this check? We have tons of
> code without doing sanity checks for firmware provided values - where
> should we start or end?
Yes, this would be an error.

> 
> So imho: either remove this check if this would be firmware error,
> unless there is a good reason do keep this check, or if this is not an
> error convert to WARN_ON_ONCE() and limit the copy_to_user().
OK. I'll remove the check. Sending a fix-up reply.
