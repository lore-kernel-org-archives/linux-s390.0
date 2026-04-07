Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEC38A289;
	Tue,  7 Apr 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551959; cv=none; b=Pr4Mq/sdmCRtyf1Cm2NoSPx+RVzvTY7XWHPGGAcRnx8Kynny1nbD3ynG2DxiV+Jc32YhU56gKWmAWQCpGcIYuuShX+YNBEBRshOND2GiIiJQTtGZg+5ZaXayYdD6r2+qTRWtOkgh7UMJifKv8Vpz+v0teT4YK4zXdYYGUpwmM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551959; c=relaxed/simple;
	bh=7smeLzRgMUZ0JktPP6XuZP2JhhbUMHxaUd3OQcyTHAk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lvOb6/vyZtQTw9hEsfQWoL+lMrVthKWII7Jz83IwPOT3I/RuydWFxVceHJeIbzD8raxxGkWm3dgXRpCRn+Pkjj/L+b55bb+5kYjKal8YFWKq3oJYRMzJ+9SJ+9Qqi5iz8M6+5s1kr9xuwJK8b2CM9pmTeZkB3Dn+yVWg3fN8B1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EH67A4FZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EH67A4FZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LllnA2314896;
	Tue, 7 Apr 2026 08:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kHtq13
	/UucncQdNoTmKzNz2FEhnpqDEFES/BaWBsT6c=; b=EH67A4FZYt/JAPyAozxRFN
	+Uo+HETvvttpwgqnJbilyWOjw+bFCs9byAyi/p/jB6x9PaWqg2wsbxN1R/+hopd/
	lQewB3gm+hzGD/2YqUN9TZBuJYSBCnLkxDvEV5YXSnHUMSeR6H/HvXg/wLVDcekx
	tAFunviKSF+W1582VB7PCF+x/GC3ob1AzaIAphacynOVcLxDFafVXTrOLZ0zEoDX
	ZhZEC+agabQvSW6AjDcFbXPKQsvi4WvzWfl4z+ncFrTCEIKN2PUfNX6k+r28ssTW
	C98p+XXaKtIto4IkdRFEvP3eTK3n1JyUJOHb9DZFZ0qNAgwlMI0VPYmY6WMDO7KA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ft1xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 08:52:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6373K6Ij007881;
	Tue, 7 Apr 2026 08:52:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg29qsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 08:52:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6378qWia28771070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 08:52:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20DD65805D;
	Tue,  7 Apr 2026 08:52:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 197D858059;
	Tue,  7 Apr 2026 08:52:29 +0000 (GMT)
Received: from [9.111.71.68] (unknown [9.111.71.68])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 08:52:28 +0000 (GMT)
Message-ID: <e1af5f750eef67d4a3bcb76033fe05adae1acf82.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] PCI: s390: Expose the UID as an arch specific
 PCI slot attribute
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Farhan Ali <alifm@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet
	 <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>,
        Shuah Khan
	 <skhan@linuxfoundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven
 Schnelle	 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org
In-Reply-To: <bde50f9a-bbe1-43ba-b2f4-24951dd0cccf@linux.ibm.com>
References: <20260402-uid_slot-v6-0-d5ea0a14ddb9@linux.ibm.com>
	 <20260402-uid_slot-v6-2-d5ea0a14ddb9@linux.ibm.com>
	 <bde50f9a-bbe1-43ba-b2f4-24951dd0cccf@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Apr 2026 10:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d4c5d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=79MQ7SVBH1W6g1D19XUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YWhYcsHDIoruVcwSjgjyA9rRaTBiVNAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4MCBTYWx0ZWRfX4Z9Dti3nfm8S
 T/oyGiTV5vId9MCJx2wAEdgl6x+Ma8w2mUlDRZqTB27q/DjrQpfnPEc2YR8Gb2V1F5rHt3+tkZj
 xLYmyya/sbP00k0Pebe/+pw8HST71ZTW2FjUBhBctWmJxj/ZPvc2inFclw/E2Tj1+mM3ZX9cdJK
 B7sUeqtbF+aCH4h4lT0gixlYsx9vmV/NxADizRY1pCvX2p5kYhNtze/sFvZv+5Q+j71zxFcbjAa
 EmRcFKGlIKBfmrOrdTcrNKIHqx0H65rfxJzyccIF/+rvgpkomuFJO2rOQmBxkp6UWDl4lgfzVAm
 Y9nJbgIp4cCczG9sPIpxCgvC3i5O86OL4cgTAp8lJhqhMb7bclurY6K/e7eaPSCEGOZF9/aU4RZ
 5wNi7lBwq88V6V32EzKktlhc4AYchIoQ+g/CHMEq9m8sTaT8SZGjGCph/KJStsxNcQ1EE83BdKO
 DSAHn4IDt0XSH25OMPA==
X-Proofpoint-GUID: 5-emW2eizs0oWucx_eksl-VUEaDdlSjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070080

