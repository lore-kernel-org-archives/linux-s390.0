Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC63D3D1B;
	Tue, 23 Jun 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214186; cv=none; b=LWA1r/KSFXq2JT8BCkOmxfrZOt2HcFU7MQ0JXVE63V3IkzyE20Rjk2BblJlKdJPZWiXL+g94UlvrldIKuoo7B3kYCWrVpnLhoD3rHge7MVXZ5S/1ujYNjJP1oXgQU+36wwtdqW8bYxfSJqz1u6SbZfe1zjdjpk2MibeJKQxUogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214186; c=relaxed/simple;
	bh=xn6YxnvJ599Gb6Dle6qLaRJVIr1ZU1CM9ExOWOYGSVQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TIbQR0WqPhQq6qOP8304l/pyZdHewX4KIJkL876xAjbwMmSSUJjSHbpmwl4+o9hG8GgUkZLAtqge/bALvM4eBzWxAlaq0huZ0Oy1v3RWRmi7uUrP5jzvsFPvQSMHP5HQYCTAmpdMvbZI+wb08sxaym8r2AngvjcVH6BTO1oZSE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ou4ZTw/B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ou4ZTw/B"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBIRE91851354;
	Tue, 23 Jun 2026 11:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OBefJE
	ZTD8+eIgqHi+T8qiZJv2+uIcUYbrBalMcadHI=; b=ou4ZTw/BjiuHmcxAyPjt8Y
	tu/U9oM92aeZJTetc4SIfgIkYQdqEWCdVS5guQxk5f4ckhTvZD4jHwX/cmuOaAQ0
	YuRAxUrpqIzDnLxbdDEQvfM1n8XdhNCJUkN0hJpchOHJJWH8TbG+0xUcqmkV2CIZ
	sWptvfb8MhD1e5lBEbtl6uzWXXXUfIobjB9kxE/it0duFTeHc1niWoMVpUfelS0H
	NO6MjgWaCTmpnRNe06nSrirmrWdvOPwMlFDDDt0ZPJZ7d7FCGirXJcXLCLW7WznF
	87XI8jw2Z/ot9XlTfNVP7PmIVszNraLEQOeTdKUDqUOWpXS5mTzgjWUsiY/ERPnw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4e5kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 11:29:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NBJviH001155;
	Tue, 23 Jun 2026 11:29:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyjncc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 11:29:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NBTdaG24183450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 11:29:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78A158045;
	Tue, 23 Jun 2026 11:29:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F5FF58050;
	Tue, 23 Jun 2026 11:29:37 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 11:29:37 +0000 (GMT)
Message-ID: <087b5cafd04d2fee89f3a4a941d425e967d1ee72.camel@linux.ibm.com>
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
In-Reply-To: <c8abc1c8-71e0-443f-820f-182c0ff931e9@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
	 <20260622171840.1618-5-alifm@linux.ibm.com> <87ik7al3of.ffs@fw13>
	 <c8abc1c8-71e0-443f-820f-182c0ff931e9@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5MiBTYWx0ZWRfX6skRVgKw1nMR
 Ay8kxSPO9BWQJNrGy71NHeW1M78cF41AFHfVOHFZT2Uwmu3hsE4sBlLkltHOAYeM09OvmFGL/L6
 piIwJkaYyRrs1DQSsCeYIHbKA7cbTck=
X-Proofpoint-ORIG-GUID: GaE5wnh-g8ix_yYuFWP8qsowCLm6vBX1
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a6e25 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cv3ftqYjHt7s5IYWvSEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5MiBTYWx0ZWRfX6T8aF2B3Ft8K
 ExOtJaq/Ebhpg2om1V9+1Y8I8s0iT4Hn9EJXf57WUBgv11b3Kp2KAQzZSYRzD5fJGCxX1ACpTKZ
 17FWoeD6JRwJ8jqcWCbKmjJrS/o6brItCenyBVr84zv1RCaT0Et3rwzaMwGbJg/K9H4MK2zInDy
 aDRp4BDv5FVF+sLJpWLC+mtP3LG3h58MwapVjoBL5Rb77dKuP0vd+2+XWQLraeqXYQsXLo39c1/
 ujBHheHbK+RKGxVxEi07cwJ/uQaD62lTo/uEa4y646pjtNcmqNujFiNnjVc8Wzloe2YAp2k9C6W
 lytjd/jqw9fJaAJN+i54W3h3CCXMNn2guYDBYpmJ8SKMeu4xXhs3DCAZXlNdEdT6Ai+e4llSLbE
 CrMRVcdJh6acrSpCr2g9ZENGV0y4XbZfYXdaWQR0ncXFJ9gB+zwD9AkULap6RAFhXwuaieGDds4
 vDegiSTvdLk2A4lmhGA==
X-Proofpoint-GUID: GaE5wnh-g8ix_yYuFWP8qsowCLm6vBX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230092

On Mon, 2026-06-22 at 13:49 -0700, Farhan Ali wrote:
> On 6/22/2026 1:29 PM, Thomas Gleixner wrote:
> > On Mon, Jun 22 2026 at 10:18, Farhan Ali wrote:
> > > The current MSI-X restoration path assumes the Command register Memor=
y bit
> > > is enabled when writing MSI-X messages. But its possible the last sav=
ed and
> > > restored state of device may not have the Memory bit enabled, even if=
 a
> > > device driver later enables Memory bit and MSI-X. Attempting to acces=
s
> > > Memory space without Memory bit enabled can lead to Unsupported Reque=
st
> > > (UR) from the device. Fix this by enabling Memory bit and restore
> > > it afterwards.
> > >=20
> > > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > > ---
> > >=20
--- 8< ---
> > > @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev=
)
> > >   	pci_intx_for_msi(dev, 0);
> > >   	pci_msix_clear_and_set_ctrl(dev, 0,
> > >   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> > > +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > > +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> > Can we please have a comment there which explains this? Three month dow=
n
> > the road this will results in head scratching otherwise.
> >=20
> > I agree with Niklas that this wants a Fixes and a Cc:stable tag.
> >=20
> > Other than that:
> >=20
> > Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> >=20
> > Thanks,
> >=20
> >          tglx
> >=20
> I can add a comment, how about something like below?
>=20
> "The restored device state may not have Memory decoding enabled in=20
> Command register. Since the MSI-X was enabled for the device, enable=20
> Memory decoding before restoring MSI-X"

Missing "the" before "Command register" other than that this sounds
good to me and I agree with Thomas that a comment makes sense here.

>=20
> For the Fixes tag, do you have a suggestion for a commit? This behavior=
=20
> has been present since=C2=A041017f0cac92 ("[PATCH] PCI: MSI(X) save/resto=
re=20
> for suspend/resume" which introduced these restore functions. So should=
=20
> be Fixes against 41017f0cac92?

I'm not sure but my guess would be that for suspend/resume this isn't
an issue since the suspend part would save the state with Memory Space
enabled. So it wouldn't be broken in this original use-case. I think
the problem only occurs in case restore is done for error recovery.
Might it make sense to have the Fixes tag point to a2f1e22390ac
("PCI/ERR: Ensure error recoverability at all times") even though that
only helps to expose the issue?

Thanks,
Niklas
