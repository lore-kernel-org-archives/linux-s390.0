Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6169258CF9
	for <linux-s390@vger.kernel.org>; Tue, 20 May 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736637; cv=none; b=bpkKq7HLqYxVyC9RK4hBmzP8FYHYdQcIZPbzh3f1acT4yzOtK0spjKu4DZkomTfTchUXBuCM8/832VJuv9lHASNLPevaXu3u/A343y6ZdO3sLy9CK4DKMqPtNi2cj65MACIw2VP+4aGOUuKHCTqwKmTkA3emvGtOWIkFrWOLpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736637; c=relaxed/simple;
	bh=7umWF2YvjD0jJBYWzItANOsXOC6KvAB92RgO5GBJkBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmJepsKxf59ELGkF56bYzQ2wGUBqxF9z9hzHs2XvaFR4Lxg5Fs5lyB43eEBMd0MM3J/fq7Vpo3U+uIKij8rF3v7rx5g3yr/KRW3a+j0fJzmqe8n39By/mH5jrAf0TunqRAMN72hwZQK2kjEar9iOFq93tRgkN87v+vukicgfM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZhKDGg+j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZhKDGg+j"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9FBYt008525;
	Tue, 20 May 2025 10:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C7NNio
	cntfbPCZ588WWdSr/qkTQ63q8aMHfq3MfUcVk=; b=ZhKDGg+jX0NDwvNbNJDPpM
	ciueLmM8Ul/P0nAZ+eL0pr1p0EMagJMLvRwhXYy9LLiio/dDQqGBQKre8wKSDHG2
	cHQvlkoMkASAhKCgUyJ/8yRohTbJ3Z/vS5Ynka2c9FK6MOndGor2FzAGcz3zbIE2
	FFvQ1QQJ1Xd/B62Lm0JosLF1grsUSKUR09k3oyuZQjyNPcQo7VOWiRQbz4EfxKkr
	X86+JZ38/EzIGX6SDsLPCzUHkkthCJhY/9Sud56b1Pq6qhjch89DMqDdxTEy3Qg0
	fvlQ8G04rZ4FB8yOEkagxk3vTumAeCWFMeqImoOCBkMKWEkIFaOsN44MZ7lNGR+g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxkray7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:23:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54KANkGL031679;
	Tue, 20 May 2025 10:23:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxkray3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:23:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54K713kH002449;
	Tue, 20 May 2025 10:23:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q5snubhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:23:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KANhhV59703782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 10:23:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3419201CB;
	Tue, 20 May 2025 10:23:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F63D201CA;
	Tue, 20 May 2025 10:23:43 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.111.10.158])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 10:23:43 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
In-Reply-To: <20250512171429.GB615800@cmpxchg.org>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
 <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>
 <20250512171429.GB615800@cmpxchg.org>
Date: Tue, 20 May 2025 12:23:42 +0200
Message-ID: <87zff7r369.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EM8G00ZC c=1 sm=1 tr=0 ts=682c5832 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=ufHFDILaAAAA:8 a=cxcNUk2sTnefaYOuv1sA:9 a=QEXdDO2ut3YA:10
 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-GUID: n9cYqIxbMlZ_ELpfT3uYHINE_T4Z7Smc
X-Proofpoint-ORIG-GUID: kgnyDFtKd5ZtmrNp8vH6cGcogc4EHzw6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4MyBTYWx0ZWRfX/cSH9kWPSnpy 3MoPgsNQLpW4YtwZzujox0ChhKY84LYKm9Rq6tBD9lhGBBhb9R3rWXuqNbc/VhnwMNGyUBR9dsa KYhV6FoJUiZ9WZ2ys0iyDo91sXryoLziUn7pw6fPNA1NDuLGxCx6gRuAc99sz+bNChx4myRwhqI
 lDR8iMn89DdBzn961Ui/YM1nCcp9MDcKUQvuWwV4oywemTBkUWlIwtPzL8KS7JWpJSZUawKVENg RaIiGVYoz97eykxAOjbQIuUnOFZRCR8rcf3LWYJXfWwI4Lo0M2ER5SxArAuG1/1+lBvPhyFjHl0 6+1J6nUFdKiKE1EBjaSR6M2M1NrQNJOxbnooXxDDL6MrDKxePARf76VzagsZnd30NnWQqEMXuer
 TcMX9vC3FvYh2k01L4kBC3k1fY/AvY8Gg68dip2fK8rJNyriKhGhw/4D2cZudJONNgtZqAFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200083

