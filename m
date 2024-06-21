Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AD16D324;
	Fri, 21 Jun 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958089; cv=none; b=NepR+FA3LScw89TtyxyDIOoolB2jcQj9YtNVGPxrRepWPiocHrrQkF9JJ2uIRzvzYlg7k7lBqmWVrfduhB8RAXYxYIhkPN5gpgtp8GLSIIhspqc+a1K1At0jTSIHGCo0BMIntUnObpGaKC7DZvwlns1GfHmBA4NLlzqrkNUBkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958089; c=relaxed/simple;
	bh=Rq7ISxfYw80N3/2x7VC7rXstSoA8dIPUSY5wwlHiCDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJXuWpkN6GLZJiUl/4SS450pk7b0F2kE7p7QEV+vD6YRbNWV7jQpzWALB2wpCf6CPoGy4+3Iv+yr73PCGs0MAwpYHE8gUvNDkyZkfEjG6VbSWjjSuYIAjAJ9xo5o6J1w+jrsE52anlkpXIAAecv8UgDDY97D1RaTrU0Bfc0liog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WKPjtw7y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WKPjtw7y"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7v5Gn010169;
	Fri, 21 Jun 2024 08:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	bOMJVb7Zy5y+AcLTafdKk+2YiRA7kTcVYCv4Y9XBs08=; b=WKPjtw7y+CU8gKb5
	47zr/upyd7H2mn/UtZO/QIjbhoclgJGkJAj3DQDzV9PogUpVvNF20BmXsMEk55Hi
	xLPT4v+pj4ufUHyTLRgSos7GmubqhG6hkOGcdAaNqJAeWnne3hfsDf5xGmLai2NV
	8TA76o1B0pMed+GCuieHb3gar4bwsGCtYM2Nf77bHnZbK7GhoT9WMVfIL00C+aRs
	nWnMbs8WnAgAwDdTDzMJy7A9gmVuiI8DdPV7GEAaptRaYHXQoLXzvWW1faQITiyX
	hscz6eCZsM51Sa+oY0uUU8H65dDFE5SmmfTeGUdCXBid8NLeykbK52VfPjGcnRXP
	xSV9kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw0ry0qsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 08:20:57 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L8KvJp016031;
	Fri, 21 Jun 2024 08:20:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw0ry0qs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 08:20:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L7GTtQ030896;
	Fri, 21 Jun 2024 08:20:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrsswsuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 08:20:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L8Kn2x55771402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 08:20:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD2320043;
	Fri, 21 Jun 2024 08:20:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FFA220040;
	Fri, 21 Jun 2024 08:20:48 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 08:20:48 +0000 (GMT)
Message-ID: <ec92cdaa57866306a6fcf52a386193bafcb2155b.camel@linux.ibm.com>
Subject: Re: [PATCH v6 32/39] s390/ptdump: Add KMSAN page markers
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko
 <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph
 Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco
 Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka
 Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily
 Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov
 <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle
 <svens@linux.ibm.com>
Date: Fri, 21 Jun 2024 10:20:48 +0200
In-Reply-To: <20240621002616.40684-33-iii@linux.ibm.com>
References: <20240621002616.40684-1-iii@linux.ibm.com>
	 <20240621002616.40684-33-iii@linux.ibm.com>
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
X-Proofpoint-GUID: VeEapbGV6IkSc8UA2_9IOlInc0MQ5ih1
X-Proofpoint-ORIG-GUID: r7kSYJf0oRMft-JV5P--079W7nGU4PZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_02,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210058

On Fri, 2024-06-21 at 02:25 +0200, Ilya Leoshkevich wrote:
> Add KMSAN vmalloc metadata areas to kernel_page_tables.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0arch/s390/mm/dump_pagetables.c | 30 ++++++++++++++++++++++++++++++
> =C2=A01 file changed, 30 insertions(+)
>=20
> diff --git a/arch/s390/mm/dump_pagetables.c
> b/arch/s390/mm/dump_pagetables.c
> index ffd07ed7b4af..f51e5d0862a3 100644
> --- a/arch/s390/mm/dump_pagetables.c
> +++ b/arch/s390/mm/dump_pagetables.c
> @@ -36,6 +36,16 @@ enum address_markers_idx {
> =C2=A0	VMEMMAP_END_NR,
> =C2=A0	VMALLOC_NR,
> =C2=A0	VMALLOC_END_NR,
> +#ifdef CONFIG_KMSAN
> +	KMSAN_VMALLOC_SHADOW_START_NR,
> +	KMSAN_VMALLOC_SHADOW_END_NR,
> +	KMSAN_VMALLOC_ORIGIN_START_NR,
> +	KMSAN_VMALLOC_ORIGIN_END_NR,
> +	KMSAN_MODULES_SHADOW_START_NR,
> +	KMSAN_MODULES_SHADOW_END_NR,
> +	KMSAN_MODULES_ORIGIN_START_NR,
> +	KMSAN_MODULES_ORIGIN_END_NR,
> +#endif
> =C2=A0	MODULES_NR,
> =C2=A0	MODULES_END_NR,
> =C2=A0	ABS_LOWCORE_NR,
> @@ -74,6 +84,16 @@ static struct addr_marker address_markers[] =3D {
> =C2=A0#ifdef CONFIG_KASAN
> =C2=A0	[KASAN_SHADOW_START_NR]	=3D {KASAN_SHADOW_START,
> "Kasan Shadow Start"},
> =C2=A0	[KASAN_SHADOW_END_NR]	=3D {KASAN_SHADOW_END, "Kasan Shadow
> End"},
> +#endif
> +#ifdef CONFIG_KMSAN
> +	[KMSAN_VMALLOC_SHADOW_START_NR]	=3D {0, "Kmsan vmalloc
> Shadow Start"},
> +	[KMSAN_VMALLOC_SHADOW_END_NR]	=3D {0, "Kmsan vmalloc Shadow
> End"},
> +	[KMSAN_VMALLOC_ORIGIN_START_NR]	=3D {0, "Kmsan vmalloc
> Origins Start"},
> +	[KMSAN_VMALLOC_ORIGIN_END_NR]	=3D {0, "Kmsan vmalloc Origins
> End"},
> +	[KMSAN_MODULES_SHADOW_START_NR]	=3D {0, "Kmsan Modules
> Shadow Start"},
> +	[KMSAN_MODULES_SHADOW_END_NR]	=3D {0, "Kmsan Modules Shadow
> End"},
> +	[KMSAN_MODULES_ORIGIN_START_NR]	=3D {0, "Kmsan Modules
> Origins Start"},
> +	[KMSAN_MODULES_ORIGIN_END_NR]	=3D {0, "Kmsan Modules Origins
> End"},
> =C2=A0#endif

Please disregard this patch. It's not essential for the series, and
also has a subtle bug: this block needs to be moved upwards, because
right now { -1, NULL } overlaps [MODULES_NR]. I will resend it
separately later.

> =C2=A0	{ -1, NULL }
> =C2=A0};
