Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570B299950;
	Fri, 21 Nov 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734804; cv=none; b=L6X4F1i5I8yqqlk2O/kHfW3L9DzRIaQ/YWvtJ1IPlBpC6fnhTHc0Bbxg36wBjeSnY03h5oGMjCn28TArPJYAvFXisWQ3DAhMZscj2ZlEPyUzb3Wa9iX82tjauzrjv8CSQq5ELKTdUdovx8lw+IcP90jdwi0Q8ommBpasI/bsffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734804; c=relaxed/simple;
	bh=dA4PQl7xBMAQMW3U3pMU/geLpS0vqUVW9/J4uUEnZJs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Prp7gLk8EnUPrWlOwAxGWsFoF9nH3eo3w5YJpTJokMC0ZvkFbHCnFGwo9Hij8YG3lnI+ZKmCShP/nhJVhoS5qHztNGs2DN+dgFUHFWnhJ5kMonbPHbhDg5VCFebd0L3azoGsCyV8q1DHgWgaEsCulM0yFMMCxmIkHrolXQluJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HO+QtN3L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HO+QtN3L"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALDJgwb007084;
	Fri, 21 Nov 2025 14:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j/18iT
	Cw2oncOV/qV7oFUVePBDLphJwjeS+eMlqIHQE=; b=HO+QtN3L94/Jr300pNlQLR
	uwwHibGrg29ht+P0M778jxGUu5plVLbemp6RayLNnW5QtfE6TGzfohi6vak1a42a
	GDmR7D0kd0PCbO2NETwlxEYlpyBKxH0xRQo+I3sxtyKvLYRBZ/s6lLawd6eJA17K
	FGBeHS0Svb2r7aq1/m0f3xKwExZJNykHIZbeApnPHH9oIUXvAdyGADAoCtMu5eHF
	BTnvkdYlDm0INIZ61MemKVsbICU7FNK7oqzLr7ToWrgYrqGm/1hUj2G2TkPovB6s
	yrDUI/CP3ZhdZz40YReozXCORFfe6SYkkZGtbHU2mQCWe+i2/+piMZrjzlrmaUzw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmt2uxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:19:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALCYKP8005133;
	Fri, 21 Nov 2025 14:19:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bkmkfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 14:19:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALEJs2A61538796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 14:19:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ECF620043;
	Fri, 21 Nov 2025 14:19:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7800A20040;
	Fri, 21 Nov 2025 14:19:53 +0000 (GMT)
Received: from localhost (unknown [9.111.95.11])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 14:19:53 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 15:19:53 +0100
Message-Id: <DEEFSYEK2EPX.7THCTOCXJLUU@linux.ibm.com>
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Heiko Carstens" <hca@linux.ibm.com>, "Gerd Bayer"
 <gbayer@linux.ibm.com>
Cc: "Tobias Schumacher" <ts@linux.ibm.com>,
        "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Gerald
 Schaefer" <gerald.schaefer@linux.ibm.com>,
        "Halil Pasic"
 <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Thomas
 Gleixner" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        "Farhan Ali" <alifm@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
X-Mailer: aerc 0.21.0
References: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
 <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
 <626c1d010ff720c8c2beb7bdd36b0565850a6ab3.camel@linux.ibm.com>
 <20251121140311.27602C99-hca@linux.ibm.com>
In-Reply-To: <20251121140311.27602C99-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1uEGzKYTka5mV-Vkb3Dh_drvHZ8Pc4xi
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=6920750e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ENFrDvVUNvTEZJsXknYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1uEGzKYTka5mV-Vkb3Dh_drvHZ8Pc4xi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8zoXSxJHrFsR
 kbVVJXWS1zdi4HGQueb8CeHQpurt9GzWoduCjpkDU9YBF9vLBpJi4Fag0gjYnoBzKUdLWQMinYx
 HuMBbpFsBsPO79G5EOYtoQqtwNOrpEPq3vC7na03GB6piq99JHd3RQ6/Q2eIaRKbK2BTebdKcPp
 Zcdd30A/vyvn302Uyouh6Hl+DbHe4ml2nOCgzZQkfSfbGtk4zBugT3kjcTJpOidopQHZCxOcOys
 WXoFQvw1QvW9YpPRI3T4fBDja0Q207ZGowNziioTR2X23fhB23V7/EXCHABrHGdiqGuc/KgrHfW
 f5A4Uk9I5I/VATRc205X9PbAt3eccP5FLB/fJIjsqpaXnz/o23G9+ifp+pwhZmcBCrbAkNkUIta
 cIUT8PbUH/sS3dl8zhmsKQ4vrbb7wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri Nov 21, 2025 at 3:03 PM CET, Heiko Carstens wrote:
> On Fri, Nov 21, 2025 at 02:27:38PM +0100, Gerd Bayer wrote:
>> >  	bus =3D pci_create_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->res=
ources);
>> > -	if (!bus) {
>> > -		zpci_free_domain(zbus->domain_nr);
>> > -		return -EFAULT;
>> > -	}
>> > +	if (!bus)
>> > +		goto out_remove_msi_domain;
>>=20
>> Or do you want to set rc to -EFAULT here, and return the "original" rc
>> in the error exits?
>>=20
>> > =20
>> >  	zbus->bus =3D bus;
>> > +	dev_set_msi_domain(&zbus->bus->dev, zbus->msi_parent_domain);
>> > =20
>> >  	return 0;
>> > +
>> > +out_remove_msi_domain:
>> > +	zpci_remove_parent_msi_domain(zbus);
>> > +out_free_domain:
>> > +	zpci_free_domain(zbus->domain_nr);
>> > +	return -EFAULT;
>> >  }
>
> Oh, just realized this oddity with Gerd's reply: -EFAULT should _only_ be=
 used
> for page faults. Looks like this return code is not passed to user space,=
 but
> please change this to something more appropriate. E.g. -ENOMEM, or whatev=
er
> fits here.
>
> Given that Gerd had quite a few more comments, please send a new version =
with
> my comments also addressed :)

Sure, will do

Thanks,
Tobias