On Mon, May 12, 2025 at 01:14 PM -0400, Johannes Weiner <hannes@cmpxchg.org=
> wrote:
> On Mon, May 12, 2025 at 12:35:39PM -0400, Zi Yan wrote:
>> On 12 May 2025, at 12:16, Lorenzo Stoakes wrote:
>>=20
>> > +cc Zi
>> >
>> > Hi Marc,
>> >
>> > I noticed this same bug as reported in [0], but only for a _very_ rece=
nt
>> > patch series by Zi, which is only present in mm-new, which is the most
>> > unstable mm branch right now :)
>> >
>> > So I wonder if related or a coincidence caused by something else?
>>=20
>> Unless Marc's branch has my "make MIGRATE_ISOLATE a standalone bit" patc=
hset,
>> it should be caused by something else.
>>=20
>> A bisect would be very helpful.
>>=20
>> >
>> > This is triggered by the mm self-test (in tools/testing/selftests/mm, =
you
>> > can just make -jXX there) transhuge-stress, invoked as:
>> >
>> > $ sudo ./transhuge-stress -d 20
>> >
>> > The stack traces do look very different though so perhaps unrelated?
>>=20
>> The warning is triggered, in the both cases, a pageblock with MIGRATE_UN=
MOVABLE(0)
>> is moved to MIGRATE_RECLAIMABLE(2). The pageblock is supposed to have
>> MIGRATE_RECLAIMABLE(2) before the movement.
>
> The weird thing is that the warning is from expand(), when the broken
> up chunks are put *back*. Marc, can you confirm that this is the only
> warning in dmesg, and there aren't any before this one?

Yep, I=E2=80=99ve just checked, it was the first warning and `panic_on_warn=
` is
set to 1.

I managed to reproduce a similar crash using 6.15.0-rc7 (this time THP
seems to be involved):

  =E2=80=A6
  root@qemus390x:~# [   40.442403] ------------[ cut here ]------------
  [   40.442471] page type is 0, passed migratetype is 1 (nr=3D256)
  [   40.442525] WARNING: CPU: 0 PID: 350 at mm/page_alloc.c:669 expand (mm=
/page_alloc.c:669 (discriminator 2) mm/page_alloc.c:1572 (discriminator 2))
  [   40.442558] Modules linked in: pkey_pckmo(E) pkey(E) diag288_wdt(E) wa=
tchdog(E) s390_trng(E) virtio_console(E) rng_core(E) vmw_vsock_virtio_trans=
port(E) vmw_vsock_virtio_transport_common(E) vsock(E) ghash_s390(E) prng(E)=
 aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha512=
_s390(E) sha256_s390(E) sha1_s390(E) sha_common(E) vfio_ccw(E) mdev(E) vfio=
_iommu_type1(E) vfio(E) sch_fq_codel(E) drm(E) i2c_core(E) drm_panel_orient=
ation_quirks(E) nfnetlink(E) autofs4(E)
  [   40.442651] Unloaded tainted modules: hmac_s390(E):1
  [   40.442677] CPU: 0 UID: 0 PID: 350 Comm: mempig_verify Tainted: G     =
       E       6.15.0-rc7-11557-ga01c92c55b53 #1 PREEMPT
  [   40.442683] Tainted: [E]=3DUNSIGNED_MODULE
  [   40.442687] Hardware name: IBM 3931 A01 701 (KVM/Linux)
  [   40.442692] Krnl PSW : 0404d00180000000 000002ff929af40c expand (mm/pa=
ge_alloc.c:669 (discriminator 10) mm/page_alloc.c:1572 (discriminator 10))
  [   40.442696]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 P=
M:0 RI:0 EA:3
  [   40.442699] Krnl GPRS: 000002ff80000004 0000000000000005 0000000000000=
030 0000000000000000
  [   40.442701]            0000000000000005 0000027f80000005 0000000000000=
100 0000000000000008
  [   40.442703]            000002ff93f99290 000001f63a415900 0000027500000=
008 00000275829f4000
  [   40.442704]            0000000000000000 0000000000000008 000002ff929af=
408 0000027f928c36f8
  [ 40.442722] Krnl Code: 000002ff929af3fc: c02000883f4b larl %r2,000002ff9=
3ab7292

  Code starting with the faulting instruction
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [   40.442722]            000002ff929af402: c0e5ffe7bd17        brasl   %=
r14,000002ff926a6e30
  [   40.442722]           #000002ff929af408: af000000            mc      0=
,0
  [   40.442722]           >000002ff929af40c: a7f4ff49            brc     1=
5,000002ff929af29e
  [   40.442722]            000002ff929af410: b904002b            lgr     %=
r2,%r11
  [   40.442722]            000002ff929af414: c03000881980        larl    %=
r3,000002ff93ab2714
  [   40.442722]            000002ff929af41a: c0e5fffdd883        brasl   %=
r14,000002ff9296a520
  [   40.442722]            000002ff929af420: af000000            mc      0=
