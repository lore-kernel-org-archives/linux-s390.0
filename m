Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF22093E5;
	Tue, 18 Jun 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704904; cv=none; b=AX56p8cdEPytBj07B5YD8BTTKYINBI1o8VKx6ulWpCqbvtO/+rGhmdqfkc45zSc2BwutBp0eKYcZp7VKi0IydxcRPSoQZ62+hkXEnGzM2meTspjVC+0ukbqPvwFOF946a2yG6bL886Owo4p8CwHm7H1WFxtd8yCldNUA/5z3s/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704904; c=relaxed/simple;
	bh=56ndxlWUopxXCxRtq9AcvSBP4vgwCrhT9Wo6d8WigyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+moMRwJs4ZFB07nVaT3EXsG6+zxjNCkCunqKJAUKlvO6WNmlDlNRkY4sQsJDl+P7d4V+V9SdVaJWSHQZ2+PpO6J2lxFuhIA5gdg14mkgrmoJSD81knJxMYrKgarVmCqufX4+PBJm0ifm9FB3DJ8E1lJ+geix7XdrXWleFQgC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z5AXNp3H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z5AXNp3H"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I9SGHN016418;
	Tue, 18 Jun 2024 09:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	56ndxlWUopxXCxRtq9AcvSBP4vgwCrhT9Wo6d8WigyE=; b=Z5AXNp3HRoxkgb6s
	XI+msgzi6TLeTTRR/cJVTYO5tIo4iaFp6fcMk+0pPQntyHoFWgHFfc3whXKeoZMe
	HjqyrcI9eQU7K7CWl+mJuoEE6hPRWPnXrOQH4uk2Mrrsf5NRucKQsVg5V6/oCtof
	0SCl2D/Vn/2aVFJ64ZXty1ViPvG1FR78M3qdf/7nAWlFEKdUBA7r2N6q2I62tNfW
	dRpPg2atBTpYRSDX2Y51KNiqo/3Wo3vXROnP7DjPnCRa3QWCpQw/rDiVOTrz53KL
	sUK3niNLycCPHWA4ElXAdjtMqRPnfM4e8kknScoCFUcYWNEl72NWbZFtds31K6lM
	0s8YdQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu7mrg339-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:56:16 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I9sUGQ024178;
	Tue, 18 Jun 2024 09:56:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu7mrg331-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:56:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45I7orXa009425;
	Tue, 18 Jun 2024 09:56:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgmhfw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:56:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45I9u8ui49480134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:56:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFDA320043;
	Tue, 18 Jun 2024 09:56:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F02720040;
	Tue, 18 Jun 2024 09:56:07 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 09:56:07 +0000 (GMT)
Message-ID: <1686a7d4dfdfc0a7820f9f9eaf2b08efd1582cc5.camel@linux.ibm.com>
Subject: Re: [PATCH v4 32/35] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
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
Date: Tue, 18 Jun 2024 11:56:06 +0200
In-Reply-To: <CAG_fn=XhWpLKbMO6ZHpnxQDh+PXrTxBnL9X-1zZtBj-CoVk0=g@mail.gmail.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
	 <20240613153924.961511-33-iii@linux.ibm.com>
	 <CAG_fn=X6wHfmGsVgdqwms_Hk1CQAZ6M5623WyatjVp=Uk-z9pQ@mail.gmail.com>
	 <e91768f518876ec9b53ffa8069b798107434d0dd.camel@linux.ibm.com>
	 <CAG_fn=XhWpLKbMO6ZHpnxQDh+PXrTxBnL9X-1zZtBj-CoVk0=g@mail.gmail.com>
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
X-Proofpoint-GUID: thTUXS9VWyXfcdKqlWXkBkJtxj-ngN6F
X-Proofpoint-ORIG-GUID: PAQyFSQ5hY8FDUl-TDPKYjyoD0hkTlRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=924 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406180073

On Tue, 2024-06-18 at 11:52 +0200, Alexander Potapenko wrote:
> On Tue, Jun 18, 2024 at 11:40=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.=
com>
> wrote:
> >=20
> > On Tue, 2024-06-18 at 11:24 +0200, Alexander Potapenko wrote:
> > > On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > put_user() uses inline assembly with precise constraints, so
> > > > Clang
> > > > is
> > > > in principle capable of instrumenting it automatically.
> > > > Unfortunately,
> > > > one of the constraints contains a dereferenced user pointer,
> > > > and
> > > > Clang
> > > > does not currently distinguish user and kernel pointers.
> > > > Therefore
> > > > KMSAN attempts to access shadow for user pointers, which is not
> > > > a
> > > > right
> > > > thing to do.
> > > >=20
> > > > An obvious fix to add __no_sanitize_memory to __put_user_fn()
> > > > does
> > > > not
> > > > work, since it's __always_inline. And __always_inline cannot be
> > > > removed
> > > > due to the __put_user_bad() trick.
> > > >=20
> > > > A different obvious fix of using the "a" instead of the "+Q"
> > > > constraint
> > > > degrades the code quality, which is very important here, since
> > > > it's
> > > > a
> > > > hot path.
> > > >=20
> > > > Instead, repurpose the __put_user_asm() macro to define
> > > > __put_user_{char,short,int,long}_noinstr() functions and mark
> > > > them
> > > > with
> > > > __no_sanitize_memory. For the non-KMSAN builds make them
> > > > __always_inline in order to keep the generated code quality.
> > > > Also
> > > > define __put_user_{char,short,int,long}() functions, which call
> > > > the
> > > > aforementioned ones and which *are* instrumented, because they
> > > > call
> > > > KMSAN hooks, which may be implemented as macros.
> > >=20
> > > I am not really familiar with s390 assembly, but I think you
> > > still
> > > need to call kmsan_copy_to_user() and kmsan_copy_from_user() to
> > > properly initialize the copied data and report infoleaks.
> > > Would it be possible to insert calls to linux/instrumented.h
> > > hooks
> > > into uaccess functions?
> >=20
> > Aren't the existing instrument_get_user() / instrument_put_user()
> > calls
> > sufficient?
>=20
> Oh, sorry, I overlooked them. Yes, those should be sufficient.
> But you don't include linux/instrumented.h, do you?

No, apparently we get this include from somewhere else by accident.
I will add it in a separate patch.
