Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32333B47DF;
	Wed, 10 Jun 2026 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082521; cv=none; b=AWxReebkEzdy4shkJ6ysyeg+lP9WT9eAukmHTXBRhQJLqQpB907v73TFhj2Jc6ezXkbc8TBBzCh46kXESDmUwXwMi1KiIPOXo/IthcjAGNfw+d2zFaJl4llr47Ed55B7L7rk5zaStpg4P5kJcmF5iFUAuLTVyuKlcBHvJuvou/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082521; c=relaxed/simple;
	bh=P05h9S2io+6GoPNL5Pg2E9us+S6gnh8wuqJI7jj14V4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nTAki7plwt6qxCxZHju28J/fhULqGS0J0LENcr2wf7qQr3PzpPk1XsJDwCzfrjMSllsUVOcQKLG/YrrbuA968KA6w8gSC9Mz9GewEgPL/ARHtAJ6Yht5Xu/G8FpqR9nVCSKi/djzQtsIB2hVPzRVLTNs0khjPIn4KaPgCPkbbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GrB6J+RN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GrB6J+RN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A4qc9m4021298;
	Wed, 10 Jun 2026 09:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=prvyXa
	DfP1DUZjWEW7FWjDUGrtYC67weEy+CvS8GTvo=; b=GrB6J+RNxI3MbYv4WcZTnP
	JPe/EX8OqdbEg1GfDDwxb1PtxOpgGCNAEY7tlx3aBk8Oa9LO8ae6uNT/aBYFk2wm
	UAUIU2lSgWYSKTdBag6vEeDB/iChCIM3HE1n7+oa3SMhgpAvPNzGEB/ot0sdCHXr
	7Fl9cnLn+oyPTh3v/4XxeNqyRDmXUlQkRCU24e5hfRyEvevHdPsGnoVhFBuTPtEZ
	JLCgX8SD5Cig/OI/A9ftcjW18U8+oUg4JeRiSo8veDiFjywdgik3QMFzu8OK5P95
	O0qYbwwhEF/IF7xDV3mStUJQ2zKfs1Vn3FkUuc8eB7TMHw2BM7w0DQXs45jo5H6g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye80ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A94bcn011073;
	Wed, 10 Jun 2026 09:08:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjwxua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A98ZYk33686036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:08:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077125805D;
	Wed, 10 Jun 2026 09:08:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2243758052;
	Wed, 10 Jun 2026 09:08:33 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 09:08:32 +0000 (GMT)
Message-ID: <986385851fb30f53b8899d61bfeae81979d36d58.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] s390/pci: Fence FMB enable/disable via sysfs
 for passthrough devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, Alex Williamson
 <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com
In-Reply-To: <7a230cd2-757e-449b-bb66-4daac5df6185@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
		 <20260608171850.62829-5-oelghoul@linux.ibm.com>
		 <20260609165208.6aba1731@shazbot.org>
		 <7a230cd2-757e-449b-bb66-4daac5df6185@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 11:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX4kW2E/l238cI
 ohby+/K5yKAPy5g9gJhNgkcZ3/Ti/IgzSyfM7hc8vVMSB6BVhTzy4GIqd2dfMKtiq0/kdQJVodv
 alfvnsxdPUFgZ3001vnUcUwjL/3J3ppWz91fochOu/VBlwS6FWPkus+8FWOJm7JMJhz25gMGMJ4
 MFnuKJr9P5AyNagZtp33Lhsp1qPoGQj/L3nAu6CFFQ0XM4K1LenSjbOjH9tBuESiaTkiiOL84Kk
 IIt3Ya6kTcn5X8AG7s8w2dZ9WQAQ6JLm5tTcjJZX32E0ztaiJz5EEhEboDsFfcSYH3GMuhUAryx
 kNvVVmfmifi3FndU2C6qMYNpAN3oN5Vk0ZZzvE3znJxx20h6Hmy1EgFdR8tWIVGdvGJQru0O8B7
 /zwo4a+xSvOIQeN5S6mFA2GZoTGWAmG9C6EOFOakVmWoaH5UClLwp+0gxNgEv0AZ5GIxzW7wj2F
 /hRGM+4pbgNUUpLtV8A==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a292994 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=9wuqEY2A3Bjt7H9dH7oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PH89q0KC66-ZzqW6C2n6JDQU-F80MGCU
X-Proofpoint-ORIG-GUID: PH89q0KC66-ZzqW6C2n6JDQU-F80MGCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086

On Tue, 2026-06-09 at 20:32 -0400, Omar Elghoul wrote:
> On 6/9/26 6:52 PM, Alex Williamson wrote:
> > On Mon,  8 Jun 2026 13:18:50 -0400
> > Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> >=20
> > > Introduce a fence over enabling or disabling FMB via sysfs when the z=
PCI
> > > device is associated with a KVM. This will allow a KVM guest to use F=
MB
> > > passthrough and avoid the edge-case where the host disables FMB while=
 the
> > > guest is still using it, which may cause partial counter resets and
> > > inconsistent reads which have no parallel in the architecture.
> > >=20
> > > With this patch, the userspace driver, likely QEMU, is still able to =
enable
> > > or disable the FMB using the VFIO device feature introduced in the pr=
evious
> > > patch, effectively securing what is associated with the VM state and
> > > isolating it from other processes on the host.
> > >=20
> > > For VFIO devices that are not associated with a KVM (i.e., for usersp=
ace
> > > drivers other than QEMU), this fence does not take effect.
> > >=20
> > > Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >   arch/s390/pci/pci_debug.c | 11 ++++++++++-
> > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> > > index c7ed7bf254b5..a2dc79418c21 100644
> > > --- a/arch/s390/pci/pci_debug.c
> > > +++ b/arch/s390/pci/pci_debug.c
> > > @@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *f=
ile, const char __user *ubuf,
> > >   	if (!zdev)
> > >   		return 0;
> > >  =20
> > > +	mutex_lock(&zdev->kzdev_lock);
> > > +	if (zdev->kzdev) {
> > > +		rc =3D -EPERM;
> > > +		goto out_unlock_kzdev;
> > > +	}
> > > +
> > >   	rc =3D kstrtoul_from_user(ubuf, count, 10, &val);
> > >   	if (rc)
> > > -		return rc;
> > > +		goto out_unlock_kzdev;
> > >  =20
> > >   	mutex_lock(&zdev->fmb_lock);
> > >   	switch (val) {
> > > @@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *fi=
le, const char __user *ubuf,
> > >   		break;
> > >   	}
> > >   	mutex_unlock(&zdev->fmb_lock);
> > > +
> > > +out_unlock_kzdev:
> > > +	mutex_unlock(&zdev->kzdev_lock);
> > >   	return rc ? rc : count;
> > >   }
> > >  =20
> >=20
> > Why not also use a guard for the mutex here and avoid the goto
> > unlock... also moving the guard below the kstrtoul_from_user()?
> >=20
> > The fmb_lock could switch to a guard too, but that's existing.
>=20
>  From where I'm standing I don't think there is any particular reason to
> do it one way vs the other. Thanks.

I do prefer the guard(mutex) because it does remove the need for a goto
exit in many places including the above. That said it should also take
the surrounding code into account and definitely needs to be applied to
the whole function. In this case pci_perf_seq_write() uses both the
kzdev and fmb_lock so to use guard you'd have to convert both. That
then feels out of scope for this patch so I'd prefer you stick with
plain mutex here but use guard in cases where the whole function ends
up using guards. So for patch 2 you can also go with guard, it's not a
must for me though.

Thanks,
Niklas
>=20
