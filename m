Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3A2222AC;
	Tue,  7 Apr 2026 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569297; cv=none; b=DtNa8azt7SiFoNyJ8iOG367OIZpaf+xglEGcDkGiWLSaHJFCUn2r9uzC8aNtAMJpoFtsD32wxCAEvXK/jCBu4gPmStYDnknsELL22wrIbOueN0/Ze5H7hGsWpkOzNh/G+Rk9zKaBcmyLnEw5s9B2DLL/AYMbcE4fDY7NqdaTZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569297; c=relaxed/simple;
	bh=AQsfXK80JF5M7Xxy0srJ/WY75mLclYMuTwC3X59QEEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUJ9l2yuvNn3x9gzWAiCAmtKTASPakDAQ2RFBFvxh6GsNKJHB+pzLRlYFD3uaBCVDroKTN3nxfNvOq24Nj2G6RNo51Atpwm+b/IlsmYgXNKfY13DJylUimK4jYjXLGY/RE7be+YyDafnB5dkTCl0qhA5Ds8EbFiAKW3iLV573iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PkC07zyZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PkC07zyZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmCap2326198;
	Tue, 7 Apr 2026 13:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nhHkHUhEG/d9L76wZ/YfXZE9f6XeJ2
	eVbUf8N7bXRNI=; b=PkC07zyZM5yEidLuKm/eUZwMm6/JhOVbxUvi11HIlMv1XI
	AKygxC1yx9gBQ3Zsj8vbsJjd1JT7fwYjb2FV48vz/KGXZ+XlhyK13GGHxzaKfMZW
	WEfa6u+g/1CAuq0waJ8Shc3OA9fEdau6hHkg+koyA7R7pG4OZO1pt1bF0O8Zaeaj
	vDF9H3WenbM3HpdftbGPlcAFfFFMAyh915Wc2SpAZBR+LZDZe9rT/jyaIv0tGx+G
	aH6uZ+j8DV5umluPJ74CxrUfeYD94IGTqzFSdaVQscZxyuWqkaO7cLpoGocUlPpR
	FZwgpRRczn6lN2aTT9LJ1kuM7gX1Ut63AsWNan8A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kaxrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:41:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BOMGU014361;
	Tue, 7 Apr 2026 13:41:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4kbbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:41:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637DfR0n36700522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:41:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E5002004B;
	Tue,  7 Apr 2026 13:41:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FFC420043;
	Tue,  7 Apr 2026 13:41:27 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 13:41:27 +0000 (GMT)
Date: Tue, 7 Apr 2026 15:41:25 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 5/6] KVM: s390: selftests: enable some common
 memory-related tests
Message-ID: <20260407134125.331757-C-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-6-imbrenda@linux.ibm.com>
 <20260407124752.296205-E-seiden@linux.ibm.com>
 <20260407150438.16c28bed@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407150438.16c28bed@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNSBTYWx0ZWRfX+Z7oGwp4tMxC
 b0VDHRi9PWQc1Ee0IfJQtWW+86zkI0l7id0bSrjOuItsF5J97N97eOhntt6eJDrW1md2ouZ/oXM
 5AGGTknCW5jns9jDOcs/8BLAO5mDFa6s26VPoDr1q3fK7n0h8YHO+q+VAk9cpnyRY1AvTayBkKJ
 /PL7KeSh7lkTLlCH9Aybx2YcfQv5GJJ3lQh/bfrCX+o77cNADrobajGUkOXb9u6y78pV15QxGPn
 kuEF7HrQp8/K3zcOBwkcwgtmqTHZrvpdp9tZDlUeMHEMmnm7an8c5UOTnj/X6ZrK7nbDiowEBW2
 s+55lOBw54IF0sCyJES6fh9a5C5ceGurWe4TU5EjD98W5V6NavvlmbDOXi/aPdBF21tYE3wG3vs
 oWgmt2ga11P1tAl29OM8YvStkYnhzrbwhl/gHSDgWDDpJ/rl9BGVPIGx0EAJbhGB85ztp/NiiOH
 hDKQ160x11BK9kixLKQ==
X-Proofpoint-ORIG-GUID: R4TeGZmDtEFMYmmtvEBZebMD8zHUzIQY
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5098b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=RDZPgTbyyryNPOe_llkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: R4TeGZmDtEFMYmmtvEBZebMD8zHUzIQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070125

On Tue, Apr 07, 2026 at 03:04:38PM +0200, Claudio Imbrenda wrote:
> On Tue, 7 Apr 2026 14:47:52 +0200
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> > On Thu, Apr 02, 2026 at 05:01:34PM +0200, Claudio Imbrenda wrote:
> > > Enable the following tests on s390:
> > > * memslot_modification_stress_test
> > > * memslot_perf_test
> > > * mmu_stress_test
> > > 
> > > Since the first two tests are now supported on all architectures, move
> > > them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.
> > > 
> > > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile.kvm | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > > index fdec90e85467..057f17d6b896 100644
> > > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > > @@ -64,6 +64,8 @@ TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
> > >  TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
> > >  TEST_GEN_PROGS_COMMON += kvm_page_table_test
> > >  TEST_GEN_PROGS_COMMON += set_memory_region_test
> > > +TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
> > > +TEST_GEN_PROGS_COMMON += memslot_perf_test
> 
> [...]
> 
> > >  TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
> > >  TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
> > > @@ -214,8 +213,6 @@ TEST_GEN_PROGS_riscv += arch_timer
> > >  TEST_GEN_PROGS_riscv += coalesced_io_test
> > >  TEST_GEN_PROGS_riscv += dirty_log_perf_test
> > >  TEST_GEN_PROGS_riscv += get-reg-list
> > > -TEST_GEN_PROGS_riscv += memslot_modification_stress_test
> > > -TEST_GEN_PROGS_riscv += memslot_perf_test
> > >  TEST_GEN_PROGS_riscv += mmu_stress_test
> > >  TEST_GEN_PROGS_riscv += rseq_test
> > >  TEST_GEN_PROGS_riscv += steal_time
> > > --   
> > 
> > I think you missed removing the loongarch targets.
> 
> no, loongarch does *not* include TEST_GEN_PROGS_COMMON, so if I
> remove them, they're gone

Ok, my bad. I just did a quick grep for the test names to look for missing
removals. I missed that little detail.

> 
> > 
> > 	Steffen
> 
