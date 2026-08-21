Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721C42E406;
	Fri, 21 Aug 2026 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341317; cv=none; b=PgGOLNheVy72MNh3H8BGF1L1NayNodGQgGDW5zmN6bHWC+Z+tts9UXUYXNHM4kNtokY3qjYDvoJa7aySPKOc/eDfmoS7e/AELJKhPEQXL8p/ctGkxCBdTUBEktElilt5Znb3xwyQVn4kLrvoBBBeaIxJxnlH2fBN+L1x+7uC3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341317; c=relaxed/simple;
	bh=scZe2IONEFKfFXg3+CxxJmBOZrqiUXXw21k055TZIQM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VHMpwxdbHX8LkrjIFRcfLnBmDIxhqV3JIxT9fWlbbv8EoFSAwj+Xl2FbWFy86diIcLKfl1bhuavMqb9GFtIvKYZhqI9ROakJ79no0w+S8WYfxxn8nHVve82HlGjjH18bhjE06UH3gXB40R4lX8T2JK+nyvtfjVYQJlzh2ziv9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hq5Gnu8R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hq5Gnu8R"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVcCu2315025;
	Fri, 21 Aug 2026 19:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lX/nhP
	nKwNdZInzyOCT6OUJJq/qixr/05V7nH1henWw=; b=hq5Gnu8RRg3In4Um/+yF+v
	cgUt3ubN935zwYWkYzFrejx2aumybJZvXzeASbNDlrdbasmCTUZ0x1S2FFYtP6i3
	tvQQrTfOhegrzF8b+aZ42Qp9Trti0XbuP6tjzsVt50ae2xSgPkgVm0lCrRvqaHpo
	B1gfssM/NHFiHPEvBKqyYPciZUf07uLsVoKdZzz4UyIdXc4HcaoPHDCdjijNuBYC
	Xw2ssXAnzas8afSS9O+DDpZyi0vygkVQOeFk5ZnfixFnsMaAT41dNOvmspjODFCc
	XwvVvzh7/vv25HgxDmYllI1Fqx4L3IzAWYj7Kf2naScJoBdBc62KZT1h8MWn/N/A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1ur9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHeK020578;
	Fri, 21 Aug 2026 19:41:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpsjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfhYG42795400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2202004B;
	Fri, 21 Aug 2026 19:41:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 627BC2004D;
	Fri, 21 Aug 2026 19:41:42 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:42 +0000 (GMT)
Message-ID: <f7846379-ec5e-433a-971b-cc66fe0474f1@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 18/25] unwind_user/eh_frame: Add support for DWARF
 expressions
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-trace-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-19-jremus@linux.ibm.com>
 <20260818151338.757DE1F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151338.757DE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a88a9fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=2K9xg7xn94ptyIVrJxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JpvHVaUa5gQAX3c-dFDzgbex0D4kPl4u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXyXtX/LRzU6UO
 iBIt9+ecWIJlznkMN9fpXEXyvutTUoL7i/ANQqqjO7TvfSqU4GI2ISTlUWAJ3uUXljmooO2C8rK
 b7HZvrFE8W+c9Au6yZi4ZZuMop0CaSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXwmr5wrSvD1dv
 yhGmY1VFNHuYG5NtK7Z0IW4LgwJdwEizcupndi5eLmqVu18psM3YwjmYQFme7/eu9VETiMtmZiG
 Ef+0oG3sT9Zyz2k0oCl8nkHBTlNPhwvRdJBSqeXUGx2y9cNKa4mCyWA5yr1mnQQ5v66tMVFXcaP
 rBRbgwXZ4HdgIEi5px1vnrglyTtfevW2P4UT04z37rdWoSboeQdI3hezHJz/vPXVIo+1pIZTOdW
 5s1ZQHZaMLurFw3egNFuA1fDTaCH9MNLbJ/V4PxEXczriIh9LSJ7o+J3Iw6PXQ9i+NhuKc3PHnB
 uTvq3KgBj2yKmdsUCI2Q08AxW93o6el9DMnmaRmqEfz5NhWfBrizHvSlqIWaz6NVEQWsgtb/o5Z
 OXZOx4Se/v5WKsR8EdPooOqjQiptWo0jgfUEKKdx8Au6l2ZrNCf6eayMtL2/yu1kWhlrwCPI57C
 FyuTiiwVnyDlW7ZpRQQ==
