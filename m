Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647F40A95F;
	Fri, 21 Aug 2026 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341297; cv=none; b=PLkkKozqNsY/SYi5IVDINedjBZiaVHOaJciRUgRQr9MkJdliD4C4cJFlgJJZ+xHt6W2VsuK8oyzbV4ATqQQOpyNVP/CZRjoIegWKaNjh4VPfDIDKscN6w9vkAdv2sWLdAu9qQhpS1li7MQ34KRU2QCDHQWBHa3KHkJvtn1XOiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341297; c=relaxed/simple;
	bh=V5c+hYxZ1bldS7DCB8TjtN5FnVC75vS0sx7rUpEnUmQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DkOyhFb8pHmHwMET2nS1+9oExNy0c9K3d9hg/dTdwN4iim6OXVexhTMAgDHhwTm6Ll60+zMw5NQ1BSVZgbwmjnwwY85agYVa66827pzkMj2TkQNeJYiTM/glC+DZRcATRroWqHk12ZEPW/0ZY0lirTl6b8N6OvKYIVdUWBIFFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USQoPBlc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USQoPBlc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVjAF1237461;
	Fri, 21 Aug 2026 19:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gUL4xJ
	UANxSoAyiRZEP1bQiYvJiCAZSti8JUPMpWS+A=; b=USQoPBlcL40rmJKF6HboEf
	nc2W9D0WLd7e3zKt7FZFdRgU0w+P4fu8SU+nrniOinNPrePhi849LrnRunR37g9o
	htyl8dje+q7gpOWOuvs5dhlON5cM2PdCtjXlTKj6NZfdXH76G0Pj83XhCXjunnYa
	gNw6OhA7ARZPnyrQx4Kweb0A6MrT2S9rU+Exaxs1Z7ZWcKpHJ3Qpwp/UFLNRT3rp
	M6Z+WEy1b2zpjWqESxe3auHSieNSm1gmAg7CyaWpodJYhuprRFcuKOwgIOnDAO3R
	H/Lufvc1qYlCRgTDilOhieiP6Rievyn4Lac6jyJ8NeiZtVnm3eUBSwk/QXLL6k2Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2knr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfJJe021077;
	Fri, 21 Aug 2026 19:41:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpksb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfKlg46662096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB79720043;
	Fri, 21 Aug 2026 19:41:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D382004E;
	Fri, 21 Aug 2026 19:41:19 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:19 +0000 (GMT)
Message-ID: <dbf67dbc-01e6-492a-a1ce-d396a13f4037@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 11/25] unwind_user/eh_frame: Wire up unwind_user to
 eh_frame
To: sashiko-reviews@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-12-jremus@linux.ibm.com>
 <20260818150955.96FF11F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818150955.96FF11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88a9e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=LFt20mCCc4CE-LtB3JUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _5GdXajyPASmwT47IFw4h3MeTSdTH5w-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX+MYu+MyQtBbV
 yl0g4Djg+RJazn6pOChYbA11LRJSo51Lq3Qk6usb7reMVbNFP1unpactLVYH67YwgkVv828NMcL
 mSc0F45tPn7BPcC5rMw2Fe1/vTWfiryOY9hbv7IFSFLwyRe6djGHSWeE4rZXlqaQq3rAbs2q/ig
 Cel42ltqYBb5+PemRe46KNSKhjYguPkaVa8DQw0gtGOF2Hjp3AgUWddJkMeTyrw9SzpItpUB+Ze
 /BgX6sQufMx4GCwrzrYDlXt7Sp7xzAhQc0zG2k+w8JN0/a1TUP9tbxs8Km2b0fDf4uT3dJonPsd
 RQZO8UdRiVQvpbSEbY3J0XwhTG0XKdVNkYqIds29VkM/FS1oYHxSf5vskGhD7iG4rLW333GTxe1
 J/MyndhADEzca3ddDsL9ejXBn+GorlW4hzwBzmkUykPbC9Mp3pVdlpT7eWOXQMBx57PlFx9/Kgh
 4pytkHkWTsMr5IZH0nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXz86GHxmVECFJ
 NjGKK0Drm5H2RNWEZLLUg+CgA07tqixxkOMdeIrj3lqsUrEA5egi0qyrjFX+Ifapm6TqeCyNCIY
 1wADnxrU/kXJ0b3y6i4WYd6GB7HUfrE=
X-Proofpoint-ORIG-GUID: _5GdXajyPASmwT47IFw4h3MeTSdTH5w-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

On 8/18/2026 5:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The unwinder fails to adjust the return address before looking up the FDE for non-topmost frames, leading to unwinding failures or incorrect CFI state at function boundaries.

Valid.  See below.

> - [High] Child processes created via fork() do not inherit the .eh_frame tracking structures, silently breaking user stack unwinding for all child processes.

This is resolved by subsequent patch "unwind_user/eh_frame: Duplicate
registered .eh_frame[_hdr] section data on clone/fork".

>> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c

>> +static int unwind_user_next_eh_frame(struct unwind_user_state *state)
>> +{
>> +	struct unwind_user_frame frame;
>> +
>> +	/* eh_frame expects the frame to be local storage */
>> +	if (eh_frame_find(state->ip, &frame))
> 
> [Severity: High]
> Does the lookup need to adjust the instruction pointer for non-topmost frames?
> 
> When state->ip holds the return address (for non-topmost frames), it points to
> the instruction after the call. If a function call is the last instruction of
> an FDE block, passing the unmodified state->ip could cause the lookup to fall
> outside the FDE or into the next function's FDE.
> 
> Could this lead to incorrect unwinding state or unwinding failures at function
> boundaries?

I do have a patch to adjust the return address for non-topmost frames in
the common unwind user code.  It resolves a few unwind issues in Glibc
on s390.

The question is whether it should be adjusted only internally on lookup
(as suggested by Sashiko AI above) or whether it should be adjusted so
that the adjustment becomes visible in the recorded callchain:

	state->ip = ra - (!state->topmost);

Thoughts?

> 
>> +		return -ENOENT;
>> +	return unwind_user_next_common(state, &frame);
>> +}
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

