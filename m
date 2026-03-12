Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3228507B;
	Thu, 12 Mar 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319539; cv=none; b=ZZYdbMui9ZlPUjzViJZUc1Rwsj6vYMepB45TNkW5TqL1UKyed/qE8ru9vLodCuBPH422d0LYdVM2LWouZ4yEITByWLj157rsziUr5C2tsD2TmATbSXr2Iz2AQsVjylLdy94MM3I3NSrfAa1JQV6Od6JJ0aMV0amU9PHbPNJPUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319539; c=relaxed/simple;
	bh=rTDT2QgJB+eUrqse4ML69yd8QtkW5P7Bi5VU2mk4JJ8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=cIohXETB3X5m12yVtX/X9pyzH+FnDGXEhbiZll8b8fUjrE6RucfG+tvssVJ53gXbAFS38sGn7TRzST8JJD7I5aHFyqDUOGRSJDEltuijkN9qear/AzPgXu93syecWotFDqnOnQ4KI25bHDnG50nLk3B0+l4G5lj5hpfmJcmMFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NKbuQ3Nz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NKbuQ3Nz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMXR3L2281597;
	Thu, 12 Mar 2026 12:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ynFUcK04aAp9iIR+uee7O5zyqdxP+n
	vcFEZroIL+0Rc=; b=NKbuQ3NznNSjbAgETKAENzqc+8OfoESsWrFlb5qvMI8wD+
	rMy+ZNxGmwJKz/2axgDQERh2I9RVfTZUwCuWGoBq7ZbcbDd2bng6KnUZbErlczpp
	FQBv6Mnvd8jIZDlbnBuscf5gskfTp9cWX9dPOjRjcJ7jVeptwtggh7frInl+uQTR
	VTpl3Tqln6QP68UqZUc0Js1wbbJLoZgB7mzcqp6qM0sUNMFKaZNGibs41wZg4TOR
	w5QLO/BFs1A55ZK84TJK877jXR5MAzTVeWEeFCppG4V9CMZmjRbVrVsh8d0RIH14
	mkhyN3d4yhu/18AU31Dakv8TcccZVgPw+qHaG4xg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91jpw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:45:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9OPd7025674;
	Thu, 12 Mar 2026 12:45:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8abar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:45:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCjUxj52035944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:45:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B83A420040;
	Thu, 12 Mar 2026 12:45:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D33F2004F;
	Thu, 12 Mar 2026 12:45:30 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:45:30 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------xXUn209Nx2rfMjen2Uut601r"
Message-ID: <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
Date: Thu, 12 Mar 2026 13:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf evsel: Don't configure framepointer
 callchains on s390
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        namhyung@kernel.org, sumanthk@linux.ibm.com
References: <20260312031928.1494864-1-irogers@google.com>
 <20260312061628.1593105-1-irogers@google.com>
 <20260312061628.1593105-3-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260312061628.1593105-3-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iKJob_BonqqusGzZZz2lAQxF4VCmYKN2
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b2b56f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=1XWaLZrsAAAA:8
 a=9SBzVrqZk0vsA-ejMuMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XCyEH9WiKkoFSUuY7REA:9 a=B2y7HmGcmWMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5OSBTYWx0ZWRfX9GbyyH+2nOOv
 Wj5js3O+fEMZatNQlpfOTZdwlqQz8rwB7HHRfZT6Go3j48a/a2KIVj7wvm68MAYRALrTBdhO6v6
 IYpFEeEVm9NNieMAzFd5kysT5+WoVLe/f0P37sJM2RIyASMQ+MUlibEVh5yiurgGNGrE4d3iy+D
 QzX4lHWNgy3oa/th+Aq/zU+jYrzPwN2MnPj0ucs4GeOnHAwThbIKpqf6Ze4mh72bvm0DBjOVrwz
 Jfx9bsQxwZxNptj84XO8wPVNswLbTkB9Mj2Hldyw4rdyG0/t1XF2T3kPLNZZyiWPT1Y2LZuDJEm
 M9Z78EQT1TtwmRi8CISdwljgujz/sxb5tDyG18sGo9Gm/TfQTkMcekPD0HMxROjPIfHwovDTeKR
 H4Vx+uUe5926Y4w19ixkidpxIaYM5XRK3Wdg5AOiOGiN6ZC4Ja7nLb/VBcmUMH8YsC+4nZJluZz
 /Uh7P70KZGTcINkeHgQ==
X-Proofpoint-ORIG-GUID: K2lX7DTTO-MIsnQ1eGAlSNyZjUQrFMHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120099

This is a multi-part message in MIME format.
--------------xXUn209Nx2rfMjen2Uut601r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/26 07:16, Ian Rogers wrote:
> Frame pointer callchains are not supported on s390. Ignore the option
> and print a warning.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Only disable user callchains as AI is telling me native "kernel"
>     callchains are supported on s390.
> ---
>  tools/perf/util/evsel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bd14d9bbc91f..fa21b48cba86 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  		attr->exclude_callchain_user = 1;
>  	}
>  
> +	if (EM_HOST == EM_S390 && (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
> +	    !evsel->core.attr.exclude_callchain_user) {
> +		pr_warning("Excluding user callchains that are not supported on s390. Try '--call-graph dwarf'\n");
> +		evsel->core.attr.exclude_callchain_user = 1;
> +	}
> +
>  	if (param->defer && !attr->exclude_callchain_user)
>  		attr->defer_callchain = 1;
>  }

