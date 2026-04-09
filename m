Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AF2874F8;
	Thu,  9 Apr 2026 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724645; cv=none; b=HMSzw0SVY7YbbcTbMWs2SG37txfrJRGOuooQcSG7XFJIQ6P6h+MnOogVN2a+9PCAzrwfcFnWhCl6ZTOvlwoXISWzyurh7FCALxc1JlduGNbYNNlQTXO2kLwkBXWwuf1si/RpdG305DaYs8aZ5BhQAZo/ZSQQWg9VYK9x59fCPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724645; c=relaxed/simple;
	bh=RzxrDc1TtWze98S8SuQzghiSNmUpz1rfD5GWWPB8UcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APteHiROl25F19yPaPTmO9cN6avKZwNkZ8rL1nh4LmiExD9/dTLE24F/x9uoX+O8TOWt1G7BM2VNKNpmVaq5rk2PmQjScneM/851U7usjmAi8aXFInqt1f6wuy/AI2SaQ+t0o7Wobkxw3A3QPIMiQ06ksa3l+QOBG8FeiNQ8rHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bmyz2whs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bmyz2whs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638HKHCY2210127;
	Thu, 9 Apr 2026 08:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yYBJdE
	bipofweVfOi9L+AKvcf6NdhG8fe3Ja4W3Vy0A=; b=bmyz2whswCWiMDBWiVRDAd
	M8yyyNDUgmdsti1AIZlilKYGTtVYrtuzAUenoS1EPRN+34jK6e8BHQRfZl9fzXzp
	DbSDQagn9HQpLZMA8dyZJrPB5YmdIEovvav5sNtG4ECelGZdMq90Km7VZE8l2PX8
	RAZLTVWEnFyTI38ALxTf0vsJ0dToNKh5fK0mOb9mmaJscy4VzN5ZSvNTxX4cfFKm
	jfYqgdhC4cCMJfJpdLwQXSke+vjJtWZ0UIyrIjw1SMwsP31CMcknm8wFFtJ5ZGnE
	s57GH2lHPExXB6TrhaM1sPuB7h2od48fwrIYVe+O+8ZKl52nGs1tKbSZ63CVrWhA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hk8a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 08:50:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6397jmsI018877;
	Thu, 9 Apr 2026 08:50:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9jvpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 08:50:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6398oW2N18546974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 08:50:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 967AB20043;
	Thu,  9 Apr 2026 08:50:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC8520040;
	Thu,  9 Apr 2026 08:50:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.130.74])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  9 Apr 2026 08:50:31 +0000 (GMT)
Date: Thu, 9 Apr 2026 10:50:29 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org,
        pbonzini@redhat.com, shuah@kernel.org
Subject: Re: [PATCH v3 5/6] KVM: s390: selftests: enable some common
 memory-related tests
Message-ID: <20260409105029.5c85acf8@p-imbrenda>
In-Reply-To: <20260402150135.196943-6-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
	<20260402150135.196943-6-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3NyBTYWx0ZWRfX2JT2rYJNt7TV
 zkDiYDQOq9+9ujDi255UMBDgQWs8sr4XVPiO8KAuiSZF2n4EtOJKgtO5fjtL7mAIj3qd12idc5C
 9UO9XUWzwdtlCEOhbFMnFlJNfN5lx3h5eAjGz+TUH8yrmtuNBK+NJbQj26EIZTlHOvbXQWJCiUF
 9eRpy38BTHWvV7Onaqc422tdXd6dFAAM6xgNj1aBefyOVisoMuAJnvqXcKLC55n/5y0e2ymqB9X
 787CVUrKqPLqiCPjeIAIa7z4crt2L74MOGM9mLFMIqSp5unu18BkgY0E21/LqRghEue8qJgpMGM
 J/tEqFPjJaBOEkN6gtOpw4WtI91rACjbp/fpTtlzCx+GuSvIkKNnw+SYQNnIsskx+gxgfrhcJlZ
 ClbMzZ3CPUD6FbXkS5519Bp3q7hoAmQPkhAJq9EC2cXW90S3SB9TQ/HaMVMD+6zzQuT1OWeEZoL
 7cfJQY4pqL/juSnxYlw==
X-Proofpoint-GUID: 8AqncheYBUIAWlDTtSLweSA6iHMFRRUK
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d7685f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hzsNpJRy4UFlppPDqzgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 8AqncheYBUIAWlDTtSLweSA6iHMFRRUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090077

Just realized I had forgotten to CC Paolo and Shuah, since this patch
touches common code.

the changes are rather trivial, but they should probably also have a
look :)

(as I already replied to another comment: loongarch does not include
TEST_GEN_PROGS_COMMON so it should not be touched)


On Thu,  2 Apr 2026 17:01:34 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

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
>  TEST_GEN_PROGS_arm64 += dirty_log_perf_test
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

