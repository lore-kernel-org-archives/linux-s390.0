Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF619EED6;
	Thu, 20 Jun 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875548; cv=none; b=ImIO26l+xECA4dE0U3NcIM3K+XlhpsUcO0KvCf4LiXOD3GXmk/tGbfGMQw4TN2x55MHcBVv5pVDG5EM3SWJuwQnwQb9McDD9rey2p35qVyoqrpsdME/8JnXpd48tuoB0AzH+weooQYsUTTLvBNzS2cens1ljBOj9NJqylb5WmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875548; c=relaxed/simple;
	bh=VtSuKoly8HsDQXpdGvQMKQfSextruyz0l/gETZd1bLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shb8vJziH6BX3+zCc/f7cFSfRL6mXIx5PICkw9wVZ3J+tQS1LPbsLp5FEkjxLLhOYjaEO28OwJH8+R/J3b7gu9R5qOaY5/obC6Px5UheHmRcrItycK67R5oNPrGFUN7fykr8Om4Vjoa3r70qtikup1GYsnH4YizmupPi4I1M3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sfio6WQO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sfio6WQO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K902cF016608;
	Thu, 20 Jun 2024 09:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=f+xXT+pi71Ik+KvC0QHepWSaRor
	cAZ6T5r10Nujhews=; b=Sfio6WQOYVTagW1lvAePUjWg7PZYt5T+OSgX5FR5CBQ
	4T8FqTVC4pGk7y9uFqQ9H82xU9f/hxcd1AgZq15JV1SUzIYn/uLKhvzmNl2iZ9Tz
	Lt8l30OOq/SVsJ62yESCJkh9impmd3uvFPWd2G7fr63apxlMVlkv4h2os7U1DYMX
	HmqePfnNaDGAu1KYVehinYSGS9ETdQuWZZLbIwk4lKJq0X7y+CEiEAxFDXuFX8Nf
	Dxsky2rQB37kiRnGjwmzceUoBJaqVuOj+MJJ2KE7GYW3ExS44sx0F4w8p1m4myRR
	jMxxH054GfGQtk+2zifvVE6F7PQWB8/ysIhYxJNj3+A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvhd082aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:25:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45K9PNjH007553;
	Thu, 20 Jun 2024 09:25:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvhd082ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:25:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K8q0Lp011355;
	Thu, 20 Jun 2024 09:25:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsnmdy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:25:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K9PFWx50331948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:25:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AA6C2004D;
	Thu, 20 Jun 2024 09:25:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50D6720043;
	Thu, 20 Jun 2024 09:25:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.21.176])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Jun 2024 09:25:13 +0000 (GMT)
Date: Thu, 20 Jun 2024 11:25:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 36/37] s390/kmsan: Implement the architecture-specific
 functions
Message-ID: <ZnP1dwNycehZyjkQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240619154530.163232-1-iii@linux.ibm.com>
 <20240619154530.163232-37-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619154530.163232-37-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wGgihVial8kXJ1bFTIVWyPNHF-8EUg62
X-Proofpoint-GUID: 0mzQWVSjgWONbMvCB5bN-IoPQn2J8C9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=512 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200062

On Wed, Jun 19, 2024 at 05:44:11PM +0200, Ilya Leoshkevich wrote:

Hi Ilya,

> +static inline bool is_lowcore_addr(void *addr)
> +{
> +	return addr >= (void *)&S390_lowcore &&
> +	       addr < (void *)(&S390_lowcore + 1);
> +}
> +
> +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
> +{
> +	if (is_lowcore_addr(addr)) {
> +		/*
> +		 * Different lowcores accessed via S390_lowcore are described
> +		 * by the same struct page. Resolve the prefix manually in
> +		 * order to get a distinct struct page.
> +		 */

> +		addr += (void *)lowcore_ptr[raw_smp_processor_id()] -
> +			(void *)&S390_lowcore;

If I am not mistaken neither raw_smp_processor_id() itself, nor
lowcore_ptr[raw_smp_processor_id()] are atomic. Should the preemption
be disabled while the addr is calculated?

But then the question arises - how meaningful the returned value is?
AFAICT kmsan_get_metadata() is called from a preemptable context.
So if the CPU is changed - how useful the previous CPU lowcore meta is?

Is it a memory block that needs to be ignored instead?

> +		if (WARN_ON_ONCE(is_lowcore_addr(addr)))
> +			return NULL;

lowcore_ptr[] pointing into S390_lowcore is rather a bug.

> +		return kmsan_get_metadata(addr, is_origin);
> +	}
> +	return NULL;
> +}

Thanks!
