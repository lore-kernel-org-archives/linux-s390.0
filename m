Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E2383339;
	Tue, 11 Aug 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474274; cv=none; b=cGrfjK0K4jfxepNPRByLQocyoXcqSnvfwHFZi+/VpWRKrbMb2ehtwBnM5HvnsfyPeUqj1TiaWk3ho4NBhUbV/t8nZ/0CbMmABAJ8Tqip8GHueTg/lOjp2d6lJgcASnprwRYTtIEXc10adBiYQBv1YtzXE/mzhBajA8r0PREBphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474274; c=relaxed/simple;
	bh=42101hI5mEHuX6DdULR9yIYZheUVk8C+PK8fZ+n1Q6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERPxyYc1mEPSfUci2YjOIsMIKt58A7GAKjOr5pOLrCGTdyZehxHA7KdHv/lBqUUgZY9uOU/Oyis5qUCuu+S6G1R+i0dG1/RW/ftzgtwfk70fi7mj0xLHA3p7SO9W3GU80oSediG/8yL15ot45kqmS3JwoP359NWv7zb/7uSPjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ebvtvz1r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ebvtvz1r"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVZEp3260705;
	Tue, 11 Aug 2026 18:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=42101h
	I5mEHuX6DdULR9yIYZheUVk8C+PK8fZ+n1Q6Y=; b=ebvtvz1rLXqCKopGIDdhTB
	RlelHoKL+LacfimqJCso/MR/mjCGe/9WDo6ZqqBy022FTtEQYP299gBCdPQJ8O4N
	vDAqhX1AWR6uN9VNYwXiM8cG2wYxxrhji0JJ+LdTQ0O7UPWiiRVrGh4IqQzVpciD
	6p79FhbB+DaVv1+hZAq6ORfYQaF3kt6DqKCdKGLUrE+Gf+a/A1buyHZn7KO1qRyI
	qzMGLv1wQurzdpL9NCFEmI59UPBBBXGQ3/sNA8/twRE9QmJ9SEAXozBBRStp4/1y
	Ivcb3OmVMQDdCu9cCUBMystBqttL2HOguoHKnV4LogTB64vWKHvfnR3LInHW8UoA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyxhuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:51:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfHmp012585;
	Tue, 11 Aug 2026 18:51:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq2fm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:51:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIp3Ex4981638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:51:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25BDD58065;
	Tue, 11 Aug 2026 18:51:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA4458056;
	Tue, 11 Aug 2026 18:51:02 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:51:02 +0000 (GMT)
Message-ID: <48f2d952-3116-4e0c-b0e6-bc6460446c08@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:51:01 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during
 display of sysfs status attribute
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-8-akrowiak@linux.ibm.com>
 <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
 <c3b21393-d01f-4816-90b6-4c868d4a0f9d@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <c3b21393-d01f-4816-90b6-4c868d4a0f9d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX4ulS+1nTHhT8
 P/eHgcT57epM/gEZXlVaR/J+eQM5BfE6zI8asFZiLPfrw4BuVta5ykcwGE0zapxdLZFK5h2KWk3
 4DJxTtvrabegAD58u95OjFrVHeiAiu5xHr/G3oDkEGpHjNGD6SCZqiCk+HKQMcwVd2pawHKzDV1
 8KR873uW+OWZsdKRsk8MHtlTEBoYbB/cIpGIOkw4Dn2qxUDRHbRoWqyRx0W4vCyAi5YQIjds+dB
 2dpsY/N/lGLkRkYwihrIas6/e8CtouFB2e2ZqatlREkREJSZmyhE8Vo+Pr3QEjid2MMeHota9hi
 NZ395sNqel+1YMWrpk4CKcBePWxOabftdUGWRJ+oo188EtHJxKYDvZF1bHcw4rBXBMZn+q0UCPZ
 WTYBJut10ooubJF89/zG1QuYLwWKvsSP9p3F5EWUvnDc46GPsoSIy4pQWBG24BewyyFbnj56l9h
 V5F/M+06Hx9G5yJSX0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX3L4rQO8cwW2I
 5hLwwlMta7CvHMlA9XemsmkWWohav7eOGpVwn1vNtTnrLrHmE4vc8Wqs5Bbuwxk341JwqCihtDt
 Wkfi+FL3gTzWt2SkcTLn2WeZd0JdNKg=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b6f1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FuzQXSa-VKAIRvJYoHoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dunqAlGKRcAUzXFPuxT4MhWTMgMOATb6
X-Proofpoint-ORIG-GUID: dunqAlGKRcAUzXFPuxT4MhWTMgMOATb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155



On 8/11/26 2:20 PM, Matthew Rosato wrote:
> On 8/11/26 2:03 PM, Matthew Rosato wrote:
>> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>>> The status_show function that supports display of the status attribute of
>>> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
>>> function which iterates the matrix_dev->mdev_list to find the object
>>> representing the queue device whose status is to be displayed. In order to
>>> traverse this list, the matrix_dev->guests_lock mutex must be held which is
>>> not the case.
>>>
>>> To fix this, the guests_lock mutex is taken prior to taking the
>>> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
>>> there rather than the vfio_ap_mdev_for_queue function - where it is
>>> needed - because it must be taken prior to the mdevs_lock mutex in order to
>>> adhere to the proper locking order and prevent a lockdep splat; also
>>> because the mdevs_lock is needed there to access fields within
>>> the matrix_mdev object in that function.
>>>
>>> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue device's sysfs dir")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Please see my comment on patch 3.
> Also same idea here, I don't believe the pre-existing finding from
> Sashiko against this patch is resolved by this series, so have a look
> and consider a follow-on patch if it's a valid report.

Can you be more specific as to which Sashiko finding you are talking about?


