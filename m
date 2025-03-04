Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C462045B2;
	Tue,  4 Mar 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097717; cv=none; b=DfYzZRFHZB2Oo+mEOGHABiByFTGN8p585+N7+WNxnpo5JF1V0FpUpEW8eEJ5RGPzmUP6AnqSw+P1N1JE5jJG0DiRcrleGHLBYEQHxXycz8GJzS+SAvLaTU0rwvAM+/K1L+A7wqTox+XnGP55XKJeNtgNo6bW6FSA7zfN4Xpk31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097717; c=relaxed/simple;
	bh=RWVL+QE/PWRG8krCkuKmboSrFi6eKsi4L4DjJqF2A18=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jpYbnDdE+fwVRdEEJx8IzkDZ8HSIuyKRzcQXSPL3wfLmMIwHKLX993OwI1QC3n7qg1ypGhFYSPwC5SdxqYofPocXdBhToJmp8xpoW9FbgN18LVZ4OKWUIyknC7qiIjRP7lFiGeoxzU3uTBDTtcutw9T7e5mCEyCH0MyitnuIMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oSmpQBwY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oSmpQBwY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249n2xY025940;
	Tue, 4 Mar 2025 14:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jMSsk+
	JkgIWBNZDwESlZUKU0V4aZjl605EKGO3C0ivk=; b=oSmpQBwYIs2wDnXBOlIEMp
	PC0CDmfFIDqNk8AWVLV4Xkw+Z37d52owo2bi5XVTkH9CfVdas/idHzGe9EQ+Wfxy
	ouVpxAW9iTFJV6jK9NcRECw9rIocB1ogS0SmDbTrI5ijN3e8TXW9Z4iToy9hCcKh
	/Gf3E4G6uOy4Luxiv7pVOs2/G+dVYDdplRqMjKBmwGGU1c3Ik+px3tCYTQoY9KCe
	nQ63tku1trH+Zyem2tfeyIuTHM4+qd9odu1N/NDz7Hb3WJoYQL5pxpcIuerMaz2p
	opB5XjCRxkVXifRWqQNmIqthThkJnsAxMGW2zs/568wqFL8Hasixf+PZKIyeKk/w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kkpca4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 14:15:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524BZ6ke020936;
	Tue, 4 Mar 2025 14:15:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djndrja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 14:15:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524EEv8S52822334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 14:14:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53642004F;
	Tue,  4 Mar 2025 14:14:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E1832004D;
	Tue,  4 Mar 2025 14:14:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.255.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:14:52 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] perf/bench: Fix perf bench syscall XXXX loop count
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20250304092349.2618082-1-tmricht@linux.ibm.com>
Date: Tue, 4 Mar 2025 19:44:39 +0530
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, yangtiezhu@loongson.cn,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <69345A2D-EF10-4530-8C95-1E7BDC0B64F1@linux.ibm.com>
References: <20250304092349.2618082-1-tmricht@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JakZI_zIw3GI_uKmjrnOjQCcHtqooOPX
X-Proofpoint-ORIG-GUID: JakZI_zIw3GI_uKmjrnOjQCcHtqooOPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503040110



> On 4 Mar 2025, at 2:53=E2=80=AFPM, Thomas Richter =
<tmricht@linux.ibm.com> wrote:
>=20
> Command 'perf bench syscall fork -l 100000' offers option
> -l to run for a specified number of iterations. However this
> option is not always observed. The number is silently limited to
> 10000 iterations as can be seen:
>=20
> Output before:
> # perf bench syscall fork -l 100000
> # Running 'syscall/fork' benchmark:
> # Executed 10,000 fork() calls
>     Total time: 23.388 [sec]
>=20
>    2338.809800 usecs/op
>            427 ops/sec
> #
>=20
> When explicitly specified with option -l or --loops, also observe
> higher number of iterations:
>=20
> Output after:
> # perf bench syscall fork -l 100000
> # Running 'syscall/fork' benchmark:
> # Executed 100,000 fork() calls
>     Total time: 716.982 [sec]
>=20
>    7169.829510 usecs/op
>            139 ops/sec
> #
>=20

Tested-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks
Athira
> This patch fixes the issue for basic execve fork and getpgid.
>=20
> Fixes: ece7f7c0507c ("perf bench syscall: Add fork syscall benchmark")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> tools/perf/bench/syscall.c | 22 +++++++++++++---------
> 1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> index ea4dfc07cbd6..e7dc216f717f 100644
> --- a/tools/perf/bench/syscall.c
> +++ b/tools/perf/bench/syscall.c
> @@ -22,8 +22,7 @@
> #define __NR_fork -1
> #endif
>=20
> -#define LOOPS_DEFAULT 10000000
> -static int loops =3D LOOPS_DEFAULT;
> +static int loops;
>=20
> static const struct option options[] =3D {
> OPT_INTEGER('l', "loop", &loops, "Specify number of loops"),
> @@ -80,6 +79,18 @@ static int bench_syscall_common(int argc, const =
char **argv, int syscall)
> const char *name =3D NULL;
> int i;
>=20
> + switch (syscall) {
> + case __NR_fork:
> + case __NR_execve:
> + /* Limit default loop to 10000 times to save time */
> + loops =3D 10000;
> + break;
> + default:
> + loops =3D 10000000;
> + break;
> + }
> +
> + /* Options -l and --loops override default above */
> argc =3D parse_options(argc, argv, options, bench_syscall_usage, 0);
>=20
> gettimeofday(&start, NULL);
> @@ -94,16 +105,9 @@ static int bench_syscall_common(int argc, const =
char **argv, int syscall)
> break;
> case __NR_fork:
> test_fork();
> - /* Only loop 10000 times to save time */
> - if (i =3D=3D 10000)
> - loops =3D 10000;
> break;
> case __NR_execve:
> test_execve();
> - /* Only loop 10000 times to save time */
> - if (i =3D=3D 10000)
> - loops =3D 10000;
> - break;
> default:
> break;
> }
> --=20
> 2.47.0
>=20
>=20

