Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0A266EEA;
	Tue, 20 May 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732915; cv=none; b=kYA8RRuHZXx4xUCK8U567UM9GKhWlsyuHHrl7qPRIj3a8gy4Vu9b5AnrMBYsw0kN1EqnUMVOR2csl5YJ3x8fexgnR+r5X5MMT5pzMc/2gdkYmI2ijIlZwKDB0QcqBYHHZhq5Oogr7KqT9d9rT9CFIPut4oDMYnx4s/xQTtVtirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732915; c=relaxed/simple;
	bh=nRck76upIrqayF48r0JMEfKggSJcdZp1u2tGZS16wqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6i8eqIGnAkYIAiywQqGxubfd+1dWDwZ/QRxr80+PWbYRHnl84lVt6mm2RrTU5kdIZ1BtfWCOahSsBCvW/d1uw6xqFo10id8FQ8mgYDJZnedNMu5gEBcLxAbYcMv0J1+G7H0dQnbvkMPuLibTnmJjeVIRmjIqJkrwvdw4+YtJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JGbX0jbF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JGbX0jbF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7K1NC012077;
	Tue, 20 May 2025 09:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m2Upju
	Q/5KwMg+65JZtPR4E0vx7qlZD6xAt9dld09JI=; b=JGbX0jbFVwGCRv0iByTjJW
	kVSzg+KBv3LpDWCKR7tviyfCr12E+nFR0y+G4a68Haf9vTqx1BulUOCHtXQsEcmf
	H8w4h5Pj+lzN5iAfyH/TJGUkcNszJS3e/MKmVZaMZlDJqesbrFQ+xFJhmrm4Bhdg
	iRCrKUTqleaxFSlNti10cHja6JtmKMlUTM/A7F9ICW4q7/i+Wtu4laOfRueN0MDq
	WgcA9yy12xTnN6gqTEgj1xMU6KZ6IirqxgWfCKjV/P1qsxDtmuDG5yLN+6Tv6Xfq
	4EuQ3eiVFTo05O5XxPTBoI7vdB1LVZUCI/0QssYN20jTkUaxZ42RVX1rGkGDXvwQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rab734y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:21:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K87GZX015958;
	Tue, 20 May 2025 09:21:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q7g2aspj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:21:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54K9LdJl55705870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:21:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACEB220244;
	Tue, 20 May 2025 09:21:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C52C20242;
	Tue, 20 May 2025 09:21:39 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 May 2025 09:21:39 +0000 (GMT)
Message-ID: <1660a81e-e057-44d3-be99-ec91fbf512e7@linux.ibm.com>
Date: Tue, 20 May 2025 11:21:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf ftrace: Use process/session specific trace
 settings
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Alexander Egorenkov <egorenar@linux.ibm.com>
References: <20250519145235.56006-1-tmricht@linux.ibm.com>
 <aCvGF547Y3eteLRK@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aCvGF547Y3eteLRK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=682c49a8 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=uxB-eVp_abppLh5YTSIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XvjZbF10tOtyVpdm3aWD2c0FeYSTQV1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3NCBTYWx0ZWRfX3ckwVGefrPpf as27ZneEG13UyW1uUbXzpVs7aKQeK+Rhq8AWD4fwE/woXS/SDZqRKbA9fX05fQqGBdGKh4sUbDc Ul8v4tHxQBYJdsHkudyLaK/+vCl6GoAhOIAbcw5f4z2IEF0Q1509z/tfHPQZJlczTp1NTeb0Nn3
 XiFJCXgzkqDmS2zij7aOWx66hkZa30SIujhABjl4eHQ+c0/vDxPFPfQy1uJuHcMrYicU1hXFmMn /K5vC3XGe4MndrPN9EXcp8Ba0g6WflcmbjGIubx++RtRmoeArVWvqR0ALt4zNUjvcbBuCQVvGiw IfbQYnwkMOPHn8kTGoD93Yhk4/zYd6hynxWUydgGUdhWdnxjOXQ/aU+apdq0K/Jc2Gp9mE/+P/N
 0YMqTFx7uBvolq+b6vqzQd6w+zfQR0bU/MW/0OiDk6rMNgyW4c/G6fuzFxuxkW3f9IfQO4Qe
