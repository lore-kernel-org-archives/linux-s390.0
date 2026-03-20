Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F863B6C0C;
	Fri, 20 Mar 2026 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011339; cv=none; b=ih0qfAiYlDuFVeuQMJ0yesV7chECZS3oecel6R96r+F2zKno1UIVoTBkBbfQoec21PcaSfR6GR2YTfGbMzvlNFJPfirb1eW3S63d2B/zhL4YUn8yscyargVA8dKk8a+8cjho+y76nZPa8+dssLxCK9CxCHziM/48t95GvcBFYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011339; c=relaxed/simple;
	bh=7Th35k7iu5aVH9vtxhiulbItp2z9B/f14DXEnPZVH3c=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=m1bCvpU4fZLN8d5wPMQKW+o/Ku92+mIHRUA+dCNCGLKml977Id8bhbhtXtiFScQHRK1OR2soWH6+p/zJp2iAakNSQ1vm1glMfm2PBVJE4S6nJ9ZKuGFCX+xmCCvFAdpG9fwY8fARmXItotgkhH5OpuRQw0wPcYglvZXXmLurPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qkMWbPHB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qkMWbPHB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K3GOuZ1476820;
	Fri, 20 Mar 2026 12:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8QhK6n
	nyf47ExF20mrvt9X432xhtfPjMQB8CteHCZ2E=; b=qkMWbPHBoZNK3y6TbCRmuE
	oitl1HVy9ykFmoEWFGy5Ysj3C8Zr0+abTzFDW5gLDJogBQSCYsJng9VqDtrNjAOF
	M3fIacAl1eiDomKhnAvGnykdp+3XPSmKkoKVp9AHTiEIAgxqVm8qYjBFxCN1GEDP
	DH9WMIZfj9MA1lyRxhp28Vn9YONmfwDx7bNHzHhwqePX9f6Bn5Nbs4DiZCBjhtf4
	W8bRbGLXNJ2mjkh8dQOpoXn18DTcLl09sGX4s/HZGlX8jAGxeHbNWpguPRiCJ9LL
	ofZcqfHan9SZlkcu2NdcKajZ5EpSBND23lSL1uMcMxWJ3O0NNBkg/IlpD9eglQlg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy653s2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:55:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K8hYYO032448;
	Fri, 20 Mar 2026 12:55:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7k715b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 12:55:30 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KCtTZK4588126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 12:55:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F37C58045;
	Fri, 20 Mar 2026 12:55:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465C558050;
	Fri, 20 Mar 2026 12:55:25 +0000 (GMT)
Received: from [9.111.12.113] (unknown [9.111.12.113])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 12:55:25 +0000 (GMT)
Message-ID: <18f44f67f096e0003d4083da20e2ace4c118c2f4.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
        ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex
 Williamson	 <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai
 Hadas	 <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian	 <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260319-vfio_pci_ism-v6-2-c6bab675bc0a@linux.ibm.com>
