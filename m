Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292741;
	b=GNYEki7KgHcThpxvPHi+dxvb3ZH5GE29hmtuOFQfxx4vOdjfwq8dL9Cfzw7Pm4OUJFgw
	 iQvm2PFUQ623UoRy3hZlzhlI2yWC7VNM0Toq4atRrbDRbC5KeQEJnrZPgNl5YYXsTP4f0
	 KjpVGNHiIs4UL+zMTxv30Kdjzjp3XfE79G6intgWUD5hslsEFwnafVctAa9+F9cLpYK6w
	 Z8b5hfTGLFlJGdsGkQc2vxhAT2zZ0fWbntc16arBr9AsoGXqa8fjVxBhAzT5zlMFwMFj+
	 B6gviyl8XJBYdTjMdM0kXD7Sr5AVw/DgJACyZvoynTNmmOV9Cpp5NEVVdz5DoxnRemQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292741;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JooeTFkFeZdEQkl6ND7vys5Grz+V81uWtbjw+kB5qQ8=;
	b=vENKwM8TlZH6vereWWmPN7LC4wNpVugMHR+/4cAWjsWRdyO1oPxaZnYYXhX3+ngzVqFp
	 n+Iq3qeTSIBaSLzkwpJQeuLJFnGq1DdaoFAEdPbGg4J2W6qmhtRrJTrEscHY3dpSPEM0+
	 0mdt1/3+I8mgzJpoF3UXpgyGJFcKSWeGAO/cbRRbVbJai/ho/w029SoeTZzxEMXjIJBNr
	 FWxMkSVU98UyNEJlhuEp3pJvh4ZDyFzAa0EA950Ut7a4Xb6VJaTi/zZ/ZbedsN2s1SWpp
	 MbHRsKfwGSAO6yvg1fXx3iHqZEovCYdZ7z91WUY+p7b3Jf4zrgUXfuH6/DcRjc4rNHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RDyID258;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8F606A31A;
	Thu, 29 Oct 2026 16:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B8F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RDyID258
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGE57P671549;
	Thu, 29 Oct 2026 16:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JooeTF
	kFeZdEQkl6ND7vys5Grz+V81uWtbjw+kB5qQ8=; b=RDyID258cMyxLC1tKGbIxk
	NTASEu9fgPKTPLE2ewpsnanMes2HliyTztOFCwFm5iBQiumW8JN7Hfyg/FWy9e8A
	mPq9l0SF2iMmVI2TlUDmTp+yl6AbGz/BdVLSsupeNii6UfbTRN+kzAfKTYe/2MCA
	24a8FBsDCHPmfnPYVIaX1cwPu9+VrowNPVYb+1ar0hCL1jSg9+VD3EYKdAve7tnt
	RPKfUPbXTpceQ5u8/gYjXe15KByL6YXHTyD7zldH/3qoaQ89gyd8NX+yDB8KcON/
	bJoaptuufUH087LxWIRO/rso3raafTX16MzsIgE3U8/8mJvMpAsi/jA2B9ZNqA9A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm64bknt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:52:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGJnmE3392668;
	Thu, 29 Oct 2026 16:52:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e12v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:52:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGq5qm56492346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:52:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26C12004B;
	Thu, 29 Oct 2026 16:52:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E3320043;
	Thu, 29 Oct 2026 16:52:05 +0000 (GMT)
