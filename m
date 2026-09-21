Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF9494817;
	Mon, 21 Sep 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995426; cv=none; b=ppnpuApbxg41UC7+f8FL6dkByoepzozGExa8qQ/AgJKLEpehitpeO67OPrm8W9laHoGDOc2qDHVKQTqNxZSn7zLsI4LbDG1q36CeJKt3tJI+Mf7AfPirU3+679ScXCm1tH2aKaHpSpApykS6MkCdN8PChkYTPnoWJCOdu9AlANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995426; c=relaxed/simple;
	bh=fow9ytOam+ipeWeq1UCJRC+jsh45uI1ixFgT9Yju4gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFZm8g2p+dFTMKw4AtIR20vNxxVV/v3cTyfp0hPc6WthcvM/GfrETiIzxcvoLgvvEuRIftlO7IoK8LxgEnUY4Nl0nQOhFWXo17t46BALNEgSCNdzT211052b2RFmk2xQthuh1hC8wk02jumY8mBV9UWrzoHXCQva2j1TIrR9c18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TpAA2q2m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TpAA2q2m"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB62ma1170446;
	Mon, 21 Sep 2026 12:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QFa75Z
	i/+VVd2lsXTb7x3WWmHJ3iRAj73+/Qblj2+qk=; b=TpAA2q2mm5JZkIBYOMuhV6
	t6K+zokHP3kod9qYZoEmuKn63eThCSTP44V9d1+qEYeQ+tFS2LdGJrLWF/T1OM9I
	IuTIVU7mADxntI0PRzZ5+ucU8jziE+CJVS/GNhR/1zdLakzeonjxJIKuIK3kNXbA
	VB5ScSRIzy/tRG+rp9xI7CXcWpzS03cnGGY8LDKJrUteWjt2t1bldf37603R/ins
	DzoKCtCK1nu55/Xjhcqn0+6iaQ0lU1EHlfFqdgXb0y2IHOTJkpGMi5g/+Ya6dhnt
	ZSkAjBAGq2slI4lnh1ipa7Iw9MMZfvrFqg+WSqiLgZORS4qBWrPXQyndQHuswvag
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske18eya-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:57:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlSow1153698;
	Mon, 21 Sep 2026 12:57:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq5f80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:57:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCuud034472360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:56:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D11920043;
	Mon, 21 Sep 2026 12:56:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3987B20040;
	Mon, 21 Sep 2026 12:56:56 +0000 (GMT)
Received: from [9.87.147.142] (unknown [9.87.147.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 12:56:56 +0000 (GMT)
Message-ID: <91ace432-681d-4b12-94e8-e82156eb4363@linux.ibm.com>
Date: Mon, 21 Sep 2026 14:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/sclp: Implement resize for sclp-vt220 console
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
        sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
 <20260921121619.1354611-3-maxbr@linux.ibm.com>
 <20260921122814.9DBAF1F00893@smtp.kernel.org>
 <28840d7e02c8eb0daa35d56553dcd8cbb9b3eaf3.camel@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <28840d7e02c8eb0daa35d56553dcd8cbb9b3eaf3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -DCoCOXzZpgEq4dT1q7QElW2Bd0u62kp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX/dcyeWo77VHx
 vCYbFZCYbcr/RfYaRGM/Ee3YRuiJMGFMzTxSA9zAnP/d4yB+2KalO+X/tQIN5cmZmu9WFlmJeyQ
 pUvJZkSzRS5Oa2NHoPcqN4/tp+d3yTBN4cSi2I8eVonbc0Wj5Ipte6DHuu646hK2OFivv8/KGzB
 BhQ6HxDJsBzr2aYqAPcX7XgV56CZRB3MFGkNdgliRPn95p22zpdqxidI8od3tLk/IYmfedEmHKW
 qYffgTCcuMFx4CqMKfEuvek35pqlsrswzkJYwzRoPr3W5bnwBcyml0PQrn7qcLjTHAiTzSF0lFE
 N264gr5t9W+1WFyUVwDTB/zMzvnrtgiwPrzEBMrkHi1Br1U3AloPzP1q4J35o1CroeiNj6WV1WX
 k7cfRWAeLf202O3Rq6CTo8+UAiyx4sCdn1Bhi/4vGabsTOsEmq+2jiWqJH3rJFWgxY3nlulZ9+J
 /i88tsKzb1nTM64YU3A==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab1299c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ujVII-inEr1P4oIIDXwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MyBTYWx0ZWRfX0u5b6HYPhQ3e
 lEVEG8nVJ1PPzgiHqSVVOQVE21y1FlgiALY18cQ1jVI7xQ3XJmppjWU098FcvTvK0TZtvNxH+OK
 u8q7d/D9V6TY67O/5y1zqcPyjgSSbWs=
X-Proofpoint-GUID: -DCoCOXzZpgEq4dT1q7QElW2Bd0u62kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210183

Am 21.09.26 um 14:54 schrieb Maximilian Immanuel Brandtner:
> On Mon, 2026-09-21 at 12:28 +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider:
>> - [High] tty: UAPI breakage due to asynchronous winsize
>> initialization in open()
>> - [High] s390/sclp: out-of-bounds read in SCLP_VT220_SESSION_RESIZE
>> parsing
>> - [Medium] s390/sclp: data race when reading shared terminal
>> dimensions
>> --
>>
>> commit 13e18fecbfc8440743cc8dff7c08364db9a637bf
>> Author: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
>>
>> s390/sclp: Implement resize for sclp-vt220 console
>>
>> This patch adds support for sclp vt220 resize events to enable host-
>> initiated
>> terminal resizing when using the sclp-vt220 console. This allows QEMU
>> to
>> dynamically resize the console.
>>
>>> diff --git a/drivers/s390/char/sclp_vt220.c
>>> b/drivers/s390/char/sclp_vt220.c
>>> index 7c168a66e4afe..d140617846a2d 100644
>>> --- a/drivers/s390/char/sclp_vt220.c
>>> +++ b/drivers/s390/char/sclp_vt220.c
>>
>> [ ... ]
>>
>>> @@ -543,6 +588,9 @@ static void sclp_vt220_receiver_fn(struct
>>> evbuf_header *evbuf)
>>>   	case SCLP_VT220_SESSION_DATA:
>>>   		/* Send input to line discipline */
>>>   		sclp_vt220_handle_input(buffer->data, count);
>>>   		tty_flip_buffer_push(&sclp_vt220_port);
>>>   		break;
>>> +	case SCLP_VT220_SESSION_RESIZE:
>>> +		sclp_vt220_resize_sched(buffer->data);
>>
>> [Severity: High]
>> If the hypervisor sends an SCLP_VT220_SESSION_RESIZE event with an
>> evbuf->length smaller than expected, is there a risk of reading out
>> of bounds
>> when the data is accessed?
>>
>> This path delegates to sclp_vt220_resize_sched() without verifying if
>> evbuf->length is large enough to contain the 4-byte resize payload.
>> Since the
>> event length is controlled by the hypervisor, could this result in an
>> out-of-bounds memory read when sclp_vt220_resize_sched() reads the
>> rows and
>> cols fields?
> 
> Yes, but a guest needs to trust the hypervisor or firmware anyways to
> provide it with correct data, so I don't see the point in verifying
> data from a trusted source. (Eg what if the hypervisor implemented
> load/store instructions incorrectly -- at that point there is nothing
> the guest can do to operate correctly.) I could add a check here, but I
> don't see the point in it.

There is a point for secure execution / confidential computing. Lets validate
the data.
