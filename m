Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD50EADC;
	Mon,  3 Mar 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981214; cv=none; b=Oz3K4KUT1CL3l5psSiAI5jab5mSPIMK3Zhl8ALQG+HwYcw6cUO8Jqc7SFM7clphXNPpJgBVtn43OkSmNlrX5KzrlzbCFdm2l9gCluTzEA1Ug3F08xTPMflQbF1C7SieOvBpf9kIKuPjKDAte/eBtn+yimpQPXjkWtkA2tKClLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981214; c=relaxed/simple;
	bh=0254LXZVFBCKkMBzhrr97R5kQbhbf2qzFiB3WLwWtlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9St1BYy1ZqWXAWlBytHtfS6d1K7+JgmvdfP7LPcYhqKBdfSJP51/6EF14lADmkC4rwkZJqvXKooleFSZlH28/jof3G3EDpRDEBSxyz1gJIV6GFtYtKfLrfaKMoM3ox/arccexeOafazk1ZAQyp31CIyfdswcDYgLCRuV9K6uyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R6zz4mav; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R6zz4mav"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5235UTqw022649;
	Mon, 3 Mar 2025 05:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b4YpM8
	BMW3oUpztSHFHpQSgXKNx45WM8WG1c/FbfQEM=; b=R6zz4mav5sCqIylbjRceuZ
	QYXT1i4BeXy8vlS/Tae4Bz1Jr6kD61wptlHUvbOlXvGMPU+ax6QeNIleKyFGC0Ec
	5xqJQxhAsj1gISTBenln7zfJSOTxCTn4p4JEvDyuJ95s4JwbJq08bGcf6BHfdglJ
	gNdaRd++dQAOQVfnKBNYun/n1G5G3BQI1AI8G13Sw9timVZ0uRr6TezIsBibR/qW
	LtBI9Lh6fhXlS2VEATgE+axLYLWy9FGlSr6vmBvCV5kawpaWfQXsM5FxdDoQFHt9
	dCDFCUIcNG/kgNMqwBXY1vMpdOhl/b09t5zLLRO66ADAFaGs3bpznR2fIk/npdDg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4556b2r3ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 05:53:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5235rTFF008560;
	Mon, 3 Mar 2025 05:53:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4556b2r3e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 05:53:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5235cq2m025181;
	Mon, 3 Mar 2025 05:53:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f91n82s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 05:53:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5235rPW854985092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 05:53:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54C1220040;
	Mon,  3 Mar 2025 05:53:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB13020043;
	Mon,  3 Mar 2025 05:53:24 +0000 (GMT)