References: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
	 <20260319-vfio_pci_ism-v6-2-c6bab675bc0a@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k
 /ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc
 3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/
 2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVS
 XQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9a
 UlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1d
 w75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakY
 tK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19
 /N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZ
 dVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQ
 JXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/Fej
 CYJAFAmmAWs8FCQl6sYAACgkQr+Q/FejCYJAn2g//UKzlXOgizdk0wudLooRbGzDo23ktGSPK5Oj9
 9o5z6v4Jz5+qOHo5835683cqkMLM9//udA1ZcKV88LVwyfmoHChPW24cWBmOEy7RJOWCR4WeEINaO
 pZUGF5YOx7oKTkPs511ky2FR0Heg35754pgTuTMEpYzRXr5pNMPS8mHXcXSARFPDPaCF+uBJ9BafO
 L7XbpSwKRttePsWAlPHbSbloeDApBfHUhcF/pbuM9GNs+c/8V9NK+SwwqNK214t7jaSq9k+19/hfE
 jvU45nbiYQM4VqGCelxVFRWol93JnwPFp/JaMgxgV1VYFH9Ijtgh+qNVVBqO8bbTjioFKy1bHdprN
 9GyPLDxoaI/lBg+5CwKewzazUjFd0xaqZbTXSgNK4ev/IuNI3qZV8tpvZZWwIgZU1K0Bhplt8Sku+
 O9Yl2H54erq9zuzwXjqBJtoW0+MaKbe+1gZ/v2/AVE2VeQMugPUWDg+2bpJaApRkeA4xQ9XfeW6Bp
 It7xYrwwbVhQtWRC0sRh+QNlU9HI28wPSnLWn7HFBeWupaIrxSp4IEL3eHUn8xv4aA8lpdNsHXD/X
 vqOSUwy5jlTPTlemvwaC9mNHagNdVXng8C6+hxiDLhZ6xH2P4qNHTKmjW61NsdF6Y/HfWP+lmbi8/
 474UNCltDt/fP01ajqogfWZKFymoH0O0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQ
 GlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y
 3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAtIw//WmQW/Z+SLdfrlDH5J2bvixzFNnO
 TOvp8uM8vcNZsxZwPXem4AeCXHayCqipxpa0iXWufEIvdMxkBxWvvM//V+rTUgQnJe6nhDxfLGklx
 5Mb2H+K/ndS73ElCuA30MPYq7mHr8i3gEmi2ZFX1W47JecJ8hno/DQxhHRG7bd+GFsiKCbsjLWXNq
 s/VaAK9uyOTQx7m6/2nR8L+Mvl1BrRXwkj7Qp0qxfQSd4r+IVNBzNFOcrGagBqsyHrN7Is7IICktH
 9VFl/G8P+hfviHQLnlxw9ltzpM1Dy6N1+BM3kbqD59gX+L6wqiLJI42eh+SHCiy35FvD3AFlYx4jZ
 MWE6qIgFnbwcL1kvcA7nnwfr3ZizCYPm8e334xXxslXBoRGsvjXSbAeAyZo2dvJXffNHdcDdUbJSl
 CfOixNGGKiQvs00X9ekfq9WmmRFvmYHu/m3lg1OXnMjFFIO41O51ZdhbEYJiqZEki7jA8Hd9xuWwQ
 nFDHhacU3xxivZ4BKQGQc+4XZ3yp/q6+7ux9prepRy/LeRyoaAmE67oxEsAgj+qyA3Tfy5nRTDdRQ
 E//gpaIt9H1VEx+68dRWHroxBQeozpnFPi25AlX3k4/EtVZjcItPWgE9iru1qT4DH3BBrz7Kd1zUw
 NnQC77zDJyZD2WUj1E+5bftO0aeE+7HZXj3tM/ea0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNj
 aG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSds
 ACy0nUgMKX3Ldyv5D8V6MJgkAUCaYBa6wUJCXqxgAAKCRCv5D8V6MJgkF/TEACOY2kL4NGFIbWeM5
 TUhatxqe8c3RT6jvNjq32CkvaK/cSZzBkS0smddyOzxt2WnsvMgkr9cM7P+CevoMwhT3e0lgQbqBD
 /vXZJjWKddC+iKXeqWkjMVcgCOsWNZ7PWEzRUT5X1AEFq2zzxQAQ/bCWEYNqIbHN4b6G1Wk+2Y598
 +KypZ3FS0bwiItnPQOWzOOqJCGxDxaEUuXFx4ah8HtVdtIev8jPS/5uzQO9iG2vZQUWeMEYZtfMHW
 sbFWqo2A3lxB+KPzNIYFhul4Lyx1CwvKUAGSHOx7FZuc2xI5DYt/Wdh2QyKFYr7xVzv3uwJjeS1+3
 6gvyB7DJaQuY+PziNPv4GPr5wy0cRkJ6Ps15fgC6y6wNwoNdNXKlwiuclIsBzJKa7A0pZMIfpCpIJ
 bEHP7oy3drBRAhIrBx7Lx1lyqqodDqc+ok5IQ5WcKG/TOrH732mTmJX6fxYTiCVxcU4WLJSNZbrZ/
 pjF0AWXs7E+onAkQy6RLg/XU1iiU5QdMvug+fTA6TpPSUMdujWtGWUt3/4nC+69AVc8tXtRQTZ7gP
 t7uIcQFwPqUuJGS26vl0w/6dIABQAyU9acvE3adCZra+/PBKFZi/yxT1WgV1T2mexKSWwQgLcR57J
 Yp5oWnQRgi/S6fAoskIWkp9UVcfAQPY0p45NwO5cZR9/g06JZmyrQhTmlrbGFzIFNjaG5lbGxlIDx
 uaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAA
 stJ1IDCl9y3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAz4A/9F+dMhzu7YonagL4qh
 WDz5IpRD4vzYKOBZ+qwYp1ugJz1BIUppN9i68HKoS4ARfgP97Sv9GpOy9g7L0lymH2MPF8hRPK0Yn
 7DKIkeu/r28YWEoWfoVm5reC+gpxMgmxBz4JScE4f6xfa7+Nw0bbTDl+nxftJD7lf/dTiruNJsXph
 HQnZ5wPXmxeH6XVJikfpyrGe8iJZALbtHtjlx6Omu7NvRGikenB8trrWS5W0F60ZdbqH1HdmDDcrZ
 pDq6LtAARHK5tGRm0SK6sZpKe3nULFeeCt7T/edk2FC6KVh4sL1jw1kyceX4DjiMffqYBPrhK5gz5
 cDIixLBF9C6Wt1ObvuDBrIQf1/3q6EZrUrUuf6qtaXDMuC6cSlShm47qaPEvVYh67O9JZQ7vzvaea
 UI74DJUb8Pjnz7mTOmMOzsS1gUhCue4n2YSSM6ythioCGb/3bgMGTpuer3JhvZG5s5uKD9yyj8s8x
 35qJkCFfjmjVx9s3vSUS48X+cUpYcMispErKzFu7C0YgKoxvJ4XTfXlDBiMFMPYcN67hsb2jeYHVJ
 wzE+fIZiDx9JLh1oQW2krwjweisE+3glOaKXZKi0fBtkxyH41iemLtLNYZRJopv6ykdl3hiI+Nh+a
 3FZJPTo/OpqchMm8XIeDxC4NFFiPMpyLeYzIxO7eZpiGrAjVTE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Mar 2026 13:54:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J788M9damuUKttupNqrpqUBs8vt4K3En
