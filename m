Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BF1A0723;
	Tue, 13 Aug 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573328; cv=none; b=d4ya6jX/2L9kkVgKClQ76HZqyO06yUO4aYMePFTC42bTReUOGMKnpATDC3331i9cbJ0eT8qyPuwhUDC5Z33uenk2IHXirxIam9YCybAv/26rjdcGecoCH7AB11IJJKOkIYpljNRt2PK7gbmAzNUyh3kal6F48nVgZDgtR9jtcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573328; c=relaxed/simple;
	bh=MOCnER6PI0sYPRv9Rixu7QIQnbO03XlabEWCRBTi7L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfUs0LH6HfayIdGuNeo63ExIFqP/rYAAE1Il0Fbc7ztlvwjWgcpg1ebSGXFKmQhACIkHE4JGCfTQaOeGaTL/t2v7d++1rb8MGvEfQfOdhHroZMx6OV9XUANJt5VldgwHk/uDldEHLXOPDDbYH3YYJc7ayRt0CNdS8aTjYYUX++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZuFw1aNR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZuFw1aNR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DHkFA4029726;
	Tue, 13 Aug 2024 18:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ynvaQAlLfbiE/EAv0dieMj7N1vx
	8awFbOuoSK+6h4AY=; b=ZuFw1aNRCeYU0h6/8/hY6GV2Z66eexDOyQHbvM5EX3z
	/Wg9cdkVKEaEhWRnww8abFAnODpkmHK1VcbndUk9VTnT4xXLIK8lP96TxZfnVohw
	nR0UjBp0wpi4krzKhV+EURrmD4otZK0FlDqB+j5Q3RDsttIzD7NrRKzR/AzXoT71
	JrWb+2hlLkrTl3Hltd5iN2meROCM0XQmDEmSy9HQLxv6VxZiWJQWjYGzwez+7l67
	cVKG5I6hmuImOeXh9Zv7LTg+G2LTbVO/8Vc/4mMb7e3LLWOfLdScArjxqGxoTNkt
	6Ub9Fndvk3QQtYljTbrZEvRRrhheHlNHjFCM3iQ9HPw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410c6605dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:21:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DH6PUa020882;
	Tue, 13 Aug 2024 18:21:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn834jkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:21:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DILlvF45154794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 18:21:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E8820043;
	Tue, 13 Aug 2024 18:21:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D9052004D;
	Tue, 13 Aug 2024 18:21:47 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 18:21:47 +0000 (GMT)
Date: Tue, 13 Aug 2024 20:21:43 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandra Winter <wintera@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <your-ad-here.call-01723573303-ext-4217@work.hours>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
 <your-ad-here.call-01723549827-ext-8444@work.hours>
 <2024081319-patriarch-brutishly-653f@gregkh>
 <221ba279-e48b-4002-9530-c6186e3e8042@linux.ibm.com>
 <2024081332-unblock-absinthe-1c26@gregkh>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024081332-unblock-absinthe-1c26@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XN7vFtli5f-GYtpnXQx21SA5m_mLntt7
X-Proofpoint-ORIG-GUID: XN7vFtli5f-GYtpnXQx21SA5m_mLntt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130130

On Tue, Aug 13, 2024 at 05:29:52PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 03:35:48PM +0200, Alexandra Winter wrote:
> > 
> > 
> > On 13.08.24 14:43, Greg Kroah-Hartman wrote:
> > >>> I don't understand, why can't dev_set_name() be called here?
> > >>>
> > [...]
> > > 
> > > But step back, why is this needed at all anyway?  No other subsystem or
> > > driver needs/wants this, what makes this api so special?  Why not figure
> > > out your name beforehand?
> > > 
> > > thanks,
> > 
> > 
> > Vasily, the following update to Heiko's patch does not touch lib/kobject.c
> > According to a quick test it still solves the original issue and does compile
> > with W=1 and iucv as a module.
> > 
> > diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> > index 64102a31b569..6a819ba4ccab 100644
> > --- a/net/iucv/iucv.c
> > +++ b/net/iucv/iucv.c
> > @@ -86,13 +86,17 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
> >  {
> >         struct device *dev;
> >         va_list vargs;
> > +       char buf[20];
> >         int rc;
> > 
> >         dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >         if (!dev)
> >                 goto out_error;
> >         va_start(vargs, fmt);
> > -       rc = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
> > +       rc = vsnprintf(buf, 20, fmt, vargs);
> > +       if (!rc)
> > +               rc = dev_set_name(dev, buf);
> 
> This looks best, let's not create a core function that no one has ever
> needed yet just for one user :)

Okay, fair enough. Thank you, Greg!

I'll drop these two patches. Alexandra, I assume you will send out your
alternative fix separately. Thank you!