Received: from [9.171.20.173] (unknown [9.171.20.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Mar 2025 05:53:24 +0000 (GMT)
Message-ID: <815e95e9-5a2d-4ef7-96bf-321fb57f42e7@linux.ibm.com>
Date: Mon, 3 Mar 2025 06:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20250228062241.303309-1-tmricht@linux.ibm.com>
 <Z8JRC2oSs8i53t_s@google.com>
 <CAP-5=fUqs=mxdgQX0Vx=D0weQSitXh6a8DcW2FycDEk6J-=RtA@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fUqs=mxdgQX0Vx=D0weQSitXh6a8DcW2FycDEk6J-=RtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XPIdWbvf7PhcQG2DToFNozI6uQVvw4bo
X-Proofpoint-GUID: 7KcxWvSpTmg-EZyZZlNKlVJtMZBWUOD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_01,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030040

On 3/1/25 01:36, Ian Rogers wrote:
> perf record --count=100000 -e '{cycles,cycles}:Su' -- perf test -w brstack

Ian, Namhyung,

here is my output using this command:
# ./perf record --count=100000 -e '{cycles,cycles}:Su' -- perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.106 MB perf.data (1080 samples) ]
# ./perf script
            perf   22194 484835.185113:     100000 cycles:       3ff9e407c8c _dl_map_object_from_fd+0xa3c (/usr/lib/ld64.so.1)
            perf   22194 484835.185114:     100000 cycles:       3ff9e408940 _dl_map_object+0x110 (/usr/lib/ld64.so.1)
            perf   22194 484835.185116:     400000 cycles:       3ff9e40890e _dl_map_object+0xde (/usr/lib/ld64.so.1)
            perf   22194 484835.185117:     900000 cycles:       3ff9e40b572 _dl_name_match_p+0x42 (/usr/lib/ld64.so.1)
            perf   22194 484835.185118:     500000 cycles:       3ff9e407c8c _dl_map_object_from_fd+0xa3c (/usr/lib/ld64.so.1)
            perf   22194 484835.185119:     100000 cycles:       3ff9e40b53e _dl_name_match_p+0xe (/usr/lib/ld64.so.1)
            perf   22194 484835.185120:     100000 cycles:       3ff9e40890e _dl_map_object+0xde (/usr/lib/ld64.so.1)
            perf   22194 484835.185121:     100000 cycles:       3ff9e408904 _dl_map_object+0xd4 (/usr/lib/ld64.so.1)
            perf   22194 484835.185122:     100000 cycles:       3ff9e40369a _dl_map_object_deps+0xbba (/usr/lib/ld64.so.1)
            perf   22194 484835.185123:     100000 cycles:       3ff9e413460 _dl_check_map_versions+0x100 (/usr/lib/ld64.so.1)
            perf   22194 484835.185124:     500000 cycles:       3ff9e40b53e _dl_name_match_p+0xe (/usr/lib/ld64.so.1)
            perf   22194 484835.185125:     100000 cycles:       3ff9e40e7e0 _dl_relocate_object+0x550 (/usr/lib/ld64.so.1)
            perf   22194 484835.185126:     200000 cycles:       3ff9e40e7e0 _dl_relocate_object+0x550 (/usr/lib/ld64.so.1)
            perf   22194 484835.185127:     200000 cycles:       3ff9e409558 check_match+0x18 (/usr/lib/ld64.so.1)
            perf   22194 484835.185128:     200000 cycles:       3ff9e409894 do_lookup_x+0x174 (/usr/lib/ld64.so.1)
            perf   22194 484835.185129:     100000 cycles:       3ff9e409910 do_lookup_x+0x1f0 (/usr/lib/ld64.so.1)
            perf   22194 484835.185130:     100000 cycles:       3ff9e409b1e do_lookup_x+0x3fe (/usr/lib/ld64.so.1)
            perf   22194 484835.185131:     100000 cycles:       3ff9e409894 do_lookup_x+0x174 (/usr/lib/ld64.so.1)
            perf   22194 484835.185132:     100000 cycles:       3ff9e409558 check_match+0x18 (/usr/lib/ld64.so.1)
            perf   22194 484835.187445:     100000 cycles:       3ff9e409ad4 do_lookup_x+0x3b4 (/usr/lib/ld64.so.1)

The difference when using counts instead of frequency is similar. Most of time the numbers are identical, 
but sometime they do not match.

Using task-clock as event, I have similar results. The counts vary a bit, but the numbers are pretty close.
They vary by just a few hundred at the most:

# perf record --count=100000 -e '{task-clock,task-clock}:Su' -- perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.016 MB perf.data (246 samples) ]
]# ./perf script
            perf   22223 485235.378380:     402070 task-clock:       3ffbed874c6 _dl_map_object_from_fd+0x276 (/usr/lib/ld64.so.1)
            perf   22223 485235.378380:     404640 task-clock:       3ffbed874c6 _dl_map_object_from_fd+0x276 (/usr/lib/ld64.so.1)
            perf   22223 485235.378779:     399960 task-clock:       3ffbed888de _dl_map_object+0xae (/usr/lib/ld64.so.1)
            perf   22223 485235.378779:     397689 task-clock:       3ffbed888de _dl_map_object+0xae (/usr/lib/ld64.so.1)
            perf   22223 485235.378879:     100055 task-clock:       3ffbed8e7e0 _dl_relocate_object+0x550 (/usr/lib/ld64.so.1)
            perf   22223 485235.378879:     100100 task-clock:       3ffbed8e7e0 _dl_relocate_object+0x550 (/usr/lib/ld64.so.1)
            perf   22223 485235.378979:      99981 task-clock:       3ffbed895ae check_match+0x6e (/usr/lib/ld64.so.1)
            perf   22223 485235.378979:      99876 task-clock:       3ffbed895ae check_match+0x6e (/usr/lib/ld64.so.1)
            perf   22223 485235.379079:      99950 task-clock:       3ffbed8974c do_lookup_x+0x2c (/usr/lib/ld64.so.1)
            perf   22223 485235.379079:      99957 task-clock:       3ffbed8974c do_lookup_x+0x2c (/usr/lib/ld64.so.1)
            perf   22223 485235.379179:     100051 task-clock:       3ffbed8e7f0 _dl_relocate_object+0x560 (/usr/lib/ld64.so.1)
            perf   22223 485235.379179:     100004 task-clock:       3ffbed8e7f0 _dl_relocate_object+0x560 (/usr/lib/ld64.so.1)
            perf   22223 485235.379279:      99933 task-clock:       3ffbed8e7ea _dl_relocate_object+0x55a (/usr/lib/ld64.so.1)
            perf   22223 485235.379279:      99952 task-clock:       3ffbed8e7ea _dl_relocate_object+0x55a (/usr/lib/ld64.so.1)

Thanks for your help
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