X-Proofpoint-GUID: J788M9damuUKttupNqrpqUBs8vt4K3En
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bd43c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ODXyO3jQYn5nzmKf3CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwMCBTYWx0ZWRfX+ellokxsWQKY
 nw+1iZMX/IhGLMVF7ymHBqr28nKzEMbUiLapNyk4fFPViBnzSsWgWEX2bxUaUSW+n+7G3vDfvLy
 D7wy6e7d4ydv39GwEFAzvaPmws54b8vEGmwmdwd2WawCL6MkeEldVot1snm/7xz6lEk3VYvq8SZ
 Lo7z0x8lg7K5ZHTKoHhkHIPeSae1vBgwW/MJq+n5OTFxGdFUPNx5OXi18ScsByPU1bNc7kOcFDO
 20+Yp2TgCaaV42Mnk+tRev7hoPrgcYxEsCAdoCfqy4yrvD3UpiIkLzrLMcOBCwwJoyWxkHS9cnF
 /VnLP9MByTgr/aJymz/cP1LWzrxZCUsoswXVKlTW68l2kre4G2dvt7UArS5Cn2YWaQiRkW0KIid
 T27XxIkiUHlJHH+kw5WNOF6tl7uZd7ZvN8aXB2zinWMlQRCqD14qG3cVNIOo6RExkG2Dyb2pqzQ
 8hwVQDUBtqqABYxJ49Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200100