X-Proofpoint-GUID: XvjZbF10tOtyVpdm3aWD2c0FeYSTQV1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200074

On 5/20/25 02:00, Namhyung Kim wrote:
> Hello,
> 
> On Mon, May 19, 2025 at 04:52:35PM +0200, Thomas Richter wrote:
>> V1 --> V2: Add Suggestion from Arnaldo Cavalho de Melo confirmed by
>>            Steven Rostedt. Use rmdir(../tracing/instances/dir) to stop
>> 	   process/session specific tracing and delete all 
>> 	   process/session specific setings.
>>
>> Executing perf ftrace commands ftrace, profile and latency
>> leave tracing disabled as can seen in this output:
>>
>>  # echo 1 > /sys/kernel/debug/tracing/tracing_on
>>  # cat /sys/kernel/debug/tracing/tracing_on
>>  1
>>  # perf ftrace trace --graph-opts depth=5 sleep 0.1 > /dev/null
>>  # cat /sys/kernel/debug/tracing/tracing_on
>>  0
>>  #
>>
>> The tracing_on file is not restored to its value before the command.
>> Fix this behavior and restore the trace setting to what
>> is was before the invocation of the command.
>> On Fedora 41 and 42 tracing is turned on by default.
>>
>> This patch use the .../tracing/instances/XXX subdirectory feature.
>> Each perf ftrace invocation creates its own session/process
>> specific subdirectory and does not change the global state
>> in the .../tracing directory itself.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
>> ---
>>  tools/perf/builtin-ftrace.c | 105 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 91 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
>> index 7caa18d5ffc3..3faf96e7185e 100644
>> --- a/tools/perf/builtin-ftrace.c
>> +++ b/tools/perf/builtin-ftrace.c
>> @@ -38,6 +38,8 @@
>>  #include "util/units.h"
>>  #include "util/parse-sublevel-options.h"
>>  
>> +#include <sys/stat.h>
> 
> The standard header files are placed in the above.  Let's put it there.
> 
>> +
>>  #define DEFAULT_TRACER  "function_graph"
>>  
>>  static volatile sig_atomic_t workload_exec_errno;
>> @@ -45,6 +47,8 @@ static volatile sig_atomic_t done;
>>  
>>  static struct stats latency_stats;  /* for tracepoints */
>>  
>> +static char tracing_instance[PATH_MAX];	/* Trace instance directory */
>> +
>>  static void sig_handler(int sig __maybe_unused)
>>  {
>>  	done = true;
>> @@ -100,6 +104,34 @@ static bool is_ftrace_supported(void)
>>  	return supported;
>>  }
>>  
>> +/*
>> + * Wrapper to test if a file in directory .../tracing/instances/XXX
>> + * exists. If so return the .../tracing/instances/XXX file for use.
>> + * Otherwise the file exists only in directory .../tracing and
>> + * is applicable to all instances, for example file available_filter_functions.
>> + * Return that file name in this case.
> 
> Not sure if it's needed.  Can we call get_tracing_file() directly for
> the global files?
> 
[SNIP]
>> +static char *get_tracing_instance_file(const char *name)

Not really, some files are not available in the tracing/instances/XXX
directory, for example 

   ret = read_tracing_file_by_line("available_filter_functions",         
                                   list_function_cb, filter);  

That file is not created in the instances subdirectory:
 # pwd
/sys/kernel/debug/tracing
[
# find . -name tracing_on | grep -E '(\.|foo)/t'
./instances/foo/tracing_on
./tracing_on
# find . -name available_filter_functions | grep -E '(\.|foo)/a'
./available_filter_functions
#

The easiest approach is to always test for file existance in the
instances/XXX directory first and if it is missing, fall back
to the tracing directory. Otherwise the file location has to
be known by file name.
The other files which are not created in the instances/XXX subdirectory
are
  max_graph_depth, tracing_thres, set_graph_function and set_graph_notrace.

Hope this helps.

I will add all your other rewiev comment and submit V3.

Thanks a lot
    
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
