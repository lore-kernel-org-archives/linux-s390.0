Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C5468C02;
	Mon, 14 Sep 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396496; cv=none; b=H+qcbAUCO1r+qa1XUG1QGcHV7Lsts8ZYazXVrdjrLy1gshmtp0Gb+pkIBbFQPjR1whQQYGoMOFXZ9CTbG81zJQ10qfZWdxyfZbyu62SBQuBcSglJW527heiGxu+g+gJ4ny28L0YGKM3dLrqcjNW0NCRfx5+9Ozw7ZnAIuFVoY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396496; c=relaxed/simple;
	bh=H/0lG3up+QOVbEeEUTBh03lfHff85Jpw/pll5raR2ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv1XGZDB5Y5cS9ZoLMFs5a/F2O/AsYrph1dl2SrgW8utMrsHWFC4LQXBobc9tABwcGQ9ccXFDlmBR0Rb2B65vKJkQhy3RFahU3Nhss+FGUCfkdEBPZo21hmmZVQ0vVJp03lK3bWjyNyxTt6HC66TbFdTqekUBQuCPWCarfosEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gNpUwIOs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gNpUwIOs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EEVl1t2160379;
	Mon, 14 Sep 2026 14:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fxASVs
	xf/pU+LQkejQE4mMnVWY63ACPXu6kRFdIWdOE=; b=gNpUwIOskkm2rdDsHrHAvL
	xCIgBC5X5pUHVyNShFgoUVdDYLey3wgLcNr90HCQhciRW1mWjbpLsDK2uAILfVlq
	p2KY58dm3q3asw35rPDnYiBB1Lmm4UkWwh04YAvDdKQxTBnuC9T365VxN6QnIbh+
	YIA1GS8Yyc29D4fxaFPUIOFSpGPA4Pms4QbY7wyJiQFn/2TMIAAf6ivpwPmD1ucu
	wyEZEzAxxgHp+KLfj0qAMMNz/4AtQV9HF3Y+TCFHYJlQHD3IQSZiJG3jY37AtQBP
	LJ/9m84lQ6MUvJj6LUdzHgXV1oJhVTR2Y5YBuEHMJn7rsMH2ChEh2Z552zwnqPtQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hj566-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:34:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED55fa2359988;
	Mon, 14 Sep 2026 14:34:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pxp7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:34:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EEYEqv8257910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:34:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AC412004D;
	Mon, 14 Sep 2026 14:34:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23BD02004B;
	Mon, 14 Sep 2026 14:34:14 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:34:14 +0000 (GMT)
Message-ID: <875df4bd-c9df-4a47-a7af-97e8e1181baf@linux.ibm.com>
Date: Mon, 14 Sep 2026 16:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/24] unwind_user/eh_frame: Duplicate registered
 .eh_frame[_hdr] section data on clone/fork
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-16-jremus@linux.ibm.com>
 <20260821200949.B22341F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821200949.B22341F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwOCBTYWx0ZWRfXxwl26mRUOYFW
 gelyLhZkFs3C/klMRjTeowfIZdNK011OrKCwEVwbl6DIjnQMRtICKFjjn3Z0hpLdc//FEigNFW7
 DQ6+G8kqemFXsUGT3+W6HD5ro9bTdQ+zGlQ7CuY1uORs6Jd/F5y4XbUT6RN0+152LrY+/l0XnRL
 N/t7PsEFJZFrLULCoBKybFhjM4I9flHKMovHuKYiU4NyMBTohcD17aW1YyFeKRGDb7o0duWlR99
 Q4o+N7UwurR+TG4MDDl044oIJJMyc++ljUad8gdNvZL/30RIA3pTSJIsYQgaHxzbB1Z5qi6bJju
 DkZYoDaV/Anzs2WAxGOSlcSGimtGI6rU8IfahrwZgLuEZQR5/fBeGxPbmRnGclt/DycigHOzm1Z
 XuDMtAY3Gr7ykMm5JsdWFzYoamME6MmdxOysak3DSqGPr+BITKAPFy9jM/hVBEWstJkR2dwJul8
 zj0NTY2/zMvas4hS4Xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwOCBTYWx0ZWRfX1WXw8BbFoBd7
 H4kH1AMzZDMOlyQpr6W4TG7oC8cSb4Wmjh35JwV6Ye+8ayRsiByGKR+pzIvoHrtXjKlHvbC6CMr
 ZYaDiGAsyVbAFpwdB6SCVPXnTqxsWEU=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa805eb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=-ikTyFVTpUAiimQj0l0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Iy6eJOdeFXuPExDKzHBFucyWS0Z5Ef6w
X-Proofpoint-GUID: Iy6eJOdeFXuPExDKzHBFucyWS0Z5Ef6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140208

On 8/21/2026 10:09 PM, sashiko-bot@kernel.org wrote:

> When duplicating a process' virtual memory mappings also duplicate all
> of its registered .eh_frame_hdr sections stored in the per-mm maple tree
> to enable stacktracing using eh_frame of the child process.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> @@ -1501,6 +1501,54 @@ int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
>>  	return 0;
>>  }
>>  
>> +static void __eh_frame_dup_section(struct eh_frame_section *sec,
>> +				   struct eh_frame_section *oldsec)
>> +{
> [ ... ]
>> +}
>> +
>> +int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
>> +{
>> +	struct eh_frame_section *sec, *oldsec;
>> +	unsigned long index = 0;
>> +	int ret;
>> +
>> +	guard(srcu)(&eh_frame_srcu);
> 
> [Severity: Medium]
> Is it acceptable to mix goto-based error handling with guard() in the same
> function? The cleanup guidelines suggest converting all resources to
> scope-based cleanup or none to avoid confusing ownership semantics.

I think it is acceptable.

> 
>> +
>> +	mt_for_each(&oldmm->eh_frame_mt, oldsec, index, ULONG_MAX) {
> 
> [Severity: High]
> Does this unconditionally duplicate all eh_frame sections from the parent
> without checking if the underlying VMA was actually copied during the fork?
> 
> If a process sets a region to VM_DONTCOPY or VM_WIPEONFORK before forking,
> the child won't inherit the VMA, but it appears it will still inherit
> the eh_frame section here. If the child process later maps new executable
> code at the same address, could the unwinder use the parent's stale rules?

Steven, could you please advise?

> 
>> +		sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
>> +		if (!sec)
>> +			return -ENOMEM;
>> +
>> +		__eh_frame_dup_section(sec, oldsec);
>> +
>> +		ret = mtree_insert_range(&mm->eh_frame_mt,
>> +					 sec->text_start,
>> +					 sec->text_end - 1,
>> +					 sec, GFP_KERNEL_ACCOUNT);
>> +		if (ret)
>> +			goto err_free;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	free_section(sec);
>> +	return ret;
>> +}
> 

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

