Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068E5228;
	Thu,  8 Aug 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099510; cv=none; b=Wn5JuTRVm900Ydtx/XZHiVChROHr8v6YHHE6g1WdI4GQr4SSRpU3+hGZlXFDWXh7AOn930iZpF+E2fclJrCa+t73PSwE+8pfQr/jWSHQ0ti+FnyBY919dNwG/VEFdpLs2DEnWd5hgzpNxpMVDU0CQuK5+FjeD+6Idb+IDv6wEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099510; c=relaxed/simple;
	bh=9f6hQpfsYWEx7XOtkE5bZ+rq2R72IjDOqr3b7kLC7P0=;
	h=Content-Type:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:MIME-Version; b=Y1vfqL2SxlHMgCHwAY4XUqBl/A4pD+ZzDLUwrxm9mBO3QicHhi/295UDR0K1eJc0b2vBuVGqiKdVNpN/bGls1VA/XB1iWjZ0Mu3gbDM4HeYA4umJxVQIrbLD1yVOUOxl28tnW7xiG2c2vfDPBPgSJIs+QCt0tOSQKcowu57JqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtmsmih4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtmsmih4"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4783raWW005829;
	Thu, 8 Aug 2024 06:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:subject:from:in-reply-to:date:cc:message-id
	:references:to:content-transfer-encoding:mime-version; s=pp1;
	 bh=LEg29M2yqo1wvbO42uopFKk9Gjuc//TOv0IVcWZHbGs=; b=qtmsmih4vFCJ
	/ybdMAs6kxwQyUQloCJHt72JMN7XatXBrUwkpN5O0KO4XLMPlT5hvKJQEPFXtWCR
	9ELo5jnjuTv9F4zDvMNTlm1uEiUKJKw/jCSCsLROciagbP250ZIgIGSuMpMIaAuM
	tIAOmQW3SbygHUa7YBaXwIk+CW79IoVaSxuIBOFejFOvv0klBYjB/HB1/gbAzLCy
	W2fpo0g6GttEI0nxXZkHKifB7Cpn5P4mDpdftglpEybVTy2vS6NirTM0+oNDxuI4
	+LHL/468xJiL71hM1WVjb7Pm079uGCMgKvD8VUpVDEGpd/i5SJCnlGzKf4StMtvf
	NNZA54IjMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40urpuby7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 06:44:43 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4786igWp030241;
	Thu, 8 Aug 2024 06:44:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40urpuby7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 06:44:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4783xS2T018004;
	Thu, 8 Aug 2024 06:44:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cmvtkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 06:44:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4786iZHZ57737710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Aug 2024 06:44:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDE620043;
	Thu,  8 Aug 2024 06:44:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC93920040;
	Thu,  8 Aug 2024 06:44:26 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.113.139])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Aug 2024 06:44:26 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Subject: Re: [PATCHSET 00/10] perf tools: Sync tools and kernel headers for
 v6.11
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZrO5HR9x2xyPKttx@google.com>
Date: Thu, 8 Aug 2024 12:14:12 +0530
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@arm.com>,
        James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org
Message-Id: <F3C6DE61-8E10-4814-A6C0-C7569B3FD613@linux.vnet.ibm.com>
References: <20240806225013.126130-1-namhyung@kernel.org>
 <ZrO5HR9x2xyPKttx@google.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L2gBmFoGup1EK_PG9EwlwP3G5Ww1ljlb
X-Proofpoint-GUID: tvb4B9ZyOUHFlc5FqnowrES5Pbrzd0es
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080046



> On 7 Aug 2024, at 11:42=E2=80=AFPM, Namhyung Kim <namhyung@kernel.org> wr=
ote:
>=20
> Hello folks,
>=20
> On Tue, Aug 06, 2024 at 03:50:03PM -0700, Namhyung Kim wrote:
>> Hello,
>>=20
>> This is the usual sync up in header files we keep in tools directory.
>> I put a file to give the reason of this work and not to repeat it in
>> every commit message.  The changes will be carried in the perf-tools
>> tree.
>=20
> Could you please double check what's in the tmp.perf-tools branch at the
> perf-tools tree so I don't break build and perf trace for arm64, powerpc
> and s390?  It has this patchset + arm64 unistd header revert (according
> to the discussion on patch 6/10) on top of v6.11-rc2.
>=20
> Thanks,
> Namhyung
Hi Namhyung,

Can you please point to the tree. I checked in https://git.kernel.org/pub/s=
cm/linux/kernel/git/acme/linux.git as well as https://git.kernel.org/pub/sc=
m/linux/kernel/git/perf/perf-tools-next.git , but didn=E2=80=99t find the c=
hanges. May be I am missing something. I am trying to check the build in po=
werpc.

Thanks
Athira


>=20
>>=20
>> Namhyung Kim (10):
>>  perf tools: Add tools/include/uapi/README
>>  tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
>>  tools/include: Sync uapi/linux/kvm.h with the kernel sources
>>  tools/include: Sync uapi/linux/perf.h with the kernel sources
>>  tools/include: Sync uapi/sound/asound.h with the kernel sources
>>  tools/include: Sync uapi/asm-generic/unistd.h with the kernel sources
>>  tools/include: Sync network socket headers with the kernel sources
>>  tools/include: Sync filesystem headers with the kernel sources
>>  tools/include: Sync x86 headers with the kernel sources
>>  tools/include: Sync arm64 headers with the kernel sources
>>=20
>> tools/arch/arm64/include/asm/cputype.h        |  10 +
>> tools/arch/arm64/include/uapi/asm/unistd.h    |  24 +-
>> tools/arch/powerpc/include/uapi/asm/kvm.h     |   3 +
>> tools/arch/x86/include/asm/cpufeatures.h      | 803 +++++++++---------
>> tools/arch/x86/include/asm/msr-index.h        |  11 +
>> tools/arch/x86/include/uapi/asm/kvm.h         |  49 ++
>> tools/arch/x86/include/uapi/asm/svm.h         |   1 +
>> tools/include/uapi/README                     |  73 ++
>> tools/include/uapi/asm-generic/unistd.h       |   2 +-
>> tools/include/uapi/drm/i915_drm.h             |  27 +
>> tools/include/uapi/linux/in.h                 |   2 +
>> tools/include/uapi/linux/kvm.h                |  17 +-
>> tools/include/uapi/linux/perf_event.h         |   6 +-
>> tools/include/uapi/linux/stat.h               |  12 +-
>> .../arch/powerpc/entry/syscalls/syscall.tbl   |   6 +-
>> .../perf/arch/s390/entry/syscalls/syscall.tbl |   2 +-
>> .../arch/x86/entry/syscalls/syscall_64.tbl    |   8 +-
>> .../perf/trace/beauty/include/linux/socket.h  |   5 +-
>> .../perf/trace/beauty/include/uapi/linux/fs.h | 163 +++-
>> .../trace/beauty/include/uapi/linux/mount.h   |  10 +-
>> .../trace/beauty/include/uapi/linux/stat.h    |  12 +-
>> .../trace/beauty/include/uapi/sound/asound.h  |   9 +-
>> 22 files changed, 810 insertions(+), 445 deletions(-)
>> create mode 100644 tools/include/uapi/README
>>=20
>> --=20
>> 2.46.0.rc2.264.g509ed76dc8-goog
>>=20

