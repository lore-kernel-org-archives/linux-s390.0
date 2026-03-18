Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E737AA7D;
	Wed, 18 Mar 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822055; cv=none; b=Q3k7zdc3fCv5FxxKm/ij3osly3l8IV3BOrj187D6d1Le0lQeQjHV+VQ3hkvcdkYqJFD+/6PBbY/H50dyMjnORyzBjGKZ7VP3XzH8ucxVYnkKOsHXy4rVInd0xAHnNpllX2aZvo7RfqMMLSjbErGiWQHW7avU6TKgMVG6ARoCgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822055; c=relaxed/simple;
	bh=4iDXfO4piBeUTI+J6XtSG33I+Bok33vhWjPBczwJ/oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgiG7YBSTaQ6+OegxqxSVqtdhW9xGo1ICXOo/tm3aHw27tsDuTMfV7JBaktoWCNCnmQejZ280VnReRrnbrNZHEuWRmsAML+YReueZ1fKhWpi+trh+tyyqzkrUpmpNHN7gNPP287vBVno5/N5X8/BDATiLWekH4n5hLqVOkv07sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VrwoUdnz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VrwoUdnz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIcguW622825;
	Wed, 18 Mar 2026 08:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JZxBCj
	ositLH+55spngCp/YOKn6U3KMCEd8mZo2qlx0=; b=VrwoUdnz5GVvceiqnaxfu/
	zdgxJhwQMXFty7BaWfpMiR3mn+uTZ1n+Kt95FM16lBWi62Uk2McdPrcEPw9hEPfv
	T20mDPAXlclSXdgaM24/bSUKiEZS0X5BxPtEgjNXf2xSmFj+Erh4LG/wysZJtwhu
	Wfm7oNceMgCx/NzIeJzffTyZi7cx7JKtRvMg9QOojcK7afiRBotAojyQ+8aWHBdw
	4AIrwxgZPeWaItFAJhDwuNQQ0K5Pls4CNFp/b9GHHa2Azdkwu3PvSv+K3NCciXi9
	kkbuk+IMdEqP3HBEKlDx2s/8tNz14E2l066+EVTskAsErM0RukLXYCcnnVlJtacw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d0abq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:20:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4Su74004581;
	Wed, 18 Mar 2026 08:20:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sd7np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 08:20:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I8Kj6d46268886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 08:20:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A9512004E;
	Wed, 18 Mar 2026 08:20:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D71AE2004B;
	Wed, 18 Mar 2026 08:20:44 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 08:20:44 +0000 (GMT)
Message-ID: <d2396ba9-1859-49d2-b8de-94e87241a6f2@linux.ibm.com>
Date: Wed, 18 Mar 2026 09:20:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] perf evsel fallback changes, better s390 defaults
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        namhyung@kernel.org, sumanthk@linux.ibm.com
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
 <20260317175642.161647-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260317175642.161647-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba6062 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=ObKG83E-m0-uxJZurrIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2OSBTYWx0ZWRfXwN8kO/h0CWXa
 zBn7sRUmgzMhdSAVk2x4izMiNugUiSnYdVB5vQ29ojm0WI999lO29ARK0d/bkUp0EtQ57WE84T9
 GwtDOoCihNJRC1r+q3lTVC+9o7/+pqmMc8dhzlNomrZageViZoI8q+TROfApKdpRlO+lk5MohpZ
 J2ux4pfMM0UgBKWJwjMh402g8d3az/EsYh0ZDncPr/817fLXeKfm85yfG/lBuH+Nc+we2BEinSV
 WmqE+pzGZit3nJPVTVpd8xFpTBK8xWIO8sw7K9YKKSB6EfFCqJysdeGeEiwHuDT6z/NdFVH6BDo
 TEwnqhv9pGPWEWCnz/CWUL4ilyrIWMtNtT59xY+ExvfYfL1Rd3ife4M22aioT6u4KMcm0UUTl5s
 9lMVf/froe4fudgKe4vUSM7VAgpDm95gsHYjbmdP7ZDE+L31zobU+zsFYguUjKaztyGenHVSFtE
 TAMYfczYLGxJ1Ic/o6w==
X-Proofpoint-GUID: uBenSS1Ap3oKWbOg24k-aYS5xVrhgNRF
X-Proofpoint-ORIG-GUID: MAcF-LjZdIk7Pr4n58gBb4lzUPUk50mW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180069

On 3/17/26 18:56, Ian Rogers wrote:
> Discussion with Thomas Richter in:
> https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
> showed that the evsel__fallback wasn't working for s390. These patches
> avoid the problematic frame pointer callchain on s390 and fix
> evsel__fallback from a range of problems when falling back to a
> software event. I simulated failures when developing the patches but
> they are untested other than that.
> 
> v6: Sashiko noted that target wasn't fully set up when creating the
>     default evlist in `perf top`, so move it earlier. Fix const char*
>     casting issues in __parse_callchain_report_opt. Make '-g' not
>     override the .perfconfig setting again.
> https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.com
> 
> v5: Fix the value for the top option to match that of record. Tidy the
>     callchain parsing option callbacks. Based on AI review feedback:
> https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google.com
> https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com/
> 
> v4: Changing the callchain parameter at configuration time means other
>     options aren't set the same as they would for `--call-graph
>     dwarf`, for example the stack size. Switch to setting the
>     callchain option on s390 to parameter parse time. For '-g' use
>     '--call-graph dwarf' for s390. Other --call-graph options are
>     parsed as normal, but a warning is generated when setting
>     `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
>     when there is only 1 event in the evlist.
> https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com/
> 
> v3: Incorporate feedback about event and callchain behavior for s390:
> https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
> https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.com/
> 
> v2: try exclude_callchain_user for s390 rather than fully disabling
>     the callchain. Fix a missed clearing of is_pmu_core if the
>     software event fallback.
> https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
> 
> v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/
> 
> Ian Rogers (5):
>   perf evsel: Improve falling back from cycles
>   perf target: Constify simple check functions
>   perf evsel: Constify option arguments to config functions
>   perf callchain: Refactor callchain option parsing
>   perf evlist: Improve default event for s390
> 
>  tools/perf/builtin-record.c      | 66 +++++++----------------------
>  tools/perf/builtin-top.c         | 67 ++++++++++++++++-------------
>  tools/perf/builtin-trace.c       |  9 +++-
>  tools/perf/tests/event_update.c  |  4 +-
>  tools/perf/tests/expand-cgroup.c |  4 +-
>  tools/perf/tests/perf-record.c   |  7 ++-
>  tools/perf/tests/topology.c      |  4 +-
>  tools/perf/util/callchain.c      | 73 ++++++++++++++++++++++++++------
>  tools/perf/util/callchain.h      | 12 ++----
>  tools/perf/util/evlist.c         | 32 +++++++++-----
>  tools/perf/util/evlist.h         |  2 +-
>  tools/perf/util/evsel.c          | 70 +++++++++++++++++++-----------
>  tools/perf/util/evsel.h          | 10 +++--
>  tools/perf/util/target.h         | 12 +++---
>  14 files changed, 217 insertions(+), 155 deletions(-)
> 

Ian, thanks a lot. I tested it using the same sequences as for v5.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
