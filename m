Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE843C04D;
	Tue, 16 Jun 2026 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608433; cv=none; b=uAlRsTfN9jtE5abQ1GMnWe+nsORP4qzws9hKE+6AAWusz1AuiYQBFBPSchmIer4mwZvGL6ErLayZlwQkhi/1K8VT47UUnOjHmPbh4R/8cwTSSp7TNOdloyFZ0D9xKWtTeejMTQkEgirKnmTwwKJjRTzqElFZAXS3OumiX8fYVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608433; c=relaxed/simple;
	bh=tH5Y3CYksCKse/U790ncAiEl5+cqqG49txptrPvaX3E=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gp46adr8VS9LEOf9aiMkqksB/S1bTrXTasBYnYX2zusnjyUhF+5F1z61HR4NdzeVJqlPE3sgs0rRod9BQSj3+CAfopCjClMgU521jXkdu45NQkHTXeV7H8+rt610lSpAzHWP18UvZRcb08YF5MLFHi4Ru2g7RgyTyeuokEnmNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KRyom5Jb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KRyom5Jb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIGFM1227484;
	Tue, 16 Jun 2026 11:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IbTJGg
	d8Wm6mOQ0OAsKYO0y4fxqkDw4LTh2TsneiWCI=; b=KRyom5Jb4f9ITVCyopCt48
	PIhlE86QDiTiKRJUa7eScEqKpCBUwqzqvnibdtRKqhZywjONk1CyvaateOPsGhdb
	PdN+jWJOehlGPM/HIX0fCtDOC4aUg3gSp6N/MJVdgDkzQ43l8qBIsVV4vvCAfTvh
	BDpETfrCewXrafeuoicPYPlVgmWCXwlgAUY98zgTUKgOrJtrRZyLMQs0+RbDkZYO
	WoB6zzAu79fgylKGTufzInL4RcitXkwyJTm5sQVscsGwEZKM/FOHf1uP5Vc2GfQv
	cBdppMsTKvhNM+o3qxfsVNJtYnRtidmlZ2fZUS8cEX/2BZS1fP4kYD38h5VZ3hOQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm58q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:13:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GB4cFZ025126;
	Tue, 16 Jun 2026 11:13:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y2se8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:13:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GBDk3C28705418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 11:13:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36DEE58055;
	Tue, 16 Jun 2026 11:13:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8F858043;
	Tue, 16 Jun 2026 11:13:45 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 11:13:44 +0000 (GMT)
