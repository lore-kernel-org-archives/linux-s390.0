Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96221369A5;
	Thu, 13 Jun 2024 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322314; cv=none; b=L+x3iJx9eAxlEuFP1SpBPaT/w96TvTuIkXMMXaCqsk7iQsaUMg09oSNMo0hMCiRjX7lj+DvnNn9kCLpPvSa1HSW3ZZpTBYi22Jc1TXBsqB1NgwEgpUWhORvBlFKPlnkfzqoYlnqTYqgtJ15oyOslXcrCUCBQwXcYOrbdjmoRO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322314; c=relaxed/simple;
	bh=PaSlr40QJse6dHNYFDgd5wEKX7Bqje7vtvx/rk8HyNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhonki/FoBaTAXTKZvghHY0R7aQXVDXB1nw7/u+p2FYqe4j7qVqC2UiruBMxBCPDdQP8dHDI4oCPOE5R0Ya4iBkRU0dWFSVXtpIQfO9UCYs/9Ik3M6RirwEi3OWHBYrP082d+AfKlJdBzayNFywaPqeGvkNX+XEfEfc+ww95XKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mRoEpD07; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRoEpD07"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DNSkeK022003;
	Thu, 13 Jun 2024 23:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Noz5pwMBvsmGR387X0Jg77Dw0n+SZY9A1aVzP4jEPgA=; b=mRoEpD07Uz4yHmAB
	ljEEsA0x1Hos8hQIWkTwTgPpcsSGZSAO2Cw/r1HP/WycSTdd1SA141q+Y4EyIA/z
	HNbKBrL+WF8r1m6khtN+1zEAiYgZaOVqc9nrXiFiqy7wjdV+CsQM266Myei4R1A5
	grCuOIfurEcyeSNMbEILdhMYJKYDadbJxfGb33/mr8f45e3ELR1r6gWk5Q6JFaXb
	VcV9EpDjYTvrpDcTDmv2wJAEZr8t0ZRqLJHYVe5edjtjIVqb7Ebz9/TAhjFasf8M
	KQqI+hJQXQjRUh5OAP7Hjz6ZDBVEyilukaoWnUXHHCC6Hu4cd+0dSqiSANLMRJ+J
	I6DX0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrafg80vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 23:44:48 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DNiloE015324;
	Thu, 13 Jun 2024 23:44:47 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrafg80vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 23:44:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DMDGBr028710;
	Thu, 13 Jun 2024 23:44:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1muvqwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 23:44:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DNiflA47513912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 23:44:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F78120043;
	Thu, 13 Jun 2024 23:44:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A100A20040;
	Thu, 13 Jun 2024 23:44:39 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 23:44:39 +0000 (GMT)
Message-ID: <5a8a3c85760c19be66965630418e09a820f79277.camel@linux.ibm.com>
Subject: Re: [PATCH v4 12/35] kmsan: Support SLAB_POISON
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: SeongJae Park <sj@kernel.org>, Alexander Potapenko <glider@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David
 Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami
 Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil
 Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle
 <svens@linux.ibm.com>
Date: Fri, 14 Jun 2024 01:44:39 +0200
In-Reply-To: <20240613233044.117000-1-sj@kernel.org>
References: <20240613233044.117000-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R8Ge89LT8ke23MedEmj8fyVcr9NYVe3c
X-Proofpoint-GUID: xkSosI_V3EwHip4n10hyZ_Dwths6J4Ly
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
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130167

On Thu, 2024-06-13 at 16:30 -0700, SeongJae Park wrote:
> Hi Ilya,
>=20
> On Thu, 13 Jun 2024 17:34:14 +0200 Ilya Leoshkevich
> <iii@linux.ibm.com> wrote:
>=20
> > Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> > kmsan_slab_free() to poison the freed memory, and by preventing
> > init_object() from unpoisoning new allocations by using __memset().
> >=20
> > There are two alternatives to this approach. First, init_object()
> > can be marked with __no_sanitize_memory. This annotation should be
> > used
> > with great care, because it drops all instrumentation from the
> > function, and any shadow writes will be lost. Even though this is
> > not a
> > concern with the current init_object() implementation, this may
> > change
> > in the future.
> >=20
> > Second, kmsan_poison_memory() calls may be added after memset()
> > calls.
> > The downside is that init_object() is called from
> > free_debug_processing(), in which case poisoning will erase the
> > distinction between simply uninitialized memory and UAF.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0mm/kmsan/hooks.c |=C2=A0 2 +-
> > =C2=A0mm/slub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++++=
+----
> > =C2=A02 files changed, 10 insertions(+), 5 deletions(-)
> >=20
> [...]
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1139,7 +1139,12 @@ static void init_object(struct kmem_cache
> > *s, void *object, u8 val)
> > =C2=A0	unsigned int poison_size =3D s->object_size;
> > =C2=A0
> > =C2=A0	if (s->flags & SLAB_RED_ZONE) {
> > -		memset(p - s->red_left_pad, val, s->red_left_pad);
> > +		/*
> > +		 * Use __memset() here and below in order to avoid
> > overwriting
> > +		 * the KMSAN shadow. Keeping the shadow makes it
> > possible to
> > +		 * distinguish uninit-value from use-after-free.
> > +		 */
> > +		__memset(p - s->red_left_pad, val, s-
> > >red_left_pad);
>=20
> I found my build test[1] fails with below error on latest mm-unstable
> branch.
> 'git bisect' points me this patch.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mm/slub.o
> =C2=A0=C2=A0=C2=A0 /mm/slub.c: In function 'init_object':
> =C2=A0=C2=A0=C2=A0 /mm/slub.c:1147:17: error: implicit declaration of fun=
ction
> '__memset'; did you mean 'memset'? [-Werror=3Dimplicit-function-
> declaration]
> =C2=A0=C2=A0=C2=A0=C2=A0 1147 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __memset(p - s->red_=
left_pad, val, s-
> >red_left_pad);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 memset
> =C2=A0=C2=A0=C2=A0 cc1: some warnings being treated as errors
>=20
> I haven't looked in deep, but reporting first.=C2=A0 Do you have any idea?
>=20
> [1]
> https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_m68k.sh
>=20
>=20
> Thanks,
> SJ
>=20
> [...]

Thanks for the report.

Apparently not all architectures have=C2=A0__memset(). We should probably go
back to memset_no_sanitize_memory() [1], but this time mark it with
noinline __maybe_unused __no_sanitize_memory, like it's done in, e.g.,
32/35.

Alexander, what do you think?

[1]
https://lore.kernel.org/lkml/20231121220155.1217090-14-iii@linux.ibm.com/
