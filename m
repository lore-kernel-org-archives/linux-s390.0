Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5B35837C
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573039; cv=none; b=fBareKaHP5EXCdV0TKIWD5Pxnye+emzJxTHDXrLUtyKY2MUQVCMmryum2as0C1nhggLR2I4t9YC9zDchcQImkIP3uSv3XgtsFX4SPAED5N8rOabPvHWMTUltHaT3+7vPDrCqR9/tYwTxhByHSER3VzC4HAHSV75mVw54UeBRojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573039; c=relaxed/simple;
	bh=MsMYNghNz5JVJJ3ezMFx3yZYN82EzK/xjQAKpE1gEs8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kwmW0JQEiBq/7Ci67gwZ4JeEjpjGQCL7dIsz9g9OeWkvwm7wYUlSGxJFmyHB5QZzhk0XCy46ZcPkyWuG2soFrUiQhqNBTbTA0cmxtvhH3px0zgjaG6m6DNe5nmQAMfwwE+GGZt1ihocznCmPkZA5tI7L2eSIpbFNBxol0Cki2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n/Q+NqgZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n/Q+NqgZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFVb9k4136887;
	Wed, 16 Sep 2026 15:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iNy5pv
	ZKyETQgWPhxLKOdWwV1mUDQAQWBXClwfPvOCM=; b=n/Q+NqgZonwafeb9gEIx1m
	mhXur0HS+jn4T/jz1Rl1MH6DtWyysqKs9EDZmMdmDcAfUfvcJzmW6CFrGng4mRVh
	RsHj72GDKNQmdibQdArtJXqtdgpvV3C3nVyKShAa87RYbHOrhw4PoCCtrt6UJrR7
	zsn1wVyqoRD10WlfZryNzDrFSrlehVnHiIEHkXPLH0ozwX550uKUjqS/ElPL5XQM
	lEE9W/60KJX4aRdtd8Bd4+BEunXCHfwytfw838veSRcOQZHtwN39rdqUk4sxyCB/
	ekWzdBrS7eFqOxHEz5ocNLRS1f4GpP9aorfqBj7ZoTBEJjw8by21iQwkOO9S1tNQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83wenc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:37:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFK5MG1688739;
	Wed, 16 Sep 2026 15:37:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywey1yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:37:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFb6lZ49807620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:37:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88D2C20043;
	Wed, 16 Sep 2026 15:37:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BF4720040;
	Wed, 16 Sep 2026 15:37:06 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.77.88])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:37:06 +0000 (GMT)
Message-ID: <e5c51625-fdab-4dab-866f-8cfb087d7d5f@linux.ibm.com>
Date: Wed, 16 Sep 2026 17:37:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/iomem: register initrd as an iomem resource when
 retain_initrd is set
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: eoin.mcnamara@ibm.com, linux-s390@vger.kernel.org,
        Joseph Cathcart <josephc@linux.ibm.com>
References: <20260818175755.3520-1-josephc@linux.ibm.com>
 <6f66956a-9793-4f96-b973-6e5875e5e433@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <6f66956a-9793-4f96-b973-6e5875e5e433@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIxMSBTYWx0ZWRfX4FdJkzWDvfA2
 /Pv1aqVNpnMA5JIIc7XmJFFDaF4FYHrLL8YASf4+U9dB5Y9O/uJvH6Nk6YjHAWjchgh9fhfbm9d
 JbcygvZ4YTn1nnG3objYvNSA4nAT8UKOJ4ut7QVOfcK7NJlU+DEzcwykXlV1NQSCFGv+/SIKx6a
 CacBUsPovbx7UN2hmPb9kEGhHlzWHOLfE+pdkai/eEfXqJzsC+R5rbJbpYLfhw1gjx5xLwNho4O
 39VNHMn/Xa1d3OMnhEQbg+TnqXrHnK0HYKnCoZIvn7xNr5sveOLj6+iD53ZFmAN1VyAIk/I0r6C
 SFCo48pxnPkjZ8A2FsnFZcmpwOH0O8fbTShYbbr5xepeXtxEr7e5TJEA3B1ZFByzCBOIu51U3GO
 rcWcnrCJyll9cc7Ykd/7adUB4PWmU5kx2TgeIi2C4v8eXX6srCkhJIolHvCo5rLyebVpxzUm5LU
 fXVK/YWpOz0WvbyVIIw==
X-Proofpoint-ORIG-GUID: sqUzDof7kwguD2SNK7smNyIA_tFrkphw
X-Proofpoint-GUID: sqUzDof7kwguD2SNK7smNyIA_tFrkphw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIxMSBTYWx0ZWRfXyijzV3YqPLH8
 q8GytlM0GOeopndpeqE9ibcuuu9z9hJhY8MArkvHYdcihnQifBGB6x/ssBu0ZXblUsPz2D2XnKL
 7jbqwztnJJpIriDXiKVCpLUgll0BYA0=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaab7a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=f9Wuf_kVOTRuHot6Ck0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160211



On 8/19/26 08:40, Ilya Leoshkevich wrote:
> 
> 
> On 8/18/26 19:57, Joseph Cathcart wrote:
>> Currently, /proc/iomem contains no reference to initrd memory, even
>> when initrd is retained and still held in RAM. This makes the memory
>> ranges invisible from userspace, and unusable to programs such as
>> kexec. (A sysfs bin file is created for initrd, but this doesn't
>> help programs which need the explicit memory ranges)
>>
>> Add initrd to standard_resources[] unconditionally. Add initrd as a
>> child of iomem_resources only if retain_initrd is specified.
>>
>> strstr() could match substrings like "retain_initrd=0" or
>> "no_retain_initrd", but this is how PPC chose to check for
>> "retain_initrd" param too. (arch/powerpc/kexec/ranges.c)
>>
>> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
>> ---
>>   arch/s390/kernel/setup.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)

[...]

> Cc: Christian and Alexander.
> 
> I wonder if it would make sense to move initrd resource creation to
> do_populate_rootfs(), right after /sys/firmware/initrd creation,
> enabling this feature on all architectures?

Ping.
