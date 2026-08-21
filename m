Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6E3A6F00;
	Fri, 21 Aug 2026 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317409; cv=none; b=FtxgpkcI3NaX3P4blOZaz+fqb42RPYiI2MRoJLXKYmXfxkxWdcnP65KxOuUQGjDOoxIMJa/fgRKXs8nQZfbawLKv3pXigkdmA8pYRsdeIFIke25Jnk4MZPDkF+eoc5j1WznZdXxhfXqF0qPKk+2bwf7QsWyA07Zac9LC3W6XtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317409; c=relaxed/simple;
	bh=XcxbcfIfqBY7DCgZWLfmaxtYrCCLex52s9UYhhdI2u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGLXNpmKjKvN7nCVwcqkIjEP+j9s2hZLdQVzi17McXRix9v/uPiMVL+yB80kj7VBVxdFOv5ye8oMhJum4el2n3UD9IKf7M6HJ6NSxV+ZGO6VpZR8groRRkp37/dh/sFIm92pfoSb3Rx4iBTQQ/yuFoKqArqxXxUnCw2mF72vf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cB0k1PK5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cB0k1PK5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1mnt1586053;
	Fri, 21 Aug 2026 13:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yg/Nzv
	fk/ncbyS3QORi/QhRlElzDhW+xXXf/YPaNtVk=; b=cB0k1PK5Tw/ytbni9fZGhw
	vamSf91jRz4d1TUKzqZOFQOpv18NyqNsafJOchsgL8jiAIt+WF5Y29knGNxSFeSj
	jPCQuBbn+EQBeNGpQrl1abjVll1I2Qk0QGs8Lwkr+z7GNJfer1uXALz/L+3tNucF
	BoCAfQHDXmk4QsrW/likx73+SKm6e+egpt31ZwbDhTMk6V4h872TUn56fiVbso/P
	lUpFDjoz6+g1lPtY3whwdynI9bnGiloeIxdeopJCV3MLYztrwy2zjkLNpoYlt1Re
	6iXd2N/GJNxQ31tqyPkThnNdZqC9OEvM+jjAXTTzuVoZ0uxj3AmGEqs83zDCkoMw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0sna8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:03:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCv0qq010346;
	Fri, 21 Aug 2026 13:03:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekmr9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 13:03:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LD3J0H52101418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 13:03:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CCA22004D;
	Fri, 21 Aug 2026 13:03:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9044B20043;
	Fri, 21 Aug 2026 13:03:18 +0000 (GMT)
Received: from [9.111.132.152] (unknown [9.111.132.152])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 13:03:18 +0000 (GMT)
Message-ID: <ba75c436-ae41-4754-8a73-80e2e5df76e7@linux.ibm.com>
Date: Fri, 21 Aug 2026 15:03:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf evsel: Improve callchain warning for s390
To: Jan Polensky <japo@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20260821125538.3721169-1-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821125538.3721169-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a884c9d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=vbp_ZNB3HVLcW2xkOEsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fQtVoxtMkHcAzoqUCDjy1wY5-Ser8JRG
X-Proofpoint-GUID: SqtHRN2ay7uTkgByVe1SVAcpgclKaqRa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwMCBTYWx0ZWRfXxdcl1ZjHdoa9
 xK9gcBJSdzlYKrWfH7z9ynjEPsXOuLyZ5MZA4+kjxE0cALCmZmdi/jA18ycEt4c2xd7jd9GHYVf
 k3i+U+uKWGBvw59JEqW0uaMTQ7lybqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwMCBTYWx0ZWRfX0TzDL5IVQX8H
 Hg9C03vFkhYqqutOawpmls/LGq70HDzJq/v5Biw2E+GkMqQqX7riaIDYNfddMypn7JHTf1GYl7N
 EvUI5MigAm+7JV/VFwiTZu7TDCxl3YyyypKYOQ/1M2t5FFW+6D9qceRLWDOgcsb1eQtetoawqCv
 Bd3wj49MIBq0OAtDMHBCOZHlO06jwzwEhtopkV/3Soq94SN+mSGgM9M4HmpVQVfcqrO3MrZLGCb
 l7Jx9zUry8mO4Pdn+NgRPhtc+2QogxiGUHs4KR7P4QRNwf0sL9OY+PWaw02nDN0yygbzKfvp557
 A08Xofqp8wyIsHEYo5tgUXWjTUyzc3blohCdlzn9AmONyjBHZNi1ee560fgPJAo0IQmduwSfkEh
 UNfAWgAs/+Mq4mtvc3uRGmHN+pogfjIet/wMzDxvy4NNpgRAF8SGPBrAkGMT8hQE2WfjZC/hZq3
 N0mfZOBoGkSmrZZbsGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210100

On 8/21/2026 2:55 PM, Jens Remus wrote:

> Instead, warn on s390 when callchain sampling is requested with an event
> provided by the CPUMSF hardware PMU, because that combination is not
> supported.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c

> @@ -1078,9 +1078,8 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>  	bool function = evsel__is_function_event(evsel);
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  
> -	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
> -		pr_warning_once(
> -			"Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
> +	if (EM_HOST == EM_S390 && evsel->pmu && !perf_pmu__is_software(evsel->pmu)) {
> +		pr_warning_once("Cannot use hardware CPUMSF event with -g and --call-graph.\n");

Jan, Thomas, could you please do me a favor and test whether this works
as expected on LPAR with CPUMSF?  Time was running out before I leave on
vacation.

>  	}
>  
>  	evsel__set_sample_bit(evsel, CALLCHAIN);
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

