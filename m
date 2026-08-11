Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157F36B07E;
	Tue, 11 Aug 2026 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472467; cv=none; b=f7XZx993FK4IVUlDMG7a0Iv6BcLhq0ulcjyIFCbqpELn6YgRwGhVy7jAQOhZWz8HCp5DqX8brjK26/Eoz4LwiTGOk5iDT98NNEpFlsbtwTMq7ofi5WeMl3h+j2kmFArhT6zCn31o+qYCEDxIw+B34v5aZY6ecytChcjp7yFnwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472467; c=relaxed/simple;
	bh=xnfRfHSr64vd14rZbtHnCxj6Ysn3YXPPV+LEai+DJNI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bwItf9HTrjOb4AeQI3MiXKCsZN3vO5eNVna28qGfYNyocdkYhImcWLlET5T2aeLBmZiaJxVgoBh6pNLEl9dRMSCvHakBT1zLHxLtFB4tpaT2cYAOY6ShBP9wghuEW3CKB5txv1JZg4jzRf8WlLqkyu/1R4y2g+2v+Q5gDGKZ96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WjKuqR/c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WjKuqR/c"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVekt846678;
	Tue, 11 Aug 2026 18:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xnfRfH
	Sr64vd14rZbtHnCxj6Ysn3YXPPV+LEai+DJNI=; b=WjKuqR/czqD588R+aQSf6F
	eAnGP97U7X8+CppQ3HSfWcIxvcW6r8ouaoHvgtfF9shDzNUyBDMpA6ji3kYgTcKC
	u/Q65ib4+uZC25o/4UwZXQusC7gUKXvVx5m0Ih8C7pTdvF9CMd/+NP2tJRF0vaQV
	f4LKwiWhsOqlacsHYIaGMebFaU0ZX+YRUUm/oapu48E7rv5UG8qAMQcVgAYsEWvm
	cb/e3fpghZiNKod6AKFwLAQsqYyO5M+CU7Oinwqu74DDHq7hztVK0R+whKoSPN6G
	12eM7o+QjFyLvZt9ncvCDvaeaKx12P3g84pOkyEeOhKJjJCgmA+DoJcVPTWQbH8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2wrqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:20:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIBGrA006264;
	Tue, 11 Aug 2026 18:20:55 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0ga24f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:20:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIKFbR29360640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:20:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE00358056;
	Tue, 11 Aug 2026 18:20:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1ECD5805A;
	Tue, 11 Aug 2026 18:20:52 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:20:52 +0000 (GMT)
Message-ID: <c3b21393-d01f-4816-90b6-4c868d4a0f9d@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:20:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during
 display of sysfs status attribute
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-8-akrowiak@linux.ibm.com>
 <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b6808 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8gt7DvUvnbPXcpqzDXYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QXkwCKTxdmHT9EodZW_CLTOpkyMSeqES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfXzkphd+Oi70b8
 iHk+3rbzpGMcmzIUqXHzHRnX3m0Lx6wKlOyHY80b6Ymy3eRl6qgazeE/WtZWFahGeqq7PKDz/34
 r+RuC68cfQWgC/RSYt3WSbeS1qFl3eW3aP1/iHrDs0DYb9Xq4UUZ/n4Qcj8q++zrOQe5g7D4Uwe
 2SP6L3ihhPaQ+tkEzZqmq+yA5V9EoZTAyWz4zUpJ3DDm5QmI1cxrzAL2PI2GDrCQiylAe/dAhJe
 bGqqJxfRbyWLBxYxc4tsL3HshBqAwopOFxy9FVca2xVStTt0F4RkCKifnuXckZIotxd+WPfNqLK
 ibRdfIL5W8FVg8BFeRE/ecSbtwWGJhnAnBm5FYa41RorAb20h/IGaAMZwFFPYsRJ3fzgrk/g2rh
 203LxYB9IyClu3YyWbn7eEr0Da9diQdOON3M5p6LXMwF1agWwr+uK6LwISC3Kvd1e+OR5AVfIsz
 +cZrulK8Yl3hfOvxNEw==
X-Proofpoint-ORIG-GUID: QXkwCKTxdmHT9EodZW_CLTOpkyMSeqES
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX/1xuGVnaCNcZ
 eiqV9Hx2Y0twcYr0VeaY0QB+C3QqNYBklia7pchhjM4SCBIhxvwuyjDdg+wc7uuOdKzdlfcM7A6
 0Z8M3pvacAoWM9NmEgczgLsnwmWnZXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110151

On 8/11/26 2:03 PM, Matthew Rosato wrote:
> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>> The status_show function that supports display of the status attribute of
>> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
>> function which iterates the matrix_dev->mdev_list to find the object
>> representing the queue device whose status is to be displayed. In order to
>> traverse this list, the matrix_dev->guests_lock mutex must be held which is
>> not the case.
>>
>> To fix this, the guests_lock mutex is taken prior to taking the
>> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
>> there rather than the vfio_ap_mdev_for_queue function - where it is
>> needed - because it must be taken prior to the mdevs_lock mutex in order to
>> adhere to the proper locking order and prevent a lockdep splat; also
>> because the mdevs_lock is needed there to access fields within
>> the matrix_mdev object in that function.
>>
>> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue device's sysfs dir")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Please see my comment on patch 3.

Also same idea here, I don't believe the pre-existing finding from
Sashiko against this patch is resolved by this series, so have a look
and consider a follow-on patch if it's a valid report.
