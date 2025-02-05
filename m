Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF75219A6E;
	Wed,  5 Feb 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746434; cv=none; b=ZFHpzvPsZZqzBi29UgqEFkwhKlj44+p4VHCP+qf5cW/PLhCt1fGCADXK6TBJnUX8xdlgyA0T0OvpWZnFRjUR5ZUupuZwLH4UhBHEtrJH7AKRfI0gAwS79iPKUFkBjXsQeWwtuHK8QzluZrfR68s8vlMlMQGl1jXM1NZfRvha0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746434; c=relaxed/simple;
	bh=wjawX1358YXjCS0M3IDazo/IC2l7c+1IedZFz7GeuHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lInPSJJ2jtlg3BLVBVWhFffCUI7zaeGrTPuLkolWJkKV8J/sbS6NEQ+/wgyZrPTOF8m/EBmxE204RiOVMVxO28nY9KsAxrmpDVKXa8mhEESMB+BtJMzzSyyFKX+0S2+4DhVBbF18lY2ai+rPtbSofuXgCnYOE+VTKCEuoaLGU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cNp+yFz5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cNp+yFz5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5151865m012355;
	Wed, 5 Feb 2025 09:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=K2f0PH2cD7QKBWZ+FSllOE7GTYjRMh
	2E/cknU+SKsVk=; b=cNp+yFz51eIzC2UuHdWsWEJXiNNA8k3bRPZbu7JDcY5f1I
	/Cd8TS/z9xb5nuVVjLLHCZjNFUFB4N7QO64uQgHZ8YTpVOvjmldAv6t2isSvpZ6l
	jV9ve5I+VMaB3RbcPtfnQoRBJx+09NzQeleksjLVIgk8cQFLTjRb0pQ6pDBQ3jnB
	hoVAnbK5M+9OkV3JUx7nsCt3K3AeGMnv5gQ3gyE4ynago4WFFqV+e1wZkZs4Yzug
	cOAkk20RFNMqlDO4j4nIi2bgt4IoNkPytr9fz4RpdKhypgk5NDXb00JCrCUte1vc
	5JDJlaDJAldPMLUeGWOOnEZOm0KXVwk2pWBEOi5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29hxh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:06:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5158qO1C006065;
	Wed, 5 Feb 2025 09:06:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29hxh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:06:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5158CegV024533;
	Wed, 5 Feb 2025 09:06:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn7yrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:06:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51596bDG17170796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 09:06:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 564B620313;
	Wed,  5 Feb 2025 09:06:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E96020312;
	Wed,  5 Feb 2025 09:06:37 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Feb 2025 09:06:37 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Eugene
 Syromyatnikov <evgsyr@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>,
        Davide Berardi
 <berardi.dav@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        strace-devel@lists.strace.io, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
In-Reply-To: <20250204151420.GA30282@strace.io> (Dmitry V. Levin's message of
	"Tue, 4 Feb 2025 17:14:20 +0200")
References: <20250204151420.GA30282@strace.io>
Date: Wed, 05 Feb 2025 10:06:36 +0100
Message-ID: <yt9d8qqkyd43.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7MffZGyFzaakFNQn2nT3hUSCU8OLe9Ad
X-Proofpoint-ORIG-GUID: jC8ovOeJCCPOFj5pvJIzOaPypbBvtX3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_03,2025-02-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=890 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050071

"Dmitry V. Levin" <ldv@strace.io> writes:

> On Mon, Feb 03, 2025 at 12:35:42PM +0200, Dmitry V. Levin wrote:
>> On Mon, Feb 03, 2025 at 10:29:37AM +0100, Alexander Gordeev wrote:
>> > On Mon, Feb 03, 2025 at 08:58:49AM +0200, Dmitry V. Levin wrote:
>> > 
>> > Hi Dmitry,
>> > 
>> > > PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
>> > > PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
>> > > system calls the tracee is blocked in.
>> > ...
>> > 
>> > FWIW, I am getting these on s390:
>> > 
>> > # ./tools/testing/selftests/ptrace/set_syscall_info 
>> > TAP version 13
>> > 1..1
>> > # Starting 1 tests from 1 test cases.
>> > #  RUN           global.set_syscall_info ...
>> > # set_syscall_info.c:87:set_syscall_info:Expected exp_entry->nr (-1) == info->entry.nr (65535)
>> > # set_syscall_info.c:88:set_syscall_info:wait #3: PTRACE_GET_SYSCALL_INFO #2: syscall nr mismatch
>> > # set_syscall_info: Test terminated by assertion
>> > #          FAIL  global.set_syscall_info
>> > not ok 1 global.set_syscall_info
>> > # FAILED: 0 / 1 tests passed.
>> > # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>> > 
>> > I remember one of the earlier versions (v1 or v2) was working for me.
>> > 
>> > Thanks!
>> 
>> In v3, this test was extended to check whether PTRACE_GET_SYSCALL_INFO
>> called immediately after PTRACE_SET_SYSCALL_INFO returns the same syscall
>> number, and on s390 it apparently doesn't, thanks to its implementation
>> of syscall_get_nr() that returns 0xffff in this case.
>> 
>> To workaround this, we could either change syscall_get_nr() to return -1
>> in this case, or add an #ifdef __s390x__ exception to the test.
>> 
>> What would you prefer?
>
> OK, I'm going to apply the following s390 workaround to the test:
>
> diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
> index 0ec69401c008..4198248ef874 100644
> --- a/tools/testing/selftests/ptrace/set_syscall_info.c
> +++ b/tools/testing/selftests/ptrace/set_syscall_info.c
> @@ -71,6 +71,11 @@ check_psi_entry(struct __test_metadata *_metadata,
>  		const char *text)
>  {
>  	unsigned int i;
> +	int exp_nr = exp_entry->nr;
> +#if defined __s390__ || defined __s390x__
> +	/* s390 is the only architecture that has 16-bit syscall numbers */
> +	exp_nr &= 0xffff;
> +#endif
>  
>  	ASSERT_EQ(PTRACE_SYSCALL_INFO_ENTRY, info->op) {
>  		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
> @@ -84,7 +89,7 @@ check_psi_entry(struct __test_metadata *_metadata,
>  	ASSERT_TRUE(info->stack_pointer) {
>  		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
>  	}
> -	ASSERT_EQ(exp_entry->nr, info->entry.nr) {
> +	ASSERT_EQ(exp_nr, info->entry.nr) {
>  		LOG_KILL_TRACEE("%s: syscall nr mismatch", text);
>  	}
>  	for (i = 0; i < ARRAY_SIZE(exp_entry->args); ++i) {

Fine with me. As you already noted only 16 bit of the syscall number is
stored in pt_regs::int_code. A quick hack would be possible to do sign
extensions, so -1 would work. But i think this would be odd, because
positive numbers would still be limited.

So i think the patch you proposed is fine.
