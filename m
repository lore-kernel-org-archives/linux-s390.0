Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9ED38F253;
	Tue,  7 Apr 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545143; cv=none; b=Exf9ke0G0oY9TwYk1q+U0okv1k4eNgZDHwsTtJxG4asAU+fWXdWc6GfMCix8JsNB6UpsS7WlY9qCOtws+x/R/S+dMZZWA1e6rYZQ9Slqnjw3JDQNL5bR6Emg8S2pB9nsYLN5SCwnqMP1G4JfWRsI81WbMJi4o+Ru4WkFKjQfZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545143; c=relaxed/simple;
	bh=Zl2KGHr71SXHfRTmltydIcmQJPAgVIOL4fQSgy47B4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=St+YkIOB6qiptSvEq7koojs1QxiZlT57wSYtmnpd8xgvNCa092w8+fUR1lt/rNVRUYYX+mMb0d24mCZp8miWLXg8XCejwtw6u7Yilna9I2HyNqNdz15LFys24p9fIUQscaDOcqSnFewKqhbA1nuNu1LDv5S4mTmz3E8ZPLDgzyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gn045p/G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gn045p/G"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LqGLw2304658;
	Tue, 7 Apr 2026 06:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oelPdH
	u8xwTgKKWMMKApPeX3J4qLoN76w/9CaGZCYDc=; b=Gn045p/GV/8gUtNsvyVRvd
	706pEiycXjscRCJzH/HlEDtENl9jD+f2zXpmBjxwGlmsTe8a8PlX52n9SGYiIZvI
	bRCsotef6dvDUyx17WrhJ3jRXJNk8lSh/Bd2XAH34eabh4N6FaQGW8YQzu7K2lil
	8zHR6346HdzpObiDQB9Y04Z1vpET2+IBkrqHJF2vmNWBNP579sRGMsGYRqAbgyTx
	rDVslg/ruFOwrpf8TqRbRgdfvneoWUvuX5xAgEmLlaGDeTXAulzErOcm1SYejMe7
	UP2akX886llEDZzmMGCNyzOf5U8/O0OeKWevq9cuNBJnhwe+Bac4mDzMGyRwYsVg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fsdm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 06:58:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6373IWIa026642;
	Tue, 7 Apr 2026 06:58:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7sdd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 06:58:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6376wsgM7995710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 06:58:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D00F820043;
	Tue,  7 Apr 2026 06:58:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99EB220040;
	Tue,  7 Apr 2026 06:58:54 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 06:58:54 +0000 (GMT)
Message-ID: <72f255b9-8480-4e5b-be42-b8a185e4c5dc@linux.ibm.com>
Date: Tue, 7 Apr 2026 08:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf config: Make
 symbol_conf::addr2line_disable_warn configurable
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-3-tmricht@linux.ibm.com>
 <ac8h9ypRe4nHUu5q@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ac8h9ypRe4nHUu5q@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4ab33 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=ODCnDn2AmzKCEQmdJIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Mruthb8xdHDLQdHHz1e9WbWvhq_QxQrI
X-Proofpoint-GUID: F347zEmG0_gJfk3RdzO8WTvZ51EVZjpx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA2MSBTYWx0ZWRfXzZAjk0Cdp8rK
 D52zBE1osyTj4Y8nxDiuAUvZnGU5A1uG2lD03HwVTp29fwiLG/GTHU3XQnGfTE3sV4YdUR/oZeP
 r4p2QUuj3xaJOP5h2fkh1RZLCDH4Ah9TEJ2Ucp7I/ek3XEVz+8X3dFgzhhKIZ2Tbqkq9xeTxpev
 +KAstFwKhSKZrPXZLU91UtsuuJsWO8hhOJzdHCJne0AxGyDp3CO7JL7tHvLmsh/rgm1Wwtht8nE
 jD1O0SvvEYnDpBS0X8Yz4zfBmBBS+7DAL03KVOYh0vlstCdQLIFpcljsU6EVXoa0es9si3fHQX0
 FSwrr1mDe6izf1NPj51S6IMXq87CQTVNZ5u1gav9zSSebHxMy66kzquVHZsdt+cxGglQ2RlQamt
 Qqn1V6EVUUv/V2SZBm+uYM+N6qch+89Ur7jQKFbP7YBMBJgb0n1MThQtAgebrrnPpWWTMeBkacF
 EQHzJHPSidjsDPOg8WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070061

On 4/3/26 04:12, Namhyung Kim wrote:
> On Thu, Apr 02, 2026 at 10:01:58AM +0200, Thomas Richter wrote:
>> Make symbol_conf::addr2line_disable_warn configurable by reading
>> the perfconfig file. Use section core and addr2line-disable-warn =
>> value.
> 
> I think it's better to have it under "report" or something.  But it
> seems we already have one in the "core" section.
> 

...snip...

It was added to the core section of the perf-config file by this patch:


commit 701677b95764 ("perf srcline: Add a timeout to reading from addr2line")

submitted by Ian Rogers in 2023. That is the reason why I left it in this section for
backward compatability.
We could also move it to the annotate::* section. What do you prefer?

I will add the other remarks in the new patch v3.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
