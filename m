Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF29175A63;
	Tue,  7 Apr 2026 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566083; cv=none; b=j2NzqzuiE/D4AOLg5754kITd8e0s2m3QOT/p3Iq6e0v9o/WPJqKXCJE54mx0HssXXu7Lo9vQVzPm84qf88eEQNEmSTaGgL9KDgb1QVeJwjUKrZnLF6vQa4pFQDD+2EkTZ0cLNJyfbhegSVgm2OfaZ3/fopcwzV40PSy1h1zW5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566083; c=relaxed/simple;
	bh=tlqaqU/zXk3bCn7WlqOZm8OROl4QN++rWAf7h278n9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWl9mwRQnFE3DhIpzwUmhse8Eaerfu/KPs0X4ie65ShXlWEq2RKA9vdpsdfi4gFlLDQf3i2EHYy7huFIaX0mdwPdVi0WWI/kGG2YEhNrTRpafVarUOjrQzQYj4NHFPSPhLAxouJEU20ClOKsYFK9Bl6oO9cW43UCVVij9/kaVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sI72XLVp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sI72XLVp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmO0B2592771;
	Tue, 7 Apr 2026 12:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MlQyXwJS8mSyIQkk3P6YmsnUJO4awp
	68PvlOUhgZfN8=; b=sI72XLVpQab8x4GueNcdlc7VA8zTAMcQv9nkfVHfEaNm4V
	nq3S1WwiWBW2G+5szZQTKU2wnWdwgTGVYMWqyHHcagnp2LLlurKUGa4BdjtM9kfj
	IKqI38/4LIhMgyM/x7aIXWfwX8iuj/Y7ZTpceQ4m1MWSyTE2kAEf45WwddotA1r5
	opxf8DyPIBacDJ0oiviLHBXUgJkbvCpnHwiXjGFLB/pXvmndTo77SDKd6pFv/uKX
	p+tUqBwWOD6mWVEVB+SeJ5Fcc4k6n/6txqM4yZwlvPBbbH2nfwnAkmjPTzEl5Ue2
	dQR05qzbpQNK5H8bzlq83Wzc1j76t+E70wT+Hq0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e31pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:47:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BOM2L014361;
	Tue, 7 Apr 2026 12:47:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4k4nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:47:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637Cls3948497132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:47:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15EA72004D;
	Tue,  7 Apr 2026 12:47:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D94CE2004B;
	Tue,  7 Apr 2026 12:47:53 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 12:47:53 +0000 (GMT)
Date: Tue, 7 Apr 2026 14:47:52 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 5/6] KVM: s390: selftests: enable some common
 memory-related tests
Message-ID: <20260407124752.296205-E-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-6-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4hFrCyXiOq6cRB5uw31wpG1xyQ53XkM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMCBTYWx0ZWRfX2iFCSTYHOVSH
 Ry2sje6k9He68Wo5hlgqOGTB8yYzGsenZvb1CBTwkAfX1JADmqyIaMQVI6Ph63QodMSI/viMSny
 pL6ccwKtx6Yhyie9ovayaf0we0hQFg8YlH2o1IHVlGm5ii/oqDZDguJgl/iRejGw+nhQWMV65d1
 LgYZZb7jjbVbQlP9wT47F2f3PtZqQ3+rmlvnj+1ob9xKT9YBc/5sbib6MKPl3o3KFGQbPBHp6mi
 JuMBLv9ZRE8IxGgpz89WeSu0p06XTZN2ITXh/lIT1EmJ+5HrgWgAziD6qZ20Qj8z3nmnjNfL9Ii
 nYN6DnzsllZgQeeRG8JYV8uWtlXi9T50sjeDYuqtsoOjN08e75fTluxmpukEWmRy7HvSiEHb2Is
 GREgKevrSgVrObBdu/9z68fwak52peJOKG+NrrwUimtKjFjZJZnWel/jCt15zK959q2xxxhAVhs
 cTd+bXQLOVnCHNyXibQ==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d4fcfe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=CxLNMF_Y0nVx0XyC1IAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4hFrCyXiOq6cRB5uw31wpG1xyQ53XkM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070120

On Thu, Apr 02, 2026 at 05:01:34PM +0200, Claudio Imbrenda wrote:
> Enable the following tests on s390:
> * memslot_modification_stress_test
> * memslot_perf_test
> * mmu_stress_test
> 
> Since the first two tests are now supported on all architectures, move
> them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index fdec90e85467..057f17d6b896 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -64,6 +64,8 @@ TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
>  TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
>  TEST_GEN_PROGS_COMMON += kvm_page_table_test
>  TEST_GEN_PROGS_COMMON += set_memory_region_test
> +TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
> +TEST_GEN_PROGS_COMMON += memslot_perf_test
>  
>  # Compiled test targets
>  TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
> @@ -147,8 +149,6 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
>  TEST_GEN_PROGS_x86 += dirty_log_perf_test
>  TEST_GEN_PROGS_x86 += guest_memfd_test
>  TEST_GEN_PROGS_x86 += hardware_disable_test
> -TEST_GEN_PROGS_x86 += memslot_modification_stress_test
> -TEST_GEN_PROGS_x86 += memslot_perf_test
>  TEST_GEN_PROGS_x86 += mmu_stress_test
>  TEST_GEN_PROGS_x86 += rseq_test
>  TEST_GEN_PROGS_x86 += steal_time
> @@ -186,8 +186,6 @@ TEST_GEN_PROGS_arm64 += coalesced_io_test
>  TEST_GEN_PROGS_arm64 += dirty_log_memslot_perf_testperf_test
>  TEST_GEN_PROGS_arm64 += get-reg-list
>  TEST_GEN_PROGS_arm64 += guest_memfd_test
> -TEST_GEN_PROGS_arm64 += memslot_modification_stress_test
> -TEST_GEN_PROGS_arm64 += memslot_perf_test
>  TEST_GEN_PROGS_arm64 += mmu_stress_test
>  TEST_GEN_PROGS_arm64 += rseq_test
>  TEST_GEN_PROGS_arm64 += steal_time
> @@ -205,6 +203,7 @@ TEST_GEN_PROGS_s390 += s390/ucontrol_test
>  TEST_GEN_PROGS_s390 += s390/user_operexec
>  TEST_GEN_PROGS_s390 += s390/keyop
>  TEST_GEN_PROGS_s390 += rseq_test
> +TEST_GEN_PROGS_s390 += mmu_stress_test
>  
>  TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
>  TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
> @@ -214,8 +213,6 @@ TEST_GEN_PROGS_riscv += arch_timer
>  TEST_GEN_PROGS_riscv += coalesced_io_test
>  TEST_GEN_PROGS_riscv += dirty_log_perf_test
>  TEST_GEN_PROGS_riscv += get-reg-list
> -TEST_GEN_PROGS_riscv += memslot_modification_stress_test
> -TEST_GEN_PROGS_riscv += memslot_perf_test
>  TEST_GEN_PROGS_riscv += mmu_stress_test
>  TEST_GEN_PROGS_riscv += rseq_test
>  TEST_GEN_PROGS_riscv += steal_time
> -- 

I think you missed removing the loongarch targets.

	Steffen
