Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222040;
	b=AVbOl57HnUKzPzR1e3SRhz3xZxPoye/H4+n1OVJKWKts74vKGGGLz8SiWtFw9i70RhsG
	 xdnXdgUQSR1vKIEh4j+i7JV1ZBiApyvgqMD489UibF9wQGFPHlYXdTel3uO0W0Iz1K9oH
	 yssJp90etiXEsqJn2UErE9Jnwvcz8AULD3gN/XI193gm5PIqq78IoUY7aiPJ02X1oS8qT
	 XD6BTV0iQMiyEnB8mizQZu2RGKVPpaITq6iWmRjBeWsFRErrr/k2wOGWGyjl9ivgSo861
	 73pVrTGnpd6aWFRBimnNwGsI0Ot1agHJ5RG8DWsjsGOeEm51b1dFzuWH3hdlSoh5KEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222040;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NVAtJGVJSXzp0BrnLtPFJyAyAoiFJ9Rvt6l34PEri54=;
	b=LUv/uyQZHx36WY0iDRlu5FmtZp2pWby6jlodSc1pmTvHxwSsMGtIOe7nFKM9aOWtoV3t
	 VHyLJ7Oa2/WfaDkVgQy8tBmx8O/x+fkW6kKZ0K9gTV2+IA/ovgbV6EpmgCXpybcRM6DhP
	 VL4AoiL2wQ1Mx2QgBcb3ooDyubCw9sapBcDf0NWf7NtNH+rD0sX85pm7yAz6U7bAKw0/G
	 IDBcrA2aTAYE2bnx2w5ejD5fmq0aupSYGJc2gkZzi1OCykohlELbQlfTK2aYyYN8UX4e5
	 ecxBTV+MWY+aiRhICbJl33akI14s6/j5fMJmDbSQ58k7RTn1k+W4zQlB7iqrZuiIa6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R2gFmzQN;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710DB606A31A;
	Wed, 28 Oct 2026 21:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R2gFmzQN
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SJZ5Rg2127453;
	Wed, 28 Oct 2026 21:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NVAtJG
	VJSXzp0BrnLtPFJyAyAoiFJ9Rvt6l34PEri54=; b=R2gFmzQN4uPhVcAoRlIrJB
	0D/M4tkrEr7QtqZ/q7ajmcU4VXBdCQ3r9lrEq4jfi0EcHIyiTiK9Y+DzosSSQeUo
	RuvhpGK6LKk77SFcA9N1pRDT+AQFxrbiso99t5ihLh8xTCL1S1a3Q9cJu8b7J1PZ
	MlgYrhIEwJy0gKQgMJb9i1C6cow43vEwqZ7Nb0aXzcTzP6Q7I6IQyGOQaAaACmqr
	Skm1Cwmd5rBXuuK95b8RVyuKCQuxlZfhAMG7ejeElfnMmrVkRdQtmxwyMfiI+AGg
	B9lg0C92JXOzzjcg4Ywnd29woHs6+TLk/N+0ggqtxtc2oPKUJzFQtYkGiTDzKBqw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd770v3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 21:13:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIZ7mR2008397;
	Wed, 28 Oct 2026 21:13:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh952b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 21:13:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SLDvGs33751802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 21:13:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02AC85805C;
	Wed, 28 Oct 2026 21:13:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850E45805A;
	Wed, 28 Oct 2026 21:13:54 +0000 (GMT)
Received: from [9.111.18.3] (unknown [9.111.18.3])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 21:13:54 +0000 (GMT)
Message-ID: <1cd8eed2c5268a02df5f8600ae469d023761754c.camel@linux.ibm.com>
Subject: Re: [PATCH v11 3/5] s390/pci: Reuse FMB buffer across enable and
 disable cycles
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Gerd Bayer	 <gbayer@linux.ibm.com>
In-Reply-To: <72ddf1a4-d672-4d9f-a205-07aec3db1248@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
	 <20261028154352.15108-4-oelghoul@linux.ibm.com>
	 <sashiko-outbox-188110@kernel.org>
	 <72ddf1a4-d672-4d9f-a205-07aec3db1248@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:12:52 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae26597 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WtBk71qh1JqlTf72BxUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfXz0Uitfw6xKF6
 0JEZgeQ8kwekCNK9OF2qOq+z8Agf9LX5jMni3viv5lYLPsPUnUpbPTlNMyGMuUebSo2teQ+yxnx
 y4vYpIuu0VglWwt0DyQiqzpaC28dBw2NGrXHGWr7gxX6HjNA3EmWtZA2a4bfpQEwacwrDvlCGRW
 mROix0u1mWUX5k0PU5hY3DJv18GUEgK1KRA4Dwej3ybmd6tNSy9HNGp5gRePD0WDBOc6iN9yF3b
 kX1tw2j/PRZaZFB77ohPZT9azZzrI6qD6w3eNtAvZsFOG+3vg+kKmj16ekDl/ghACbXBnh366fE
 6YHNjVICn2fXKtJWZBi5ZetxU7E+r98KMnHS8+aBpUC9eqK5jScH4f0nOihQRsQjvvlzJDDJ5Fv
 +HVzVH+satPW6TvBpQvapyk8wXrC0lRtFba4YOAY8TJXJsNZslkKFP8LDlqJlJdnTExE3kkBhRI
 pBiq1ABYPEDC/65dKxQ==
X-Proofpoint-GUID: 9Of9Qt5JN501oWTbgT1xZxQHQDWBqxv1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX2Q97Wt6IIeoJ
 j482gRdvHV/2RW/dxjfl+k1+F0r6R3eYykb98H+95QHuWNikMKchCkoGrapo5x5DRByGURi7r4j
 X3XP8ctYnxxsCIFNzgKbrJWADNWB0J4=
X-Proofpoint-ORIG-GUID: 9Of9Qt5JN501oWTbgT1xZxQHQDWBqxv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082

On Wed, 2026-10-28 at 12:15 -0400, Omar Elghoul wrote:
> On 10/28/26 11:59 AM, sashiko-bot@kernel.org wrote:
> [...]
> >=20
> > [Severity: Medium]
> > Can keeping zdev->fmb non-NULL when zpci_mod_fc() fails in zpci_fmb_ena=
ble()
> > leave the FMB enablement state inconsistent?
>=20
> Valid concern, but unfortunately I think this is a tradeoff we are going
> to have to accept. Based on this discussion [1] under a previous version
> of the series, we can accept these stale reads because as Niklas said,
> the firmware-written sample includes a timestamp of the last write. So
> we're already transparent about giving the user stale data, and in the
> unlikely event that this happens, the user will be able to recover by
> disabling and re-enabling statistics via debugfs or simply re-enabling
> it directly via vfio.
>=20
> Thanks
>=20
> [1]=20
> https://lore.kernel.org/all/a24337bd66864dd70ae61e28d86590052ac0fc5d.came=
l@linux.ibm.com/
> >=20

I think the problem is a slightly different one. With patch 2
statistics_on tracks if the statistics should be on and zdev->fmb !=3D
NULL tracks if they are on. With this patch zdev->fmb loses that
meaning. So when the zpci_mod_fc() in zpci_fmb_enable() in
pcibios_enable_device() fails the removal of the "if (cc)" block now
means that we still do the zpci_fmb_disable() in
pcibios_disable_device() but that is a sequencing error.

So, as we want to keep the FMB associated to prevent the platform from
overwriting an already kmem_cache freed different FMB and thus can't
have zdev->fmb NULL at any point after having it enabled we need to
track the actual enablement state separately. I'd add another bool to
zdev for this maybe "fmb_enabled".

Thanks,
Niklas
