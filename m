Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59080372B3B;
	Tue,  7 Apr 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567092; cv=none; b=nqeckBhY8W4mY4FO82UIJ8SgigSIkwLPXE5Lz3cPuLQq7DIMKzwosj/AdJrNMLhJ5pn+WmthHtw8G9gSjeu9qyDRUFPCvhFZkfCkW4a6BjZbDW1IRRaqpT0by2cnpfBZ5qLULz10iSIjNAnwJpRyZHk7XoGyiTMPcxtSj3UXqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567092; c=relaxed/simple;
	bh=Gf7a/LfScT+gKe63+jd9n5316CuGPp6x+YG2MLJCXuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TH1vMeE+Vk5AJchxeDWtquO8y71E4q+BjeNRT5DVfKJGmz58m7rDCTrRN0xWYTZD6d0+RZWMlrNjkKVTFeRhQD239CCVAUOosSu/H2pMbYU9SE71y8nhhnC1jbigyPWkZw7PdcrkrLVUfApwjr1j+vQrDHDjzwa1TyrpOA8xAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=stYdr9o4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="stYdr9o4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LnQ0q2213384;
	Tue, 7 Apr 2026 13:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pVI281
	I07tMXBHxIedUg5WIXJ1IrJrHQhiubs/5w5ZQ=; b=stYdr9o45/WR8TLDFVcRaL
	Gz1k0BSZ92mWWSouu7EbnusRD0LC3UXzBE2zQlu8JjnXv+N+7rJwCQ6fi1Xpqzkb
	Tj/mTYE/u1gojz8Bfm2O8r7qxQ1/TE2qMNKdomNy8U8sraxLEAGPeLAAELPZaRcP
	A3zHQAgkXBeuSwLDLYPW5TtQY4MC6GvwvnI6rzSbC0GQATKJwR9mDblhpdm2UbLm
	Z/LBEoDTBldRaBWuv1R81esorLSaV2N9qIp17+I/1v+V0E2klAMqL7cDAM4bue3N
	cvc4Ck9TahVCxnVKIMjJq8LxdZ+SOfYuWAHvM+JTYFHEyEfsa42IdZkwEn0o81Eg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hasab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:04:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BLhWB013824;
	Tue, 7 Apr 2026 13:04:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf43897-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:04:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637D4fgA28246536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:04:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646F820065;
	Tue,  7 Apr 2026 13:04:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3D4B2005A;
	Tue,  7 Apr 2026 13:04:40 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.4.78])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  7 Apr 2026 13:04:40 +0000 (GMT)
Date: Tue, 7 Apr 2026 15:04:38 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 5/6] KVM: s390: selftests: enable some common
 memory-related tests
Message-ID: <20260407150438.16c28bed@p-imbrenda>
In-Reply-To: <20260407124752.296205-E-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
	<20260402150135.196943-6-imbrenda@linux.ibm.com>
	<20260407124752.296205-E-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMCBTYWx0ZWRfX/kBhF9KnpCAD
 0cVHEYMlPmrR6mLWZ1AmRhUdUsE+Pb63pNZtVryBM+qSTZd5PISApy/S9PdeT9j+QS8lXtuBjwd
 rrusBrtLmEbKsjyXhUp9ebiNzYEtCqLj3coEZws4l0Xx0csCwEAOT1h2vcFeb7moyfBhwIN9nDR
 b+ZkifPsGUEiOOfFd4Yns8R/q+mvBmElY/fDwcc8yNMYyVnSapGn2G7DsCxPimi8ZyOiwGSKOH1
 0DgXv5HMV5EcDO0+gkSxpbOIS0yG841OiToE5jwJhV6WuT2wTIZqAuGInZRz84X1/Mb0Dm8kuUm
 MH8uHC8ErOalGjIoW5HVEVi2QAAi3lglka4vYP8zteggCY/T6Vl2drfhyqKTAjhwQHkiqyZb7WB
 LWcBHaM8WRXEJeGSJg69KLRCywa4IxhKY6GArH/0XprhJ4gXgAQLqwNDJfJC8xAWbGOkSscx/kl
 kVBoVC1s4w4D61IVHuw==
X-Proofpoint-GUID: c6hE6f0be3x9rDNkJgQl5BpPNUxGWHTi
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d500f0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=M768wtZThv6Po2imMZYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: c6hE6f0be3x9rDNkJgQl5BpPNUxGWHTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070120

On Tue, 7 Apr 2026 14:47:52 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> On Thu, Apr 02, 2026 at 05:01:34PM +0200, Claudio Imbrenda wrote:
> > Enable the following tests on s390:
> > * memslot_modification_stress_test
> > * memslot_perf_test
> > * mmu_stress_test
> > 
> > Since the first two tests are now supported on all architectures, move
> > them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile.kvm | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > index fdec90e85467..057f17d6b896 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -64,6 +64,8 @@ TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
> >  TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
> >  TEST_GEN_PROGS_COMMON += kvm_page_table_test
> >  TEST_GEN_PROGS_COMMON += set_memory_region_test
> > +TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
> > +TEST_GEN_PROGS_COMMON += memslot_perf_test

[...]

> >  TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
> >  TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
> > @@ -214,8 +213,6 @@ TEST_GEN_PROGS_riscv += arch_timer
> >  TEST_GEN_PROGS_riscv += coalesced_io_test
> >  TEST_GEN_PROGS_riscv += dirty_log_perf_test
> >  TEST_GEN_PROGS_riscv += get-reg-list
> > -TEST_GEN_PROGS_riscv += memslot_modification_stress_test
> > -TEST_GEN_PROGS_riscv += memslot_perf_test
> >  TEST_GEN_PROGS_riscv += mmu_stress_test
> >  TEST_GEN_PROGS_riscv += rseq_test
> >  TEST_GEN_PROGS_riscv += steal_time
> > --   
> 
> I think you missed removing the loongarch targets.

no, loongarch does *not* include TEST_GEN_PROGS_COMMON, so if I
remove them, they're gone

> 
> 	Steffen