X-Proofpoint-ORIG-GUID: JpvHVaUa5gQAX3c-dFDzgbex0D4kPl4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

On 8/18/2026 5:13 PM, sashiko-bot@kernel.org wrote:

> This commit enables architectures to handle DWARF expressions in DWARF CFI
> instructions. It limits the maximum expression length to a reasonable size
> and provides inline stubs for architectures to override.

>> diff --git a/include/linux/unwind_user_eh_frame_types.h b/include/linux/unwind_user_eh_frame_types.h

>> +struct eh_frame_reg_state {
>> +	/* CFA recovery rule */
>> +	enum eh_frame_cfa_rule cfa_rule;
>> +	unsigned long cfa_regnum;
>> +	long cfa_offset;
> 
> [Severity: High]
> What ensures cfa_offset is initialized when processing CFI programs?
> 
> When struct eh_frame_cfi_context ctx is allocated on the kernel stack in
> __do_cfi_program(), its state.cfa_rule is initialized, but state.cfa_offset
> is not.
> 
> If a user-supplied .eh_frame begins with DW_CFA_def_cfa_register, it sets
> ctx.state.cfa_rule = CFA_REG_OFFSET but leaves cfa_offset untouched.

Fixed in "unwind_user/eh_frame: Add support for reading .eh_frame
section".

> 
> When __find_frame_row() executes, it verifies cfa_rule == CFA_REG_OFFSET
> and unconditionally reads the uninitialized kernel stack memory. Could this
> cause the unwinder to use unpredictable values for the CFA offset?

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +		case DW_CFA_def_cfa_expression: {
>> +			unsigned long expr_len;
>> +			char expr[EH_FRAME_MAX_EXPRESSION_LENGTH];
>> +
>> +			ret = read_uleb128(&cur, end, &expr_len);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (cur + expr_len > end)

			if (cur + expr_len < cur || cur + expr_len > end)

> 
> [Severity: High]
> Can the pointer arithmetic wrap around if expr_len is maliciously large?
> 
> Since expr_len is parsed from untrusted user input as an unsigned long, a
> large value could overflow cur + expr_len and wrap to a small value,
> bypassing this check against end.
> 
> If this occurs, the parsing loop would advance cur by the overflowed
> expr_len, moving cur backwards. Would this lead to an infinite parsing loop
> and a hard lockup?

Valid.  Improved overflow check.

> 
>> +				return -EINVAL;
>> +
>> +			if (expr_len > sizeof(expr))
>> +				return -EOPNOTSUPP;
>> +			unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);
> 
> [Severity: Critical]
> Might unsafe_copy_from_user() improperly toggle SMAP during expression
> parsing?
> 
> Because this parsing runs inside a scoped_user_read_access_size block,
> calling unsafe_copy_from_user() on x86 defaults to __copy_from_user(),
> which executes its own stac() and clac() instructions.
> 
> The inner clac() instruction clears the AC flag prematurely, ending the
> UACCESS region while the outer block assumes it is still open.
> 
> When the loop continues to parse the next instruction using
> UNSAFE_GET_USER_INC, it will attempt a direct user memory read with the AC
> flag cleared. Will this result in a fatal page fault?

False.  IIUC config option HAVE_UNWIND_USER_EH_FRAME cannot be manually
enabled.  Therefore this code cannot be enabled on any architecture,
including x86.

unsafe_copy_from_user() is added for x86 by subsequent patch
"[RFC PATCH v1 19/25] x86/uaccess: Add unsafe_copy_from_user()
implementation".

> 
>> +			ret = eh_frame_do_def_cfa_expression(expr, expr_len, target_ip, &ctx->state);
> 
> [Severity: Medium]
> Is it safe to call an architecture hook inside a UACCESS region?
> 
> If an architecture overrides eh_frame_do_def_cfa_expression() with an
> out-of-line external function, it will trigger objtool's 'call to XXX()
> with UACCESS enabled' warning.
> 
> Executing arbitrary functions with the AC flag set is strictly forbidden
> on x86 to prevent SMAP bypasses.

Steven, Josh, what are your thoughts?

> 
>> +			if (ret)
>> +				return ret;
>> +			cur += expr_len;
>> +			break;
>> +		}
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

