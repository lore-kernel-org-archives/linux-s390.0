Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805341E520A;
	Fri, 12 Sep 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672770; cv=none; b=T3dRWnrtkG3AHzDdUEV0krHLOgPVb4r2qLk22vbGLfmWgM/OwG8ogC70WC74BEeO8hla1DqZ0RKxEaeyWIbx6+LtawDMq06jJ+440WZ7weHiFKgs7mboyMWmGE1APWRnsNUnxMrFGXOvEAULbVV/UXhZ99udafDltMDThSuL9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672770; c=relaxed/simple;
	bh=W89h20ehPRBjbNNYvA9Le0XF7Wt/5CXIH67sItbuKdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCUbMvMTlQxttVA2YqBC8gRN7wLlyZojDanSQ2IA2pZvsO31kpwXUCReKQ68TaOwCdnQ2WP4Vk4FQROZTRdj+7VYb53k0Jhmib5/dt9DIWAH2isosl6A11MIMfUg07+b7qWfh2nhhwmkjKZU3RlSmAQSRmRtn5QhnO67ZsARy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IzRr+9zy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IzRr+9zy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C5XC48009648;
	Fri, 12 Sep 2025 10:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uq06KN
	h2BBSkZYbEP58EjBxA0XmjXGhnNwnm+E/Owwc=; b=IzRr+9zyVdCc17w+PtobXn
	pXOq9znMsJUMjNVHi9Ykvmw6yJdAOQZIqDF9JPue99o2DsK1jYmklcA5ZKAISV3T
	zTynRjihb0Uz+MwNWAnelFIwY279ghxR6vM7s3KMQ+SeabVQ5E5Co05dz+WyaOUS
	DzjvA+cgTHMObz0aaJ6BQM0YGypfMNGwBD/GO6r8NIhlvzMttAfDhWQaKiS0Zzom
	NC0EIo0u8OES7S+4kJWkVBh9IDkdQE+uP+YEU41iUrmw+ITcanbY0+PRi2EwuUzr
	gLgBzTUq3MF9qInU8enknfoFB9vG8XrZXNwbf9QdG7KhPvJ3UiGJj68Ry0vuqcyw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydfn9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 10:26:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CAMZRs021195;
	Fri, 12 Sep 2025 10:26:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydfn9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 10:26:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9LYPv020499;
	Fri, 12 Sep 2025 10:26:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp1ak25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 10:26:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CAPuRs45023642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:25:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11DC20065;
	Fri, 12 Sep 2025 10:25:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3384C2005A;
	Fri, 12 Sep 2025 10:25:56 +0000 (GMT)
Received: from osiris (unknown [9.111.34.207])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 10:25:56 +0000 (GMT)
Date: Fri, 12 Sep 2025 12:25:54 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/3] Compiler Attributes: Add __assume macro
Message-ID: <20250912102554.10147Bf8-hca@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-2-hca@linux.ibm.com>
 <CANiq72=Zhcrk-cvXX+75mQzqUUwQznkZmLTCoEn0XNs62meUtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=Zhcrk-cvXX+75mQzqUUwQznkZmLTCoEn0XNs62meUtQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h2EjhHvLwW2H2KtseXpnqOSph9QsBuEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX3zNIMlxidym9
 zxrL9OeFmmj9Z199bGatG874nsxEWg3KL0Q1DKWFmTNdHU8rhyLbjd2Y0SMr+pkF/m3Qm64QXSx
 aS9OnOi8CGb8yqAWkWieaaEFj28NnDCXDk4GTlctCLRQen99XHfGfjMVdOVB6+JlyORYsztWot4
 eFLzyNZ97EnxeC766cFXAINV1KwRKFIs8Np0BTjc8BkgvQvG2F8129f12+hZpT+BNLDzBFhILr+
 RgaPbDOpAzPoEy/52L55fgPjpJvOLumgqh60JCqMYXdu+OtniU7foj+cqWNPCtM4DvUR0xKFYcv
 yCfcwcSP0fSBVzIpny/gfqjkN7O4Vq/Ii9clhCDkZU0v+W0eX684a4vfHbLj0oKjxGgU1waLGOa
 8cBEEu+m
X-Proofpoint-GUID: WBocjeFnz5nq3-g-lGn17-oBRJDtDHVy
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c3f53a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=PUJLaZJu5X_K6ovvMFYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Thu, Sep 11, 2025 at 08:59:29PM +0200, Miguel Ojeda wrote:
> On Wed, Sep 10, 2025 at 5:12 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > + * Beware: Code which makes use of __assume must be written as if the compiler
> > + * ignores the hint. Otherwise this may lead to subtle bugs if code is compiled
> > + * with compilers which do not support the attribute.
> 
> I am not sure I understand this "Beware:" comment: is it referring to
> evaluation side-effects? If so, the GCC docs say it is not evaluated.
> The real danger is triggering UB with it, but that is different, i.e.
> one needs to be really, really sure the expression is true.

No, I was referring to the original build error where the missing "& 127" lead
to a warning / build error. So what I was trying to say: if you have a
construct like:

	...
	return a & 127;

and then make this:

	...
	__assume(a < 64);
	return a & 127;

then it is not possible to leave the "& 127" part away, since __assume() is
optional. But thinking about this again, I guess the comment is misleading,
like also your reply proved.

This is not about subtle bugs, but just an optimization that is not being
done, which may or may not lead to compile time warnings for the particular
case I was trying to improve; but the code would be correct in any case, as
long as __assume() is used correctly.

I'll rephrase the comment, and split / reorder patches differently so it is
(hopefully) more obvious what I try to achieve: allow for micro-optimizations
of inline assembly outputs.
