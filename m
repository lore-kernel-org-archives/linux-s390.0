Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332674;
	b=APrMFM/UTUycnsdKsQSsqQVYUCBcyvypWCLARfjY8wxvSLKsdVEEVn/QrHcZ2/cXmgtK
	 MTRZ2Hia1qXFzXOfuGlxTjizoAzHl2eB+yqNi1941Iek+ENbeALI7J5arsj1jtgbq52ou
	 yCDXm6zLkQfqrGXuOPBbWWGb6xZUj/QinjGQq4NlDsq9amVqSifWXgx+tIDuJMfxfaYYz
	 VfON6n4nUWhWPgRIAfyv6V5IfPW/bynLsu/vmQL/B+8Lq0doVAAGisre3x4ygqzs+4XRx
	 dDI1XptJ2pihAAY/BkzO8iBmdFomeBOlluNrGGf5+0CyZujB7mWscr7BqZeWYX3bNIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Fyyz7c59PV7l+/ZX4XV1frRnphFmDjm6zPpwVJtE+g8=;
	b=1tiDkBytcJ6Yqr12CwxjMD01UnGyoBIIJrI9/xdbxvucN8W0XTwupMNBY4h6eToI9cOA
	 xUaRuJJObkhVB0i6WmkK3xg7MQqjeiOnUH8Mnpr0ZfsBP+h5QfBnx05JoYxTRBAWLTJq1
	 aJyByMWzOr05e0LZZSu3ns/E7D7VXlb+Xx2BJ1kShm6r52GaL3u+JpVYYS38egOROpLB2
	 SvT6AiEI/zcKnyE/VZ3zWxx4uPeRxLnGArIeUrnuzSd1Y/FM7wKXMbFlIDM9uRaZvvLN3
	 x/zNAkmBhUmp2JLWN9VbpiT6YVpayqXiY2ObJ6HdSi5GH9zCqnsphxrnqOke0A9bwmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ltQItx1D;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F6606A33F
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B6F6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ltQItx1D
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFEAgi1023613
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fyyz7c
	59PV7l+/ZX4XV1frRnphFmDjm6zPpwVJtE+g8=; b=ltQItx1DBQIjiJeClDlOlS
	blNfFe4OKkWsgBcDOVQtja7VRhGK2L05j4ZQw+Yw+6Tvp3v4s5WwDPtmjbyjJ0ur
	pRLaxc1rCDpMJIMF/IAYvZ9flsAymstKPLiFP0MkiPVH1+pubaQL8uKEWmpvpNGO
	h+XzUYnAClIig9v0GpOxWTCWj6Y1vbs/6f2tKjse3PcBSHdO7Ol4B5JO+kPTa5+b
	ofrrdDkrkh74NCBV6A0UO9yadqH4+1ceCL+3PDkwLMvw9l7SHsesPMOZWObog8YV
	p+I1t9cGwH+BCLQhV5vfeQjNiCuN+aVH2M1ajn3Qi6aiTF6uWBNN8VG3ujby56tA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt6cbv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF519J1980026
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nsrt6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 17:44:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAHiRiu19399240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 17:44:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0488D20043;
	Tue, 10 Nov 2026 17:44:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C733D20040;
	Tue, 10 Nov 2026 17:44:26 +0000 (GMT)
Received: from [9.68.31.53] (unknown [9.68.31.53])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 17:44:26 +0000 (GMT)
Message-ID: <4c848e93-7ca8-4498-bc1e-67d30117dfe4@linux.ibm.com>
Date: Tue, 10 Nov 2026 18:44:26 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Introduce dibs peer bus driver, dibs console and dibs
 block device driver
