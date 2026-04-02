Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663402FCC0E;
	Thu,  2 Apr 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118949; cv=none; b=J64sEfaWnI2lul6iJsMeBfGougPgyW9uuREnvahRiQ13c0iZrvz+xUjkOQKzxQvAAahe62bNnQ4NiBTnYp+TkaGnp3EZ6xL+WK5YhxBq0yqmHOK4aFUkP4TuzL1LGg2d+jmV0GziFTycHtpokMjlAF6ySPMgx5OeI9jgfsC3nsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118949; c=relaxed/simple;
	bh=/awLHbPEpUXNrMVYhKd+gMOPv2ry5mu+hhxnC4Kf/20=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fiEer3bCJLmvAzvLmbiNY+N/OQp38NvuD3COKzp50Y72vu2abqT5ZJanu5CPAXvuuMMRRBNvScbCvrGttspFLncouU7GPeMKfwNcYj04fOF69kvkyuVab4dwqTN5XB717kf6Y9ERnAJ2Cwfifp2EWXzlK374k/5XSCqZW9ASRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GbynBxMJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GbynBxMJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631K4tNm3226233;
	Thu, 2 Apr 2026 08:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e3mxvg
	AKGvFgOPgmx+Z/xBCF7m/+nDr+S/v/fNU5h7E=; b=GbynBxMJ2iFfj5w6Tayc/a
	SWU+Xyco4WUnMZlk2rv0MOH9rZymHk9gDeg7roojiPvxEK5iKc+qWwFbmK4PE/KY
	3rYta/+FrFZVbFc/JmOschF6wpEnOl4t9mPG1lLUYh5uDNpKKxT5bTlHOt+E8vc9
	IdahkIwvYKHOC4e4PATYph4bVGndw6r3Rx97DkwdSIVrMGlWwUB3QOE1xheYX52G
	v7lQeoUZBSzYBYvmLxZF4W0pNW/liBcEl2p7Zew1dUgi3lkAZRgsn6clx+O/vCFt
	YoqiawCwZvG17/pXNVBfzywlkZceiQgCG7ENgRNjTCx0Aqb1oXgwDNZqdrPQ9P1A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnuxrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:35:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6327BStw030952;
	Thu, 2 Apr 2026 08:35:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk14hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:35:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6328ZIib25166464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 08:35:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D00458055;
	Thu,  2 Apr 2026 08:35:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 412D158043;
	Thu,  2 Apr 2026 08:35:15 +0000 (GMT)
Received: from [9.111.50.144] (unknown [9.111.50.144])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 08:35:15 +0000 (GMT)
Message-ID: <af52799f1d9cd3c98251c7589bf3538e7b46a030.camel@linux.ibm.com>
Subject: Re: [PATCH v5] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas
 <bhelgaas@google.com>,
        Jonathan Corbet	 <corbet@lwn.net>, Lukas Wunner
 <lukas@wunner.de>,
        Shuah Khan	 <skhan@linuxfoundation.org>
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
In-Reply-To: <21cec18e-6c1b-4981-9479-03fa0bcc0c70@infradead.org>
References: <20260401-uid_slot-v5-1-e73036c74bf6@linux.ibm.com>
	 <21cec18e-6c1b-4981-9479-03fa0bcc0c70@infradead.org>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Apr 2026 10:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qKQOG1_AIdpLFugT4elBqXQ5lkobK-Tw
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ce2a49 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gqYRxv6u2CFBZBrzyWYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3MyBTYWx0ZWRfX6A+bVjUMWbLY
 9kiiI8Argn8pENczk7MdNb4llzUw38HxikX5lUcrrzn2mgFS9TW/GWYdRxvkuFqusWFNnWCkt2p
 /30RVgAxDr7je/bV3wJlWJt5CJJJVymIB6DzxBoVAWP9M/GHkH2yapXsTbGeKdWCqkBWesTMVQ5
 LDwJ2+cb0t7YiKEQyCcWZgw+C2/ILjSGWFZaMFhAhcFzZBzVFQiuXLlAkHn7VQ6dsm8Qdp8c83e
 IZ3kCfImtueJG416lSrsA2IQgu6eDzCu/CF9oJDUJiD4Vy7mHOcfM/U6r1fAfqJ+jBA3uov91cZ
 seNk1akH+n2qe3utYY+p673BCieZD3fd8u+cYO+w3CAH9q0zMd+kFUq+mtyFQR6fBkP1L6SRWLC
 MKv1nK2KhP5ZYArL/naUHgSdL3UQdMI0NtmStp8LqD9ZpwopIV7SXEaqQQLz6SRhsr4uLzBq70u
 l2BTWdAlvwdCbLrC33g==
X-Proofpoint-ORIG-GUID: DqgwERM50x0EfLNOqGYTVVAGArCpwirj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020073

On Wed, 2026-04-01 at 13:20 -0700, Randy Dunlap wrote:
>=20
> On 4/1/26 7:50 AM, Niklas Schnelle wrote:
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
> > Note: I considered adding the UID as a generic slot index attribute
> > analogous to the PCI device index attribute (SMBIOS index / s390 UID)
> > but decided against it as this seems rather s390 specific.
> >=20
> > v4->v5:
> > - Rebase on v7.0-rc6
> > - Reworded note
> > - Add documentation for the new attribute
> > - Link to v4: https://lore.kernel.org/r/20251217-uid_slot-v4-1-559ceb59=
ba69@linux.ibm.com
> >=20
> > v3->v4:
> > - Rebase on v6.19-rc1
> > - Collect R-bs
> > - Link to v3: https://lore.kernel.org/r/20251015-uid_slot-v3-1-44389895=
c1bb@linux.ibm.com
> > ---
> >=20
> > ---
> >  Documentation/arch/s390/pci.rst |  7 +++++++
> >  arch/s390/include/asm/pci.h     |  4 ++++
> >  arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
> >  drivers/pci/slot.c              | 13 ++++++++++++-
> >  4 files changed, 43 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/=
pci.rst
> > index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..03afb57ece4df90a75597cb=
34c1f048c2e162b67 100644
> > --- a/Documentation/arch/s390/pci.rst
> > +++ b/Documentation/arch/s390/pci.rst
> > @@ -55,6 +55,13 @@ Entries specific to zPCI functions and entries that =
hold zPCI information.
> > =20
> >    - /sys/bus/pci/slots/XXXXXXXX/power
> > =20
> > +  In addition to using the FID as the name of the slot the slot direct=
ory
> > +  also contains the following s390 specific slot attributes
>=20
>                                  s390-specific
>=20
> Use a period (full stop, '.') at the end of the sentence above.

Done

>=20
> > +
> > +  - uid
> > +    The User-defined identifier (UID) of the function which may be con=
figured
> > +    by this slot. See also the corresponding attribute of the device.
>=20
> These 3 lines are run together in html output. Maybe add a ':' or '-' aft=
er
> uid?

Good point. Thank you. This is actually an issue in the whole file e.g.
below for the device attributes. So I think I'll add another patch to
fix it for the rest of the file. There is also some naming issues too
anyway like in the PCI attribute "uid" is called "user identifier"
which doesn't match our architecture wording and is highly confusing.

Thanks,
Niklas Schnelle
