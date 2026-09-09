Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A56440626
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959236; cv=none; b=JEo7m/5mW8/0bADfLgUTRHAgUolcqhzJ3LdViCGtYdo/OhQT3ZclgxhC5qznls8/HpXBugg/U1gXf9z5awcTU8D6pd2vUvjz3awSvSpdQPZExiaYgOMch9hboF/dSEVsspHWEuywoelmmz8roHKw3njMBL5x93R6G7WmhjigOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959236; c=relaxed/simple;
	bh=AqrjD76IrmpqRW/bhIHDLNYpbLkn87xXWJmADL02VtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAjzqzCH88443q4AO0ORVYSAw0GLaWWOpsQz3i2y1O78bKPL+/awt7ODVfGYLZensg6uPQ3jNB/vZMquHAJAVHgAlzOmG8yKzX13lHk2GWceJvBJHoo4fJB6e29QF3QP2r9xsIoaMqPaXe+etzqiRORvKCgsNsAomZX7rDtsDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OK4Q5cf3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OK4Q5cf3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1PpD3801833
	for <linux-s390@vger.kernel.org>; Wed, 9 Sep 2026 13:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZFT7qh
	Dcs1nVFnxDFHXddUB36wBC3GnNE/ycIB8cjoA=; b=OK4Q5cf3qxx8SpUJ9R9T6p
	kzJbNp62PRWDFRprjx26dDq4wYRjyH4Q22ECr3Kw0+CxgK6uV7K2416IggvfrWHs
	Ik/48lVgATOYU+L5gPrKha6udyVV7zsTQM81AXmcDQJRmp+UmuudX4uMdqPjV9gN
	xV4yVPJ29xLo9gmijrf8htJSTFbJNzuZX5PUur6s1BX9ncKKhhw/ALCKOuzgfJeF
	IcpKV6UnM0HDCfEByy9Wpki5DBwYZs78RhucLTZM02+o5Ho0l+CcXja7IhV3LCWQ
	vf0SYFwMw7l1mwM/OUMlyyuaW5t7Hv1u7iXAFUJY9SwL59TvApqslfjYcFI5Svgw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkx0t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 13:07:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689CuI7x031387
	for <linux-s390@vger.kernel.org>; Wed, 9 Sep 2026 13:07:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwhaanx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 13:07:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689D78rX47645172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:07:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91CD520043;
	Wed,  9 Sep 2026 13:07:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E9F42004B;
	Wed,  9 Sep 2026 13:07:08 +0000 (GMT)
Received: from [9.224.90.205] (unknown [9.224.90.205])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:07:08 +0000 (GMT)
Message-ID: <20f9260c-a957-4b00-8dad-dcab98310336@linux.ibm.com>
Date: Wed, 9 Sep 2026 15:07:08 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/stp: Drop CLOCK_SYNC_STP
To: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260814072223.2218864-1-svens@linux.ibm.com>
 <20260814073450.908631F000E9@smtp.kernel.org>
 <cffc6734-19c8-439d-a55b-79bdedd54eab@linux.ibm.com>
 <yt9d4ifyvca4.fsf@linux.ibm.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <yt9d4ifyvca4.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0NiBTYWx0ZWRfX2IBKeEvE1WXt
 Mvl0wLVkUaZ2AM10mTeobeqNiLGsGQkzxfwPs+/jkP+4AyPs13TL7fltQdJI4YlePDQ4UWCTUC1
 IQPWp5B4ll+/Z4ZYlNpyw5uXf17n64M=
