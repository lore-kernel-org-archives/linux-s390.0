Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE07413787;
	Wed,  5 Aug 2026 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929597; cv=none; b=BHVa6ZRULPlVMq2kA43c7KAj3ZahLgKcA1rhraZ0mFMdWN9fDe4WgZeG/aOE4CRswAgT3BW3N0I2F+MsXrMREVMCGvYMgYjKysWCApeM4ipsBd45qdyR6yrxKkWFxnKD0dRL8IoLhbgqG89oYppLnSSuJiToJUlZOjHiqI4IEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929597; c=relaxed/simple;
	bh=piZ8djHj9x3ax1inVTbwHmwiCC8NEdJUJJcMFjZSCUs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mPSaFL4MvDs0wx0NnIHBrILYGFEH6JPjd8NDHBeaFxKEBVzjwGgo4Sv9YDbG6WBVqeqEIEpZceo4HdaqVZnnW99DG+UaKpgu/PW26oNRmUeizIjMrmE+D8D5pXG+RqBjLeDO36J/dKPpmazRflRxaI1ToUEMI/it4k9lz+UInjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tFoeZ6au; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tFoeZ6au"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lqfN3288836;
	Wed, 5 Aug 2026 11:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xfiRSj
	cyUViasGN0VVryx0/tlmpB2dA3AuvarOMBgqc=; b=tFoeZ6auuS3VzJTti1Ozfl
	Q1RvZcTrkSlYNpW5wFfgt0g5/swzyZ5JES+FCooRfE/fs+64+nSlMAcqHF+rgm68
	RT2XgGNRhI6g9vATplbansdxaxoCj2JaLaz7JZlk1ZRWHJ0YG7mijpZZDloJT44+
	/W6mCo6Y1/cQ4BNv1RmDhEml0ZDcTgRS5OcWy9aM7i7PaYVFUsM5ytbMW4ObTzbO
	zxlqND3FkTaRZu+AiQGBgBJuiwAxeq7himXvKEV7FLacxyljevDDXEsie7HzlajA
	4liMeYpEoc1GG00P0w3yZ9YhdA69qUfU/qE3FIMXbOcsVdLxe8e07e89CQG/gAAQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gacn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:33:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BQKoW025760;
	Wed, 5 Aug 2026 11:33:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k69wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:33:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BXD3P32768622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:33:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D4B858068;
	Wed,  5 Aug 2026 11:33:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D04958056;
	Wed,  5 Aug 2026 11:33:11 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:33:11 +0000 (GMT)
Message-ID: <0b65164f7442fec896c76e0a39a8d9a43f98b721.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] s390/pci: Rework__zpci_event_availability() to
 remove conditional locking
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily
 Gorbik	 <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803142907.1771509-3-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
	 <20260803142907.1771509-3-hca@linux.ibm.com>
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
Date: Wed, 05 Aug 2026 13:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfX2Jfp6/QLgJ2Z
 M8JbrFDbVUOvZjREMXYDGeoWm/Z6vFs9+jFMcNAbv1K9XA55DdBiJ5anMK3JEzWkEpnYwFJQK0c
 oqexXzu7CzXkmEKLxwkLmRMDUJ3gZHY280yjNoZWhUq1gVDYwaR810khYrO/lGDI91ydpaW+M4e
 mwnfYgJTLSu0N++SI57DxofgZJ+FxkA8hBzLKOTrcItG+45f3voz/oJKnLBXbwVidJIhq3cj6AT
 nUv0eCrw1b1mnmRfVi4el3HhPuWW6cU+AUqUiX+G1Exvj+WxSb08wxTed05eBLSZGwqV2AhiANV
 4BYcKW455biESGn+d6OeR9DXwc0ycnHqeYgy2nTCNL1G1J3AgiRWGJuDqaeGyMotFIGz6vZFJlZ
 CQapAcu6mITCb+vN77ACcaFOBeBQ/qJYaUYn3ygxDAQRzllPj9vzYS8Msaui/GO3shkQ22Lqn4b
 Q5XwMT4/pckiIVKiPpw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a731f7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=t8tCVMzGnkcV_0IQ88AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gQg9VQk3nPNnxgjoqf6MGxtt0dnhbhCl
