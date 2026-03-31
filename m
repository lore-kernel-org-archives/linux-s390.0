Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE4175A71;
	Tue, 31 Mar 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945844; cv=none; b=fYckGtdAURjTTNWZDJe/oTh4vz++TmbfipXrEiVZhNBGCDqc9fDBagEsbXZguSHB+GXOkVDphol4GHqKy1MCzM+XwuN2jC1t8XpKCcqJtC445WnR2IVzE2AkwLG3UtSzZ0JQZRAr0Uw3R7IvHPDoXyKH90yhhTmWhZ2gJT4qBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945844; c=relaxed/simple;
	bh=lHXKyn0rIPGWYtihxusYrWFI7wDP4RG8DEssesQ7JMM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=UZnjY1HDdPh1gwviEB0FLuRYa3pFLf2AA1ijVoGhUWJPaysZ7R5QH2Gv9Nt+sfVzb6UE5uc1F0/uiTDp3Nik7+5irJ55SmG4RxuwEVhGlNg68NNYOyaXn3N9mzlx3Mo8Tp7m0E0AshD9/2DwAdoyGXV9MuK6XXns4gFAZUZ9TmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HXyY125h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HXyY125h"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6YvFi4032815;
	Tue, 31 Mar 2026 08:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IFfMgu
	5WL9hOmQ5pM5pTR61tcKadLN/xaLZW4Ubsqts=; b=HXyY125hQGKb09knH6QIpq
	tfi7AITG+9Q3yB99ZT5HGerJ9JqIsfjrKzAdJbuRGFUymR6tdF2LoCG/UpDpxceK
	1gEzAXHtIyUXlyuIVje8XtLXKWBzW2NMgi9ySUWgVwB8PaECeu9ZFtK9/OzLVKA1
	57OrIMkVqriAwBiJaQHsSAMlaOtWNu4gK1LqBvYwrtW8uYiBPlJGTfg6QEsXXUn+
	PseUchpz2tVCu+pJ9lM4aZDpQJjWO+exSRFi9huvrgNTDY+QqCaygN2NsyBolZYD
	OLNYQSnMmJvcQggFGVHb9pHRVYwQGgO4kOUl8tDN3Jv6LoBfWxvOekSrSM+FdRzg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms1ugh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:30:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V7p1gR031034;
	Tue, 31 Mar 2026 08:30:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjr1nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:30:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V8UZIK56623416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:30:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9588C5807B;
	Tue, 31 Mar 2026 08:30:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5130F5807A;
	Tue, 31 Mar 2026 08:30:32 +0000 (GMT)
Received: from [9.52.215.169] (unknown [9.52.215.169])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 08:30:32 +0000 (GMT)
Message-ID: <4fb2b835ec81ca0ef24bc1c867d177a7d04b4873.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>
Cc: Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        wintera@linux.ibm.com, ts@linux.ibm.com, oberpar@linux.ibm.com,
        gbayer@linux.ibm.com, Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum	
 <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
        raspl@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260331000334.GI246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
	 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
	 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
	 <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
	 <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
	 <20260330093646.03b0455f@shazbot.org> <20260330155651.GD246076@ziepe.ca>
	 <20260330120945.023b2295@shazbot.org> <20260330181645.GE246076@ziepe.ca>
	 <20260330123925.713edac4@shazbot.org> <20260331000334.GI246076@ziepe.ca>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Mar 2026 10:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cb862d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=eic7ZF46ImWAZUYm3ecA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OCBTYWx0ZWRfX8yuY0RA5lt8o
 8rslq/FMUqDNmBM8KrV+Rh+yp1Dc5HzYMsfAoZ+0whoI0UN1WEVxr3tF9fEV+38irmqoynfw8Ty
 tT/MqXorMR3cjsEOoVy6nfhWsJqTKMiRIdLmWWVRZKbNSdNNzOgMXy83rm4vBusK+OR2q6ZKFGX
 rlONXxR7riwKaUSNp1CSu+fY5Y+BgmO5rwAxsjDJGVvPoQMt1+CHrCbKLikxR4utcFOqYreGXvu
 pqAF+CxjX3ZuL4xqUNdtGoUymGyANJzBwQYjXWCS3/8w67YLraNEFof5vSrZ0X1lIPgXnu6khVf
 lB6eJgKE18piGlQPBbbL7Y92ihEdyc5kMJj3n3BZI6cRNVDGOmE17O0A520TYn0v5Seg/+/azqN
 fxtImW+91ivhuSUNxnQR4t1yA5mol9ugHDxQxZ9nprWCxxwtDjmjtE6Cla8v9JFJO99+EVjzam5
 9dIBL+Lv+N2I+OtZcSA==
X-Proofpoint-GUID: tk1974_lsb68QMwYxrWQJxpZl794BysI
X-Proofpoint-ORIG-GUID: tk1974_lsb68QMwYxrWQJxpZl794BysI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310078

On Mon, 2026-03-30 at 21:03 -0300, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 12:39:25PM -0600, Alex Williamson wrote:
> > Yes, that would be the ideal balance of enabling larger BARs while
> > retaining compatibility for existing devices.  Sounds like we'll
> > continue down the variant driver path for this one-off device for
> > now.  It remains fairly self contained so long as we don't add more
> > regions for vfio-pci-core to manage.
> >=20
> > This could be a good project if someone is looking though, especially
> > if it had a build-time config option to set the minimum region size so
> > we can exercise it before we hit 1TB BARs.  Thanks,
>=20
> Well, it took claude an hour to vibe code a draft from a four sentence
> prompt.. I see many things that need changing/cleaning in here, but
> the patch strategy and general idea looks sound.
>=20
> I guess another day of effort would probably get things into something
> presentable. We are not so far away - maybe the variant driver path is
> not necessary?
>=20
> https://github.com/jgunthorpe/linux/commits/vfio_maple_tree/
>=20
> Jason

I'm in no way against changing the offset handling in general but for
what it's worth, we need a variant driver for ISM regardless, though it
would be smaller with large offset support. This is because besides the
large BAR we also have to use our classic function handle based PCI
instructions to access that BAR instead of the newer memory-I/O (MIO)
PCI instructions. And sadly the way the ISM device uses the PCI Store
Block instruction there is no straight forward way to enable the newer
instructions even if we changed the device implementation. This also
means that we would want to keep the no-mmap() restriction.

Thanks,
Niklas
