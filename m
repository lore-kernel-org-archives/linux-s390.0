Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EF30E853;
	Fri,  6 Mar 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810217; cv=none; b=RlcXhVFPq1l0TqANsZpdFaak22jXUrB/kkvZ9LIkJq9wotmZb+V8YIZMX3Nc7usDIdDM9M4Y6kDxvoijal+2osgO8t2c4Z7KsvywxTvIwkira5DEFuU/9G0Bk4tSKH0fLIvbUvxDLFQAauSaN1MDNeoK+JKZ1dw1dBi2hjQfENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810217; c=relaxed/simple;
	bh=Ww79V6XSNrOApr1MN66Q2ihaKY9e/WA00tdA/a0XbU0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BsbxChlTLoGWoBkxeSUUWFu9JZNd31pjtA21iV2fT30u0fozPF1r2A4qg+U3soUFrj5XNsdql9/1uqyZO8mZNZ+8umg3mqRhEWs9JqMoLLhUZ9XrUsjgJUZCHCI1YPbv+zVRA7dVLjSedMFS5zaKu/i31HFzPMLWC06JwoNGqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/3dom55; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/3dom55"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265h5Xg1331219;
	Fri, 6 Mar 2026 15:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2/syfV
	M8wq7Mj0Whb/PrtmjiHfXrSSuTZvLL8/o1IlQ=; b=i/3dom55NFFzaa3cEglcqa
	O62ASyymLgotD8+OzC4ZKo7aODACFcTs8B9tt756pJflmkcj1NcsiYEa0HM0z4EK
	cDgVreb7/jHZDakh+VksmeQJ1T99JQIKVDWf09Kpd8eK9XmFgMw9SJxaXy2pb5/b
	+m64HrwB58vELE3+EdtHEBQWA/TSWDhRrzCkHiU3cDheRiLhKSXQSokGx2gnQP0p
	PTKwrAxCzQc+skrkIcXTZYMcTGZgGcsXm4PXsqmt2XRtV8vUIE17cTJ7SM5TVweb
	ZZtGY6tbHY1YbOeTzPuGe43b6bxm2jAbrRi3KjW51J80C+o1YxBEovZaiLlvc2pA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk48kng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 15:16:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626CmEjX011312;
	Fri, 6 Mar 2026 15:16:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cqau2vx6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 15:16:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626FGogs30474814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 15:16:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B74958060;
	Fri,  6 Mar 2026 15:16:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 472DF5803F;
	Fri,  6 Mar 2026 15:16:48 +0000 (GMT)
Received: from [9.111.76.202] (unknown [9.111.76.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 15:16:48 +0000 (GMT)
Message-ID: <4839efe9964290d3d8e52400b6f98c394e9156c1.camel@linux.ibm.com>
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for
 PCI slots
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Leon Romanovsky <leon@kernel.org>,
        Peter Oberparleiter
	 <oberpar@linux.ibm.com>
Cc: Ramesh Errabolu <ramesh@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Bjorn Helgaas
	 <bhelgaas@google.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer
	 <gbayer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik
	 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
In-Reply-To: <20260302194844.GU12611@unreal>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
	 <20260226083427.GF12611@unreal>
	 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
	 <20260226183945.GL12611@unreal>
	 <5d30ad0a-9c16-4802-adfe-e795c38f5990@linux.ibm.com>
	 <20260302194844.GU12611@unreal>
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
Date: Fri, 06 Mar 2026 16:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qAjSol0L6ZgI6HsOJGuzCmSbZ1ruChhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NSBTYWx0ZWRfX20mRa/B7NtdR
 ZfUZiIsMdyFxq/5TDvP9eez30osg9tXUyGnFnyxUWElMQWKt1lxXOfwuqIOoG2WP8fZZ8Tp8tnM
 wJiFc1QApFIMSK4/OczyGFvUCRrLSq9chI0tcjBz+zdhdWnxyYS4u2CiDoay9MWritCgglZCgNI
 QONkWN7BCfvb2qmbVTdxXODwb8Ao6DkYRzhTdpZErNlZ2X1M6IsZQuIRC/g0qu57Lv83hiiWyB8
 LACfuP/rfHDXWaeW2pj9ql1Jzmq4Ds5vU+xEwGx3L5DA0yKsgCfaMv4gOaEOxQ+6GnGA0lNs17W
 OfdPcd+dotYnVupz8w0mIKE9r9xXaKD5fX3Jg70QdMDIbkEpjfpRy3x995KJRF5W4+o5tgHskAZ
 FMR38AB5H4oAn3a9CjPgIMVA8XhG2gPRw+ryC+VXuNFWlyDRtteV18pMDacZRLbywE63ZwuwZ/z
 b0W29zupoCk7qSUbDhg==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aaefe4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=K7P-ssea2BpVGVVpLDIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AWAZp1ZhrszT7xFL5mKGLeaYeHUjJv3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060145

On Mon, 2026-03-02 at 21:48 +0200, Leon Romanovsky wrote:
> On Fri, Feb 27, 2026 at 12:23:03PM +0100, Peter Oberparleiter wrote:
> > On 2/26/2026 7:39 PM, Leon Romanovsky wrote:
> > > On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
> > > > On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
> > > > > On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
> > > > > > Add a new write-only 'uevent' attribute to PCI slot sysfs
> > > > > > entries. This provides a mechanism for userspace to explicitly
> > > > > > synthesize PCI slot uevents when needed.
> > > > > >=20
> > > > > > For cold-plugged PCI devices, slots may be created before
> > > > > > udev is ready to receive events, causing the initial 'add'
> > > > > > uevents to be missed. As a result, slot specific udev
> > > > > > rules that define naming, permissions, and related policies,
> > > > > > are not applied at boot. Allowing userspace to resynthesize
> > > > > > the 'add' uevent ensures these rules are processed correctly.
> > > > > This patch sounds like a hack to me. AFAIK, "udevadm trigger"
> > > > > performs exactly that.
> > > > >=20
> > > > > Thanks
> > > >=20
> > > > AFAIK,=C2=A0PCI slots do not yet raise a uevent.=20
> >=20
> > That is only partially true. PCI slots are represented in sysfs by a
> > kobject (pci_slot.kobj) and pci_hotplug_core generates uevents for thes=
e
> > kobjects during pci_hp_add() [1].
> >=20
> > Here is an example for these uevents:
> >=20
> > KERNEL[62021.190266] add      /bus/pci/slots/000018d0 (slots)
> > ACTION=3Dadd
> > DEVPATH=3D/bus/pci/slots/000018d0
> > SUBSYSTEM=3Dslots
> > SEQNUM=3D1638
> >=20
> > KERNEL[62032.304390] remove   /bus/pci/slots/000018d0 (slots)
> > ACTION=3Dremove
> > DEVPATH=3D/bus/pci/slots/000018d0
> > SUBSYSTEM=3Dslots
> > SEQNUM=3D1682
> >=20
> > On s390 there is a use case for reacting to these events via udev rules=
,
> > namely to persistently apply a user-specified, per-slot power state.
>=20
> But the component that issues the uevent should create this file.
> In your example, it is the hotplug code that must provide a writable
> file, isn't it?
>=20
> Thanks

Sorry for the late reply, I was out last week and then missed your
follow up as it seems I was erroneously neither on Cc nor To for the
series.

Good point, after all a non-hotplug slot would also not have no reason
to create such events. Moreover the hotplug code does have attributes
already in particular the 'power' attribute. We will look into this.

Thanks,
Niklas
