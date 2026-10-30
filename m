Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363996;
	b=V0Z3BKYZ3vdgr8Akr6mrq50hNdf2En/6LOsVY+SwQsh2DU1md0IHzVbD2QWpoEjeSIbh
	 vzX41jkOdXLzEpAq7i8+g1YnCfrkx7Cq7G6/LDT+eabj1BbZmOCEaX2PvWpRGwSQaPFSC
	 i5L2GKL8vjnv0q57V/GsBPIhjtbvTjj/zTXOQHjFrnTKwxYtF0ZL2Tmctq15HjBpd60qT
	 4qOiu3nRvg8APFcOAcHOQpzL3iHDAIaTD5tAiSLTmBauRm81CXEaGnedj3UW+21fvITr6
	 RSI6Yl1+huY0HKPggpaqYvOjU+KbuWrzq6QiEsfarQIRdURRMJUQpM7eonU6t6boWHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363996;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Hf2vqOVmxPZeSiH1jBcR5wYyL9ei7taDnwV0lKuVX0o=;
	b=Ym8dAZoHpAvsQBRU8nCa5LtkXJQYaDIAcy53KPySxTiaPbfu+PLaXE2U1ZKXbRi9l9lO
	 MYX5SkqA3j1vvqgQgXWLWE+LQlTyaxplimPZMZJYWAaGw8Dszel6qcYTZ4vhoA7AMgf1l
	 GQAUmpXmwfRfQ4s4YUucyJND13GkEYFg2Or++TVa6TgzbPzmXB8uvub+d2ZZ6C8/SWcd4
	 dQXMlp4lnbZNURcOhw4rrYPY8eY+SBEVmWCJ96dE4e/oPQADEiD6sQmtCx3OktWjoNKub
	 JI7A+w/JVB5FWWYw8f124OJct46oyL3Wc0ih1g5uekhSaEoiZg1eoL9J7HTq8vCT3Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PZS5RVWS;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBFE606A31E;
	Fri, 30 Oct 2026 12:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PZS5RVWS
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBK4ak2700713;
	Fri, 30 Oct 2026 12:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hf2vqO
	VmxPZeSiH1jBcR5wYyL9ei7taDnwV0lKuVX0o=; b=PZS5RVWSd4lOTxAg3nd8yg
	kjXFLqbkFQ9pVwzxE8uu8aydbSoxBlBhS9kqtPRoKwrl+c1rkl+InrQxXR7KBAM+
	0D2X+zQXcSxStI7Mp65K6S9V2VIy8O11L8YcxJ0emcncaDMatXIPc07u4qUzdhQf
	DetYaJ2zo3qqsuChBPNY2qHNniGp9u0TRUfbmorJjeph1S47ZAt0pQ4h/LYjMVh9
	yotnqJEV1zpM6vBE85Ahsq4HmmhwrgkqpZedF6XJWMV9unzsy89NQo9bmPE7liv8
	LIMaF7jZ6N8C7SdvIG/BD08Ly9nqml7xdy6JYj+X3dbcxlXJjsegR2m9zLL4Nvlg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeb02pgj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 12:39:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBJr7c434443;
	Fri, 30 Oct 2026 12:39:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e4js6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 12:39:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UCdi808782302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 12:39:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 067D220040;
	Fri, 30 Oct 2026 12:39:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 581FA2004D;
	Fri, 30 Oct 2026 12:39:43 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.135.180])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 30 Oct 2026 12:39:42 +0000 (GMT)
Date: Fri, 30 Oct 2026 13:39:39 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, seanjc@google.com,
        pbonzini@redhat.com, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
Message-ID: <20261030133939.630e29af@p-imbrenda>
In-Reply-To: <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de>
References: <20261029143336.390231-3-clopez@suse.de>
	<20261029175203.5bdd51d7@p-imbrenda>
	<df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de>
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
X-Authority-Analysis: v=2.4 cv=bLaDs/+Z c=1 sm=1 tr=0 ts=6ae49012 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=OGjWj8McAAAA:8 a=gEwWiA4BuH6QpBxenCwA:9
 a=QEXdDO2ut3YA:10 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-GUID: FR6xmas1cPVLkScZELPts4BZpCfTOo1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX67kcuq+ZE4Am
 n7XYZsNsDdixdKb+kWJvsG5nfRQugaGkoMLgmz6VaRhpP6HO/VWGhYAqNrvHCV8UmjpaHAHerVi
 rS017UEq2sxdKW48U0HHNAd22qxT5v5E7On5UMeNdUyLIRb5G3NkJSlGgKCO4daiJzNGFexBvh8
 pzxoK5xs4YIuRlwrbgiwalARy3RyuNbY/nM+ho+uAQHkSCxQkKhqZtWafQmcUfTTzcDO/yKm5r8
 xjzGDJzn0Cl0MlA044Ibzz2GdYoeo9v7VUlJI1ddbEs152piMuZtyzSmdCjvk7Q42oK5xLS3YN9
 ruKcHomDLZI1VCdS+eQOHvn54CX4ZXEDCEGjZMo/jdhy9Yx2RxX0GkjBKK3TCYKHxZ1o053htOM
 Xz14khANu3DUwtvFfNj8d9mf9mV1rTbm8acMZ7T8TbmZ4RY1y1iUoXmKMdCsBqzmlhXQoetiA0N
 7zaN8OMt3OPF/Q82Riw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OCBTYWx0ZWRfX1sxtPaFQs/HX
 5L+Q3SUm57KyRb8800D87oJR6O/kLA0srS3EFQ+qKWwQQT0wmy1RvTiE8VYQ75x+dCVN/uZOvFX
 RYeG6ahAlK2bY8LQP/M9UhlqzR4sNc8=
