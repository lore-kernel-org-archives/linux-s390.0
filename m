Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5414D8B2;
	Wed, 19 Jun 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797647; cv=none; b=p3Kgh4jl+A06pYJBW1N2YwmLuKNlo8c25+cVt27CbBHo8878vVRi7rH4BGLC3W3L2fv3DnpAP/6ITzU/bsECJZgBIYxTlR0fIJE8FWqW6UCVzw+7qcSwqppsSM9Eo5mXrw9bMrrF35l6r1KR9pvbBBKbttiI8ad/k+UTnjekroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797647; c=relaxed/simple;
	bh=4aBYdd8aAGH4U0q0/YmJqtT24ak1oG6LESBEorWzHMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/RSnrIyW4Bul4kCyypyN3s4rFvX/BvbpLzc4SmVp6zu036SHVK9osFd09/ceFlWYUnWIhqc0+zkppcpA3uKB7rIFkpkdnLlNWps2HW2dSpOwkcCyTqQnyoJlTnxRHFmJs1DYfTvGunf03LUPUNHSznKQQODX1GTZi2EqD4dx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qpWFYXBP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qpWFYXBP"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JBT2Gb032134;
	Wed, 19 Jun 2024 11:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	4aBYdd8aAGH4U0q0/YmJqtT24ak1oG6LESBEorWzHMs=; b=qpWFYXBPyhP3Tm0z
	C/sRT45gj5nDYuSl/4f6IKTkUP8G4uVdsqfj5uy33dYu4ApM0one+39T7NLgvJhe
	VlSyhb97xz2OCEdnTbAihlB64ND7sixn9qtNWg3ller71SWzUMTLotmOmVK59wo0
	1TGSRdxEv6Buy2fWBhhalQQWonH3GBiTsyYE4l5TF3uqFbV/jOiC4GIDb3bm+Rrk
	71dOWS5GYd9aT1ajgjpx/ZLBWQV6sBGsvjDrOldyO0YWdl3CBETeuo7lwaF2xdVK
	rgmvAe9wkdUU0BkMzFmMVvsg93/YIsi4vX24zG0ZRxaf9RZVMAZES8woyzv/mUIL
	Vq7X0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuxg0r1cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 11:46:58 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JBkvMU026796;
	Wed, 19 Jun 2024 11:46:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuxg0r1cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 11:46:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JBQHF2006189;
	Wed, 19 Jun 2024 11:46:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9uv8v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 11:46:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JBkote34538010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 11:46:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90CFD2004B;
	Wed, 19 Jun 2024 11:46:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2858220063;
	Wed, 19 Jun 2024 11:46:50 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 11:46:50 +0000 (GMT)
Message-ID: <ff3403a257086f09db1280c5952e6f72371b10ef.camel@linux.ibm.com>
Subject: Re: [PATCH v4 16/35] mm: slub: Unpoison the memchr_inv() return
 value
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
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
Date: Wed, 19 Jun 2024 13:46:50 +0200
In-Reply-To: <CAG_fn=Uyx7ijj-igC2hgSpdzmChM0FVy46HTRXyKzNAA0OFK7A@mail.gmail.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
	 <20240613153924.961511-17-iii@linux.ibm.com>
	 <CAG_fn=Uyx7ijj-igC2hgSpdzmChM0FVy46HTRXyKzNAA0OFK7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tzqSr8HO345mo1Ia6Q97gqSzudRJArNH
X-Proofpoint-GUID: ljUZ8zkZEQkiMouQPJQ5SsIz1Fy2T4Or
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=749 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190084

On Tue, 2024-06-18 at 16:38 +0200, Alexander Potapenko wrote:
> On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > Even though the KMSAN warnings generated by memchr_inv() are
> > suppressed
> > by metadata_access_enable(), its return value may still be
> > poisoned.
> >=20
> > The reason is that the last iteration of memchr_inv() returns
> > `*start !=3D value ? start : NULL`, where *start is poisoned. Because
> > of
> > this, somewhat counterintuitively, the shadow value computed by
> > visitSelectInst() is equal to `(uintptr_t)start`.
> >=20
> > The intention behind guarding memchr_inv() behind
> > metadata_access_enable() is to touch poisoned metadata without
> > triggering KMSAN, so unpoison its return value.
>=20
> What do you think about applying __no_kmsan_checks to these functions
> instead?

Ok, will do. The __no_kmsan_checks approach is already taken by
"mm: kfence: Disable KMSAN when checking the canary", so we might as
well be consistent in how we fix these issues.