,0
  [   40.442736] Call Trace:
  [   40.442738] expand (mm/page_alloc.c:669 (discriminator 10) mm/page_all=
oc.c:1572 (discriminator 10))
  [   40.442741] expand (mm/page_alloc.c:669 (discriminator 2) mm/page_allo=
c.c:1572 (discriminator 2))
  [   40.442743] rmqueue_bulk (mm/page_alloc.c:1587 mm/page_alloc.c:1758 mm=
/page_alloc.c:2311 mm/page_alloc.c:2364)
  [   40.442745] __rmqueue_pcplist (mm/page_alloc.c:3086)
  [   40.442748] rmqueue.isra.0 (mm/page_alloc.c:3124 mm/page_alloc.c:3155)
  [   40.442751] get_page_from_freelist (mm/page_alloc.c:3683)
  [   40.442754] __alloc_frozen_pages_noprof (mm/page_alloc.c:4967 (discrim=
inator 1))
  [   40.442756] alloc_pages_mpol (mm/mempolicy.c:2290)
  [   40.442764] folio_alloc_mpol_noprof (mm/mempolicy.c:2322)
  [   40.442766] vma_alloc_folio_noprof (mm/mempolicy.c:2355 (discriminator=
 1))
  [   40.442769] vma_alloc_anon_folio_pmd (mm/huge_memory.c:1167 (discrimin=
ator 1))
  [   40.442773] __do_huge_pmd_anonymous_page (mm/huge_memory.c:1227 (discr=
iminator 1))
  [   40.442775] __handle_mm_fault (mm/memory.c:5862 mm/memory.c:6111)
  [   40.442781] handle_mm_fault (mm/memory.c:6321)
  [   40.442783] do_exception (arch/s390/mm/fault.c:298)
  [   40.442792] __do_pgm_check (arch/s390/kernel/traps.c:345)
  [   40.442802] pgm_check_handler (arch/s390/kernel/entry.S:334)
  [   40.442805] Last Breaking-Event-Address:
  [   40.442806] __warn_printk (kernel/panic.c:801)
  [   40.442818] Kernel panic - not syncing: kernel: panic_on_warn set ...
  [   40.442822] CPU: 0 UID: 0 PID: 350 Comm: mempig_verify Tainted: G     =
       E       6.15.0-rc7-11557-ga01c92c55b53 #1 PREEMPT
  [   40.442825] Tainted: [E]=3DUNSIGNED_MODULE
  [   40.442826] Hardware name: IBM 3931 A01 701 (KVM/Linux)
  [   40.442827] Call Trace:
  [   40.442828] dump_stack_lvl (lib/dump_stack.c:122)
  [   40.442831] panic (kernel/panic.c:372)
  [   40.442833] check_panic_on_warn (kernel/panic.c:247)
  [   40.442836] __warn (kernel/panic.c:751)
  [   40.443057] report_bug (lib/bug.c:176 lib/bug.c:215)
  [   40.443064] monitor_event_exception (arch/s390/kernel/traps.c:227 (dis=
criminator 1))
  [   40.443067] __do_pgm_check (arch/s390/kernel/traps.c:345)
  [   40.443071] pgm_check_handler (arch/s390/kernel/entry.S:334)
  [   40.443074] expand (mm/page_alloc.c:669 (discriminator 10) mm/page_all=
oc.c:1572 (discriminator 10))
  [   40.443077] expand (mm/page_alloc.c:669 (discriminator 2) mm/page_allo=
c.c:1572 (discriminator 2))
  [   40.443080] rmqueue_bulk (mm/page_alloc.c:1587 mm/page_alloc.c:1758 mm=
/page_alloc.c:2311 mm/page_alloc.c:2364)
  [   40.443087] __rmqueue_pcplist (mm/page_alloc.c:3086)
  [   40.443090] rmqueue.isra.0 (mm/page_alloc.c:3124 mm/page_alloc.c:3155)
  [   40.443093] get_page_from_freelist (mm/page_alloc.c:3683)
  [   40.443097] __alloc_frozen_pages_noprof (mm/page_alloc.c:4967 (discrim=
inator 1))
  [   40.443100] alloc_pages_mpol (mm/mempolicy.c:2290)
  [   40.443104] folio_alloc_mpol_noprof (mm/mempolicy.c:2322)
  [   40.443110] vma_alloc_folio_noprof (mm/mempolicy.c:2355 (discriminator=
 1))
  [   40.443114] vma_alloc_anon_folio_pmd (mm/huge_memory.c:1167 (discrimin=
ator 1))
  [   40.443117] __do_huge_pmd_anonymous_page (mm/huge_memory.c:1227 (discr=
iminator 1))
  [   40.443120] __handle_mm_fault (mm/memory.c:5862 mm/memory.c:6111)
  [   40.443123] handle_mm_fault (mm/memory.c:6321)
  [   40.443126] do_exception (arch/s390/mm/fault.c:298)
  [   40.443129] __do_pgm_check (arch/s390/kernel/traps.c:345)
  [   40.443132] pgm_check_handler (arch/s390/kernel/entry.S:334)

This time, the setup is even simpler:

1. Start a 2GB QEMU/KVM guest
2. Now run some memory stress test

I run this test in a loop (with starting/shutting down the VM) and after
many iterations, the bug occurs.

[=E2=80=A6snip=E2=80=A6]