Ian, thanks very much.
Your patch set helps a lot. However there is a small nit (which is mandatory). Please add these lines

  evsel->core.attr.sample_type &= ~PERF_SAMPLE_CALLCHAIN;
  evsel->core.attr.sample_type &= ~PERF_SAMPLE_REGS_USER;
  evsel->core.attr.sample_type &= ~PERF_SAMPLE_STACK_USER;
  
to the new if(EM_HOST == ...) above.
The s390 CPU Measurement sampling device driver does not check on the attr.core.exclude_callchain_user
member, but on the sample_type bit mask. It returns -EOPNOTSUPP when this bit PERF_SAMPLE_CALLCHAIN
is set. This solves the invocation with command line flag -g as in
 # ./perf record -v -e cycles  -g  -- perf test -w noploop
 ...  
 perf record: Captured and wrote 0.183 MB perf.data ]
 
Also I discovered that the fallback when using --call-graph dwarf command line flag still fails:
 # ./perf record -v -e cycles  --call-graph dwarf -- perf test -w noploop
 ...
 Warning:
 Trying to fall back to excluding guest samples
 Error:
 Failure to open event 'cycles:H' on PMU 'cpum_cf' which will be removed.
 cycles:H: PMU Hardware doesn't support sampling overflow-interrupts. Try 'perf stat'
 Error:
 Failure to open any events for recording.

The reason is in __evsel__config_callchain() which calls evsel__set_sample_bit(evsel, CALLCHAIN)
and sets the PERF_SAMPLE_CALLCHAIN bit in evsel->core.attr.sample_type. It also sets the
member attr->exclude_callchain_user = 1 and sets bits REGS_USER and _STACK_USER.
All three bits are not supported by s390.

I have modified your 2nd patch and appended it.

I find all these bits in sample_type and the attr.exclude_XXX stuff very confusing. If there
is a more consistant way of checking these feature, please let me know.

Thanks again for looking into this.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
--------------xXUn209Nx2rfMjen2Uut601r
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-perf-evsel-Don-t-configure-framepointer-callchains-o.patch"
Content-Disposition: attachment;
 filename*0="0001-perf-evsel-Don-t-configure-framepointer-callchains-o.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmYTc3MjAwNzEyNzdlN2Y4OTJjOWQ4MWYyZTI3N2M0YWUwMzU5MDU0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+
CkRhdGU6IFdlZCwgMTEgTWFyIDIwMjYgMjM6MTY6MjggLTA3MDAKU3ViamVjdDogW1BBVENI
XSBwZXJmIGV2c2VsOiBEb24ndCBjb25maWd1cmUgZnJhbWVwb2ludGVyIGNhbGxjaGFpbnMg
b24gczM5MAoKRnJhbWUgcG9pbnRlciBjYWxsY2hhaW5zIGFyZSBub3Qgc3VwcG9ydGVkIG9u
IHMzOTAuIElnbm9yZSB0aGUgb3B0aW9uCmFuZCBwcmludCBhIHdhcm5pbmcuCgpTaWduZWQt
b2ZmLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+Ci0tLQogdG9vbHMvcGVy
Zi91dGlsL2V2c2VsLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgYi90b29scy9w
ZXJmL3V0aWwvZXZzZWwuYwppbmRleCBiZDE0ZDliYmM5MWYuLmVjNGM2ZDhhNzM2ZCAxMDA2
NDQKLS0tIGEvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMKKysrIGIvdG9vbHMvcGVyZi91dGls
L2V2c2VsLmMKQEAgLTEwNzYsNiArMTA3NiwxNCBAQCBzdGF0aWMgdm9pZCBfX2V2c2VsX19j
b25maWdfY2FsbGNoYWluKHN0cnVjdCBldnNlbCAqZXZzZWwsIHN0cnVjdCByZWNvcmRfb3B0
cyAqbwogCQlhdHRyLT5leGNsdWRlX2NhbGxjaGFpbl91c2VyID0gMTsKIAl9CiAKKwlpZiAo
RU1fSE9TVCA9PSBFTV9TMzkwICYmIChldnNlbC0+Y29yZS5hdHRyLnNhbXBsZV90eXBlICYg
UEVSRl9TQU1QTEVfQ0FMTENIQUlOKSkgeworCQlwcl93YXJuaW5nKCJFeGNsdWRpbmcgdXNl
ciBjYWxsY2hhaW5zIHRoYXQgYXJlIG5vdCBzdXBwb3J0ZWQgb24gczM5MC4gVHJ5ICctLWNh
bGwtZ3JhcGggZHdhcmYnXG4iKTsKKwkJZXZzZWwtPmNvcmUuYXR0ci5leGNsdWRlX2NhbGxj
aGFpbl91c2VyID0gMTsKKwkJZXZzZWwtPmNvcmUuYXR0ci5zYW1wbGVfdHlwZSAmPSB+UEVS
Rl9TQU1QTEVfQ0FMTENIQUlOOworCQlldnNlbC0+Y29yZS5hdHRyLnNhbXBsZV90eXBlICY9
IH5QRVJGX1NBTVBMRV9SRUdTX1VTRVI7CisJCWV2c2VsLT5jb3JlLmF0dHIuc2FtcGxlX3R5
cGUgJj0gflBFUkZfU0FNUExFX1NUQUNLX1VTRVI7CisJfQorCiAJaWYgKHBhcmFtLT5kZWZl
ciAmJiAhYXR0ci0+ZXhjbHVkZV9jYWxsY2hhaW5fdXNlcikKIAkJYXR0ci0+ZGVmZXJfY2Fs
bGNoYWluID0gMTsKIH0KLS0gCjIuNTMuMAoK

--------------xXUn209Nx2rfMjen2Uut601r--

