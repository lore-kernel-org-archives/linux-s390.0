Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238882EDD53;
	Tue, 22 Sep 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088230; cv=none; b=dMvGBEuFmxN4FVv4GM7J78qV2WFNInBcXg0LRKgUyF/hKu6IuNyia632nFcnp710WpVEAsdeDBjbZy+70Z9TOywXkBMNKo9M9q0MYX28V5n1+XKSiQOFuzY1jOnO00VbTI3jOrhcuJrVr7NLygeJoBq9pjXJskBCOsSb33QVT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088230; c=relaxed/simple;
	bh=FDHmyForiupedSDf8UB4UpjxG7dMD7eDaD3cclNcaYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3wXbTSXOO6YqefMe5iD7y4bLoqhMJXDMOGYaCp8ez+O1Lzlicb6uK2zFh4JbI3QQcoNMxeuUqQnHIfAl5Ajnlqo+kAPQLDH04S5/b1vzdKNQINs/KRMvyQjg1pDlveJt0g6F27PN4bjZNAFNXPvPk0AmgIeujo+3PJ/m7Io2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QUs2qQm6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QUs2qQm6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBZUpN343480;
	Tue, 22 Sep 2026 14:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dNB1ye
	PvGGXyEs3MYkb8AcguoESTqlTL/OEfMYmyYuM=; b=QUs2qQm6kMZcpck4F9xN/2
	RHt6Sh7xIibzjaqCamrN54bKIU1fxt2pNvhftdhaua2LNNqoNdPYmlB0h//oD+nY
	nlx+IsEm3vappKY0alzWR+7BA1TJI7JwIwBKw7ZR8jOTl5385SHT42Mb00RRJyBo
	ftMmdni2BJGfJ1XFDLQ9fLLiFYYht2ChORSPqk3x+TfS9Bw9KLgBJNhCGRauIVos
	kbpq64jSdXJmnup8bBmfucMBIhuJZhif4T+Ai0j+3ZZIQvQhbmH9yYaKpGcBYVyk
	eNMH5G7JZ1qgQXqdeIQGa7Z4cxRh3w0U3kabOMTb75V4cUv5rUIDVLIm1ilP+Nkg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv629r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 14:43:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBWW1M1521395;
	Tue, 22 Sep 2026 14:43:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkcsc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 14:43:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MEhfRZ51511784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 14:43:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D8720043;
	Tue, 22 Sep 2026 14:43:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37DCD20040;
	Tue, 22 Sep 2026 14:43:41 +0000 (GMT)
Received: from [9.224.95.8] (unknown [9.224.95.8])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 14:43:41 +0000 (GMT)
Message-ID: <3faf0677-d594-4f6f-9aaa-a79aceeba25f@linux.ibm.com>
Date: Tue, 22 Sep 2026 16:43:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf evsel: Improve callchain warning for s390
To: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20260821125538.3721169-1-jremus@linux.ibm.com>
 <ba75c436-ae41-4754-8a73-80e2e5df76e7@linux.ibm.com>
 <CAP-5=fXGKJk6VrWTcdC8iUdhzw6djscJ8SBoJiBgFaPH8TWSZw@mail.gmail.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <CAP-5=fXGKJk6VrWTcdC8iUdhzw6djscJ8SBoJiBgFaPH8TWSZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: CJFABOpHS0hCqFiT0R15lkTMSQNbat_s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMyBTYWx0ZWRfX/I6/3t50Hfxs
 tsE7LduPU4IPMGyOeqaCSrquDKrAXCm6AIMoMqawCXJMs3R0ZLC2dR7+OKta6xxQp/+pK9JgkV2
 yeDf1UVsF5u1rhWaqlhS231rV52qSlI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab29422 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_9HK9EMw26ai-TFMaYUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4Dv9cqK9ukU2ByL5RAudTQaiS_WzQPuO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMyBTYWx0ZWRfX97fdvcHexR8Q
 JYC8dWhfLfkdgqQbL6vqBBnC6bsYEhK96FcqLMn3QYAep9hcT1XfLnp/0wxmpFa4Vq08Dj7VVEQ
 x76ZA+oQ2mtKkxMje6uQBVWsttaG4PCWerYseT+YnAWZ/eqo8Lw+O1//ZBMbYiEvK/OW/+tClpm
 e2TlIEn6vy2zp73zs/+4r/SJdrqPBdPDky0K9OwHzWtaZYuwOHh2AQswFIHFxj+NxOb2Do1tvpv
 ANjzOWm1Cei6esO+tAiNeV7PjGY/suTxg0bJfE9k3NmQiaKWloqLrBU1z0XHDi7mgLETzy2Wq1O
 nqxA/uyv8enTdhjP4jnwAkL9nJoyzHdemohduN/JI+NWnHf1nOOjQ3tRdLANy7AUytsl7d/TpCg
 4iQTEvT6ZAwNKMUN4UomCQA2DyhT8YDl8FJfJzovZsVRLnr3VD+TPlgtN+F+fuLQQgj++Qt4kXO
 rFcl1tZHLPXzeba7E6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220213

On 9/15/2026 9:47 PM, Ian Rogers wrote:
> On Fri, Aug 21, 2026 at 6:03 AM Jens Remus <jremus@linux.ibm.com> wrote:
>>
>> On 8/21/2026 2:55 PM, Jens Remus wrote:
>>
>>> Instead, warn on s390 when callchain sampling is requested with an event
>>> provided by the CPUMSF hardware PMU, because that combination is not
>>> supported.
>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>
>>> @@ -1078,9 +1078,8 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>>>       bool function = evsel__is_function_event(evsel);
>>>       struct perf_event_attr *attr = &evsel->core.attr;
>>>
>>> -     if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
>>> -             pr_warning_once(
>>> -                     "Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
>>> +     if (EM_HOST == EM_S390 && evsel->pmu && !perf_pmu__is_software(evsel->pmu)) {
>>> +             pr_warning_once("Cannot use hardware CPUMSF event with -g and --call-graph.\n");
>>
>> Jan, Thomas, could you please do me a favor and test whether this works
>> as expected on LPAR with CPUMSF?  Time was running out before I leave on
>> vacation.
> 
> Thomas, the change looks good to me. What are your thoughts?

Sent a v3 with updated warning message.

> 
>>>       }
>>>
>>>       evsel__set_sample_bit(evsel, CALLCHAIN);

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

