Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FB1E4A4;
	Tue, 13 Aug 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554602; cv=none; b=tou9adMf7Bf/SoPozhxy2S6AClmxt+NZFh5mptTsIy19aNR7g5wdCCLjRFnjdI0KOE59ZR46rrrWw7qUD7otGQjRcB37G3z1+FlBjuIDIeJlXTAsGvAQL+33mzuQCGZH8GhyNgvdpvLXqGhvahiWb3Ul5/1yXEcpXUoi4qfsFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554602; c=relaxed/simple;
	bh=gOpZ3fjCUWpkUVj57kxD8oMWuH6BPbVDe/bhcSHnepk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pNV1sQ/1dsVYbdGaybW3ZVAINIZTkBtilkzl/szPdZvHGIjJGFeVB/xisAcf1V2luRl62pk8MOHv130ZHzNwE0ebMf78XAqiEYS0zDc4fIdgsc8z2prlYPam6x6E586nHGK2uY545xLH2DfEmnsQJa3W9+bzUFuavCjOkCF+bbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EbvTyxLI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EbvTyxLI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4eWOG007753;
	Tue, 13 Aug 2024 13:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=/
	3srlTOq1kV/fswUWzBg50vKAcGJ886o6OeipTMRRU8=; b=EbvTyxLIJfshSKHKT
	FPU3F9Ce6m7EqHuXTLZrdP5Ky04HM+aMT479JYpj7NKXxtxcqwU16E/I7awmOLN6
	SYOGv+AU/RC9H1nqQCx8MjmwivOrce68dULrA8SXYSBc5nRSKcGPfiFBdjxf/Ej+
	EMqdmczxK2oT/ZKm+W+9KVRox9LqBPIzOGcCXH+Hi0Zp2DQIbDdSsDr2Wy7iINs5
	h3DgyvVrbTmb6tzxpWcNnVptELjwNpuN2CumlnV+ZJ7vraeARPW9dGJTqOn2ICZI
	y12supa0R4ZRs/mxyFKNMveBJrKZgriIWJsl8Qr3sqAsK0nzy5KSi38gQUrTUtBy
	qq5Ww==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8r94k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:09:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DBUseb010079;
	Tue, 13 Aug 2024 13:09:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0ku7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:09:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DD9jox51970428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 13:09:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4034E2004F;
	Tue, 13 Aug 2024 13:09:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D76762004E;
	Tue, 13 Aug 2024 13:09:44 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 13:09:44 +0000 (GMT)
Date: Tue, 13 Aug 2024 15:09:43 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <your-ad-here.call-01723554583-ext-4892@work.hours>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
 <your-ad-here.call-01723549827-ext-8444@work.hours>
 <2024081319-patriarch-brutishly-653f@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024081319-patriarch-brutishly-653f@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dwW4XO91YFQxlxoBoTUQy90-ErOzpjp5
X-Proofpoint-ORIG-GUID: dwW4XO91YFQxlxoBoTUQy90-ErOzpjp5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_04,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130095

On Tue, Aug 13, 2024 at 02:43:33PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 01:50:27PM +0200, Vasily Gorbik wrote:
> > On Tue, Aug 13, 2024 at 12:52:19PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 13, 2024 at 12:42:37PM +0200, Vasily Gorbik wrote:
> > > > From: Heiko Carstens <hca@linux.ibm.com>
> > > > 
> > > > iucv_alloc_device() gets a format string and a varying number of
> > > > arguments. This is incorrectly forwarded by calling dev_set_name() with
> > > > the format string and a va_list, while dev_set_name() expects also a
> > > > varying number of arguments.
> > > > 
> > > > Fix this and call kobject_set_name_vargs() instead which expects a
> > > > va_list parameter.
> > > 
> > > I don't understand, why can't dev_set_name() be called here?
> > > 
> > > Calling "raw" kobject functions is almost never the correct thing to be
> > > doing, ESPECIALLY as you have a struct device here.
> > 
> > struct device *iucv_alloc_device(const struct attribute_group **attrs,
> >                                  void *priv, const char *fmt, ...);
> > 
> > va_start(vargs, fmt); initializes vargs to point to the first argument after fmt.
> > 
> > __printf(2, 0) int kobject_set_name_vargs(struct kobject *kobj, const char *fmt, va_list vargs);
> > 
> > __printf(2, 3) int dev_set_name(struct device *dev, const char *name, ...);
> > 
> > dev_set_name is expecting to receive individual variable arguments
> > directly (...), not a va_list.
> > 
> > The (...) in dev_set_name is meant to be expanded into individual
> > arguments, but when you pass a va_list to it, this expansion doesn't
> > happen. Instead, the va_list is just treated as a pointer or a single
> > argument, leading to undefined or incorrect behavior.
> > 
> > So, would it be okay to reuse kobject_set_name_vargs() here, or would you propose
> > introducing another helper just for this case? e.g.
> > 
> > int dev_set_name_vargs(struct device *dev, const char *fmt, va_list vargs)
> > {
> > ჻·······return kobject_set_name_vargs(&dev->kobj, fmt, vargs);
> > }
> > EXPORT_SYMBOL_GPL(dev_set_name_vargs)
> 
> This function makes more sense if you really want to do this.
> 
> But step back, why is this needed at all anyway?  No other subsystem or
> driver needs/wants this, what makes this api so special?  Why not figure
> out your name beforehand?

That's comming from this patch series:
https://lore.kernel.org/all/20240506194454.1160315-1-hca@linux.ibm.com/#t

"""
Unify IUCV device allocation as suggested by Arnd Bergmann in order
to get rid of code duplication in various device drivers.
"""

It just introduces and utilizes a couple of wrappers to reduce code
duplication, and in this case, introducing this level of indirection
led to the need for forwarding vargs.

And reimplementing parts of kobject_set_name_vargs to format the device
name beforehand is probably not what we want.
