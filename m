Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51D3A6B69;
	Thu, 19 Mar 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907403; cv=none; b=Ca9stXN9mIAk84wEt7PQWyOXjIC6+kFxLnR4eY39Q2C6ov1UV+/ok4c0/NNwkyWsWfmUqBzK/IBL4bi2320dz/ddMQATnOyCoe3puo3qBrhR3E2zWJqcFMnsnYywkyNVGbl2PHAAa3y75ZeItobcmHJJIenQYQxr4tTggiUD6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907403; c=relaxed/simple;
	bh=0lMcK1G13URdOHMqqvm29DLiAbebQRZTs4sa7qHc2kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkVi/DiNI4KhqG0qNfB1i0ny3SVCiJJJ3j2EUlrVhIPZuSTEYNzrR7ewYFMwB7ZoEi7m9Y6j2z+33I4iGgnzJAqWSR+9/GvFJZ/IQpEOoYy6Ij7m2cKOoQ+3bm+BLg5rbYnorZbo7CluOQXoCunC2t5bR0418rMyVSt+i854uWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SS5jVr57; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SS5jVr57"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IHTnlj4170117;
	Thu, 19 Mar 2026 08:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oNwFG8
	9J8ppDVm3xVChqx+jOUkoyqA9YH+RXGEmfr+M=; b=SS5jVr57EUp5ge+RvMRCgU
	XxTvtQocVwEp4Qi61FdQbobmNG0wbNW9WBxm+4if934VJL3WOjYNQnxnEkP+G3QH
	59wPwF2wpWn7BLaqUnk2//KX+i/0mePxZkGkyvV7GVCTDAz0L9N43/3wuL7h2xX/
	vOEgZOAikAJXnWa6bjnFl60AefLxXZGypG0/j1Kk0fswVHFQSEQc5nmvaN2W4UxR
	kx0NxbSCdUsPT5WXbdzZNbqPp2QRUb1fDX6uaztE3XleCXYUtVAXVGR3h00cnETE
	aTnWZFrSSFlp1IEt0Jf6ZpKEdrFZv+Dn11vQNMtnA4A5Z6XSLhP0WvuDvTSk57Cw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaun5fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:03:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J548US028496;
	Thu, 19 Mar 2026 08:03:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1hbhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:03:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62J8304Y42467818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 08:03:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ED4220089;
	Thu, 19 Mar 2026 08:03:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF16920083;
	Thu, 19 Mar 2026 08:02:59 +0000 (GMT)
Received: from [9.111.17.237] (unknown [9.111.17.237])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 08:02:59 +0000 (GMT)
Message-ID: <5e2f413d-2b09-4d27-9ab2-7936c91fc52d@linux.ibm.com>
Date: Thu, 19 Mar 2026 09:02:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] perf evsel fallback changes, better s390 defaults
To: Ian Rogers <irogers@google.com>, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        sumanthk@linux.ibm.com
References: <20260318175808.582009-1-irogers@google.com>
 <20260318234600.730340-1-irogers@google.com>
 <CAP-5=fVWNP-fpD6bCWBKNDnwcMkYwZcvkBgqGjTJJ0fFQko89g@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fVWNP-fpD6bCWBKNDnwcMkYwZcvkBgqGjTJJ0fFQko89g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA1OSBTYWx0ZWRfX7/3ze4TfUfg2
 wqTXw+etkCuv6pGTb4CedZTLxiuRUCyDdKkLxJZZBvLXN3ODiJd4X8owFVEXviYCv2B4tdpSTsV
 eDVGtJYpQ6aQicmGgEHImXRPt+ZzTcj+fRPw2p842Nink9M/TAEHFpKpafIkHOlIz1sRxi51Tfl
 Laoigc5R6rPSTUV517meS9f7T7rYl9L+UiCilr7jzUTztZy5LS8zotcORDpC0AGDVFD7t9+/MEU
 BWSuX7Qrn8P25I136jdUZjHVzxUEBzlCB/RkkN1EZFrWA8dxANf6g+zNHUyYJxMJfaubMTnyaFy
 w9kUYknOt7/7eETUmn+0TmdBPjl8Cmw72GhfjHQxb5M+DZz5s5hXs63L3WwhvrTB34rc53ypeUx
 PDezNYkN67vgvti3WxICT/EqBxZeOCAbjYRaAaYgRfx46uokjqZ4H5v7IJZhIoq5AM37VcX1Q8j
 8LxLTm/5q/iZX4QgAng==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bbadb9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=gxYhOCFLj5_Kw6bs89EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 8soTQZDNh53nbBe9-D4EcEAvZz6DtjQq
X-Proofpoint-GUID: d85SBiPiGl-LBljQPpZQmtKWofIYN0Gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190059

On 3/19/26 06:39, Ian Rogers wrote:
> On Wed, Mar 18, 2026 at 4:46 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Discussion with Thomas Richter in:
>> https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
>> showed that the evsel__fallback wasn't working for s390. These patches
>> avoid the problematic frame pointer callchain on s390 and fix
>> evsel__fallback from a range of problems when falling back to a
>> software event. I simulated failures when developing the patches but
>> they are untested other than that.
> 
> I think at this point I call it a day. Sashiko still has feedback that
> could justify a v9:
> https://sashiko.dev/#/patchset/20260318234600.730340-1-irogers%40google.com
> Specifically:
> 1) software PMUs may fail if sysfs isn't mounted. This isn't a real
> problem as "software" is a "well known" PMU that we create even if
> sysfs isn't mounted.

I totally agree with you. Patch set 8 should be it.
Honestly, if /sys (of sysfs) is not mounted, I guess perf tool is the
least of the issues that arise. I believe this is now getting 
'over-engineered'.

> 2) the handling of callchain in .perfconfig files isn't right, but the
> patches aren't making it any worse. I worry there could be several
> more patches if I start fixing things wrong with .perfconfig.

Correct, you can not fix everything in one patch set :-)

> 3) the possibility to add another NULL check for safety exists, but
> the code would already crash at the same point.
> Apparently, the tendency of prompts to generate further refinements
> instead of providing all the problems at once is a known limitation of
> LLMs and the current prompting methods.
> 
> Thanks,
> Ian
> 
my 2 cents.... 
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
