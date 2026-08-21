Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100342E428;
	Fri, 21 Aug 2026 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341300; cv=none; b=boeWWakzH7dgBLN3NOlCOgAnV0QgX8eSuss/AjVejmPkDSuTSoAEzPhdl6VoBNoFLSJ2uaemIeBfHFoMgkOnLTT468zaFd2himyYuLr3DecaIBUdiJl4TLbAqMe2uQ3564xuEEdp4yVU5/vL6JNTdTm+9zsKOy1Y9QkCfISFj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341300; c=relaxed/simple;
	bh=xyAUd5Rfcj1prw+cBbzZMTz3OFrkAM/UbNhjdLE6YSc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VYqx5ey6/sG2sTURDcCafnYe4hJHrxi43MEjiTA7d0SKh6jGKTW8f0U3/oP8ugNB5UWdHBxinh/OxQ+7WNYjewCOXWcn3EGeysBXda/KE6G2Ve0HzcCGqGApu/YNGR99C5A2q4Lk+xJaatOquvHnlbz0kd9lu5U55YdTxjCmRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGQLX7NE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGQLX7NE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVwFx2253883;
	Fri, 21 Aug 2026 19:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cdPJwO
	th4L2j8ec3nm3cYYlSx6QvUSLjdbJplfgPZ8E=; b=gGQLX7NEn/23tTFZ8Ok8jP
	zOR/AGjkRa1mQqGBfIRVqswDyawzr8ospeXgO65KJ2PlmBJhVZrs2TbF3W5F8Ehf
	AkRCNBQfRDX+m1e4/25d2dsKjj+SYK29mW+zvCvuHT5lbH4y1TqM7PedOTm/g21S
	NdZd/LmDPjs4J8HUh9dKK0zat4kcNkSgBTtN07U6ovOm7FYuPCGwY6I7NtXtK4pV
	2q2pps3ECxih+rd8p8uHXZVaiAVmn9qbmAW4+hLpyiBCS4elN9UxlF0hmlcyCjLQ
	XqSSVUdSjNBmyjIZOUOrMDIyRMHKpizyTnMJVVmougDC5iIWswx57s399YoEjFoQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4kpdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfRDL016689;
	Fri, 21 Aug 2026 19:41:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpke2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfU4L40698328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A837B20043;
	Fri, 21 Aug 2026 19:41:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F339B2004E;
	Fri, 21 Aug 2026 19:41:29 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:29 +0000 (GMT)
Message-ID: <c72ad38a-8735-4bf2-9a9c-1d28369d4954@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 15/25] unwind_user/eh_frame: Duplicate registered
 .eh_frame[_hdr] section data on clone/fork
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-16-jremus@linux.ibm.com>
 <20260818151105.053861F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151105.053861F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXyFho1+I80N6Y
 2Ay4Vm3rd4zd7OcD83LsWuJ+7CsEZERF5LnTs9lMhV7PRqQ+sqQcVZhQyv3AJjceqCiidwwZ1Fy
 rNi9rYg2yjTf6eGElMCBaVXXvs1RrUc=
X-Proofpoint-GUID: YwIf1Q2mTFOaMilyIhzxVgjuG3GHVvwY
X-Proofpoint-ORIG-GUID: YwIf1Q2mTFOaMilyIhzxVgjuG3GHVvwY
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88a9ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=_sPRJXl7WXizVRayzzoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXzf+1uIoD9Q0p
 rJnmgjZ/U15o7eo4iabcdNFBSca6nmVBo8oNBkUR77YvaNo88xyjpWKeT0wcjOuEViWRfwP/6kw
 ZBJaHkLXHc9yuKCF0KWKLDXiPmjmQYNAin9U4RIy+lgiKH1RSbb82Pat1q0IIAYi+AKuBMS5M5C
 Qiiw9c/6tLuAyUqiPVBZpxhFTkdPE9e0eF4tBHQEfFJFoiwPk6A5bU5p3QtY7OThavrEz7w6JYa
 jYi7oedA50VpZII6W8J0ccFZPYrm+OqjzWYB1L4Q31VmICmpJay3eVzM7/DFRAXfWKiFsIrqTO4
 JZ0st0aiG1JYWF5eIoFotHq5tAf3/LS/tkNxtBfmYalBkYddRh00IieMAPWDbhCfVwa5vHtCbo2
 T1EJ5ripPeR+mn1/xatGtlcBaDO4caC4Awy2r5imeDB5hlOuVzpDzY2ka9uK+0wtzraqGMyVi8f
 kFw1TjgesSglo4hUhGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:11 PM, sashiko-bot@kernel.org wrote:

> This commit ensures that a process's registered .eh_frame_hdr sections are
> duplicated in the per-mm maple tree during virtual memory duplication. This
> enables stack tracing for child processes using eh_frame.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
>> +{
>> +	struct eh_frame_section *sec, *oldsec;
>> +	unsigned long index = 0;
>> +	int ret;
>> +
>> +	guard(srcu)(&eh_frame_srcu);
>> +
>> +	mt_for_each(&oldmm->eh_frame_mt, oldsec, index, ULONG_MAX) {
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
> [Severity: Low]
> This isn't a bug, but does this function mix scope-based cleanup with
> traditional goto-based error handling?

No.  The guard(srcu)(&eh_frame_srcu) is for read access of the oldsec
obtained from the oldmm->eh_frame_mt.  The goto-based error handling
is for the new copy sec, in case inserting into mm->eh_frame_mt failed.

> 
> The kernel's cleanup guidelines specify that usage of goto and cleanup
> helpers like guard() should not be mixed in the same function. Could this
> be converted to use scope-based cleanup entirely, or avoid guard() to keep
> the style consistent?
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

