Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1681E536;
	Thu, 20 Jun 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890749; cv=none; b=YacckJ14Yjg0dbDh9iOeejXsM0UDyUthx8TgcMQzdVbxfNRwqIS0M/Y6lV5EOKjqQuo6LxM3n7sm19TySnmAlUZFTZCjkBgqS9g1LjpVpEgk7OUaeC/fP87xq7kGBOqGwIASjUuL4eYCn7/ymcXWvuKhTleLJWduMdCxi9eX0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890749; c=relaxed/simple;
	bh=9HGv70JIMn6ZZt2ugfN/5t1vr7E8lqYXwzHG3dM/GPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ujP/fNTHtrT7hYKfn6p8xGo9R/M0ezpCRwX+czTWB8y5K5/UCiEuggBXaZZlChkRUP+cVh6KkOU8uAkad6TvWCxXowHD37JttmnCfEikMu6IPZBiLAkijZZEzyU3qPYQSbzaIN12MbBRBUsgUln0cCjXX14QUMY0V8jO9VxvQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DVj2yxKJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DVj2yxKJ"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KDXb8H018582;
	Thu, 20 Jun 2024 13:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	YUbNUxVRxVzSfRB8DznG+AI9YazUwyusPtVlI9Nb7aM=; b=DVj2yxKJ78KGS2dF
	DVlRx1erNBA4hS2DHyKvmTK/XX98eIGGOw3sh6PtrVVZbbSx+ZqF4oeOvrg+hCoY
	f0p03nWs4S6CdU2za/htkSZ7DViH1Uah2d4TCGkSB4HFKMpj48EP9pOfhLkoT4zT
	O/mIMG/e9uTTkzu5g+8iaIBqBZj3bSgJm+LH47nXN0RLNB4rcm6DASkDil6fwp57
	y/vgaoW2HzjhGgkd6EB077lTyVeGOdeny1Ok2a4PGxTre5iW3nRvhWgag+ys17Rz
	y7mxtg+tFERSbixzd5OVdAPgo4BdupnAkjzPkfF+UDO8mriMHaXavYxXFvP2FCka
	llAoNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvndp80aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:38:39 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45KDYo37020397;
	Thu, 20 Jun 2024 13:38:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvndp80at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:38:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KCIJjB023874;
	Thu, 20 Jun 2024 13:38:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9qphf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:38:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45KDcWRJ18874846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 13:38:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4852320043;
	Thu, 20 Jun 2024 13:38:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7A420040;
	Thu, 20 Jun 2024 13:38:31 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 13:38:31 +0000 (GMT)
Message-ID: <f6ab5d6e0aa90ad85e239a2da9252930ca9a70c3.camel@linux.ibm.com>
Subject: Re: [PATCH v5 36/37] s390/kmsan: Implement the
 architecture-specific functions
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>,
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
Date: Thu, 20 Jun 2024 15:38:31 +0200
In-Reply-To: <ZnP1dwNycehZyjkQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240619154530.163232-1-iii@linux.ibm.com>
	 <20240619154530.163232-37-iii@linux.ibm.com>
	 <ZnP1dwNycehZyjkQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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
X-Proofpoint-GUID: EoXF46C30_1HJeuiJvzTvJ3K5p2rf5em
X-Proofpoint-ORIG-GUID: bqmJR33qqTSFJQTMaJPsqaDg4i4nBhCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=720 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200096

On Thu, 2024-06-20 at 11:25 +0200, Alexander Gordeev wrote:
> On Wed, Jun 19, 2024 at 05:44:11PM +0200, Ilya Leoshkevich wrote:
>=20
> Hi Ilya,
>=20
> > +static inline bool is_lowcore_addr(void *addr)
> > +{
> > +	return addr >=3D (void *)&S390_lowcore &&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr < (void *)(&S390_lowcore + =
1);
> > +}
> > +
> > +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool
> > is_origin)
> > +{
> > +	if (is_lowcore_addr(addr)) {
> > +		/*
> > +		 * Different lowcores accessed via S390_lowcore
> > are described
> > +		 * by the same struct page. Resolve the prefix
> > manually in
> > +		 * order to get a distinct struct page.
> > +		 */
>=20
> > +		addr +=3D (void
> > *)lowcore_ptr[raw_smp_processor_id()] -
> > +			(void *)&S390_lowcore;
>=20
> If I am not mistaken neither raw_smp_processor_id() itself, nor
> lowcore_ptr[raw_smp_processor_id()] are atomic. Should the preemption
> be disabled while the addr is calculated?
>=20
> But then the question arises - how meaningful the returned value is?
> AFAICT kmsan_get_metadata() is called from a preemptable context.
> So if the CPU is changed - how useful the previous CPU lowcore meta
> is?

This code path will only be triggered by instrumented code that
accesses lowcore. That code is supposed to disable preemption;
if it didn't, it's a bug in that code and it should be fixed there.

>=20
> Is it a memory block that needs to be ignored instead?
>=20
> > +		if (WARN_ON_ONCE(is_lowcore_addr(addr)))
> > +			return NULL;
>=20
> lowcore_ptr[] pointing into S390_lowcore is rather a bug.

Right, but AFAIK BUG() calls are discouraged. I guess in a debug tool
the rules are more relaxed, but we can recover from this condition here
easily, that's why I still went for WARN_ON_ONCE().

> > +		return kmsan_get_metadata(addr, is_origin);
> > +	}
> > +	return NULL;
> > +}
>=20
> Thanks!
