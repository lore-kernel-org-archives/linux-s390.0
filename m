Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D765283C9D;
	Mon, 16 Mar 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664395; cv=none; b=izS5Z11JjIJVVV8Auy4ssSM6iPQEvOPFgqPOq6wPjmWdLukhrt3DQ93lnR8iS+Dca+7Mmdz0UPikFySOXvtAiVcWWZIDsnc0B6GoVo9cjugmBzFlpcZdPcuQJYMkPBVO2wIwK5G60tqSM51uThzXxeQirftP1e9mr5zxjtyVPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664395; c=relaxed/simple;
	bh=JrpOQyjAilcBkykDuGfyplv1BJ1uga3/yZdS/64qzmI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h5RdU7AmSfCErGdmeGEesR7qepZbgc5H0XSt1rECYkEMpseQeUIAFEObreMyLAy4Y/W+5tnYMPm6SOuh+sa9bnGBwUCFr5W5Znt7o5ArYB+nsQmKlM9HG1AXdHq+mb35E6HYHsOMM04nHBIgF0gjBhcIr1OnwrHnATj1T0vIxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jf1ZNm/z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jf1ZNm/z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GC2sgw3991856;
	Mon, 16 Mar 2026 12:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iACLx4
	Nm8I6fmxx5/fFJ//5pDwT/CB3x7MidVZlDOJE=; b=Jf1ZNm/zrwbnCFqk9359OK
	naDfC3f5FqWJxFZBzBUkh4wv+gJjBQxTEW1U5o24NFPUjzR/UZlKAcHA/1/b8409
	7A3+/g+rlbSEXckt7HG7yyn5XZ6/+IQDY27kGsNIylG1AMiHHpmO1TaTBt8axDOp
	bRP3HHlMFsFksRtuIO3ntuEnJyXomc/UGJZWLwtWvTIcb/b5XsCvc5Vo/6CrpSKe
	c6d19F41yxyVB35QnYKG6LR/odD6GY8+bP45bJD0w+iGlRI324rnMB7TsS10ulld
	j8Zcq1w9bOiYub3A83EGRbykP6IkBK97FvQeym1/IIYUU4/6qAjCo6LaugtRzAxw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybrysu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:33:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G9evht004563;
	Mon, 16 Mar 2026 12:33:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s4weq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:33:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GCX4NS17170750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 12:33:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C93320043;
	Mon, 16 Mar 2026 12:33:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 451E520040;
	Mon, 16 Mar 2026 12:33:04 +0000 (GMT)
Received: from localhost (unknown [9.52.203.172])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 12:33:04 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 13:33:04 +0100
Message-Id: <DH47JTI4L8PJ.2A4XCC5SRV0NW@linux.ibm.com>
Cc: <schnelle@linux.ibm.com>, <wintera@linux.ibm.com>, <ts@linux.ibm.com>,
        <oberpar@linux.ibm.com>, <gbayer@linux.ibm.com>,
        "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Yishai Hadas" <yishaih@nvidia.com>,
        "Shameer Kolothum"
 <skolothumtho@nvidia.com>,
        "Kevin Tian" <kevin.tian@intel.com>, <mjrosato@linux.ibm.com>,
        <alifm@linux.ibm.com>, <raspl@linux.ibm.com>, <hca@linux.ibm.com>,
        <agordeev@linux.ibm.com>, <gor@linux.ibm.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] vfio/pci: Introduce vfio_pci driver for ISM
 devices
From: "Julian Ruess" <julianr@linux.ibm.com>
To: "Alex Williamson" <alex@shazbot.org>,
        "Julian Ruess"
 <julianr@linux.ibm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
 <20260313094127.74aa0767@shazbot.org>
In-Reply-To: <20260313094127.74aa0767@shazbot.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b7f885 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=XT77oCoie9bqOVgFqwkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K5dECYn4QDvuS67C2cR4ghuTlZagqDxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfX05THRAST5MUz
 4vlSPI1lhJ3bPNnR0AH/BBQ4jYZNbFjNtGFjjlacDRilRTv0G12F9mgGn5Tvz9rMcZWurzOOjoC
 +Gjmg65sCnthobqLqT/0rsmOteFj7LrwuXEnNihijIktxsS8lSuRuV3Rpj0DtsUGDylGx8FDnym
 6m+yszxOWTw1XIlA+vt5Hf/jQ4PFXgeA7DZBDWjYOmGAFFfFuf9gF+v4CLK5ag4I+0mbSowxA7T
 VG9XwJgJMEvx9G/1ieYuhej5xpytS8YfJMkJYL99A517DwZSzRSuIPFzJIE5ZqOhDVhSgtsaiHD
 rlXVXNhSj9lSDwL9P/LmlDB2SF9yx7k5XBYvJ+u7W2cFTNR209FTZag7jS58peBX6uOg35aLYSb
 DcGbAA+8WdHQG8G7axwIdb4nmNSgfw4gS0sgAkYcBmUTusU528nuFGbTJtozm/hhxg/QpWvVFTQ
 AIOyeDBJ7KNsymLZ0CA==
X-Proofpoint-GUID: K5dECYn4QDvuS67C2cR4ghuTlZagqDxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160093

On Fri Mar 13, 2026 at 4:41 PM CET, Alex Williamson wrote:
> On Fri, 13 Mar 2026 15:40:27 +0100
> Julian Ruess <julianr@linux.ibm.com> wrote:
>
>> Hi all,
>>=20
>> This series adds a vfio_pci variant driver for the s390-specific
>> Internal Shared Memory (ISM) devices used for inter-VM communication
>> including SMC-D.
>>=20
>> This is a prerequisite for an in-development open-source user space
>> driver stack that will allow to use ISM devices to provide remote
>> console and block device functionality. This stack will be part of
>> s390-tools.
>>=20
>> This driver would also allow QEMU to mediate access to an ISM device,
>> enabling a form of PCI pass-through even for guests whose hardware
>> cannot directly execute PCI accesses, such as nested guests.
>>=20
>> On s390, kernel primitives such as ioread() and iowrite() are switched
>> over from function handle based PCI load/stores instructions to PCI
>> memory-I/O (MIO) loads/stores when these are available and not
>> explicitly disabled. Since these instructions cannot be used with ISM
>> devices, ensure that classic function handle-based PCI instructions are
>> used instead.
>>=20
>> The driver is still required even when MIO instructions are disabled, as
>> the ISM device relies on the PCI store=E2=80=91block (PCISTB) instructio=
n to
>> perform write operations.
>>=20
>> Thank you,
>> Julian
>>=20
>> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
>> ---
>> Changes in v4:
>> - Fix bug with < 8 byte reads. For code simplicity, only support 8 byte =
reads.
>
> Does the ISM device define sub-8-byte accesses as valid?  It looks like
> if pread() doesn't return the desired size QEMU will fill the return
> with -1.  Unless such accesses are classified as undefined by ISM,
> doesn't that suggest a potential data corruption issue to the guest
> driver?  Thanks,
>
> Alex

Hi Alex,

thanks for the quick feedback!

We are currently developing this extension for a non=E2=80=91QEMU vfio user=
 space
driver. Reads smaller than 8 bytes are theoretically valid, but they are no=
t
used by this driver nor the existing in-kernel driver at the moment. We cou=
ld
extend this in the future if needed.

vfio=E2=80=91pci based PCI pass-through of the ISM device is already possib=
le without
this extension. In that case, the ISM driver in the guest kernel accesses t=
he
BARs directly through hardware virtualization, without using the new access
routines provided by this variant driver.

Julian
