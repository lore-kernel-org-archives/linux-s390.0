Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1781E8826;
	Mon, 23 Feb 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847120; cv=none; b=KqVpy5u9+9US8qTbNbuvQKJRZhAaznqp5tDAo+OI0selivjnNAlIRDu1yy93eYJNu4wP4lrW57dabYpvG9EtJdADX6oZXFZLzk1tkgy1tDhkQsxDZa3qsinYJQ6StqdReFHqnad4As/GXHd8b71AGVkfaKQ+9PE8QvuUyWBRaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847120; c=relaxed/simple;
	bh=yF1FienbPqJic4BVlNmeo6NKSgMmU7TG0stNKKmtpus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF+67O8yFH9HcQdOqq0g6+ndqnYvEZgtDAn2eZwxTKdsAVU5okdHG/LtqixRPlTo/VAHTwPzzFEx+5txRVyb4EO/LdLq5MooNDIyvSWk8y2SxvztMllavjBNNut17vWoZJxHZnljQbX4Av13FouUY/gFbgbVAOfM+MReS0XTlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q/cYGrkh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/cYGrkh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MFR6nw1887407;
	Mon, 23 Feb 2026 11:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Egf1YO
	xXcx7VYqjg8Adb8Y4GCJBODNLLqZ8S+SLO+Ak=; b=q/cYGrkh9pyq+ipLmpeuHi
	1CMJGyPa5jAN1ekNjw5Y5niyg7OIu13oFshI1uS+pzBuYBHLTbeKPrmj5cPlR9lb
	0k4F59q1Gn+Gzp8FTo+/tBFZ6kApJHX/LMEU/FaaVsqN7SHzUFJ1V2+MG/Gr87CY
	VIio0disVEhQUuFjNH4yh5T0wz6iS8mI8pkloCye2NIQeByhXIt0PbBBIi+Zj+xn
	NVvTa91NlwMpOV7KIeN+ZaL/iRAToAAqCpX9PB6nt/K0HX3Y/FBb2wP1et8J+4l2
	tBNsuzrBljP2rje73JX3kC4t0hM/YXV13x4sMA9xt/oW4/kFBaLSRuYor9dBUqKQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24g6pgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:44:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61N7Kcq4027776;
	Mon, 23 Feb 2026 11:44:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1m9ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:44:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBict428967368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:44:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 606262004B;
	Mon, 23 Feb 2026 11:44:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F07920040;
	Mon, 23 Feb 2026 11:44:37 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.140.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 11:44:37 +0000 (GMT)
Message-ID: <d3f92c01-3915-448b-ae19-ac155188d2ae@linux.ibm.com>
Date: Mon, 23 Feb 2026 12:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: factor out get_func_* tests
 for fsession
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260223084022.653186-1-dongml2@chinatelecom.cn>
 <20260223084022.653186-4-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260223084022.653186-4-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699c3dab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=klgjOAtpShmeThnBdCEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SkMefq4LwG4Qe3eozpNkpMQxHJgGlV18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX8wBFVO7fFq5T
 6g8f5Tv6/U4ZLYlaMaKq8S0JNo/l/0scrCHifBuAoW/haAEX0MCxINfB6wSDuIF8jT73XhzYxWC
 ifc92GGVbETrzWJsdA6I1ktcA51VePeo3NK5JHmf+GGCdGNtA0ms/U/KRi2sU9rtqoQgeMLdzHw
 +bZ1x3c4qe3+jwDFwuYNRA+8ZvF+ShxqsPDD0Wjii+yqOyvyn/ULwDrdCswCJ6JoqmnSWLbfx/d
 kXYySDElcPLMCkznxL9ZZiGzC1bTOUAwGe5QBZQSLZi9ufEeB5PxNN0/+rYB1ryw8KD2wtKs9Zs
 Ct2g7+r39i25tWSpCJHP+cENzTXzs8/8fEEfEPcmyvP+soH21LfTEegVccBLDPBzaz3MGW/n/Al
 M6FORZgcSenqvhURqBmcUOIk0sHS8uDzoUSJf6BsWL2QbSqQG2E8CqJoZILQZlSLlO2W3vCfH6z
 zQcKwSTnK/EzYFAPazQ==
X-Proofpoint-ORIG-GUID: vgGpTUFSSw-5X2CLDMa1mxLQM0V0hSk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230099

On 2/23/26 09:40, Menglong Dong wrote:
> The fsession is already supported by x86_64, arm64, riscv and s390, so we
> don't need to disable it in the compile time according to the
> architecture. Factor out the testings for it. Therefore, the testing can
> be disabled for the architecture that doesn't support it manually.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>   .../bpf/prog_tests/get_func_args_test.c       | 25 +++++++++++-
>   .../bpf/prog_tests/get_func_ip_test.c         | 28 +++++++++++++-
>   .../bpf/progs/get_func_args_fsession_test.c   | 37 ++++++++++++++++++
>   .../selftests/bpf/progs/get_func_args_test.c  | 38 -------------------
>   .../bpf/progs/get_func_ip_fsession_test.c     | 21 ++++++++++
>   .../selftests/bpf/progs/get_func_ip_test.c    | 23 -----------
>   6 files changed, 108 insertions(+), 64 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
>   create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c


I personally like the "let the test fail on unsupported architectures" 
philosophy, since it lets architecture maintainers notice missing 
features more easily and take action (even if it's just adding the 
respective test to DENYLIST), so:


Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