X-Proofpoint-ORIG-GUID: CCliHKMrfGBBl2PGYsYJgX3fKGomBfIB
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa15a01 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=dDSH4cpXGB8ZWBbiCQ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0NiBTYWx0ZWRfX1eIdPEWyYBO/
 jpd/iZ348Db3nZLAwQt5BGq6olLf0kedfwVfFi7o+mpNT2t0cd8TIizm1HF8Bt3ltD+BufkfoVj
 NL4UmZgiMWKIeUVSIozulVtD55CwhBVapdQ+HYszu3cAfOIcX4H1h4j6NGMxndqKy5UaU1MoLEr
 W47oZfC8kwznBnFhyCTEBKYOldj/27ZX6D8j6FC0PQ19WWUfygu4wS7CqFu4Bg3zb79w2IkgDqa
 2Kmx/5d/jrAajKRJPUxCBt+45Lf3qkBZ2+NB8QPNfnc0K1cWxlAEfdPOijggpe+3TvKSyWjibAw
 jBHVMZxZ/2QeYdFfPV95767pSacBBnSz3wifIRxrwjcFEOjKR/w0L5tWG4KoYplkjOUipK4q0ux
 sKBAn+KVmbaE4vXuDzxqvnRW116q5zyeM8AFnabONrzSOXZIWBOv41bUsD+NVoXWHUm77F9WTBm
 j5fio6uesEFvb84vS8A==
X-Proofpoint-GUID: CCliHKMrfGBBl2PGYsYJgX3fKGomBfIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090146

Am 09.09.26 um 14:29 schrieb Sven Schnelle:
> Stefan Haberland <sth@linux.ibm.com> writes:
> 
>> Am 14.08.26 um 09:34 schrieb sashiko-bot@kernel.org:
>>> [Severity: High]
>>> Could this change cause a boot hang on systems with XRC-capable DASDs
>>> but no active STP network?
>>>
>>> Because stp_online is initialized to true, if the machine supports the
>>> STP facility but is not connected to a usable STP time source, time
>>> synchronization won't occur and stp_online will remain true.
>>>
>>> With stp_online remaining true, get_phys_clock() will continuously fall
>>> through and return -EAGAIN, rather than safely returning -EACCES as it
>>> did prior to this patch.
>>>
>>> The DASD driver ignores -EACCES but propagates -EAGAIN:
>>>
>>> drivers/s390/block/dasd_eckd.c:set_timestamp() {
>>>     ...
>>> 	if ((rc && !private->rdc_data.facilities.XRC_supported) ||
>>> 	    rc == -EOPNOTSUPP || rc == -EACCES)
>>> 		return 0;
>>>     ...
>>> }
>>>
>>> If -EAGAIN is propagated up, will the block layer endlessly retry the I/O,
>>> resulting in a complete hang during boot?
>>>
>>
>> From what I see, Sashiko is right. This will break how the DASD driver
>> actually checks if the clock is enabled and in sync.
>>
>> The DASD driver relies on -EACCES to know that the clock exists but STP
>> sync is not online/applicable which in turn will skip it, whereas
>> -EAGAIN means the clock does exist but is not in sync yet and we should
>> wait and retry, which in turn leads to endless loop of request never
>> being built because we never get a valid timestamp.
>>
>> So I guess we will still need a third bit to differentiate those states.
> 
> If I understood the code correctly, it would only block until STP is in
> sync, so this is expected behaviour - looking at z/VM documentation (especially
> the XRC_OPTional flag), DASD I/O should be blocked until time is in
> sync.
> 
> I think the correct way would be to add a patch on top that adds the
> XRC_OPTional parameter to either block DASD I/O when STP is in unsynchronized
> state (current behaviour) or just omits the timestamp when XRC_OPTional
> is set.

Not sure XRC_OPTional fully covers the case here, though.
The existing "don't count -EAGAIN against retries" logic assumes the
clock will eventually converge, a real STP network mid-sync.

But the scenario here is different: no CTN/network attached at all, so
there's nothing to converge the state only changes via admin action, not
by waiting.

Wouldn't a mandatory-XRC device on a machine with no STP network at all
still block forever either way, regardless of XRC_OPTional? That flag
decides whether a given volume needs a timestamp, but not whether the
system can ever produce one.

Could it make sense for get_phys_clock() to distinguish "converging"
from "no usable source at all" itself independent of the XRC_OPTional patch?