On Fri, 2026-04-03 at 10:19 -0700, Farhan Ali wrote:
> On 4/2/2026 1:34 PM, Niklas Schnelle wrote:
> > On s390, an individual PCI function can generally be identified by two
> > identifiers, the FID and the UID. Which identifier is used depends on
> > the scope and the platform configuration.
> >=20
> > The first identifier, the FID, is always available and identifies a PCI
> > device uniquely within a machine. The FID may be virtualized by
> > hypervisors, but on the LPAR level, the machine scope makes it
> > impossible to create the same configuration based on FIDs on two
> > different LPARs of the same machine, and difficult to reuse across
> > machines.
> >=20
> > Such matching LPAR configurations are useful, though, allowing
> > standardized setups and booting a Linux installation on different LPARs=
.
> > To this end the UID, or user-defined identifier, was introduced. While
> > it is only guaranteed to be unique within an LPAR and only if indicated
> > by firmware, it allows users to replicate PCI device setups.
> >=20
> > On s390, which uses a machine hypervisor, a per PCI function hotplug
> > model is used. The shortcoming with the UID then is, that it is not
> > visible to the user without first attaching the PCI function and
> > accessing the "uid" device attribute. The FID, on the other hand, is
> > used as the slot name and is thus known even with the PCI function in
> > standby.
> >=20
> > Remedy this shortcoming by providing the UID as an attribute on the slo=
t
> > allowing the user to identify a PCI function based on the UID without
> > having to first attach it. Do this via a macro mechanism analogous to
> > what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
> > pdev->dev.groups") for the PCI device attributes.
> >=20
> > Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> > Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   Documentation/arch/s390/pci.rst |  7 +++++++
> >   arch/s390/include/asm/pci.h     |  4 ++++
> >   arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
> >   drivers/pci/slot.c              | 13 ++++++++++++-
> >   4 files changed, 43 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/=
pci.rst
> > index 31c24ed5506f1fc07f89821f67a814118514f441..4c0f35c8a5588eee3cf0d59=
6e0057f24b3ed079c 100644
> > --- a/Documentation/arch/s390/pci.rst
> > +++ b/Documentation/arch/s390/pci.rst
> > @@ -57,6 +57,13 @@ Entries specific to zPCI functions and entries that =
hold zPCI information.
> >  =20
> >     - /sys/bus/pci/slots/XXXXXXXX/power
> >  =20
> > +  In addition to using the FID as the name of the slot the slot direct=
ory
> > +  also contains the following s390 specific slot attributes.
> > +
> > +  - uid:
> > +    The User-defined identifier (UID) of the function which may be con=
figured
> > +    by this slot. See also the corresponding attribute of the device.
> > +
> >     A physical function that currently supports a virtual function cann=
ot be
> >     powered off until all virtual functions are removed with:
> >     echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
> > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > index c0ff19dab5807c7e1aabb48a0e9436aac45ec97d..5dcf35f0f325f5f44b28109=
a1c8d9aef18401035 100644
> > --- a/arch/s390/include/asm/pci.h
> > +++ b/arch/s390/include/asm/pci.h
> > @@ -208,6 +208,10 @@ extern const struct attribute_group zpci_ident_att=
r_group;
> >   			    &pfip_attr_group,		 \
> >   			    &zpci_ident_attr_group,
> >  =20
> > +extern const struct attribute_group zpci_slot_attr_group;
> > +
> > +#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
> > +
> >   extern unsigned int s390_pci_force_floating __initdata;
> >   extern unsigned int s390_pci_no_rid;
> >  =20
> > diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> > index c2444a23e26c4218832bb91930b5f0ffd498d28f..d98d97df792adb3c7e415a8=
d374cc2f3a65fbb52 100644
> > --- a/arch/s390/pci/pci_sysfs.c
> > +++ b/arch/s390/pci/pci_sysfs.c
> > @@ -187,6 +187,17 @@ static ssize_t index_show(struct device *dev,
> >   }
> >   static DEVICE_ATTR_RO(index);
> >  =20
> > +static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
> > +{
> > +	struct zpci_dev *zdev =3D container_of(slot->hotplug, struct zpci_dev=
,
> > +					     hotplug_slot);
> > +
> > +	return sysfs_emit(buf, "0x%x\n", zdev->uid);
> > +}
>=20
> I think the way we assign the same pci slot to multifunctions (PF and VF=
=20
> on the same LPAR), IIUC we could possibly display the wrong uid here. I=
=20
> am hoping my patch [1] can fix this. I am curious, is there any=20
> s390-tool that would use the uid? Though this would only impact the NETD=
=20
> devices on newer machines, so I don't know if we want to gate this=20
> behind my patch?
>=20
> [1] https://lore.kernel.org/all/20260330174011.1161-2-alifm@linux.ibm.com=
/
>=20
> Thanks
>=20
> Farhan
>=20
>=20

In my testing the UIDs for NETD VFs were correct. This is because there
is a bit of an asymmetry in the wrong slot assignment. Without your
patch pdev->slot gets set to the wrong slot but the correct slot and
hotplug slot still exist and are reachable via the sysfs kobjects or
zdev->hotplug_slot. This is also why we do have the correct
/sys/bus/pci/slots/<FID>/ directory and why the issue of wrong slot
assignment only came up via the reset mechanism not e.g. when trying to
deconfigure a PCI function.

As for tools using this attribute there is work ongoing to add PCI
support to lszdev/chzdev and these would utilize the UID in the slot
directory for listing the PCI functions as well as by generating udev
rules based on the UID. See also Ramesh's patch for adding the missing
uevent file in /sys/bus/pci/slots/*/ for cold plug[0].

Thanks,
Niklas

[0]
https://lore.kernel.org/lkml/20260401163152.632779-1-ramesh@linux.ibm.com/