X-Proofpoint-ORIG-GUID: gQg9VQk3nPNnxgjoqf6MGxtt0dnhbhCl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfX1tODMOXG7/QY
 /BtSiTfx8g2ZKEB/XWEvECegAz2tGvO1+whJFRPHyJSHgKoniW03h/tL5Q1dsBIAACT29q9H0ux
 INA5Tgc74ucSPP0e2tf9ThcQ0TjYQlE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050090

On Mon, 2026-08-03 at 16:29 +0200, Heiko Carstens wrote:
> Clang's compiler based static context analysis does not work with locks
> that are conditionally taken like in __zpci_event_availability():
>=20
> arch/s390/pci/pci_event.c:402:10: warning: mutex 'get_zdev_by_fid(ccdf->f=
id).state_lock'
>   is not held on every path through here [-Wthread-safety-analysis]
>=20
> Given that code which takes locks conditionally can be considered
> suboptimal rework __zpci_event_availability() to get rid of this.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/pci/pci_event.c | 108 +++++++++++++++++++-------------------
>  1 file changed, 53 insertions(+), 55 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 48fa26dcbee1..f96ee87405f9 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -389,19 +389,25 @@ static void zpci_event_reappear(struct zpci_dev *zd=
ev)
> =20
>  static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  {
> -	struct zpci_dev *zdev =3D get_zdev_by_fid(ccdf->fid);
> -	bool existing_zdev =3D !!zdev;
> +	struct zpci_dev *zdev;
>  	enum zpci_state state;
> =20
>  	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
>  		 ccdf->fid, ccdf->fh, ccdf->pec);
> =20
> -	if (existing_zdev)
> -		mutex_lock(&zdev->state_lock);
> +	/* 0x0306 - No handle or fid stored */
> +	if (ccdf->pec =3D=3D 0x0306) {
> +		/* 0x308 or 0x302 for multiple devices */
> +		zpci_remove_reserved_devices();
> +		zpci_scan_devices();
> +		return;
> +	}
> =20
> -	switch (ccdf->pec) {
> -	case 0x0301: /* Reserved|Standby -> Configured */
> -		if (!zdev) {
> +	zdev =3D get_zdev_by_fid(ccdf->fid);
> +

Nit: Stray empty line

> +	if (!zdev) {
> +		switch (ccdf->pec) {
> +		case 0x0301: /* Reserved|Standby -> Configured */
>  			zdev =3D zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIG=
URED);
>  			if (IS_ERR(zdev))
>  				break;
--- snip ---
> +			break;
>  		}
> +		return;
> +	}
--- snip ---
> +
> +	mutex_lock(&zdev->state_lock);
> +	switch (ccdf->pec) {
> +	case 0x0301: /* Reserved|Standby -> Configured */
> +		if (zdev->state =3D=3D ZPCI_FN_STATE_RESERVED)
> +			zpci_event_reappear(zdev);
> +		/* the configuration request may be stale */
> +		else if (zdev->state !=3D ZPCI_FN_STATE_STANDBY)
> +			break;
> +		zdev->state =3D ZPCI_FN_STATE_CONFIGURED;
> +		zpci_scan_configured_device(zdev, ccdf->fh);
> +		break;
> +	case 0x0302: /* Reserved -> Standby */
> +		if (zdev->state =3D=3D ZPCI_FN_STATE_RESERVED)
> +			zpci_event_reappear(zdev);
> +		zpci_update_fh(zdev, ccdf->fh);
--- snip ---
>  	}
> +	mutex_unlock(&zdev->state_lock);
> +	zpci_zdev_put(zdev);
>  }
> =20
>  void zpci_event_availability(void *data)

Personally I think I'd put the 0x0306 and each of the two switches in
helper functions to improve readability as this is getting awfully
long. Maybe something like zpci_event_avail_any_device() (0x0306),
zpci_event_avail_new_device() and zpci_event_avail_existing_device().

If you prefer and since I'm doing a follow up for the missing locking
in zpci_reserved_devices() I can also do that in a separate patch. Also
just to clarify Sashiko is right in that the missing locking is a pre-
existing issue as the state_lock was already not taken in that case,
it's just more obvious now.

Either way, functionality looks good to me so feel free to add:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
