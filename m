Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041EE475328
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390223; cv=none; b=VELyOOwYi9W0GNzvvWHOvieDFKezWT9ebv/WCgATlckkZvjHGnS/+t/Z5yklQ+JCU/yWqZ29pLgA2Qed94JBdEHXV8D1RrR4D3Ydm+eANvpZmSHU4CDA6fxwHOOU3sBI4ISYaY2UlhHeUplehhgXzmNUi0YGcb8s0nDFrrPzLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390223; c=relaxed/simple;
	bh=njlhKXdib3tgnHlBq0t0Qob+ZhYYngAdOojimxla6jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpmRWjsc75FHghrHMn9uFwpQh5KrHjU/p4si3rLooeN51XBvJ6SXVHDcEjr/d7GFDh/IsZra4H7n7tMsPZhv+nSDCY1jan8iDBkOsOtQq2wUwfrpHD8HSrVaULF/vOTC8ukTF4YBOte/oO3U8GlxkokBBGer1Y+Pon/0P2AxnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tokTI5vR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tokTI5vR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EA1Zx51572325;
	Mon, 14 Sep 2026 12:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z7BRFg
	W6bAijGTaTraVELyIu5oHVE/Uv/32ZV8TDaCU=; b=tokTI5vRkvqeqXl6W8EwgZ
	+gC9AGPFzU/KshcCoNC6xqTvnP95OLt2G+8sUGqHrTk0QERwvnly1GxQV4wOPYz7
	CQHEFDlopJjDx5wp+Q7F1TwgxLBMdZ2qC/UCbVXCDdD8XTfhJnlvfAjxScVHYmpE
	Rd3elQuuEwFt2suNZLb7VUp6UYEBtAmrZmnZ1tgyJ7T5zoJKo/Z6s9YTePhEcrFb
	b/lvFzlK8f8b7N43LxZofDeqwHFOywX7Y+yx7g/2VinSJ3vr5OyyaVY9AMighrBf
	FuTP0WviS2UhmEHdKIunNlamF6IrhlMjuGQjTmZJsbfZlK4XgPodqVeVIexpM8Xg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hhkjg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 12:50:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9o4Nm2069036;
	Mon, 14 Sep 2026 12:50:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhevx6ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 12:50:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ECoCSX52363754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 12:50:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC0CA2004B;
	Mon, 14 Sep 2026 12:50:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67AB220040;
	Mon, 14 Sep 2026 12:50:12 +0000 (GMT)
Received: from [9.111.12.145] (unknown [9.111.12.145])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 12:50:12 +0000 (GMT)
Message-ID: <8c97e152-7718-4d6e-ab3d-0d9cafc7339b@linux.ibm.com>
Date: Mon, 14 Sep 2026 14:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] s390/cio: Harden pmcw/schib handling for dnv=0
To: Heiko Carstens <hca@linux.ibm.com>
Cc: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com,
        linux-s390@vger.kernel.org
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
 <20260914121715.39845Ba0-hca@linux.ibm.com>
Content-Language: en-US
From: Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20260914121715.39845Ba0-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3OSBTYWx0ZWRfX4/htHFeOvN0O
 x1tAOaqdzzlDaiPVttWiccreF3snEvAnzmufkXh5Liytee3OeCct601xgkb3+dUVORd0vlDIGjr
 lXhFSzRyfrQvWAH3lVYOxsb4bXNYLAskmzjkpBA6REobCaX0Pu6/C9H470UNPaJy/H0CHADQU/7
 vLKQGJ83KXQ1MkNiec2AmvzAU279bvSDoTamkRsHzdwH+qX1yEsI3a3MKbCon7wGMWXMkF7IiyZ
 xNC3zoEInK8W3D0nonqz364Ml99CJ/RRAwiqD/F4y14UVVMv4hTFuHz6NCovm5S5Nlks1zb1rmo
 zHn0MyQddZX6KppR42iX9Hh0alRonDqi3bFnWnnzD5vtWOmCAHt4LAAW68a40vQRpNNKplUMbNJ
 I0YnK2C1pB2FCO+zin/kszMa0zXM8y5O0duOv1tA5vZG84efzVINdUDhW6AaKLxYoTVuTNXsYou
 ZBA0bPVT+GW7BRbLfAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3OSBTYWx0ZWRfX6HcwUUbI4yr7
 vRwERIsUXEsbnGFWpCjltEgqPkR4JlVG7qMSlYi9xeKUpanKX/on068XJgZZaB5j0Ch4ZsXW5c1
 qvKQ8XEuRxU1UpdHAiOUxy6iBbv6D9c=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa7ed89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NhG1dQo5bRBPcueBa_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: csAGQVf0DlwKesqf3feIGCNWtX2hm4JQ
X-Proofpoint-GUID: csAGQVf0DlwKesqf3feIGCNWtX2hm4JQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140179



On 9/14/26 14:17, Heiko Carstens wrote:
> On Thu, Sep 10, 2026 at 11:32:00AM +0200, Vineeth Vijayan wrote:
>> For I/O subchannels, pmcw.dnv must be validated before relying on any
>> other PMCW or SCHIB fields.
>> Two issues exist today:
>>   - Some I/O entry points check pmcw.ena without first verifying that
>>     pmcw.dnv is set.
>>   - cio_update_schib() updates the cached SCHIB before validating
>>     pmcw.dnv, allowing an stsch result with dnv=0 to leave stale or
>>     undefined data in sch->schib.
>>   
>> This can trigger spurious, non-fatal error messages in the guest kernel
>> log when a virtio device is being detached.
>>   
>> Fix this by validating pmcw.dnv before updating the cached SCHIB. Also
>> clear the cached SCHIB when stsch succeeds but returns dnv=0, ensuring
>> that stale state is not retained.
>>   
>> Additionally, add pmcw.dnv checks before pmcw.ena checks in I/O entry
>> points and return -ENODEV when no device is present. Guard remaining
>> direct accesses to cached PMCW fields, such as chpid[] and pam, to
>> ensure they are only evaluated when the SCHIB contents are valid.
>>   
>> This was reported and discussed at:
>>   
>> Link: https://lore.kernel.org/linux-s390/20260612155407.199218-1-wbezenah@linux.ibm.com/
>>
>> Vineeth Vijayan (3):
>>    s390/cio: Fix cio_update_schib() to not cache invalid schib
>>    s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
>>    s390/cio: Guard PMCW field accesses with dnv check
>>
>>   drivers/s390/cio/chp.c          |  3 +++
>>   drivers/s390/cio/cio.c          | 11 +++++++----
>>   drivers/s390/cio/device.c       |  9 +++++----
>>   drivers/s390/cio/device_fsm.c   |  3 +++
>>   drivers/s390/cio/device_ops.c   | 21 +++++++++++++++++++++
>>   drivers/s390/cio/vfio_ccw_fsm.c |  2 +-
>>   6 files changed, 40 insertions(+), 9 deletions(-)
> 
> What is supposed to happen with this series? Since none of the s390
> maintainers were on to/cc I assume this is not supposed to go upstream
> and can be ignored?

Hi Heiko,

My bad. I missed adding the maintainers explicitly.
I was expecting to get the review comments from the reporter and
from Sashiko.

Looks like There are no major issues introduced by this patch. So,
could you please not ignore and consider the series for
upstreaming.

