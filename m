Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755031BCAE;
	Mon, 19 Oct 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400049; cv=none; b=QOUUJhxHNmwuzJedOUa2F7jCEDNO0f45ELgbeacbE19WJAjqoeH/eYMPnNqgL4VtMJphhlD2z2/q8AtFJDdNyX+GUQgOVCIkpkauHQ2wdq0piOVdILuKUPLKUEf/nkw3hc1dC1kBZLvJnU6+dy/EhlCox5S+EyBi0WrKI4tRmCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400049; c=relaxed/simple;
	bh=EyaMsR5iFwGWvG9qQ3I0c8/2vWJxmxXrEFqr0VPGaW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVYep/5P3DNOieTIud6ytEkOwe4DAkCRSZp1b6M28I/GBOhENZADa+f30W+NTPiqZ51DgEnN/yakLiMSs6LMFdzycoCM1dlyHDCz+nT9ny12yO/mKax5aYLeUjyG+3xgLsQt/m4aI5ACVeX/qU+0f4u/RCXcdeBLHDl9+pcvR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pqyuCBbo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pqyuCBbo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8i5vU1636640;
	Mon, 19 Oct 2026 08:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OxWYpG
	YGadiI9V8mHVtnuZO1pcajp+u0zbDutU4rXHI=; b=pqyuCBboU4EDht1tq5y4ta
	/JstzltpTRATNRPNoKzqfr6iF1ySlA6WL6vLvk9r0BGo3+VubJs/SGPy3VPqKglY
	DlU0MhBEYG3vHqnBBewIX53rwq59ma2WgupFPJ9Dn/lga/o/O6C6xFA5nLpXONaD
	E9gKbgNEsMKyUcXDh41yR5RSwBhNaqEJ9H3D2RnAbA7zCEc8FheIZPIcJ+TmcWJf
	BZkfWa26r9tHNhJcK92IX6xuG11IcyJrKlwNBtEi5X/bIUgjrlCAmqxWaJT6DeSc
	iYXnPB9CWhjPA0B7/ScjQbuoJP756oBK5l4hHxXmQKVPsNyCb7JCGRhGW8VrGG+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0ptj4qj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 08:54:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8ZH4g3842415;
	Mon, 19 Oct 2026 08:54:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq521c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 08:54:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69J8rvxd47251754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 08:53:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEFEB2004B;
	Mon, 19 Oct 2026 08:53:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76D0D20040;
	Mon, 19 Oct 2026 08:53:57 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 08:53:57 +0000 (GMT)
Message-ID: <ec1cdde1-3201-4f6e-845c-c8f2ca0bb76a@linux.ibm.com>
Date: Mon, 19 Oct 2026 10:53:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] KVM: s390: fix ESSA addressing exception injection
 in migration mode
To: Gautam Gala <ggala@linux.ibm.com>, imbrenda@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org
References: <20261015104822.77062-1-ggala@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261015104822.77062-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX/8FL6NjUpEGo
 V3w5Ln1Z7LCJv/1YhjON2fTqMrcGkPIf0Pg8SUFxks+PB4uEVjbyruWQu3tvh4/EYvOI+P8djYM
 0WsSI7YvVYL8rHUxb9itrS5SejaeTGroD2GZ4Nu8fcr2eak4fCftaxa3sbwCEziGV6kA7IZCjeR
 1rt3gKNsLh8sPoxDGpHwbnFi8DKvs/SKy6cOhqTEkFfSCRkcj26YhUR0cltrrQQkQknIf6ipmG4
 FNzPYP3wAmuYaTbepm19EZx8/bU7rnyTM4+n+78uS1h9waTUkKVQ2HulxbpIl4KiqS+L+ScZXeE
 IGvct5DlJkvrHsSzi61JjHTU/qR2WFIOQVoXxJcEIZNFJWbRQokYPdXdDwf6NWfNTDNYXBlXFMN
 vSd9vFExLfpvgaklEdHeiw58jeDS0KWq8od+7HyBbq/pt/5LMOfZPuZGBmyuvVfBRnCk5gJnPTo
 j5/LD910e8GeecnNCDw==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad5daaa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=BdKKiVBxiTNh0JwODn8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX8hcLAkJbjeNC
 rv7XZUKzSz67kHteS6tLcRN9PdUCCmYOmgdv2UlFZmpamLpZ3UH9SnJDNAO+K5Xd93rmaisrVpX
 WppPh+/oQ8Un5jJQ10me5FE2WHAwZTI=
X-Proofpoint-GUID: T1G9eOk7o-EigrjfgA9crZAav1XT9UUO
X-Proofpoint-ORIG-GUID: kXCNzz0_rstK71_YtHoaIcEQfFdKsrNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190034



Am 15.10.26 um 12:48 schrieb Gautam Gala:
> ESSA emulation in migration mode silently dropped addressing exceptions
> when the guest page-table walk failed, so the guest never received the
> expected PGM_ADDRESSING interrupt during live migration.
> 
> Patch 1 fixes dat_perform_essa() to return PGM_ADDRESSING on a walk
> failure, and __do_essa() to inject the program interrupt when it sees
> that return value.
> 
> Patch 2 adds a regression test integrated into the existing cmma_test
> selftest.
> 
> Changes since v1:
>   - dat_perform_essa() now returns +PGM_ADDRESSING instead of
>     -PGM_ADDRESSING; kvm_s390_inject_program_int() takes an unsigned u16
>     so passing -5 would have wrapped to 0xFFFB and injected a bogus PIC.
>     __do_essa() comparison and inject call updated accordingly. The
>     kernel-doc return-value entry is corrected to %PGM_ADDRESSING.
>   - Selftest: pgm_handler_c() now reads the actual PIC from lowcore
>     (__LC_PGM_INT_CODE) instead of hard-coding PGM_ADDRESSING, so the
>     test would have caught the sign error above had it been in v1.
>   - Selftest: virt_map(vm, 0, 0, 1) added so the DAT-on guest can
>     access the lowcore to read the PIC.
>   - Selftest: PGM_ADDRESSING, __LC_PGM_INT_CODE and __LC_PGM_NEW_PSW
>     constants moved to the shared s390/processor.h header.
>   - Selftest: SIGALRM/alarm() timeout wrapper removed.
> 
> Gautam Gala (2):
>    KVM: s390: fix ESSA addressing exception injection in migration mode
>    KVM: s390: selftests: add ESSA migration mode PGM_ADDRESSING
>      regression test
> 
>   arch/s390/kvm/gmap/dat.c                      |  5 +-
>   arch/s390/kvm/s390/priv.c                     |  2 +
>   .../selftests/kvm/include/s390/processor.h    |  7 ++
>   tools/testing/selftests/kvm/s390/cmma_test.c  | 69 +++++++++++++++++++
>   4 files changed, 82 insertions(+), 1 deletion(-)
> 


Thanks, applied.