On Thu, 2026-03-19 at 16:42 +0100, Julian Ruess wrote:
> Add a vfio_pci variant driver for the s390-specific Internal Shared
> Memory (ISM) devices used for inter-VM communication.
>=20
> This enables the development of vfio-pci-based user space drivers for
> ISM devices.
>=20
> On s390, kernel primitives such as ioread() and iowrite() are switched
> over from function handle based PCI load/stores instructions to PCI
> memory-I/O (MIO) loads/stores when these are available and not
> explicitly disabled. Since these instructions cannot be used with ISM
> devices, ensure that classic function handle-based PCI instructions are
> used instead.
>=20
> The driver is still required even when MIO instructions are disabled, as
> the ISM device relies on the PCI store block (PCISTB) instruction to
> perform write operations.
>=20
> Stores are not fragmented, therefore one ioctl corresponds to exactly
> one PCISTB instruction. User space must ensure to not write more than
> 4096 bytes at once to an ISM BAR which is the maximum payload of the
> PCISTB instruction.
>=20
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig      |   2 +
>  drivers/vfio/pci/Makefile     |   2 +
>  drivers/vfio/pci/ism/Kconfig  |  10 ++
>  drivers/vfio/pci/ism/Makefile |   3 +
>  drivers/vfio/pci/ism/main.c   | 400 ++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 417 insertions(+)
>=20

As a general note, ISM devices do not support any low power/sleep modes
which is why there is no PM handling done.

> +
> +/*
> + * ism_vfio_pci_do_io_w()
> + *
> + * Ensure that the PCI store block (PCISTB) instruction is used as requi=
red by the
> + * ISM device. The ISM device also uses a 256 TiB BAR 0 for write operat=
ions,
> + * which requires a 48bit region address space (ISM_VFIO_PCI_OFFSET_SHIF=
T).
> + */
> +static ssize_t ism_vfio_pci_do_io_w(struct vfio_pci_core_device *vdev,
> +				    char __user *buf, loff_t off, size_t count,
> +				    int bar)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> +	struct ism_vfio_pci_core_device *ivpcd;
> +	ssize_t ret;
> +	void *data;
> +	u64 req;
> +
> +	if (count > zdev->maxstbl)
> +		return -EINVAL;
> +	if (((off % PAGE_SIZE) + count) > PAGE_SIZE)
> +		return -EINVAL;
> +
> +	ivpcd =3D container_of(vdev, struct ism_vfio_pci_core_device,
> +			     core_device);
> +	data =3D kmem_cache_alloc(ivpcd->store_block_cache, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(data, buf, count)) {
> +		ret =3D -EFAULT;
> +		goto out_free;
> +	}
> +
> +	req =3D ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, count);
> +	ret =3D __zpci_store_block(data, req, off);

Note: There is a Sashiko finding that PCI Store Block needs 8 byte
alignment and we don't ensure that off is 8 byte aligned here. While
generally true the ISM device has relaxed alignment rules and this
requirement does not apply. That said we should set PAGE_SIZE alignment
on the kmem_cache such that data is guaranteed PAGE_SIZE aligned and
the page crossing check works correctly.

> +	if (ret)
> +		goto out_free;
> +
> +	ret =3D count;
> +
> +out_free:
> +	kmem_cache_free(ivpcd->store_block_cache, data);
> +	return ret;
> +}
> +
--- snip ---

> +
> +static int ism_vfio_pci_init_dev(struct vfio_device *core_vdev)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(to_pci_dev(core_vdev->dev));
> +	struct ism_vfio_pci_core_device *ivpcd;
> +	char cache_name[20];
> +	int ret;
> +
> +	ivpcd =3D container_of(core_vdev, struct ism_vfio_pci_core_device,
> +			     core_device.vdev);
> +
> +	snprintf(cache_name, sizeof(cache_name), "ism_sb_fid_%08x", zdev->fid);
> +	ivpcd->store_block_cache =3D
> +		kmem_cache_create(cache_name, zdev->maxstbl, 0, 0, NULL);

Sashiko notes here that the cache_name is stack allocated and says that
kmem_cache_create() doesn't copy it. Looking at
__kmem_cache_create_args() however this seems to be not true as that
does krstrdup_const() on the passed-in name.

> +	if (!ivpcd->store_block_cache)
> +		return -ENOMEM;
> +
> +	ret =3D vfio_pci_core_init_dev(core_vdev);
> +	if (ret)
> +		kmem_cache_destroy(ivpcd->store_block_cache);
> +
> +	return ret;
> +}
> +
--- snip ---
