Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386D19F42D;
	Thu, 12 Sep 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144591; cv=none; b=kUV58ZfAd/iO1qyuNI11u064/18ekRrqf9JkWy45/puScTa7wWt/2s/jYooFl93qk+CPPFSUn6Lj0MyJOzETiaFf9L9a3n4svszk34H194HZ/UskaYzf1bWPurdEZ0KwDHJcSHpfs4EEkf6XoIlgcmqGoKNSNSMgVElEvnTcWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144591; c=relaxed/simple;
	bh=jR+JjIZdNItSVFmpDyogwHkZaZV8vO33LzD6VOvkQHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SI3ZfRLE/tnqyCK/R4iY+jjKYJTYxNPxmtXcolYuMouwedmMGx7tanyOc+zPWFTmZqapxZfYDlJRcfeyMgBKF5d9Db9ElFhajm0Bm5J6YgzaF1G5sII0m91uQwCYT3TtaIQmU3xC8ymftjkDxMVeqdHtQF72qoRTBu+b681+R6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j257m5ZM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j257m5ZM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C5NfpL026280;
	Thu, 12 Sep 2024 12:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=j
	TKkv+Ld/7v5dJ8QISPrscKOH9Dmlr/dppBEwgL+SuM=; b=j257m5ZM+3xQUf2gr
	D04LyfA0GFbqcc9d9mTBapkBGSNxIfEqLwlP3dIettExGMx0qP0PGyIpytcNb49z
	wiIlk7tRrs+kuOHsxC48wWBqGvhKo+5T7mw0Y66mqZtgXJ+vmN1J/c9piTolo3lb
	ZDBFf31pA3VSaFt2c6KqvAXzTNgoIF0Ap4oWJ53nQMuN5rcanM+Q6c9N4rSrQMsh
	xHkgmjH4jf7WndW6i6xATd7Rgox3TBlgAB2OJTYQhdFJRtkiniL32xGsIqBVwQbw
	RP96IwGkJa3Sqi+6FxV3iHMaG5DpEYIbvFOHm41JheTZ6IwheFdcSPRTOkm2uCmx
	5/OCQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qku1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 12:36:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C9c6w3032103;
	Thu, 12 Sep 2024 12:36:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmyv6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 12:36:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48CCaNHn46006776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 12:36:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 090A120040;
	Thu, 12 Sep 2024 12:36:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2082004B;
	Thu, 12 Sep 2024 12:36:22 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.222.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Sep 2024 12:36:22 +0000 (GMT)
Message-ID: <cffbae68-0439-470f-979b-efe83f54697c@linux.ibm.com>
Date: Thu, 12 Sep 2024 14:36:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/vfio-ap: Driver feature advertisement
To: "Jason J. Herne" <jjherne@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
References: <20240910113440.8107-1-jjherne@linux.ibm.com>
 <20240911065707.6563-A-hca@linux.ibm.com>
 <218686c3-56bd-479f-b805-dd0c77a89cf7@linux.ibm.com>
Content-Language: en-US
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
In-Reply-To: <218686c3-56bd-479f-b805-dd0c77a89cf7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u1VgOumgDE5cZ6RdkTGJppQVNfo8zdle
X-Proofpoint-ORIG-GUID: u1VgOumgDE5cZ6RdkTGJppQVNfo8zdle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_02,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 mlxlogscore=962 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120090

On 9/12/24 2:24 PM, Jason J. Herne wrote:
> On 9/11/24 2:57 AM, Heiko Carstens wrote:
>> On Tue, Sep 10, 2024 at 07:34:40AM -0400, Jason J. Herne wrote:
>>> Advertise features of the driver for the benefit of automated tooling
>>> like Libvirt and mdevctl.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
>>> ---
>>>   Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
>>>   drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
>>>   2 files changed, 47 insertions(+)
>>
>> ...
>>
>>> +Driver Features
>>> +===============
>>> +The vfio_ap driver exposes a sysfs file containing supported features.
>>> +This exists so third party tools (like Libvirt and mdevctl) can 
>>> query the
>>> +availability of specific features.
>>> +
>>> +The features list can be found here: 
>>> /sys/bus/matrix/devices/matrix/features
>>> +
>>> +Entries are \n delimited. Each entry contains a key value pair. The 
>>> key is made
>>> +up of a combination of alphanumeric and underscore characters. The 
>>> separator
>>> +consists of a space, a colon and then another space. The value 
>>> consists of
>>> +alphanumeric, space, and underscore characters.
>>> +
>>> +Example:
>>> +cat /sys/bus/matrix/devices/matrix/features
>>> +flags : guest_matrix dyn ap_config
>>> +
>>> +Presently only a single field named flags is defined. It is meant to 
>>> advertise a
>>> +list of features the driver provides. The flags fields advertises 
>>> the following
>>> +features:
>>
>> I stumbled across this only now: sysfs files are not supposed to have
>> several key value pairs. Actually the file(name) itself is supposed to
>> be the key and its contents are the value. So I would expect:
>>
>> cat /sys/bus/matrix/devices/matrix/flags
>> guest_matrix dyn ap_config
>>
>> Which is also easier to parse. Is there a good reason why this does
>> not follow the general approach for sysfs files?
> 
> 
> We talked about a few designs for this feature. This patch represents 
> where we landed. I'm happy to make the change to the way you suggest but 
> I'll give some time for Boris or Tony to speak up if they disagree.

Heiko's expectation is fine by me.

-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

