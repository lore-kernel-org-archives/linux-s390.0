Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA753BB57;
	Wed, 15 Apr 2026 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280724; cv=none; b=C01WofKrkUNw802a6Klrnz6t+97OaRUzs4f0cZoQTIjeVHC1gQkcLSBmZAanWnOB0LAA4gOFrhggqhNhXm9KcQ16COX0tN4V82sHStF1jwnNmwpJKxty9j/tZ/bMNWrlqsKMG8EE3A0L9488y7N+h5+aceU9/HuGb5mZimf9r9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280724; c=relaxed/simple;
	bh=mStHPbupelR0bY+rmlPlxlfmtIwFFK3z+Q13AxCevus=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=q4iE+6/Xx86sl6/sSX33ZoXLrjicTowFoRpB5R7U90GLA9Pswzv/TbOKSAAhdzmS20Sz7OtIGduBa/lzmnDtBxM3daYkf5ySoiUeEv3DB8D0QJMr+QPmHqidhsE77FZYbgKDHE7fSJrY5rrezGb4qTrPmaIuvUZMOdlN85j5Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZuwW9UgY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZuwW9UgY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FGj3kN1735742;
	Wed, 15 Apr 2026 19:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cy793L
	HEds/cw6abUT+Lp7iwIANQViyL3BGCy3GEbrY=; b=ZuwW9UgYuNlPzNAmbzMSeu
	0K2FNIPzOMA1yvtofKI1eSJFeIFDHej0HauDtLmXNkFFzzGhNFcPPuJzmyGTVHOp
	t2xYCjzsFimXR1AaRUDddIdNBViL+JQc8Lmb7RzuqvQMrPzUi6qUIPVxTIeNqne4
	3XSpnc0dcIBjUzqVC2SET+6MUTMmEuMlfUSCdNHfmPwKJb9Bt4GtOiKlkXrDSjwA
	5zr87MlNTCukjxRfY2BC8DHAz+lww1+29jG2tUTgxYjk1YF7ej2li+bzEdG0qiN7
	LcOwqEISEJlc41LiQjfoybDbPwmuOL+AJxR4zghlsanIbL9+nZnZfhRbWhsYjvAQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m99ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 19:18:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FGnHkD003610;
	Wed, 15 Apr 2026 19:18:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnfph0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 19:18:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FJIZcK31588966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 19:18:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A69F58058;
	Wed, 15 Apr 2026 19:18:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 369D15805B;
	Wed, 15 Apr 2026 19:18:33 +0000 (GMT)
Received: from [9.111.81.211] (unknown [9.111.81.211])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 19:18:33 +0000 (GMT)
Message-ID: <2059e5412e5d9367ac635b6471fefd0849ff7984.camel@linux.ibm.com>
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
        clg@redhat.com, kbusch@kernel.org, mjrosato@linux.ibm.com
In-Reply-To: <34f59b3b-dc28-4fd3-b2d6-d34bc4fd297c@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
	 <20260413210608.2912-6-alifm@linux.ibm.com>
	 <20260413165758.0f87312b@shazbot.org>
	 <cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
	 <20260414081238.23e2cecc@shazbot.org>
	 <5f26af4c-9584-4c70-9702-0a3bcd0c4ad1@linux.ibm.com>
	 <20260414114132.31481b48@shazbot.org>
	 <9d68b944-bd65-495b-b69c-e0d6758f15ee@linux.ibm.com>
	 <f20c8b1c6cd7fefbe3fbeea1055d41bea009b5ba.camel@linux.ibm.com>
	 <34f59b3b-dc28-4fd3-b2d6-d34bc4fd297c@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 21:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69dfe48d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=adBxAaxHKppDwLjIIogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Mzxnu8K5p-dNlUtcXXQgyAk4o4hZHqkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE4MCBTYWx0ZWRfXzNgI08iyfuKi
 3A4LjE3R8ThoOw3am4Sw8r7T2FrfbU0jjpFQGgyblMyd3AlXeRyXbHS7Hhj2JeUb42BEdEwObs5
 X8qpBGpG/9zBbnwn+zCqI/uBoe0v4li3wmk6HJbDtbWcoTJjyL6C/wY0Nig72tlIICqXxPmr8WY
 CwvHg+x2z+SVRXo5EQvELFCdfx7F9i6pGkHsMQOx1RDdW4yG0Oa3KGZ8uSBhWTl0DUqBC339V4H
 3qqh/VjhiH9eOUf+JfgtLFL8Eg11v+02Vp1yfpSeW1X7TO6ZWm9oUxUtv6XDWcqgPWGqWP3DquZ
 usecK3VUsiF3Z1I1g7OZSCG/lxDSHtLF4LBXcPHC2Ei4GlSecjZWdxIxIaHbtgRg0u7RgROOoRA
 om6G8TxU1y5kUCwjFkNKIM/HzrhiCGrdcV4BKpmkq0nVboRrpU+Aqw16m2B0hQeTIBw7Bku6epB
 WRXz94FJOpxU6aCsHfw==