To: Julian Ruess <julianr@linux.ibm.com>, schnelle@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
References: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX2PPo+eDreU+W
 36OkigQ0qNN6cEfAD3DL8sCXa+8umNxbJPTnuByNdpJwDrUqFs9fZpgFqpJ7EaIdRHH+Rd8r8uP
 dLkTwsuMuoePQIGNtrlXMHkceWh4tJhxNvg/YW0+j20mOGiOrhz8S3baaiMtAcTjzWv9bhMpJB7
 Hj/YGZ9RDn8R4HMTBIVCcEbN8Jv7OIeLfHGg2v6XxbMVW88buxhsv4MMT2qZxi3Lq1B/TxOc239
 ux91D9ugOBSNNbheAgfShk9iyP9zW2+CbSRkHIL2UhvH1vHvTjR9FTGsQ0EuzRBcZtYArpKaG5R
 2lMGy5K6oLPoR5WixUwi5K09gqqa7nqA2AdaX7PyQfJ+4cIskVnnWZMNIPJ2YlVoWt7xxANsU9y
 DLIcxPL9XtcCr71VR1kcv8whJnTXnxXZ2trMdR3R0m2C3VnFBJzsDV+rQ/D2RKBVR6+vrF+ipxT
 3bZOZK2lqsqy1eGAFIg==
X-Proofpoint-ORIG-GUID: UEcXmqZ9X3rqpZWHcLZ6e4on2y9s_E5j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MCBTYWx0ZWRfX77kAhqbpzsul
 O8C5sD7grpnfEFqiFVUpmma0cN44wPWN3JIpF2wlDj1aL5j//N2IlFHN0E35DoMbuKouGtoeWaU
 geSmKtArdxdunhZRkG/7SIN+T6P4mbo=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af35800 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6Jk19v7ZAwXfwLV5VQsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UEcXmqZ9X3rqpZWHcLZ6e4on2y9s_E5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100070



On 08.10.26 10:08, Julian Ruess wrote:
> Hi all,
> 
> this series is based on net-next.
> 
> It introduces the concept of dibs peer devices as devices on a virtual
> bus, called the dibs peer bus, implemented on top of the dibs
> communication layer. These devices are based on the concept that one
> peer on a dibs abstracted fabric can present virtual devices for
> consumption by other peers on the same fabric. 

Maybe spend a sentence on dibs bus here:
Sth like:
This series provides the bus driver for dibs peer bus.


In this series two such
> device drivers, a console/tty driver and a block device driver are
> included. While the console/tty allows two peers to establish a virtual
> TTY between them 

Just wording:
Is TTY an symmetric connection between 2 peers, or is it more like
the device server provides a virtual terminal on a dibs bus and the
tty device driver is used to access it?


the block device driver allows read-only access to
> block data, such as the contents of an image file.
> 

Same here, maybe you want to mention a device server providing a virtual
block device on the dibs bus.



vvv maybe move this paragraph up?
1st paragraph: concept
2nd paragraph console server
then describe the patches provided in this series

Missing: 1/4
maybe: general enhancement to dibs layer, prereq for bus driver and
device drivers.

> This is a prerequisite for an in-development, open-source user space
> driver stack (console server) that uses the s390 ISM (Internal Shared
> Memory) device to implement 

add sth like "dibs peer bus implementation on top of remote ism device
... implement virtual devices attached to dibs peer bus in user space"

and announce dibs peer devices to multiple
> remote target systems. These peer devices are currently of type console
> and block device. In addition to the console device which enables
> console access, the block device support enables a target system to
> access resources such as ISO images provided by the console server. Both
> the console and block device functionality operate without requiring any
> network connectivity. The console server is planned to be part of
> s390-tools.
> 

Is there a design document?
Can you post an RFC of the console server?

> Thank you,
> Julian and Tobias
> 
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
> Julian Ruess (3):
>       dibs: introduce dibs peer device bus driver
>       dibs: introduce dibs console peer device driver
>       dibs: introduce dibs block device peer device driver
> 
> Tobias Schumacher (1):
>       dibs: introduce ring-buffer send/receive API
> 
>  arch/s390/configs/debug_defconfig |    3 +
>  arch/s390/configs/defconfig       |    3 +
>  drivers/dibs/Kconfig              |   32 +
>  drivers/dibs/Makefile             |    5 +-
>  drivers/dibs/dibs_blk.c           |  798 ++++++++++++++++++++++++
>  drivers/dibs/dibs_console.c       |  388 ++++++++++++
>  drivers/dibs/dibs_main.c          |  500 ++++++++++++++-
>  drivers/dibs/dibs_peer_bus_drv.c  | 1220 +++++++++++++++++++++++++++++++++++++
>  include/linux/dibs.h              |  177 +++++-
>  9 files changed, 3122 insertions(+), 4 deletions(-)
> ---
> base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
> change-id: 20260330-console_server-fc7a9ced6481
> 
> Best regards,