X-Proofpoint-ORIG-GUID: 8ef1u-oL4y62RhtKrr36jM_2w4AU8TWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300048

On Fri, 30 Oct 2026 12:11:07 +0100
Carlos L=C3=B3pez <clopez@suse.de> wrote:

[...]

> > regarding this series:
> >=20
> > on x86 you don't care what the new permissions are, because you're
> > updating when re-faulting (if I understood correctly). =20
>=20
> Correct.
>=20
> > for s390 it might be beneficial to know what the new permissions are;
> > of course we could look up the vma and find out, but since you are
> > already checking the permissions, maybe you can find a way to also
> > convey the new permission bits?
> >=20
> > that would make our life on s390 easier :) =20
>=20
> Right, getting the new bits from vma->flags should be trivially done
> from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
> this series though. The rest of architectures still need the notifier to
> tell them if the change is an upgrade, since they don't have an easy way
> to grab the old RWX bits. Passing the old RWX bits from the MMU notifier
> does not seem trivial to me either.
>=20
> So what I can do is to plumb down the event and flags into KVM, and
> leave it open for you to come back and forward the permission bits you
> need via the range flags, if the MM maintainers are okay with it.
>=20
> However, I tried to understand the s390 code better with AI, and it
> seems to think that skipping the zap is also safe there (and an
> improvement). It could be further optimized by passing down the new W
> bit to eagerly fix the gmap when restoring write permissions.

right, the fast path would fail (gmap_try_fixup_minor()), and the slow
path will call __kvm_faultin_pfn(), which will update the flags as
needed.

knowing whether the new mapping is writable would allow us to set the
w softbit (which is a fast operation), thus allowing the fast path to
handle the fault afterwards, instead of the slow path.

but even just avoiding the zap would surely be beneficial already

I can try to test this next week and see if anything explodes

>=20
> >>
> >> Benchmarks
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> AMD EPYC 9654 96-Core Processor host running a recent Linux kernel
> >> (6b4b543fa187), with a 64GB, 64-vCPU guest running stress-ng --vm while
> >> the host takes a QEMU background snapshot. All results are aggregated
> >> over 5 runs, and compared between the stock kernel and one with this
> >> patch series. Guest is rebooted across each individual run, and NUMA
> >> balancing is disabled.
> >>
> >> pf/s and tlb/s (per-second deltas of KVM's pf_taken and remote_tlb_flu=
sh
> >> debugfs stats) clearly improve:
> >>
> >>   guest pattern          baseline                    patched
> >>   --------------------------------------------------------------------=
---
> >>   read64   (read)        pf/s=3D950,015   tlb/s=3D1,440  pf/s=3D2,503 =
tlb/s=3D0.1
> >>   rand-set (read+write)  pf/s=3D1,004,353 tlb/s=3D862    pf/s=3D4,073 =
tlb/s=3D0.3
> >>   write64  (write)       pf/s=3D968,018   tlb/s=3D94     pf/s=3D2,292 =
tlb/s=3D0.3
> >>
> >> Guest read latency was sampled with a paced probe thread in the
> >> guest, reading one byte per page with an idle gap between reads, while
> >> stress-ng ran with read64. Each figure is the median across 5 runs, wi=
th
> >> the run-to-run min and max, in ns:
> >>
> >>   metric           baseline             patched
> >>   ------------------------------------------------------
> >>   p50 (min max)      340     (270 380)   260   (250 260)
> >>   p99 (min max)    19789 (16885 20200)  5207 (4076 5638)
> >>   p99.9 (min max)  23445 (22845 24036)  6850 (6259 7110)
> >>
> >> The median improves modestly and the refault cost shows in the tail,
> >> where p99 drops ~3.8x.
> >>
> >> A separate stress-ng run with write64 and --verify showed no data
> >> corruption and no livelocks.
> >>
> >> References
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> [1] https://lore.kernel.org/linux-mm/cover.1eca029b8603ef4eebe5b41eae5=
1facfc5920c41.1690292440.git-series.apopple@nvidia.com/
> >> [2] https://lore.kernel.org/linux-mm/ZGu1vsbscdO48V6h@google.com/
> >> [3] https://lpc.events/event/20/contributions/2552/
> >> [4] https://lore.kernel.org/all/20240801183453.57199-1-seanjc@google.c=
om
> >> [5] https://lore.kernel.org/all/20231110003734.1014084-1-jackyli@googl=
e.com
> >>
> >> Carlos L=C3=B3pez (4):
> >>   mm/mprotect: add MM_CP_PERM_UPGRADE
> >>   mm/mmu_notifier: add MMU_NOTIFIER_RANGE_PERM_UPGRADE
> >>   KVM: plumb MMU_NOTIFIER_RANGE_PERM_UPGRADE into kvm_gfn_range
> >>   KVM: x86/mmu: don't zap the secondary MMU on permission upgrade
> >>
> >>  arch/x86/kvm/mmu/mmu.c       |  7 +++++++
> >>  include/linux/kvm_host.h     |  1 +
> >>  include/linux/mm.h           |  8 ++++++++
> >>  include/linux/mmu_notifier.h |  5 +++++
> >>  mm/hugetlb.c                 |  6 +++++-
> >>  mm/mprotect.c                | 20 +++++++++++++++++++-
> >>  virt/kvm/kvm_main.c          |  4 ++++
> >>  7 files changed, 49 insertions(+), 2 deletions(-)
> >> =20
> >  =20
>=20