X-Proofpoint-ORIG-GUID: Mzxnu8K5p-dNlUtcXXQgyAk4o4hZHqkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150180

On Tue, 2026-04-14 at 14:06 -0700, Farhan Ali wrote:
> On 4/14/2026 12:43 PM, Niklas Schnelle wrote:
> > On Tue, 2026-04-14 at 11:45 -0700, Farhan Ali wrote:
> > > On 4/14/2026 10:41 AM, Alex Williamson wrote:
> > > > On Tue, 14 Apr 2026 10:13:22 -0700
> > > > Farhan Ali <alifm@linux.ibm.com> wrote:
> > > > > On 4/14/2026 7:12 AM, Alex Williamson wrote:
> > > > > > On Mon, 13 Apr 2026 16:40:49 -0700
> > > > > > Farhan Ali <alifm@linux.ibm.com> wrote:
> > > > > > > On 4/13/2026 3:57 PM, Alex Williamson wrote:
> > > > > > > > On Mon, 13 Apr 2026 14:06:06 -0700
> > > > > > > > Farhan Ali <alifm@linux.ibm.com> wrote:
> > > > > > > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/lin=
ux/vfio.h
> > > > > > > > > index 5de618a3a5ee..2980ca39dd38 100644
> > > > > > > > > --- a/include/uapi/linux/vfio.h
> > > > > > > > > +++ b/include/uapi/linux/vfio.h
> > > > > > > > > @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf=
 {
> > > > > > > > >       */
> > > > > > > > >      #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> > > > > > > > >     =20
> > > > > > > > > +/**
> > > > > > > > > + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI e=
rror information to
> > > > > > > > > + * userspace for vfio-pci devices on s390x. On s390x, PC=
I error recovery
> > > > > > > > > + * involves platform firmware and notification to operat=
ing system is done
> > > > > > > > > + * by architecture specific mechanism. Exposing this inf=
ormation to
> > > > > > > > > + * userspace allows it to take appropriate actions to ha=
ndle an
> > > > > > > > > + * error on the device. The pending_errors provide any a=
dditional errors
> > > > > > > > > + * pending for the device, and userspace should read unt=
il zero. A value of
> > > > > > > > > + * 0 for pending_errors and pec would indicate no pendin=
g errors that need
> > > > > > > > > + * to be handled.
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +struct vfio_device_feature_zpci_err {
> > > > > > > > > +	__u8 version;
> > > > > > > > > +	__u8 pending_errors;
> > > > > > > > > +	__u16 pec;
> > > > > > > > > +};
> > > > > > > > I assume .version is for compatibility, but we don't define=
 a strategy
> > > > > > > > for using it or specify what the version should be for this=
 table.  It
> > > > > > > > doesn't seem like there's actually an value-add to having i=
t.
> > > > > > > Its possible we may need to extend this structure in the futu=
re if we
> > > > > > > want to report more information to userspace. I at least want=
 the
> > > > > > > flexibility to do so. We had some discussion around this [1] =
in an
> > > > > > > earlier version. I was trying to follow similar versioning pa=
ttern we
> > > > > > > had around vfio-pci/zdev structures.
> > > > > > IMHO, the version field is a dead end towards achieving this,
> > > > > > especially if we don't specify from the onset the expected vers=
ion
> > > > > > value or the compatibility semantics.  All that's going to happ=
en is
> > > > > > that some userspace will hard code that it understands version =
1
> > > > > > because that's what's currently reported and matches the struct=
 defined
> > > > > > here, and you can never ever report anything other than version=
 1
> > > > > > without breaking that user.  At that point you need to come up =
with
> > > > > > some other means for the user to opt-in to a new version, wheth=
er it's
> > > > > > triggered by another feature (as we did with the PRECOPY_INFOv2=
 above
> > > > > > this), or we reimplement the whole v2 feature.
> > > > > My understanding was based on how we version some of the capabili=
ty
> > > > > structures for zdev (in include/uapi/linux/vfio_zdev.h). If we wa=
nted to
> > > > > provide more information to userspace in the future, what would b=
e
> > > > > preferred approach? Do we need to explicitly define a v2 feature?=
 I am
> > > > > open to suggestions on this.
> > > > >=20
> > > > > If we need to define v2 explicitly in the future, then yes I agre=
e we
> > > > > can simplify it to return only the PEC code (or an error code oth=
erwise).
> > > > Maybe I'm reading too much into it, but it sounds like you already =
have
> > > > plans to expand this.
> > > >=20
> > > > The existing zdev structures seem to rely on the version field in t=
he
> > > > capability header and maybe you've gotten away with bumping the ver=
sion
> > > > without breaking userspace, but it's fragile.  AFAICT, the ioctls d=
o not
> > > > define a versioning strategy where vN+1 only adds fields to vN, so =
all
> > > > it takes is one outspoken userspace tool that hard codes its
> > > > compatibility to a specific version to become a problem for further
> > > > updates.
> > > >=20
> > > > Likewise this feature doesn't define a versioning policy for usersp=
ace
> > > > to follow.  I'm sure there are other examples within vfio that are
> > > > problematic, but let's try not to create more.
> > > >=20
> > > > If you want to use a version, then also define what the version is =
and
> > > > what the compatibility policy is for future versions.  A flags fiel=
d is
> > > > another option that we've used extensively in vfio.  The version fi=
eld
> > > > might be better for incremental expansion of the structure, while f=
lags
> > > > can address specific fields more directly, ex. a reserved field bei=
ng
> > > > redefined.  Thanks,
> > > >=20
> > > > Alex
> > > Just wanted to understand and clarify if we can associate multiple
> > > fields with a feature flag? I think in that case flags would be bette=
r
> > > here and given its also something that is widely used in vfio. I am j=
ust
> > > trying to figure out the best way we can extend this without a lot of
> > > code churn in the future.
> > >=20
> > > I appreciate the feedback and discussion on this.
> > >=20
> > > Thanks
> > >=20
> > > Farhan
> > Here is an idea. I think we even discussed this internally at some
> > point. How about we just use the architected CCDF Error Event (i.e.
> > basically struct zpci_ccdf_err with possible uAPI type adjustments) as
> > the data user-space reads. The bit definitions of it are already part
> > of the architecture and it has provisions for extensibility based on
> > s390 architecture principles which have worked quite well for forward
> > compatibility. If we additionally make it possible to query its length
> > as kind of a version it could even grow. I think this would also work
> > well with the idea of returning an error on read if there are no more
> > error events and user-space reading again and again until it sees the
> > error. I agree with Alex that this seems much easier to get right than
> > a pending_errs count. As a bonus we can immediately expose all the
> > error event information Linux currently uses. That said, I would opt to
> > setting the struct fields by copying field by field explicitly and
> > leaving reserved fields 0 such that we don't pass-through any bits a
> > future platform may add without having a defined field in Linux.
> > Thoughts?
> >=20
> > Thanks,
> > Niklas
>=20
> My concern with exposing the entire struct zpci_ccdf_err was it could be=
=20
> error prone trying to keep the struct and vfio uAPI struct in sync. Just=
=20
> thinking out loud, to query the length we would need a different vfio=20
> device feature bit? But if it makes for a better uAPI, I can make the=20
> change. Thanks
>=20
> Farhan

If we have a function that copies between the struct zpci_ccdf_err and
the uAPI variant field by field and add a BUILD_BUG_ON() for matchting
sizes it should be pretty hard to miss them going out of sync. If we
want to be absolutely sure we could do a series of
BUILD_BUG_ON(offsetof(struct zpci_ccdf_err, foo) !=3D offsetof(struct
vfio_zpci_ccdf_err, foo)) into that copy function. It's not the most
elegant but should definitely catch any mismatch.

Thanks,
Niklas
