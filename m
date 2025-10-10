Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9372749ED;
	Fri, 10 Oct 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083786; cv=none; b=IJLg4qZr305UIzL2f3H/yEYQJyT4UN5xfbKv4Qmd8MQeUI7bWIGCqJc/9JOEaNj1Lx0ly1qersJIIrJ5rmymmbo6J4i6kznHCHFVEg6hxosfBVo5XXV+XbpqhyhveAsb3mz6O0O0g3lGy1XH3sNRQxrjN4gAm3K0nEmYRQ5gzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083786; c=relaxed/simple;
	bh=ykShCOPmAhqg69uP7U0GZy54nhN8YLicots+KryMWEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFNF9kL55vX4S+pjjxyyZkd6WH1ycBBOAyZeBap2uOVT99i7g3L3WOXlbzbZUwajD8vs+uQsRK3ZQELC+hgfbp7HXtOLCPeGtt0DbWggqxtVnmVXcqy81iAzw/H0OJo0MpWVDGarBF5EncL37DcFelo4HpVHDhHUKYIqTBpFSR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MHp7l3M4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MHp7l3M4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A7QtOa031098;
	Fri, 10 Oct 2025 08:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Gzdv8UWdEnCN56xKeWjK1CJF5EdNSu
	3Q50DKVSJHF8M=; b=MHp7l3M4ztwAPc0fyybEazxaTSzDl6k40j9mZAP1C/tJ7U
	kbUp5DQOuIUQaxmLdGMjXvHerAo2ErrM29R6Ik/+YSmJ+YMChSrEVPbaIDIqlq8y
	OSekPQHyHiTzxEoSQ7MkkPayXXkvEb0Fq8ivunbIBLGkwmlIQO581cbcJ+9UKPW6
	VgJPqFFpabjODT6p2qZt889z/Rt1W8EqV/V4VaXhbnKIvDwe0gPVTCmziqy9UPvf
	U/DUeF6YbxaACXToUWMuQjApqkzAJZm7464jFNigAO8WUkwYNHPXUjTJmr6mM/eP
	BP7ljBDvLNk8MNO3reP5Rp0Axk1Lti5ciTjIN+TA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81sa32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:09:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A812mC012997;
	Fri, 10 Oct 2025 08:09:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvan0uqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:09:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A89YVN38338946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 08:09:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A0B320183;
	Fri, 10 Oct 2025 08:09:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BC6320181;
	Fri, 10 Oct 2025 08:09:34 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.54.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Oct 2025 08:09:34 +0000 (GMT)
Date: Fri, 10 Oct 2025 10:09:32 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] s390/sclp: Add support for dynamic
 (de)configuration of memory
Message-ID: <aOi_PL68QaY2YIAg@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
 <20251009131839.3739108-3-sumanthk@linux.ibm.com>
 <ed7db8b9-e828-420d-a8b2-3e1b8aa8c95c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7db8b9-e828-420d-a8b2-3e1b8aa8c95c@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IudfyhWzW7_jQh-hdHIgBVZ2osLZPOxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyOplaghO3qUJ
 L75RtbN4mdBJFl14fqQH9v9Drb1zLgcbQrLPimgMiwkCY960GAY6pmTWsEv/n/mo04QazaooSg3
 3yFExSyAe5HMF8elHfGe+Croi+Ksdez4HldSerO0JrFdjnTDLkBMahK1Mp/MDNcWN/Gkxlk+LBV
 Z4hUYneSqMJrxExsO8wvAe8ajYAaXpQ3E32y0SNoSyInb/OzxT63lKTMloTXFs8xzeEjNHn7Mx8
 jsfjg6zk08whGJWpPUjv/25mVgXNGLg8HKoXXGOdN1zyhwKjipq4Y1+YgtcSPHYJtWhb2T1hVV8
 xJCxTveeuy+a3gB0+aA/3b7Hh6Q92RdtjC0OMgTwWNhI8gA24i1M4kuDXceuxARfzgispzC8qUm
 crltVkOGrjwd8N43EDcH6jn/rs/07A==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e8bf43 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=Fw4thcao37LPlByLA-sA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: IudfyhWzW7_jQh-hdHIgBVZ2osLZPOxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

> > +struct sclp_mem {
> > +	struct kobject kobj;
> > +	unsigned int id;
> > +	unsigned int memmap_on_memory;
> > +	unsigned int config;
> > +};
> > +
> > +struct sclp_mem_arg {
> > +	struct sclp_mem *sclp_mems;
> > +	struct kset *kset;
> > +};
> 
> Just one thought: if you keep either as global variable you wouldn't need
> this. (I would just keep both as globals, but whatever you prefer)
> 
> Whatever you prefer.

Hi David,

I prefer to preserve the ones we have.

> > -static void __init sclp_add_standby_memory(void)
> > +static int __init create_standby_sclp_mems(struct sclp_mem *sclp_mems, struct kset *kset)
> >   {
> >   	struct memory_increment *incr;
> > +	int rc = 0;
> >   	list_for_each_entry(incr, &sclp_mem_list, list) {
> >   		if (incr->standby)
> > -			add_memory_merged(incr->rn);
> > +			rc = create_standby_sclp_mems_merged(sclp_mems, kset, incr->rn);
> > +		if (rc)
> > +			goto out;
> 
> Why not "return rc;" to avoid the goto label?

Sure. Will add it.

> >   	}
> > -	add_memory_merged(0);
> > +	rc = create_standby_sclp_mems_merged(sclp_mems, kset, 0);
> > +out:
> > +	return rc;
> > +}
> > +
> > +static int __init init_sclp_mem(void)
> > +{
> > +	const u64 block_size = memory_block_size_bytes();
> 
> Instead of "u64" maybe "unsigned long" like memory_block_size_bytes()
> returns?

Noted.

> > +	const u64 max_sclp_mems = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
> 
> Instead of u64 maybe "unsigned int" like the ids you store per sclp_mem?

Sure.

> > +	struct sclp_mem *sclp_mems;
> > +	struct sclp_mem_arg arg;
> > +	struct kset *kset;
> > +	int rc;
> > +
> > +	/* Allocate memory for all blocks ahead of time. */
> > +	sclp_mems = kcalloc(max_sclp_mems, sizeof(struct sclp_mem), GFP_KERNEL);
> > +	if (!sclp_mems)
> > +		return -ENOMEM;
> > +
> > +	kset = kset_create_and_add("memory", NULL, firmware_kobj);
> > +	if (!kset)
> > +		return -ENOMEM;
> 
> I guess we don't care about freeing sclp_mems in that case? Likely it should
> never ever happen either way.

Right. We dont care about freeing sclp_mems here.

Thank you.
