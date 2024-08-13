Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9019D07D;
	Tue, 13 Aug 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559780; cv=none; b=FVmGKH4Br1bIGj+7MMD9ud2LFq8Fgd+STPZ2TwJH5YFG7reUm72X1txzLK4prMTnGE7QO9TKDxuhGe8H5AoeP00zRAoSEgMuqDD8pJfWnWM8LPUmj2+lUbY+LVEl3a77xsTXWUoZnV2INJhcQEwi2ILlbF6pAlMUT9WmmJVry+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559780; c=relaxed/simple;
	bh=UR+vgnqraCUFJ4mNSvXJ5nb3LwOpi2i4CyaOmUox8SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHjcs7fBWoRXqDDmoJDwt1SLOKK3IwPICCpHoBtzNyGeIdVLNg3oRZFretVhLLUZgFSXVYL6VLdv+vCUv67wXO1OAEZNlGbHIPuuaNW4AG4sYL0uBPuPZEPW2qU2wyeDYOQLcmMLETV8iSADTCgA56fSnSjI8RO6rZVFlPk1UTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1enpu1o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1enpu1o"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4ZZ0G003452;
	Tue, 13 Aug 2024 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=yUCESVzeByC87R2nyHyrYk3bTW1
	CB4yhtBY2U8tn4eU=; b=e1enpu1ovasKPxHfdciwA6rRUXSFIy8s+rVyIWDDkIg
	fa00UXCAxfVkkqxnOMxPlYDKl1jFISbktkrPtd7chp+Ge3M4XSzH/Qu3CWYwzTKb
	l8JOAZfht/FeUu/SlFPKoo1FNvLB4D6SdUxMG+VftTDa2el8P1X0i6BvIetDFH+s
	imfglHrVEut3kosTUDNuuoQnXxJUKhvoAFIIZxsQX4mB0qwB1PfuQchuRg4J/J/D
	kC4EXSkaTGxHa7k1MhmcD3TKpTBElkLTo8XHX7EN5PMhpxJRTdFZY7tzuepaoX9C
	UkAKaadVeXy9hEzmYEdizmL+QGnCXQOoEQjxjWTNPxw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyuxrbjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 14:36:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DD0kFs015282;
	Tue, 13 Aug 2024 14:36:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1mkwf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 14:36:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DEa52Z29622670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:36:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD3820067;
	Tue, 13 Aug 2024 14:36:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F366D20065;
	Tue, 13 Aug 2024 14:36:04 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 14:36:04 +0000 (GMT)
Date: Tue, 13 Aug 2024 16:36:01 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <your-ad-here.call-01723559761-ext-3660@work.hours>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
 <your-ad-here.call-01723549827-ext-8444@work.hours>
 <2024081319-patriarch-brutishly-653f@gregkh>
 <221ba279-e48b-4002-9530-c6186e3e8042@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <221ba279-e48b-4002-9530-c6186e3e8042@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zjRTfB75LOqWA0_0tibPCQAjWqJT-7NR
X-Proofpoint-ORIG-GUID: zjRTfB75LOqWA0_0tibPCQAjWqJT-7NR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=992 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130105

On Tue, Aug 13, 2024 at 03:35:48PM +0200, Alexandra Winter wrote:
> 
> 
> On 13.08.24 14:43, Greg Kroah-Hartman wrote:
> >>> I don't understand, why can't dev_set_name() be called here?
> >>>
> [...]
> > 
> > But step back, why is this needed at all anyway?  No other subsystem or
> > driver needs/wants this, what makes this api so special?  Why not figure
> > out your name beforehand?
> > 
> > thanks,
> 
> 
> Vasily, the following update to Heiko's patch does not touch lib/kobject.c
> According to a quick test it still solves the original issue and does compile
> with W=1 and iucv as a module.
> 
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 64102a31b569..6a819ba4ccab 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -86,13 +86,17 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
>  {
>         struct device *dev;
>         va_list vargs;
> +       char buf[20];
>         int rc;
> 
>         dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>         if (!dev)
>                 goto out_error;
>         va_start(vargs, fmt);
> -       rc = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
> +       rc = vsnprintf(buf, 20, fmt, vargs);
> +       if (!rc)
> +               rc = dev_set_name(dev, buf);
>         va_end(vargs);
>         if (rc)
>                 goto out_error;
> 
> Maybe Greg has somethign like this in mind?

Thanks Alexandra,
 
but I'm still leaning towards forwarding vargs and avoid splitting the name
formatting logic, if Greg agrees that the use case justifies adding a
new helper. Let's see what Greg prefers.
 
int dev_set_name_vargs(struct device *dev, const char *fmt, va_list vargs)
{
        return kobject_set_name_vargs(&dev->kobj, fmt, vargs);
}
EXPORT_SYMBOL_GPL(dev_set_name_vargs)
