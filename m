Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1A38C413;
	Tue,  7 Apr 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544668; cv=none; b=fC1QwqF+ZnDy5vAphJhK9CQ5L/Lh3ULD64t8UHWlRhcsef/ATs9SiajH23s7i+wRXPYhgYyj5EKgvkHyYuriWJcxJ02rDCyzzMFIM6kSNxzTBbLJxEpKfuOjf/4AG1tMSDKJRY1rxS3DYoTO9K05uboHzevcWcichgIuP0+Y+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544668; c=relaxed/simple;
	bh=CvNOpL4D8h9Lb/nMK6S6jOgxO7Zj7e7VBQUDPFb9hrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC6ClfwR+UzUDIJPvi1yaGLaWuuVHujy8iS+yiB8rlZQyvtV0iBwxWMfDQzWNC6jgn8uRdSx205sSYjbiF/ryI2+wjzNFT6qzZRMnmqUTPnD7qeCIhR8XeD+I/AS3wb0u4c6gZtmEyGbwhRwNM19ZqS4DXdSm0EYdQd40PTtPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HjGM028e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HjGM028e"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Lmg1E2298432;
	Tue, 7 Apr 2026 06:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0PLo+x
	7hpOA1kun8cUnCjqKjwxlbjCqIAeZUgo0WtVk=; b=HjGM028e0PLnc7RLhywXW7
	7YXVBjkLF0XZIi/v+4sra2Nc6GBGe9sAgz3tvA3A2QPiJimHcq3TPTn2pvqiazp4
	F22S5T861WDdKHvalmcspvm+a5i9yCd6dXG+Qv0VJFFJ41WrUKTKd/0ArXumihlh
	2WBtUPriqHgovVEPiJlvLsojslMCs/0VoYDi210qWyrt/7sNc5hCLpOZ9nRX3BPE
	pFbUvnsBcKrtLUQ0bsjlsVjnZbQ1o/G3yQX6hdlYatbMgmwPsvQ3T/tYm4f8jtdq
	nlqQPW8hfRIVlCT3yrgRK+MtxSP5uR6+1SoY8H+yrsuc4kJKiQaVENQA2XC4WKUw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fsctp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 06:51:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6373GYp1014423;
	Tue, 7 Apr 2026 06:51:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4hcx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 06:51:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6376ovKp54395208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 06:50:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAD3120043;
	Tue,  7 Apr 2026 06:50:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8013720040;
	Tue,  7 Apr 2026 06:50:57 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 06:50:57 +0000 (GMT)
Message-ID: <2718d162-2c51-41ce-9830-81366a1034e2@linux.ibm.com>
Date: Tue, 7 Apr 2026 08:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf config: Rename
 symbol_conf::disable_add2line_warn
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-2-tmricht@linux.ibm.com>
 <ac8hBOjxhiX-VtCl@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ac8hBOjxhiX-VtCl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4a956 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=HVa9FsKFN9bTpKEVuYAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Os7YLxiw-sBP2qKl-19vQnEXIXQXHquj
X-Proofpoint-GUID: Qv3YxxC5VGvs6NDebN1bxTtFsTTzzCIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA2MSBTYWx0ZWRfX0tEinP6CaDh6
 SN7zfQi9RAbm+lYAUkgmf9JNri6sUcdYQ2avd7G2+WO91yYW0BDEY8qKTssa8mzdRS4sqv0rIpt
 5h+V/0ApuGD2NU9glPTABfRL+KyaWzRBocn5ZszoaxmUsBonmb0KfCDIE3c/UVG9YkrktGAOMvF
 3rPYPuFc6yqgvsPuw79v91F4yyLzTG7Y13ve8VAwfcK4t73eZelpeHpA2LLzJQ2bgendHrOcVz1
 GkVI2dDCC1iPTAJKGfkcp9QqjD7oVc/LRu6pX7xBAz6hTxWzkAGml72Qs9T4YrnIiVUfhDzoEWA
 b2WjAqBNSp5V1N8LQdCW7XeBAfF9Z3ci7/BY2JiAib8a25z0Ej5rtA8bbBAuBeYnmt1BP+707kr
 7e/t34C5gSZ1BZ6eueS1ydeDl1oLXS/N04tMuOi7/XPAeRq+ZZFy9pbyeL7hK7eXF74Tal28tTO
 mlavsg6ZfrfTivA8QVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070061

On 4/3/26 04:08, Namhyung Kim wrote:
> On Thu, Apr 02, 2026 at 10:01:57AM +0200, Thomas Richter wrote:
>> Rename member symbol_conf::disable_add2line_warn to
>> symbol_conf::addr2line_disable_warn to make it consistent with other
>> addr2line_xxx constants.
>> No functional change.
>>
>> Fixes: 257046a36750a ("perf srcline: Fallback between addr2line implementations")
> 
> I'm not sure if we want it for typo fixes.
> 
> Thanks,
> Namhyung
> 
> 

...snip...

Do you want me to drop the Fixes: line or the complete rename patch?


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