Received: from p-imbrenda (unknown [9.68.31.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 29 Oct 2026 16:52:05 +0000 (GMT)
Date: Thu, 29 Oct 2026 17:52:03 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, seanjc@google.com,
        pbonzini@redhat.com, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
Message-ID: <20261029175203.5bdd51d7@p-imbrenda>
In-Reply-To: <20261029143336.390231-3-clopez@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfXx6UdmsdZJ5uq
 4SBWHjKCj33E/5AWMgEh0WWGowV4uCTCnYMbLs+41hJTD62QDwxEiTmH99XxHhcR7lmLesqH+NG
 cPO9LA5wX9aBsdU7K9FqhzaAc8IaE9U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX3Op2rO17bqhc
 N3aweLd5V5+ZMeNtlsQNeDD3L8VyTvx9o3+3D9zRmFnCa/c2u1gxWAXB2kj4peUifDA7d2o7I0J
 xvk+ON9ChQRqultX9hFQfI1cQxZjWnFajXwkjiNrnv6YvfMhktdffwQeKKlmHM8/0tKNykc2rdi
 mNFfmMMbUejGR+npYqJUMSdyh+kUhFSvWSD+m7I/qNHW5Zb3QDvquE2lecsxCYPFkwwVAoRWyiv
 PktYORk2ftmckyhkyTHkgJYgF3w4rkvxsxDsl3Q2aTQyoWGltQ59Wyg2vqKpe5gpSMke8U4/O9b
 X5w9po5gnipiCnmITp8Otc+zLWTeDHmfPeAi/eNatmlDfoa0gG73Nn41e/u5TWXtFcgBeTObzu0
 EWel+Pg4cyqgmn46cMMAIf7QMJitnPHGXqM0JnuJI11OI3SNuUSA8STn7phDHWcLrsHJqTDIlbH
 Y6USDixlNawTaWzQ/qw==
X-Proofpoint-ORIG-GUID: qOGToXewIEgxE8Z0yvQ72HahQG9QDnh5
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae379b8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=OGjWj8McAAAA:8 a=ByQFhZ5OTr0xIyoFu1UA:9
 a=QEXdDO2ut3YA:10 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-GUID: uZy4EJwURba9PQ9Xme3MN3woR2o8K-CV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290065

On Thu, 29 Oct 2026 15:33:33 +0100
Carlos L=C3=B3pez <clopez@suse.de> wrote:

> Prevent x86 KVM from over-zapping its secondary MMU on PTE permission
> upgrades, which leave the PFNs unchanged and do not revoke access.
> Permissions for SPTEs that KVM holds are updated on the next fault, so
> dropping them early gains nothing.
>=20
> Do this by adding a new MMU notifier flag to signal that a
> MMU_NOTIFY_PROTECTION_VMA strictly upgrades (loosens) permissions on a
> particular range.
>=20
> See below for benchmark results.
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> change_protection() pairs every protection change with an
> MMU_NOTIFY_PROTECTION_VMA invalidation, and KVM zaps its SPTEs in
> response, as it cannot tell whether permissions widened or narrowed.
> This is costly e.g. during a QEMU background snapshot, which relies on
> uffd-wp to write-protect guest RAM and then restore permissions as each
> page is saved. Without this series, the permission restore causes the
> guest to re-fault read-only memory needlessly.
>=20
> Note, the reverse situation is already handled for secondary MMUs
> that reuse the CPU page tables (e.g. ARM SMMU, IOMMU/ATS). They cannot
> refault, so they are notified of a permission upgrade on the CPU
> TLB-flush path [1].
>=20
> KVM, however, owns separate page tables and faults permissions on demand,
> so it needs no such notification (as Sean noted when that signalling
> was first proposed on the fault path [2]). This series applies the same
> principle to the change_protection() path, signalling the permission
> upgrade so KVM can avoid the unnecessary zap.
>=20
> RFC Considerations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 1. Having the zap skip in KVM's arch-independent code does not seem
>    obviously correct, as s390 caches additional translation state
>    that may not be rebuilt by refaults. Maybe an expert can correct
>    me. The skip could be extended to arm64 and RISC-V, but I have not
>    benchmarked the benefits and I'd like to get feedback first. Hence,
>    x86-only for now.
>=20
> 2. change_protection() could simply not emit the invalidation at all
>    for a pure permission upgrade (shared-page-table MMUs invalidate
>    on the CPU TLB-flush path, as noted above, so they do not need it).
>    But again, the s390 case could be broken, and even then, that would
>    seem too much intrusion for KVM's benefit.
>=20
> 3. The flag reaches KVM as a bool on struct kvm_gfn_range.
>    Alternatively, KVM could forward the notifier event, as Claudio
>    Imbrenda suggested at LPC [3] and others have proposed in the past
>    for different purposes [4] [5]. That, along with the event flags,
>    could serve the same purpose. I'd be happy to take that approach if
>    there is agreement that other consumers would want it.
>=20
>    (The LPC talk recording has some audio issues so I am not too sure
>    on what the final agreement was)

AFAIR the consensus was:
- adding the reason to the kvm kvm_gfn_range is fine.
- having a return value from the notifier to pass information back is
  _not_ fine; I should add a new callback instead.

regarding this series:

on x86 you don't care what the new permissions are, because you're
updating when re-faulting (if I understood correctly).

for s390 it might be beneficial to know what the new permissions are;
of course we could look up the vma and find out, but since you are
already checking the permissions, maybe you can find a way to also
convey the new permission bits?

that would make our life on s390 easier :)

>=20
> Benchmarks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> AMD EPYC 9654 96-Core Processor host running a recent Linux kernel
> (6b4b543fa187), with a 64GB, 64-vCPU guest running stress-ng --vm while
> the host takes a QEMU background snapshot. All results are aggregated
> over 5 runs, and compared between the stock kernel and one with this
> patch series. Guest is rebooted across each individual run, and NUMA
> balancing is disabled.
>=20
> pf/s and tlb/s (per-second deltas of KVM's pf_taken and remote_tlb_flush
> debugfs stats) clearly improve:
>=20
>   guest pattern          baseline                    patched
>   -----------------------------------------------------------------------
>   read64   (read)        pf/s=3D950,015   tlb/s=3D1,440  pf/s=3D2,503 tlb=
/s=3D0.1
>   rand-set (read+write)  pf/s=3D1,004,353 tlb/s=3D862    pf/s=3D4,073 tlb=
/s=3D0.3
>   write64  (write)       pf/s=3D968,018   tlb/s=3D94     pf/s=3D2,292 tlb=
/s=3D0.3
>=20
> Guest read latency was sampled with a paced probe thread in the
> guest, reading one byte per page with an idle gap between reads, while
> stress-ng ran with read64. Each figure is the median across 5 runs, with
> the run-to-run min and max, in ns:
>=20
>   metric           baseline             patched
>   ------------------------------------------------------
>   p50 (min max)      340     (270 380)   260   (250 260)
>   p99 (min max)    19789 (16885 20200)  5207 (4076 5638)
>   p99.9 (min max)  23445 (22845 24036)  6850 (6259 7110)
>=20
> The median improves modestly and the refault cost shows in the tail,
> where p99 drops ~3.8x.
>=20
> A separate stress-ng run with write64 and --verify showed no data
> corruption and no livelocks.
>=20
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [1] https://lore.kernel.org/linux-mm/cover.1eca029b8603ef4eebe5b41eae51fa=
cfc5920c41.1690292440.git-series.apopple@nvidia.com/
> [2] https://lore.kernel.org/linux-mm/ZGu1vsbscdO48V6h@google.com/
> [3] https://lpc.events/event/20/contributions/2552/
> [4] https://lore.kernel.org/all/20240801183453.57199-1-seanjc@google.com
> [5] https://lore.kernel.org/all/20231110003734.1014084-1-jackyli@google.c=
om
>=20
> Carlos L=C3=B3pez (4):
>   mm/mprotect: add MM_CP_PERM_UPGRADE
>   mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
>   KVM: plumb MMU_NOTIFIER_RANGE_PERM_UPGRADE into kvm_gfn_range
>   KVM: x86/mmu: don't zap the secondary MMU on permission upgrade
>=20
>  arch/x86/kvm/mmu/mmu.c       |  7 +++++++
>  include/linux/kvm_host.h     |  1 +
>  include/linux/mm.h           |  8 ++++++++
>  include/linux/mmu_notifier.h |  5 +++++
>  mm/hugetlb.c                 |  6 +++++-
>  mm/mprotect.c                | 20 +++++++++++++++++++-
>  virt/kvm/kvm_main.c          |  4 ++++
>  7 files changed, 49 insertions(+), 2 deletions(-)
>=20