Message-ID: <b03380c2b16f32880810804cd847d6006ea2ad1b.camel@linux.ibm.com>
Subject: Re: [PATCH v19 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, mjrosato@linux.ibm.com
In-Reply-To: <19fe09a8-4b56-4e47-9b03-ba51679f25ff@linux.ibm.com>
References: <20260615183524.2880-1-alifm@linux.ibm.com>
	 <20260615183524.2880-5-alifm@linux.ibm.com>
	 <02c66b72de27b3360536dfdd0747261dc487059d.camel@linux.ibm.com>
	 <19fe09a8-4b56-4e47-9b03-ba51679f25ff@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwOSBTYWx0ZWRfX+4mVXueQGupW
 D9JTKy6swCK2ERT5/L8uSdz87rUVAdsU1yJxVLKlpyzhTy2DOZr7hE8PDB1Oq59Yht0IAhNQ/JN
 vay6dEZNWFaTpBmV8gqTfvo9ucLgE24=
X-Proofpoint-GUID: SsAHinMGFJZgdTba7HttOlpZYJflbCU1
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a312fec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=C1Hwd92nIuYfSArr40IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwOSBTYWx0ZWRfX7/Ar2aS4scg7
 jqhsp7zBiE/FeOSQnD46uVY4IKl8x25msJYuQEBgMZryTUqomDKyCnDCpo8p0IcE29bwUTUCVac
 b6RCNxol8W/9G8xG6QT5lFsjvXiRcfnuayYV+NW6Jsxy52TKXac1ij4G3Rxg8GL+wQjbPkqKoEA
 C27Up6oqo9pBvFwiiA6ip+w4iGTs7+VviptSZDtGxH0iUCSE2NWW3e0AFbQTU1mmNI3tgeEDs/K
 AQEoSsQ2jRku8B5O2eXp1drRTTY509zs2zmLWQR8IHNATohuP+2XXcX6wvrLsjrVsaWTXGFHAvM
 hZKjITtjN9jsrZKmdoIVqjoV6XjsSmpzveiR5UPRRw+M8keQYwbl7HYimF60MJRcOvp0zo2toSi
 wHHdyOpw5mf7R56R1lyTc3aiqvjf76c7IKx7DzP+79vBRz1rkkjBK0q2mct4K7PC14a57pxlC6l
 OxtVVKS26Bvvy1PTqgA==
X-Proofpoint-ORIG-GUID: SsAHinMGFJZgdTba7HttOlpZYJflbCU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160109

On Mon, 2026-06-15 at 15:17 -0700, Farhan Ali wrote:
> On 6/15/2026 11:59 AM, Niklas Schnelle wrote:
> > On Mon, 2026-06-15 at 11:35 -0700, Farhan Ali wrote:
> > > The current MSI-X restoration path assumes the Command register Memor=
y bit
> > > is enabled when writing MSI-X messages. But its possible the last sav=
ed and
> >                                                ^ it's
> >=20
> > > restored state of device may not have the Memory bit enabled, even if=
 a
> >                     ^a
> >=20
> > > device driver later enables Memory bit and MSI-X. Attempting to acces=
s
> > > Memory space without Memory bit enabled can lead to Unsupported Reque=
st
> > > (UR) from the device. Fix this by enabling Memory bit if we write MSI=
-X
> > > messages, and restore it afterwards.
> > Don't we have the same issue in __pci_restore_msi_state()?
>=20
> I think for MSI it's done through config space registers and so it=20
> doesn't need to access MMIO.

Ah you're right, I was confused by the call to
__pci_restore_msi_state() in __pci_restore_msi_state() but looking at
the code paths it does seem like for MSI's it won't do MMIO.

>=20
> >=20
> > > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > > ---
> > >   drivers/pci/msi/msi.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > index 81d24a270a79..d8d3c8a911ac 100644
> > > --- a/drivers/pci/msi/msi.c
> > > +++ b/drivers/pci/msi/msi.c
> > > @@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev=
)
> > >   {
> > >   	struct msi_desc *entry;
> > >   	bool write_msg;
> > > +	u16 cmd;
> > >  =20
> > >   	if (!dev->msix_enabled)
> > >   		return;
> > > @@ -884,6 +885,11 @@ void __pci_restore_msix_state(struct pci_dev *de=
v)
> > >   				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> > >  =20
> > >   	write_msg =3D arch_restore_msi_irqs(dev);
> > > +	if (write_msg) {
> > > +		pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > Sashiko complains that the read cmd may be all 0xFF=E2=80=A6F in case o=
f
> > transient errors. Though I don't see how we'd handle that here without
> > a larger refactor.
> >=20
> > > +		pci_write_config_word(dev, PCI_COMMAND,
> > > +				      cmd | PCI_COMMAND_MEMORY);
> > > +	}
> > >  =20
> > >   	scoped_guard (msi_descs_lock, &dev->dev) {
> > >   		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> > > @@ -893,6 +899,9 @@ void __pci_restore_msix_state(struct pci_dev *dev=
)
> > >   		}
> > >   	}
> > >  =20
> > > +	if (write_msg)
> > > +		pci_write_config_word(dev, PCI_COMMAND, cmd);
> > I wonder if it may be safer to have the Command register reads/writes
> > within the msic_descs_lock critical section in case this gets executed
> > concurrently and so the restore above from one thread could slip
> > between the Memory bit enable and the beginning of the critical
> > section.
>=20
> Hmm I am not sure if its necessary, AFAIU the msi_desc_lock is used to=
=20
> protect the descriptor list. Other config space changes in this function=
=20
> is also done outside of this critical section.
>=20
> OTOH Sashiko does mention correctly pci_msix_write_vector_ctrl() can=20
> happen even when write_msg is false and which I missed. But this got me=
=20
> curious, as to why would we write the vector control for an MSI-X entry=
=20
> if we are not writing the message (Address and Data). AFAICT the change=
=20
> to write message based on arch_restore_msi_irq() was originally=20
> introduced with 76ccc297018d ("x86/PCI: Expand the x86_msi_ops to have a=
=20
> restore MSIs."). Prior to that we always restored the message and vector=
=20
> control mask for an entry. So I am not sure if write_msg is false and we=
=20
> don't write a message, why would we want to write the vector control=20
> mask? If we have a valid reason to write the vector control, even though=
=20
> we don't write the message then we should we enable the Memory bit=20
> unconditionally? Thanks
>=20
> Farhan

It seems to me that the only place where arch_restore_msi_irqs() even
returns false is in xen_initdom_restore_msi() and from what I can tell
from the Xen code this then ends up doing the MSI write message in the
Xen hypervisor so for MSI-X also does MMIO. And yes I'd think that if
write_msg is false the pci_msix_write_vector_ctrl() would potentially
also cause an UR if the Memory bit remains off. So from my basic
understanding I'd think it should be enabled unconditionally. As a
bonus it would make the code easier to read too.

Thanks,
Niklas

